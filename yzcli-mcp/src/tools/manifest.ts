/**
 * yzcli_manifest tool: Get business index and tool schema
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { executeCliJson } from "../cli-executor.js";
import { mcpLog, mcpTimer } from "../logger.js";

export function registerManifestTool(server: McpServer): void {
  server.tool(
    "yzcli_manifest",
    "Get the full business index of available ERP TypeKeys, supported operations, and the request schema for yzcli agent commands. Call this first to discover what business operations are available.",
    {},
    async () => {
      const timer = mcpTimer("tool=yzcli_manifest");
      mcpLog("tool_start", { tool: "yzcli_manifest" });
      try {
        const result = await executeCliJson(["agent", "manifest"]);
        const resSize = JSON.stringify(result).length;
        timer.stop({ res_size: resSize });
        return {
          content: [{ type: "text" as const, text: JSON.stringify(result, null, 2) }],
        };
      } catch (error: any) {
        timer.stop({ error: error.message?.slice(0, 100) });
        return {
          content: [{ type: "text" as const, text: JSON.stringify({
            success: false,
            error: { type: "cli_error", message: error.message },
          }, null, 2) }],
          isError: true,
        };
      }
    },
  );
}
