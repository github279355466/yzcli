#!/usr/bin/env node
/**
 * yzcli-mcp: MCP Server for YZCLI ERP CLI
 *
 * Provides 4 tools for AI Agent integration:
 * - yzcli_manifest: Get business index and tool schema
 * - yzcli_help: Get field details for a TypeKey
 * - yzcli_validate: Validate request JSON structure
 * - yzcli_run: Execute ERP operation
 */

// Handle --help / --version before starting MCP server
const args = process.argv.slice(2);
if (args.includes("--help") || args.includes("-h")) {
  console.log(`yzcli-mcp v0.1.0 — MCP Server for YZCLI ERP CLI

Usage:
  yzcli-mcp              Start MCP server (stdio transport)

⚠️  This server communicates via MCP stdio protocol (stdin/stdout JSON-RPC).
   It does NOT listen on any HTTP port.
   Do NOT use curl or HTTP requests — use MCP tools through your AI agent.

Options:
  --help, -h       Show this help
  --version, -v    Show version

Environment variables:
  YZCLI_PYTHON    Python executable path (default: "python")
  YZCLI_ARGS      Extra args passed to yzcli CLI (space-separated)

Tools provided:
  yzcli_manifest  Get business index and tool schema (no input)
  yzcli_help      Get field details for a TypeKey
                 Input: { type_key: string }
  yzcli_validate  Validate request JSON structure
                 Input: { request: object }
  yzcli_run       Execute ERP operation
                 Input: { request: object, explain?: boolean }
  yzcli_skill_version  Check skill version and update status (no input)

Typically launched by an MCP client (e.g. Claude Code, Codex, OpenClaw),
not invoked directly from the terminal.`);
  process.exit(0);
}
if (args.includes("--version") || args.includes("-v")) {
  console.log("0.1.0");
  process.exit(0);
}

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { registerManifestTool } from "./tools/manifest.js";
import { registerHelpTool } from "./tools/help.js";
import { registerValidateTool } from "./tools/validate.js";
import { registerRunTool } from "./tools/run.js";
import { registerSkillVersionTool } from "./tools/skill-version.js";

const server = new McpServer({
  name: "yzcli-mcp",
  version: "0.1.0",
});

// Register all tools
registerManifestTool(server);
registerHelpTool(server);
registerValidateTool(server);
registerRunTool(server);
registerSkillVersionTool(server);

// Start with stdio transport
const transport = new StdioServerTransport();
await server.connect(transport);
