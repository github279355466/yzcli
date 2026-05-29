/**
 * yzcli_help: Get TypeKey details (aliases, operations, metadata)
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";
import { findTypeKey, findTypeKeyByAlias, type TypeKeyInfo } from "yzcli-sdk";
import { mcpLog, mcpTimer } from "../logger.js";

function formatHelpResponse(tk: TypeKeyInfo) {
  return {
    success: true,
    type_key: tk.type_key,
    title: tk.title,
    dll: tk.dll,
    aliases: tk.aliases,
    operations: tk.operations,
    operation_aliases: tk.operation_aliases,
  };
}

export function registerHelpTool(server: McpServer): void {
  server.tool(
    "yzcli_help",
    "Get detailed information for a specific ERP TypeKey: aliases, supported operations, and operation aliases. Use this to understand a TypeKey before constructing a request.",
    {
      type_key: z.string().describe("The TypeKey or alias to get help for, e.g. 'sales.order', 'customer', 'item'"),
    },
    async ({ type_key }) => {
      const timer = mcpTimer("tool=yzcli_help");
      mcpLog("tool_start", { tool: "yzcli_help", type_key });
      try {
        let tk = findTypeKey(type_key);
        if (!tk) {
          const resolved = findTypeKeyByAlias(type_key);
          if (resolved) tk = findTypeKey(resolved);
        }

        if (!tk) {
          timer.stop({ found: false });
          return {
            content: [{ type: "text" as const, text: JSON.stringify({
              success: false,
              error: {
                type: "not_found",
                message: `TypeKey '${type_key}' not found. Use yzcli_manifest to see all available TypeKeys.`,
              },
            }, null, 2) }],
            isError: true,
          };
        }

        const result = formatHelpResponse(tk);
        timer.stop({ type_key: tk.type_key, operations: tk.operations.length });
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
