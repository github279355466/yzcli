/**
 * CLI Executor: unified subprocess wrapper for calling yzcli Python CLI
 */
import { spawn } from "node:child_process";
import { randomUUID } from "node:crypto";
import { writeFile, unlink } from "node:fs/promises";
import { join } from "node:path";
import { tmpdir } from "node:os";
import { mcpLog, mcpTimer } from "./logger.js";

const DEFAULT_TIMEOUT_MS = 60_000;

function getPythonCommand(): string {
  return process.env.YZCLI_PYTHON || "python";
}

function getExtraArgs(): string[] {
  const extra = process.env.YZCLI_ARGS;
  return extra ? extra.split(/\s+/).filter(Boolean) : [];
}

/**
 * Execute yzcli CLI command and return raw stdout string.
 * @throws {CliError} on non-zero exit, timeout, or parse failure.
 */
export async function executeCli(args: string[], timeoutMs = DEFAULT_TIMEOUT_MS): Promise<string> {
  const python = getPythonCommand();
  const extraArgs = getExtraArgs();
  const fullArgs = ["-m", "yzcli", ...extraArgs, ...args];
  const argsStr = fullArgs.join(" ");
  const timer = mcpTimer("cli_exec");
  mcpLog("cli_spawn", { python, args: argsStr });

  return new Promise<string>((resolve, reject) => {
    const child = spawn(python, fullArgs, {
      stdio: ["pipe", "pipe", "pipe"],
      timeout: timeoutMs,
    });

    let stdout = "";
    let stderr = "";

    child.stdout.on("data", (chunk: Buffer) => {
      stdout += chunk.toString("utf-8");
    });

    child.stderr.on("data", (chunk: Buffer) => {
      stderr += chunk.toString("utf-8");
    });

    child.on("error", (err) => {
      timer.stop({ exit: "error" });
      reject(new CliError(
        `Failed to spawn ${python}: ${err.message}`,
        "spawn_error",
      ));
    });

    child.on("close", (code) => {
      timer.stop({ exit: String(code), stdout_len: stdout.length });
      if (code !== 0) {
        reject(new CliError(
          `yzcli exited with code ${code}: ${stderr || stdout}`,
          "cli_error",
          code ?? undefined,
          stderr,
        ));
        return;
      }
      resolve(stdout);
    });
  });
}

/**
 * Execute yzcli CLI and parse JSON output.
 */
export async function executeCliJson(args: string[], timeoutMs = DEFAULT_TIMEOUT_MS): Promise<any> {
  const stdout = await executeCli(args, timeoutMs);
  try {
    return JSON.parse(stdout);
  } catch {
    throw new CliError(
      `Failed to parse yzcli output as JSON: ${stdout.slice(0, 500)}`,
      "parse_error",
      undefined,
      stdout,
    );
  }
}

/**
 * Write request JSON to a temp file and return the path.
 * Caller must clean up the file after use.
 */
export async function writeTempJson(data: object): Promise<string> {
  const filename = `yzcli-mcp-${randomUUID()}.json`;
  const filepath = join(tmpdir(), filename);
  await writeFile(filepath, JSON.stringify(data, null, 2), "utf-8");
  return filepath;
}

/**
 * Remove a temp file (best-effort, no throw).
 */
export async function removeTempFile(filepath: string): Promise<void> {
  try {
    await unlink(filepath);
  } catch {
    // ignore cleanup errors
  }
}

/**
 * Execute a yzcli agent command with a JSON request body.
 * Writes request to temp file, calls CLI, cleans up.
 */
export async function executeAgentCommand(
  command: "validate" | "run",
  request: object,
  extraArgs: string[] = [],
): Promise<any> {
  const reqSize = JSON.stringify(request).length;
  const timer = mcpTimer("agent_command");
  mcpLog("agent_command_start", { command, req_size: reqSize });
  const filepath = await writeTempJson(request);
  try {
    const result = await executeCliJson(["agent", command, `@${filepath}`, ...extraArgs]);
    const resSize = JSON.stringify(result).length;
    timer.stop({ command, res_size: resSize });
    return result;
  } finally {
    await removeTempFile(filepath);
  }
}

/** Custom error class for CLI execution failures */
export class CliError extends Error {
  constructor(
    message: string,
    public readonly type: string,
    public readonly exitCode?: number,
    public readonly stderr?: string,
  ) {
    super(message);
    this.name = "CliError";
  }
}
