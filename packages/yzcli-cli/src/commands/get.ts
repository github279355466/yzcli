/**
 * yzcli get TYPE_KEY — 按主键读取
 */
import { Command } from "commander";
import { ErpClient } from "yzcli-sdk";
import { formatOutput, parseKeyValues, readJsonInput, print, exitError, type OutputFormat } from "../output.js";
import { resolveTypeKey } from "./query.js";

export function createGetCommand(clientFactory: () => ErpClient): Command {
  return new Command("get")
    .description("按主键读取 ERP 记录")
    .argument("<type-key>", "TypeKey 或别名")
    .option("-k, --key <name=value...>", "主键字段值（多次指定）")
    .option("-b, --batch <@file>", "批量读取（@file.json 含 datakeys 数组）")
    .option("-o, --output <format>", "输出格式: json|table|csv", "json")
    .option("--no-pretty", "紧凑 JSON 输出")
    .action(async (typeKey, opts) => {
      try {
        const resolved = resolveTypeKey(typeKey);
        const client = clientFactory();

        let datakeys: Record<string, any>[];

        if (opts.batch) {
          datakeys = readJsonInput(opts.batch);
          if (!Array.isArray(datakeys)) datakeys = [datakeys];
        } else if (opts.key) {
          datakeys = [parseKeyValues(opts.key)];
        } else {
          exitError("必须指定 --key 或 --batch");
          return;
        }

        const result = await client.get(resolved, datakeys);

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
