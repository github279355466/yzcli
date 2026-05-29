import { describe, it, expect, vi, beforeEach } from "vitest";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { InMemoryTransport } from "@modelcontextprotocol/sdk/inMemory.js";
import { Client } from "@modelcontextprotocol/sdk/client/index.js";

// Mock yzcli-sdk modules
vi.mock("yzcli-sdk", () => ({
  getAllTypeKeys: vi.fn(() => [
    {
      type_key: "sales.order",
      title: "销售订单",
      dll: "SO_SaleOrder",
      aliases: ["销售订单", "SO_SaleOrder"],
      operations: ["fastquery", "getMultiple", "create", "update", "delete", "approve"],
      operation_aliases: { fastquery: ["查询", "列表"] },
    },
  ]),
  findTypeKey: vi.fn((key: string) => {
    if (key === "sales.order") {
      return {
        type_key: "sales.order",
        title: "销售订单",
        dll: "SO_SaleOrder",
        aliases: ["销售订单"],
        operations: ["fastquery", "getMultiple", "create", "update", "delete", "approve"],
        operation_aliases: { fastquery: ["查询", "列表"] },
      };
    }
    return undefined;
  }),
  findTypeKeyByAlias: vi.fn((alias: string) => {
    if (alias === "销售订单") return "sales.order";
    return null;
  }),
  ErpClient: vi.fn().mockImplementation(() => ({
    query: vi.fn().mockResolvedValue({ success: true, code: "0", message: "ok", data: { result: [] }, rawResponse: {} }),
    get: vi.fn().mockResolvedValue({ success: true, code: "0", message: "ok", data: {}, rawResponse: {} }),
    create: vi.fn().mockResolvedValue({ success: true, code: "0", message: "ok", data: {}, rawResponse: {} }),
    update: vi.fn().mockResolvedValue({ success: true, code: "0", message: "ok", data: {}, rawResponse: {} }),
    delete: vi.fn().mockResolvedValue({ success: true, code: "0", message: "ok", data: {}, rawResponse: {} }),
    approve: vi.fn().mockResolvedValue({ success: true, code: "0", message: "ok", data: {}, rawResponse: {} }),
    disapprove: vi.fn().mockResolvedValue({ success: true, code: "0", message: "ok", data: {}, rawResponse: {} }),
  })),
  loadConfig: vi.fn(() => ({
    erp: { baseUrl: "http://test:8103", token: "test-token", timeout: 30 },
    fieldMode: "field_number",
  })),
  ApiClientError: class ApiClientError extends Error {
    constructor(message: string, public type = "api_error") { super(message); this.name = "ApiClientError"; }
  },
}));

import { registerManifestTool } from "../tools/manifest.js";
import { registerHelpTool } from "../tools/help.js";
import { registerValidateTool } from "../tools/validate.js";
import { registerRunTool } from "../tools/run.js";
import { registerSkillVersionTool } from "../tools/skill-version.js";

async function createTestPair() {
  const server = new McpServer({ name: "test-server", version: "0.0.1" });
  registerManifestTool(server);
  registerHelpTool(server);
  registerValidateTool(server);
  registerRunTool(server);
  registerSkillVersionTool(server);

  const [clientTransport, serverTransport] = InMemoryTransport.createLinkedPair();
  await server.connect(serverTransport);

  const client = new Client({ name: "test-client", version: "0.0.1" });
  await client.connect(clientTransport);

  return { client, server };
}

describe("yzcli_manifest", () => {
  it("returns manifest with business_index", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({ name: "yzcli_manifest", arguments: {} });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.schema_version).toBe("1");
    expect(parsed.business_index).toHaveLength(1);
    expect(parsed.business_index[0].type_key).toBe("sales.order");
    expect(parsed.request_schema.operation_schemas).toBeDefined();
  });
});

describe("yzcli_help", () => {
  it("returns TypeKey info for valid key", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({ name: "yzcli_help", arguments: { type_key: "sales.order" } });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(true);
    expect(parsed.type_key).toBe("sales.order");
    expect(parsed.operations).toContain("fastquery");
  });

  it("resolves alias to TypeKey", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({ name: "yzcli_help", arguments: { type_key: "销售订单" } });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(true);
    expect(parsed.type_key).toBe("sales.order");
  });

  it("returns error for unknown TypeKey", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({ name: "yzcli_help", arguments: { type_key: "nonexistent" } });
    expect(response.isError).toBe(true);
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.error.type).toBe("not_found");
  });
});

describe("yzcli_validate", () => {
  it("validates correct request", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_validate",
      arguments: { request: { type_key: "sales.order", operation: "fastquery", input: {} } },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(true);
    expect(parsed.request.type_key).toBe("sales.order");
  });

  it("rejects missing type_key", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_validate",
      arguments: { request: { operation: "fastquery", input: {} } },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(false);
    expect(parsed.error.type).toBe("validation_error");
  });

  it("rejects invalid operation", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_validate",
      arguments: { request: { type_key: "sales.order", operation: "invalid_op", input: {} } },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(false);
  });

  it("checks required input fields for create", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_validate",
      arguments: { request: { type_key: "sales.order", operation: "create", input: {} } },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(false);
    expect(parsed.error.message).toContain("cdsMaster");
  });

  it("passes validation with required fields", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_validate",
      arguments: { request: { type_key: "sales.order", operation: "create", input: { cdsMaster: [{}] } } },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(true);
  });
});

describe("yzcli_run", () => {
  it("executes query operation", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_run",
      arguments: { request: { type_key: "sales.order", operation: "fastquery", input: {} } },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(true);
    expect(parsed.type_key).toBe("sales.order");
    expect(parsed.operation).toBe("fastquery");
  });

  it("returns error for unknown TypeKey", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_run",
      arguments: { request: { type_key: "unknown.key", operation: "fastquery", input: {} } },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(false);
    expect(parsed.error.type).toBe("validation_error");
  });

  it("includes explain info when requested", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_run",
      arguments: { request: { type_key: "sales.order", operation: "fastquery", input: {} }, explain: true },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.explain).toBeDefined();
    expect(parsed.explain.resolved.type_key).toBe("sales.order");
  });
});

describe("yzcli_skill_version", () => {
  it("returns version object", async () => {
    const { client } = await createTestPair();
    const response = await client.callTool({ name: "yzcli_skill_version", arguments: {} });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed).toHaveProperty("version");
  });
});
