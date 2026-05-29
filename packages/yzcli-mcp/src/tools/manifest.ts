/**
 * yzcli_manifest: Get business index and tool schema
 */
import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { getAllTypeKeys, type TypeKeyInfo } from "yzcli-sdk";
import { mcpLog, mcpTimer } from "../logger.js";

const OPERATION_SCHEMAS: Record<string, Record<string, unknown>> = {
  fastquery: {
    description: "Search records with conditions (fastquery)",
    required: [],
    properties: {
      conditions: { type: "array", description: "Query conditions" },
      orders: { type: "array", description: "Sort orders" },
      page_no: { type: "integer", default: 1, description: "Page number" },
      page_size: { type: "integer", default: 20, description: "Page size" },
      query_type: { type: "string", default: "all", description: "Query type: all or key" },
      use_has_next: { type: "boolean", default: true, description: "Use pagination" },
      load_data_browse_config: { type: "boolean", default: false, description: "Load browse config" },
    },
  },
  getMultiple: {
    description: "Get records by primary keys",
    required: ["datakeys"],
    properties: {
      datakeys: { type: "array", minItems: 1, description: "List of primary key dictionaries" },
      load_data_browse_config: { type: "boolean", default: false },
    },
  },
  create: {
    description: "Create new records",
    required: ["cdsMaster"],
    properties: {
      cdsMaster: { type: "array", minItems: 1, description: "List of master record dictionaries" },
    },
  },
  update: {
    description: "Update existing records",
    required: ["cdsMaster"],
    properties: {
      cdsMaster: { type: "array", minItems: 1, description: "List of master record dictionaries" },
    },
  },
  delete: {
    description: "Delete records",
    required: ["datakeys"],
    properties: {
      datakeys: { type: "array", minItems: 1, description: "List of primary key dictionaries" },
    },
  },
  approve: {
    description: "Approve records",
    required: ["datakeys"],
    properties: {
      datakeys: { type: "array", minItems: 1, description: "List of primary key dictionaries" },
    },
  },
  disapprove: {
    description: "Disapprove records",
    required: ["datakeys"],
    properties: {
      datakeys: { type: "array", minItems: 1, description: "List of primary key dictionaries" },
    },
  },
};

function buildManifestData() {
  const typeKeys = getAllTypeKeys();
  const businessIndex = typeKeys.map((tk: TypeKeyInfo) => ({
    type_key: tk.type_key,
    title: tk.title,
    dll: tk.dll,
    aliases: tk.aliases,
    operations: tk.operations,
    operation_aliases: tk.operation_aliases,
  }));

  return {
    schema_version: "1",
    tool: {
      name: "yzcli.agent",
      commands: ["manifest", "validate", "run"],
      operations: ["fastquery", "getMultiple", "create", "update", "delete", "approve", "disapprove"],
    },
    request_schema: {
      type: "object",
      required: ["type_key", "operation"],
      properties: {
        type_key: { type: "string", description: "TypeKey for the operation" },
        operation: {
          type: "string",
          enum: ["fastquery", "getMultiple", "create", "update", "delete", "approve", "disapprove"],
          description: "Operation to perform",
        },
        input: { type: "object", description: "Operation-specific input parameters" },
      },
      operation_schemas: OPERATION_SCHEMAS,
    },
    business_index: businessIndex,
  };
}

export function registerManifestTool(server: McpServer): void {
  server.tool(
    "yzcli_manifest",
    "Get the full business index of available ERP TypeKeys, supported operations, and the request schema. Call this first to discover what business operations are available.",
    {},
    async () => {
      const timer = mcpTimer("tool=yzcli_manifest");
      mcpLog("tool_start", { tool: "yzcli_manifest" });
      try {
        const result = buildManifestData();
        timer.stop({ typekeys: result.business_index.length });
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
