import { describe, it, expect } from "vitest";
import { spawn } from "node:child_process";
import { join } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = fileURLToPath(new URL(".", import.meta.url));
const DIST_INDEX = join(__dirname, "..", "..", "dist", "index.js");

function runCli(...args: string[]): Promise<{ stdout: string; stderr: string; code: number }> {
  return new Promise((resolve) => {
    const child = spawn("node", [DIST_INDEX, ...args], {
      stdio: ["pipe", "pipe", "pipe"],
      env: { ...process.env },
    });
    let stdout = "";
    let stderr = "";
    child.stdout.on("data", (d: Buffer) => stdout += d.toString("utf-8"));
    child.stderr.on("data", (d: Buffer) => stderr += d.toString("utf-8"));
    child.on("close", (code) => resolve({ stdout, stderr, code: code ?? 1 }));
  });
}

describe("yzcli-cli", () => {
  it("--version shows version", async () => {
    const { stdout, code } = await runCli("--version");
    expect(stdout.trim()).toBe("0.1.0");
    expect(code).toBe(0);
  });

  it("--help shows usage", async () => {
    const { stdout, code } = await runCli("--help");
    expect(stdout).toContain("yzcli");
    expect(stdout).toContain("query");
    expect(stdout).toContain("manifest");
    expect(code).toBe(0);
  });

  it("manifest lists TypeKeys", async () => {
    const { stdout, code } = await runCli("manifest");
    expect(code).toBe(0);
    const data = JSON.parse(stdout);
    expect(Array.isArray(data)).toBe(true);
    expect(data.length).toBeGreaterThan(0);
    expect(data[0]).toHaveProperty("type_key");
    expect(data[0]).toHaveProperty("title");
  });

  it("help shows TypeKey info", async () => {
    const { stdout, code } = await runCli("help", "sales.order");
    expect(code).toBe(0);
    const data = JSON.parse(stdout);
    expect(data.success).toBe(true);
    expect(data.type_key).toBe("sales.order");
    expect(data.operations).toContain("query");
  });

  it("help resolves alias", async () => {
    const { stdout, code } = await runCli("help", "订单");
    expect(code).toBe(0);
    const data = JSON.parse(stdout);
    expect(data.success).toBe(true);
    expect(data.type_key).toBe("sales.order");
  });

  it("help rejects unknown TypeKey", async () => {
    const { code } = await runCli("help", "nonexistent");
    expect(code).toBe(1);
  });

  it("agent manifest outputs manifest JSON", async () => {
    const { stdout, code } = await runCli("agent", "manifest");
    expect(code).toBe(0);
    const data = JSON.parse(stdout);
    expect(data.schema_version).toBe("1");
    expect(data.business_index).toBeDefined();
    expect(data.business_index.length).toBeGreaterThan(0);
  });

  it("agent validate accepts valid request", async () => {
    const { stdout, code } = await runCli("agent", "validate", '{"type_key":"sales.order","operation":"fastquery","input":{}}');
    expect(code).toBe(0);
    const data = JSON.parse(stdout);
    expect(data.success).toBe(true);
  });

  it("agent validate rejects missing type_key", async () => {
    const { code } = await runCli("agent", "validate", '{"operation":"fastquery"}');
    expect(code).toBe(2);
  });

  it("query --help shows query usage", async () => {
    const { stdout, code } = await runCli("query", "--help");
    expect(stdout).toContain("type-key");
    expect(stdout).toContain("--condition");
    expect(code).toBe(0);
  });
});
