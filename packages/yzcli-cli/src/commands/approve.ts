/**
 * yzcli approve/disapprove TYPE_KEY — 审核/撤审
 */
import { Command } from "commander";
import { ErpClient } from "yzcli-sdk";
import { formatOutput, parseKeyValues, readJsonInput, print, exitError, type OutputFormat } from "../output.js";
import { resolveTypeKey } from "./query.js";

function createApproveCommand(clientFactory: () => ErpClient, name: string, desc: string, method: "approve" | "disapprove"): Command {
  return new Command(name)
    .description(desc)
    .argument("<type-key>", "TypeKey 或别名")
    .option("-k, --key <name=value...>", "主键字段值（多次指定）")
    .option("-b, --batch <@file>", "批量操作（@file.json 含 datakeys 数组）")
    .option("-f, --force", "跳过确认")
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

        const result = await client[method](resolved, datakeys);

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

export function createApproveCmd(clientFactory: () => ErpClient): Command {
  return createApproveCommand(clientFactory, "approve", "审核 ERP 数据", "approve");
}

export function createDisapproveCommand(clientFactory: () => ErpClient): Command {
  return createApproveCommand(clientFactory, "disapprove", "撤审 ERP 数据", "disapprove");
}
