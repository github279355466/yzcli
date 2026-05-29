import { describe, it, expect } from "vitest";
import {
  executeCli,
  executeCliJson,
  CliError,
  writeTempJson,
  removeTempFile,
  executeAgentCommand,
} from "../cli-executor.js";

describe("executeCli", () => {
  it("returns stdout for a successful yzcli command", async () => {
    const result = await executeCli(["--help"]);
    expect(result).toContain("yzcli");
  });

  it("throws CliError on non-zero exit code", async () => {
    // yzcli with invalid subcommand exits non-zero
    await expect(
      executeCli(["nonexistent-subcommand-xyz"])
    ).rejects.toThrow(CliError);
  });

  it("CliError contains type and exit code", async () => {
    try {
      await executeCli(["nonexistent-subcommand-xyz"]);
      expect.fail("should have thrown");
    } catch (e) {
      expect(e).toBeInstanceOf(CliError);
      const cliErr = e as CliError;
      expect(cliErr.type).toBe("cli_error");
      expect(typeof cliErr.exitCode).toBe("number");
    }
  });

  it("throws CliError on invalid Python path", async () => {
    const orig = process.env.YZCLI_PYTHON;
    process.env.YZCLI_PYTHON = "nonexistent_python_xyz_999";
    try {
      await executeCli(["--help"]);
      expect.fail("should have thrown");
    } catch (e) {
      expect(e).toBeInstanceOf(CliError);
      expect((e as CliError).type).toBe("spawn_error");
    } finally {
      if (orig !== undefined) process.env.YZCLI_PYTHON = orig;
      else delete process.env.YZCLI_PYTHON;
    }
  });
});

describe("executeCliJson", () => {
  it("parses JSON output from yzcli agent manifest", async () => {
    const result = await executeCliJson(["agent", "manifest"]);
    expect(result).toBeDefined();
    expect(result.schema_version).toBe("1");
    expect(result.business_index).toBeDefined();
  });

  it("throws CliError on non-JSON output", async () => {
    // yzcli --help outputs text, not JSON; executeCliJson should fail to parse
    await expect(
      executeCliJson(["--help"])
    ).rejects.toThrow(CliError);
  });

  it("CliError type is parse_error for bad JSON", async () => {
    try {
      await executeCliJson(["--help"]);
      expect.fail("should have thrown");
    } catch (e) {
      expect((e as CliError).type).toBe("parse_error");
    }
  });
});

describe("writeTempJson / removeTempFile", () => {
  it("writes and removes temp file", async () => {
    const data = { test: "value", numbers: [1, 2, 3] };
    const filepath = await writeTempJson(data);

    // Read back and verify
    const { readFileSync } = await import("node:fs");
    const content = readFileSync(filepath, "utf-8");
    expect(JSON.parse(content)).toEqual(data);

    // Remove
    await removeTempFile(filepath);

    // Verify removed
    const { existsSync } = await import("node:fs");
    expect(existsSync(filepath)).toBe(false);
  });

  it("removeTempFile does not throw on non-existent file", async () => {
    await expect(removeTempFile("/tmp/nonexistent-yzcli-test-999999.json")).resolves.not.toThrow();
  });
});

describe("executeAgentCommand", () => {
  it("validate command returns result with request and success fields", async () => {
    const request = {
      type_key: "sales.order",
      operation: "query",
      input: { page_no: 1, page_size: 1 },
    };
    const result = await executeAgentCommand("validate", request);
    expect(result).toBeDefined();
    expect(typeof result).toBe("object");
    expect(result.success).toBe(true);
    expect(result.request).toBeDefined();
  });

  it("run command returns result structure", async () => {
    const request = {
      type_key: "sales.order",
      operation: "query",
      input: { page_no: 1, page_size: 1, query_type: "all" },
    };
    const result = await executeAgentCommand("run", request, ["--explain"]);
    expect(result).toBeDefined();
    expect(typeof result).toBe("object");
    expect(typeof result.success).toBe("boolean");
  });
});
