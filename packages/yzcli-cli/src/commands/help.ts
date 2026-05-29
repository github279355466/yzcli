/**
 * yzcli help TYPE_KEY — TypeKey 信息查询
 */
import { Command } from "commander";
import { findTypeKey, findTypeKeyByAlias } from "yzcli-sdk";
import { formatOutput, print, exitError, type OutputFormat } from "../output.js";

export function createHelpCommand(): Command {
  return new Command("help")
    .description("查看 TypeKey 详细信息（别名、支持的操作）")
    .argument("<type-key>", "TypeKey 或别名")
    .option("-o, --output <format>", "输出格式: json|table|csv", "json")
    .option("--no-pretty", "紧凑 JSON 输出")
    .action((typeKey, opts) => {
      let tk = findTypeKey(typeKey);
      if (!tk) {
        const alias = findTypeKeyByAlias(typeKey);
        if (alias) tk = findTypeKey(alias);
      }
      if (!tk) {
        exitError(`未找到 TypeKey: "${typeKey}". 使用 yzcli manifest 查看可用 TypeKey`);
        return;
      }

      print(formatOutput({
        success: true,
        type_key: tk.type_key,
        title: tk.title,
        dll: tk.dll,
        aliases: tk.aliases,
        operations: tk.operations,
        operation_aliases: tk.operation_aliases,
      }, opts.output as OutputFormat, opts.pretty));
    });
}
