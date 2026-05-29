/**
 * yzcli_run: Execute an ERP operation via SDK
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";
import { findTypeKey, findTypeKeyByAlias, type ApiResponse } from "yzcli-sdk";
import { getErpClient } from "../erp-client.js";
import { mcpLog, mcpTimer } from "../logger.js";

type ErpOperation = "fastquery" | "getMultiple" | "create" | "update" | "delete" | "approve" | "disapprove";

async function executeErpOperation(
  typeKey: string,
  operation: ErpOperation,
  input: Record<string, any>,
  token?: string,
): Promise<Record<string, any>> {
  // Resolve TypeKey
  let resolved = findTypeKey(typeKey);
  if (!resolved) {
    const alias = findTypeKeyByAlias(typeKey);
    if (alias) resolved = findTypeKey(alias);
  }
  if (!resolved) {
    return {
      success: false,
      type_key: typeKey,
      operation,
      error: {
        type: "validation_error",
        message: `Unknown type_key: '${typeKey}'`,
        suggestions: ["Call yzcli_manifest to discover available TypeKeys"],
      },
    };
  }

  const client = getErpClient(token);
  let result: ApiResponse;

  try {
    switch (operation) {
      case "fastquery":
        result = await client.query(resolved.type_key, input);
        break;
      case "getMultiple":
        result = await client.get(resolved.type_key, input.datakeys || []);
        break;
      case "create":
        result = await client.create(resolved.type_key, input.cdsMaster || []);
        break;
      case "update":
        result = await client.update(resolved.type_key, input.cdsMaster || []);
        break;
      case "delete":
        result = await client.delete(resolved.type_key, input.datakeys || []);
        break;
      case "approve":
        result = await client.approve(resolved.type_key, input.datakeys || []);
        break;
      case "disapprove":
        result = await client.disapprove(resolved.type_key, input.datakeys || []);
        break;
      default:
        return {
          success: false,
          type_key: resolved.type_key,
          operation,
          error: {
            type: "validation_error",
            message: `Unknown operation: '${operation}'`,
          },
        };
    }
  } catch (e: any) {
    return {
      success: false,
      type_key: resolved.type_key,
      operation,
      error: {
        type: e.type || "api_error",
        message: e.message,
      },
    };
  }

  return {
    success: result.success,
    type_key: resolved.type_key,
    operation,
    result: result.data,
    raw: { code: result.code, message: result.message },
  };
}

export function registerRunTool(server: McpServer): void {
  server.tool(
    "yzcli_run",
    "Execute an ERP operation via yzcli. The request must contain type_key, operation, and input. Use yzcli_validate first to check the request, or yzcli_help to discover field names. Use yzcli_manifest to see available TypeKeys.",
    {
      request: z.record(z.unknown()).describe("The request object to execute. Must contain type_key (string), operation (string: fastquery/getMultiple/create/update/delete/approve/disapprove), and input (object)."),
      explain: z.boolean().optional().default(false).describe("If true, include resolved service info in the response."),
    },
    async ({ request, explain }) => {
      const timer = mcpTimer("tool=yzcli_run");
      mcpLog("tool_start", { tool: "yzcli_run", type_key: (request as any)?.type_key, operation: (request as any)?.operation });
      try {
        const typeKey = request.type_key as string;
        const operation = request.operation as string;
        const input = (request.input || {}) as Record<string, any>;
        const token = request._token as string | undefined;

        const result = await executeErpOperation(
          typeKey,
          operation as ErpOperation,
          input,
          token,
        );

        if (explain) {
          let resolved = findTypeKey(typeKey);
          if (!resolved) {
            const alias = findTypeKeyByAlias(typeKey);
            if (alias) resolved = findTypeKey(alias);
          }
          (result as any).explain = {
            resolved: {
              type_key: resolved?.type_key || typeKey,
              operation,
              service: `${resolved?.type_key || typeKey}.${operation}`,
            },
          };
        }

        timer.stop({ success: result.success });
        return {
          content: [{ type: "text" as const, text: JSON.stringify(result, null, 2) }],
          isError: !result.success,
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
