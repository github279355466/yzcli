/**
 * yzcli_validate: Validate request JSON structure
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { z } from "zod";
import { findTypeKey, findTypeKeyByAlias } from "yzcli-sdk";
import { mcpLog, mcpTimer } from "../logger.js";

const VALID_OPERATIONS = [
  "fastquery", "getMultiple", "create", "update", "delete", "approve", "disapprove",
];

const OPERATION_REQUIRED_FIELDS: Record<string, string[]> = {
  fastquery: [],
  query: [],
  getMultiple: ["datakeys"],
  get: ["datakeys"],
  create: ["cdsMaster"],
  update: ["cdsMaster"],
  delete: ["datakeys"],
  approve: ["datakeys"],
  disapprove: ["datakeys"],
};

function validateRequest(data: Record<string, unknown>) {
  const errors: string[] = [];

  if (!data.type_key || typeof data.type_key !== "string") {
    errors.push("Missing or invalid 'type_key' (string required)");
  }
  if (!data.operation || typeof data.operation !== "string") {
    errors.push("Missing or invalid 'operation' (string required)");
  } else if (!VALID_OPERATIONS.includes(data.operation)) {
    errors.push(`Invalid operation '${data.operation}'. Must be one of: ${VALID_OPERATIONS.join(", ")}`);
  }

  if (errors.length > 0) {
    return {
      success: false,
      error: {
        type: "validation_error",
        message: errors.join("; "),
        suggestions: [
          "Check required fields: type_key, operation",
          `Verify operation is one of: ${VALID_OPERATIONS.join(", ")}`,
        ],
      },
    };
  }

  const typeKey = data.type_key as string;
  const operation = data.operation as string;

  // Resolve TypeKey
  let resolved = findTypeKey(typeKey);
  if (!resolved) {
    const alias = findTypeKeyByAlias(typeKey);
    if (alias) resolved = findTypeKey(alias);
  }
  if (!resolved) {
    return {
      success: false,
      error: {
        type: "validation_error",
        message: `Unknown type_key: '${typeKey}'. Use yzcli_manifest to see available TypeKeys.`,
        suggestions: ["Call yzcli_manifest to discover available TypeKeys"],
      },
    };
  }

  // Check operation support
  if (!resolved.operations.includes(operation)) {
    return {
      success: false,
      error: {
        type: "validation_error",
        message: `Operation '${operation}' is not supported for TypeKey '${resolved.type_key}'. Supported: ${resolved.operations.join(", ")}`,
        suggestions: [`Use one of: ${resolved.operations.join(", ")}`],
      },
    };
  }

  // Check required input fields
  const input = (data.input || {}) as Record<string, unknown>;
  const required = OPERATION_REQUIRED_FIELDS[operation] || [];
  for (const field of required) {
    if (!(field in input)) {
      return {
        success: false,
        error: {
          type: "validation_error",
          message: `Missing required field '${field}' for operation '${operation}'`,
          suggestions: [`Add '${field}' to input parameters`],
        },
      };
    }
  }

  return {
    success: true,
    request: {
      type_key: resolved.type_key,
      operation,
      input,
    },
  };
}

export function registerValidateTool(server: McpServer): void {
  server.tool(
    "yzcli_validate",
    "Validate an ERP request JSON structure before executing it. Checks that the request has required fields (type_key, operation, input) and that the TypeKey and operation are valid. Use this to catch errors before calling yzcli_run.",
    {
      request: z.record(z.unknown()).describe("The request object to validate. Must contain type_key (string), operation (string), and input (object)."),
    },
    async ({ request }) => {
      const timer = mcpTimer("tool=yzcli_validate");
      mcpLog("tool_start", { tool: "yzcli_validate", req_size: JSON.stringify(request).length });
      try {
        const result = validateRequest(request);
        timer.stop({ success: result.success });
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
