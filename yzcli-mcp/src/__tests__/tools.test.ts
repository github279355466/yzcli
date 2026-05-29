import { describe, it, expect, vi, beforeEach } from "vitest";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { InMemoryTransport } from "@modelcontextprotocol/sdk/inMemory.js";
import { Client } from "@modelcontextprotocol/sdk/client/index.js";

// Mock the cli-executor module
vi.mock("../cli-executor.js", () => ({
  executeCliJson: vi.fn(),
  executeAgentCommand: vi.fn(),
}));

import { executeCliJson, executeAgentCommand } from "../cli-executor.js";
import { registerManifestTool } from "../tools/manifest.js";
import { registerHelpTool } from "../tools/help.js";
import { registerValidateTool } from "../tools/validate.js";
import { registerRunTool } from "../tools/run.js";

const mockExecuteCliJson = vi.mocked(executeCliJson);
const mockExecuteAgentCommand = vi.mocked(executeAgentCommand);

/**
 * Create a connected client-server pair for testing tools.
 */
async function createTestPair() {
  const server = new McpServer({ name: "test-server", version: "0.0.1" });
  registerManifestTool(server);
  registerHelpTool(server);
  registerValidateTool(server);
  registerRunTool(server);

  const [clientTransport, serverTransport] = InMemoryTransport.createLinkedPair();
  await server.connect(serverTransport);

  const client = new Client({ name: "test-client", version: "0.0.1" });
  await client.connect(clientTransport);

  return { client, server };
}

describe("yzcli_manifest tool", () => {
  beforeEach(() => {
    mockExecuteCliJson.mockReset();
  });

  it("calls executeCliJson with correct args", async () => {
    mockExecuteCliJson.mockResolvedValue({ schema_version: "1", business_index: [] });
    const { client } = await createTestPair();
    await client.callTool({ name: "yzcli_manifest", arguments: {} });
    expect(mockExecuteCliJson).toHaveBeenCalledWith(["agent", "manifest"]);
  });

  it("returns JSON content on success", async () => {
    const mockResult = { schema_version: "1", business_index: [{ type_key: "sales.order" }] };
    mockExecuteCliJson.mockResolvedValue(mockResult);
    const { client } = await createTestPair();
    const response = await client.callTool({ name: "yzcli_manifest", arguments: {} });
    expect(response.content).toHaveLength(1);
    const text = (response.content as any[])[0].text;
    const parsed = JSON.parse(text);
    expect(parsed.schema_version).toBe("1");
    expect(parsed.business_index).toHaveLength(1);
  });

  it("returns error content on CLI failure", async () => {
    mockExecuteCliJson.mockRejectedValue(new Error("CLI failed"));
    const { client } = await createTestPair();
    const response = await client.callTool({ name: "yzcli_manifest", arguments: {} });
    expect(response.isError).toBe(true);
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(false);
    expect(parsed.error.type).toBe("cli_error");
  });
});

describe("yzcli_help tool", () => {
  beforeEach(() => {
    mockExecuteCliJson.mockReset();
  });

  it("calls executeCliJson with type_key", async () => {
    mockExecuteCliJson.mockResolvedValue({ fields: [] });
    const { client } = await createTestPair();
    await client.callTool({ name: "yzcli_help", arguments: { type_key: "customer" } });
    expect(mockExecuteCliJson).toHaveBeenCalledWith(["help", "customer", "--output", "json"]);
  });

  it("returns field data on success", async () => {
    mockExecuteCliJson.mockResolvedValue({ fields: [{ name: "DFA001" }] });
    const { client } = await createTestPair();
    const response = await client.callTool({ name: "yzcli_help", arguments: { type_key: "customer" } });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.fields).toHaveLength(1);
  });
});

describe("yzcli_validate tool", () => {
  beforeEach(() => {
    mockExecuteAgentCommand.mockReset();
  });

  it("calls executeAgentCommand with validate", async () => {
    mockExecuteAgentCommand.mockResolvedValue({ success: true });
    const request = { type_key: "sales.order", operation: "query", input: {} };
    const { client } = await createTestPair();
    await client.callTool({ name: "yzcli_validate", arguments: { request } });
    expect(mockExecuteAgentCommand).toHaveBeenCalledWith("validate", request);
  });

  it("returns validation result", async () => {
    mockExecuteAgentCommand.mockResolvedValue({ success: true, request: {} });
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_validate",
      arguments: { request: { type_key: "x", operation: "query", input: {} } },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(true);
  });
});

describe("yzcli_run tool", () => {
  beforeEach(() => {
    mockExecuteAgentCommand.mockReset();
  });

  it("calls executeAgentCommand with run", async () => {
    mockExecuteAgentCommand.mockResolvedValue({ success: true });
    const request = { type_key: "sales.order", operation: "query", input: { page_no: 1 } };
    const { client } = await createTestPair();
    await client.callTool({ name: "yzcli_run", arguments: { request } });
    expect(mockExecuteAgentCommand).toHaveBeenCalledWith("run", request, []);
  });

  it("passes --explain when explain is true", async () => {
    mockExecuteAgentCommand.mockResolvedValue({ success: true });
    const request = { type_key: "sales.order", operation: "query", input: {} };
    const { client } = await createTestPair();
    await client.callTool({ name: "yzcli_run", arguments: { request, explain: true } });
    expect(mockExecuteAgentCommand).toHaveBeenCalledWith("run", request, ["--explain"]);
  });

  it("returns execution result", async () => {
    mockExecuteAgentCommand.mockResolvedValue({
      success: true,
      type_key: "sales.order",
      result: { success: { data: [] } },
    });
    const { client } = await createTestPair();
    const response = await client.callTool({
      name: "yzcli_run",
      arguments: { request: { type_key: "sales.order", operation: "query", input: {} } },
    });
    const parsed = JSON.parse((response.content as any[])[0].text);
    expect(parsed.success).toBe(true);
    expect(parsed.type_key).toBe("sales.order");
  });
});
