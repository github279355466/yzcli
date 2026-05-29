/**
 * yzcli_help tool: Get field details for a TypeKey
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";
import { executeCliJson } from "../cli-executor.js";
import { mcpLog, mcpTimer } from "../logger.js";

export function registerHelpTool(server: McpServer): void {
  server.tool(
    "yzcli_help",
    "Get detailed field information (field numbers, names, types, descriptions) for a specific ERP TypeKey. Use this to discover the exact field names and numbers before constructing a request.",
    {
      type_key: z.string().describe("The TypeKey to get help for, e.g. 'sales.order', 'customer', 'item'"),
    },
    async ({ type_key }) => {
      const timer = mcpTimer("tool=yzcli_help");
      mcpLog("tool_start", { tool: "yzcli_help", type_key });
      try {
        const result = await executeCliJson(["help", type_key, "--output", "json"]);
        const resSize = JSON.stringify(result).length;
        timer.stop({ type_key, res_size: resSize });
        return {
          content: [{ type: "text" as const, text: JSON.stringify(result, null, 2) }],
        };
      } catch (error: any) {
        timer.stop({ type_key, error: error.message?.slice(0, 100) });
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
