#!/usr/bin/env node
/**
 * yzcli-mcp v0.2.0 — MCP Server for YZCLI ERP (SDK-based)
 *
 * Supports two transport modes:
 * 1. stdio (default) — for per-client MCP client connections
 * 2. HTTP (--http)    — for centralized MCP gateway deployment
 */

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { registerManifestTool } from "./tools/manifest.js";
import { registerHelpTool } from "./tools/help.js";
import { registerValidateTool } from "./tools/validate.js";
import { registerRunTool } from "./tools/run.js";
import { registerSkillVersionTool } from "./tools/skill-version.js";
import { startHttpServer } from "./http-server.js";
import { mcpLog } from "./logger.js";

// Handle CLI flags before any imports that might fail
const args = process.argv.slice(2);

if (args.includes("--help") || args.includes("-h")) {
  console.log(`yzcli-mcp v0.2.0 — MCP Server for YZCLI ERP (SDK-based)

Usage:
  yzcli-mcp              Start MCP server (stdio transport)
  yzcli-mcp --http       Start MCP server (HTTP gateway mode)
  yzcli-mcp --http --port 3000   HTTP mode on custom port

Options:
  --help, -h       Show this help
  --version, -v    Show version
  --http           Start in HTTP gateway mode (StreamableHTTP)
  --port <n>       HTTP port (default: 3000, env: MCP_PORT)

Environment variables:
  ERP_BASE_URL     ERP server URL
  ERP_TOKEN        ERP authentication token
  MCP_PORT         HTTP listen port (default: 3000)

Tools provided:
  yzcli_manifest        Get business index and tool schema
  yzcli_help            Get TypeKey details
  yzcli_validate        Validate request JSON structure
  yzcli_run             Execute ERP operation
  yzcli_skill_version   Check skill version`);
  process.exit(0);
}

if (args.includes("--version") || args.includes("-v")) {
  console.log("0.2.0");
  process.exit(0);
}

// Determine transport mode
const httpMode = args.includes("--http");
const portArg = args.indexOf("--port");
const port = portArg >= 0
  ? parseInt(args[portArg + 1], 10)
  : parseInt(process.env.MCP_PORT || "3000", 10);

function createServer(): McpServer {
  const server = new McpServer({
    name: "yzcli-mcp",
    version: "0.2.0",
  });
  registerManifestTool(server);
  registerHelpTool(server);
  registerValidateTool(server);
  registerRunTool(server);
  registerSkillVersionTool(server);
  return server;
}

if (httpMode) {
  // HTTP gateway mode
  mcpLog("startup", { mode: "http", port });
  await startHttpServer(port, (token) => {
    // In HTTP mode, token comes from Authorization header
    // Create a new McpServer for each session
    // Tools use getErpClient(token) internally
    const server = createServer();
    return server;
  });
} else {
  // Stdio mode (default)
  mcpLog("startup", { mode: "stdio" });
  const server = createServer();
  const transport = new StdioServerTransport();
  await server.connect(transport);
}
