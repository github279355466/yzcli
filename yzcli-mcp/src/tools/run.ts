/**
 * yzcli_run tool: Execute an ERP operation
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";
import { executeAgentCommand } from "../cli-executor.js";
import { mcpLog, mcpTimer } from "../logger.js";

export function registerRunTool(server: McpServer): void {
  server.tool(
    "yzcli_run",
    "Execute an ERP operation via yzcli. The request must contain type_key, operation, and input. Use yzcli_validate first to check the request, or yzcli_help to discover field names. Use yzcli_manifest to see available TypeKeys.",
    {
      request: z.record(z.unknown()).describe("The request object to execute. Must contain type_key (string), operation (string: fastquery/getMultiple/create/update/delete/approve/disapprove), and input (object)."),
      explain: z.boolean().optional().default(false).describe("If true, include resolved service info and field conversion details in the response."),
    },
    async ({ request, explain }) => {
      const timer = mcpTimer("tool=yzcli_run");
      mcpLog("tool_start", { tool: "yzcli_run", type_key: (request as any)?.type_key, operation: (request as any)?.operation, req_size: JSON.stringify(request).length });
      try {
        const extraArgs = explain ? ["--explain"] : [];
        const result = await executeAgentCommand("run", request, extraArgs);
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
