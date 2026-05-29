/**
 * yzcli_validate tool: Validate request JSON structure
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";
import { executeAgentCommand } from "../cli-executor.js";
import { mcpLog, mcpTimer } from "../logger.js";

export function registerValidateTool(server: McpServer): void {
  server.tool(
    "yzcli_validate",
    "Validate an ERP request JSON structure before executing it. Checks that the request has required fields (type_key, operation, input) and that the input matches the operation's schema. Use this to catch errors before calling yzcli_run.",
    {
      request: z.record(z.unknown()).describe("The request object to validate. Must contain type_key (string), operation (string: fastquery/getMultiple/create/update/delete/approve/disapprove), and input (object)."),
    },
    async ({ request }) => {
      const timer = mcpTimer("tool=yzcli_validate");
      mcpLog("tool_start", { tool: "yzcli_validate", req_size: JSON.stringify(request).length });
      try {
        const result = await executeAgentCommand("validate", request);
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
