#!/usr/bin/env node
/**
 * yzcli-cli v0.1.0 — YZCLI ERP CLI (TypeScript, SDK-based)
 *
 * 与 Python yzcli CLI 功能等价，使用 yzcli-sdk 共享库。
 */
import { Command } from "commander";
import { ErpClient, getErpConfig } from "yzcli-sdk";
import { createQueryCommand } from "./commands/query.js";
import { createGetCommand } from "./commands/get.js";
import { createCreateCommand } from "./commands/create.js";
import { createUpdateCommand } from "./commands/update.js";
import { createDeleteCommand } from "./commands/delete.js";
import { createApproveCmd, createDisapproveCommand } from "./commands/approve.js";
import { createAgentCommand } from "./commands/agent.js";
import { createHelpCommand } from "./commands/help.js";
import { createManifestCommand } from "./commands/manifest.js";
import { createConfigCommand } from "./commands/config.js";

// Windows UTF-8 safety
if (process.platform === "win32") {
  try {
    process.stdout.setEncoding?.("utf-8" as any);
  } catch { /* ignore */ }
}

/**
 * Create ErpClient from global options
 */
function createClient(opts?: { token?: string; baseUrl?: string }): ErpClient {
  const config = getErpConfig(opts?.token, opts?.baseUrl);
  return new ErpClient(config);
}

const program = new Command();

program
  .name("yzcli")
  .version("0.1.0")
  .description("YZCLI ERP CLI — TypeScript 版，基于 yzcli-sdk")
  .option("--token <token>", "ERP 认证 Token（覆盖配置文件）")
  .option("--base-url <url>", "ERP 服务器地址（覆盖配置文件）");

// ERP 操作命令
program.addCommand(createQueryCommand(() => createClient(program.opts())));
program.addCommand(createGetCommand(() => createClient(program.opts())));
program.addCommand(createCreateCommand(() => createClient(program.opts())));
program.addCommand(createUpdateCommand(() => createClient(program.opts())));
program.addCommand(createDeleteCommand(() => createClient(program.opts())));
program.addCommand(createApproveCmd(() => createClient(program.opts())));
program.addCommand(createDisapproveCommand(() => createClient(program.opts())));

// Agent 命令组
program.addCommand(createAgentCommand(() => createClient(program.opts())));

// 工具命令
program.addCommand(createHelpCommand());
program.addCommand(createManifestCommand());
program.addCommand(createConfigCommand());

program.parse();
