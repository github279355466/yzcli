/**
 * yzcli update TYPE_KEY — 更新数据
 */
import { Command } from "commander";
import { ErpClient } from "yzcli-sdk";
import { formatOutput, readJsonInput, print, exitError, type OutputFormat } from "../output.js";
import { resolveTypeKey } from "./query.js";

export function createUpdateCommand(clientFactory: () => ErpClient): Command {
  return new Command("update")
    .description("更新 ERP 数据（仅传主键 + 变更字段）")
    .argument("<type-key>", "TypeKey 或别名")
    .requiredOption("-j, --json <data>", "数据 JSON（内联或 @file.json），须含主键字段")
    .option("--dry-run", "仅验证，不实际提交")
    .option("-o, --output <format>", "输出格式: json|table|csv", "json")
    .option("--no-pretty", "紧凑 JSON 输出")
    .action(async (typeKey, opts) => {
      try {
        const resolved = resolveTypeKey(typeKey);
        const client = clientFactory();

        let cdsMaster = readJsonInput(opts.json);
        if (!Array.isArray(cdsMaster)) cdsMaster = [cdsMaster];

        if (opts.dryRun) {
          print(formatOutput({
            success: true,
            dry_run: true,
            type_key: resolved,
            would_update: cdsMaster,
          }, opts.output as OutputFormat, opts.pretty));
          return;
        }

        const result = await client.update(resolved, cdsMaster);

        if (!result.success) {
          print(formatOutput({ success: false, message: result.message, data: result.data }, opts.output as OutputFormat, opts.pretty));
          process.exit(1);
        }

        print(formatOutput({
          success: true,
          type_key: resolved,
          data: result.data,
          message: result.message,
        }, opts.output as OutputFormat, opts.pretty));
      } catch (e: any) {
        exitError(e.message);
      }
    });
}
