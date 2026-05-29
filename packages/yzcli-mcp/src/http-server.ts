/**
 * HTTP Server: StreamableHTTP transport for centralized MCP gateway.
 *
 * Agent connects via HTTP: { "mcpServers": { "yzcli": { "url": "http://erp-server:3000/mcp" } } }
 * Token is extracted from Authorization: Bearer <token> header.
 */
import { createServer, type IncomingMessage, type ServerResponse } from "node:http";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StreamableHTTPServerTransport } from "@modelcontextprotocol/sdk/server/streamableHttp.js";
import { randomUUID } from "node:crypto";
import { mcpLog } from "./logger.js";

interface HttpSession {
  transport: StreamableHTTPServerTransport;
  server: McpServer;
  createdAt: number;
}

const sessions = new Map<string, HttpSession>();

function extractToken(req: IncomingMessage): string | undefined {
  const auth = req.headers.authorization;
  if (auth?.startsWith("Bearer ")) {
    return auth.slice(7).trim();
  }
  return undefined;
}

function setCorsHeaders(res: ServerResponse) {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, mcp-session-id");
  res.setHeader("Access-Control-Expose-Headers", "mcp-session-id");
}

async function handleMcpRequest(
  req: IncomingMessage,
  res: ServerResponse,
  serverFactory: (token?: string) => McpServer,
) {
  setCorsHeaders(res);

  if (req.method === "OPTIONS") {
    res.writeHead(204);
    res.end();
    return;
  }

  const token = extractToken(req);
  const sessionIdHeader = req.headers["mcp-session-id"] as string | undefined;

  // Collect request body
  const chunks: Buffer[] = [];
  for await (const chunk of req) {
    chunks.push(chunk);
  }
  const bodyStr = Buffer.concat(chunks).toString("utf-8");

  let body: any;
  try {
    body = bodyStr ? JSON.parse(bodyStr) : undefined;
  } catch {
    res.writeHead(400, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ error: "Invalid JSON" }));
    return;
  }

  // POST: handle JSON-RPC requests
  if (req.method === "POST") {
    // Initialize request: create new session
    if (body?.method === "initialize") {
      const sessionId = randomUUID();
      const server = serverFactory(token);
      const transport = new StreamableHTTPServerTransport({
        sessionIdGenerator: () => sessionId,
      });

      await server.connect(transport);
      sessions.set(sessionId, {
        transport,
        server,
        createdAt: Date.now(),
      });

      mcpLog("http_session_created", { sessionId, hasToken: !!token });

      // Handle the request through the transport
      await transport.handleRequest(req, res, body);
      return;
    }

    // Session-based requests
    if (sessionIdHeader && sessions.has(sessionIdHeader)) {
      const session = sessions.get(sessionIdHeader)!;
      await session.transport.handleRequest(req, res, body);
      return;
    }

    // No session: reject
    res.writeHead(400, { "Content-Type": "application/json" });
    res.end(JSON.stringify({
      jsonrpc: "2.0",
      error: { code: -32000, message: "Missing mcp-session-id header. Call initialize first." },
      id: body?.id,
    }));
    return;
  }

  // GET: SSE stream for server-initiated messages
  if (req.method === "GET" && sessionIdHeader && sessions.has(sessionIdHeader)) {
    const session = sessions.get(sessionIdHeader)!;
    await session.transport.handleRequest(req, res);
    return;
  }

  // DELETE: session termination
  if (req.method === "DELETE" && sessionIdHeader && sessions.has(sessionIdHeader)) {
    const session = sessions.get(sessionIdHeader)!;
    await session.transport.handleRequest(req, res);
    sessions.delete(sessionIdHeader);
    mcpLog("http_session_closed", { sessionId: sessionIdHeader });
    return;
  }

  res.writeHead(404, { "Content-Type": "application/json" });
  res.end(JSON.stringify({ error: "Not found" }));
}

/**
 * Start HTTP server for MCP gateway mode.
 * @param port Port to listen on (default 3000)
 * @param serverFactory Function that creates McpServer with optional token
 */
export async function startHttpServer(
  port: number,
  serverFactory: (token?: string) => McpServer,
): Promise<void> {
  const server = createServer((req, res) => {
    handleMcpRequest(req, res, serverFactory).catch((err) => {
      mcpLog("http_error", { error: err.message });
      if (!res.headersSent) {
        res.writeHead(500, { "Content-Type": "application/json" });
        res.end(JSON.stringify({ error: "Internal server error" }));
      }
    });
  });

  // Clean up stale sessions every 5 minutes
  setInterval(() => {
    const now = Date.now();
    for (const [id, session] of sessions) {
      if (now - session.createdAt > 30 * 60 * 1000) {
        sessions.delete(id);
        mcpLog("http_session_expired", { sessionId: id });
      }
    }
  }, 5 * 60_000);

  return new Promise((resolve) => {
    server.listen(port, () => {
      mcpLog("http_server_start", { port, path: "/mcp" });
      console.error(`yzcli-mcp HTTP gateway listening on http://0.0.0.0:${port}/mcp`);
      resolve();
    });
  });
}
