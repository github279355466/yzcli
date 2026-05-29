/**
 * yzcli_skill_version: Check skill version
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { readFileSync, existsSync } from "node:fs";
import { join } from "node:path";
import { homedir } from "node:os";
import { mcpLog, mcpTimer } from "../logger.js";

const SKILL_MD_CANDIDATES = [
  join(homedir(), ".claude", "skills", "yzcli-erp.md"),
  join(homedir(), ".claude", "skills", "yzcli-erp", "SKILL.md"),
  join(homedir(), ".codex", "skills", "yzcli-erp", "SKILL.md"),
];

function getSkillVersion(): string {
  for (const path of SKILL_MD_CANDIDATES) {
    if (existsSync(path)) {
      try {
        const content = readFileSync(path, "utf-8");
        // Try frontmatter version
        const fmMatch = content.match(/^---\s*\n[\s\S]*?version:\s*["']?(\d+\.\d+\.\d+)["']?\s*\n[\s\S]*?---/);
        if (fmMatch) return fmMatch[1];
        // Try inline version
        const inlineMatch = content.match(/版本[：:]\s*(\d+\.\d+\.\d+)/);
        if (inlineMatch) return inlineMatch[1];
        const vMatch = content.match(/v(\d+\.\d+\.\d+)/);
        if (vMatch) return vMatch[1];
      } catch {
        // continue to next candidate
      }
    }
  }
  return "unknown";
}

export function registerSkillVersionTool(server: McpServer): void {
  server.tool(
    "yzcli_skill_version",
    "Check the current skill version. Returns { version: string }. Use this to verify the skill is up to date.",
    {},
    async () => {
      const timer = mcpTimer("tool=yzcli_skill_version");
      mcpLog("tool_start", { tool: "yzcli_skill_version" });
      try {
        const version = getSkillVersion();
        const result = { version };
        timer.stop({ version });
        return {
          content: [{ type: "text" as const, text: JSON.stringify(result, null, 2) }],
        };
      } catch (error: any) {
        timer.stop({ error: error.message?.slice(0, 100) });
        return {
          content: [{ type: "text" as const, text: JSON.stringify({
            success: false,
            error: { type: "sdk_error", message: error.message },
          }, null, 2) }],
          isError: true,
        };
      }
    },
  );
}
