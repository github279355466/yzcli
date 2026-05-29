/**
 * yzcli_skill_version tool: Check skill version
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { executeCliJson } from "../cli-executor.js";
import { mcpLog, mcpTimer } from "../logger.js";

export function registerSkillVersionTool(server: McpServer): void {
  server.tool(
    "yzcli_skill_version",
    "Check the current skill version. Returns { version: string }. Use this to verify the skill is up to date.",
    {},
    async () => {
      const timer = mcpTimer("tool=yzcli_skill_version");
      mcpLog("tool_start", { tool: "yzcli_skill_version" });
      try {
        const result = await executeCliJson(["skill", "version", "--json-output"]);
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
