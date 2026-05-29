import { describe, it, expect } from "vitest";
import { spawn } from "node:child_process";
import { join } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = fileURLToPath(new URL(".", import.meta.url));
const DIST_INDEX = join(__dirname, "..", "..", "dist", "index.js");

function spawnServer(): {
  send: (msg: object) => void;
  responses: Promise<any[]>;
  kill: () => void;
} {
  const child = spawn("node", [DIST_INDEX], {
    stdio: ["pipe", "pipe", "pipe"],
    env: { ...process.env },
  });

  let buffer = "";
  const received: any[] = [];
  let resolveResponses: (val: any[]) => void;

  const responses = new Promise<any[]>((resolve) => {
    resolveResponses = resolve;
  });

  child.stdout.on("data", (chunk: Buffer) => {
    buffer += chunk.toString("utf-8");
    const lines = buffer.split("\n");
    buffer = lines.pop() || "";
    for (const line of lines) {
      const trimmed = line.trim();
      if (trimmed) {
        try {
          received.push(JSON.parse(trimmed));
        } catch {
          // not JSON, skip
        }
      }
    }
  });

  setTimeout(() => resolveResponses!(received), 5000);

  return {
    send: (msg: object) => {
      child.stdin.write(JSON.stringify(msg) + "\n");
    },
    responses,
    kill: () => child.kill(),
  };
}

describe("MCP Server integration (SDK-based)", () => {
  it("responds to tools/list with 5 tools", async () => {
    const server = spawnServer();
    try {
      server.send({
        jsonrpc: "2.0",
        id: 1,
        method: "initialize",
        params: {
          protocolVersion: "2024-11-05",
          capabilities: {},
          clientInfo: { name: "test-client", version: "0.0.1" },
        },
      });

      await new Promise((r) => setTimeout(r, 1000));

      server.send({
        jsonrpc: "2.0",
        id: 2,
        method: "tools/list",
        params: {},
      });

      const responses = await server.responses;
      const toolsListResponse = responses.find(
        (r: any) => r.id === 2 && r.result?.tools
      );

      expect(toolsListResponse).toBeDefined();
      const toolNames = toolsListResponse.result.tools.map((t: any) => t.name);
      expect(toolNames).toContain("yzcli_manifest");
      expect(toolNames).toContain("yzcli_help");
      expect(toolNames).toContain("yzcli_validate");
      expect(toolNames).toContain("yzcli_run");
      expect(toolNames).toContain("yzcli_skill_version");
      expect(toolNames).toHaveLength(5);
    } finally {
      server.kill();
    }
  });
});
