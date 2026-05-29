/**
 * yzcli manifest — 输出业务索引
 */
import { Command } from "commander";
import { getAllTypeKeys } from "yzcli-sdk";
import { formatOutput, print, type OutputFormat } from "../output.js";

export function createManifestCommand(): Command {
  return new Command("manifest")
    .description("输出全部 TypeKey 业务索引")
    .option("-o, --output <format>", "输出格式: json|table|csv", "json")
    .option("--no-pretty", "紧凑 JSON 输出")
    .action((opts) => {
      const typeKeys = getAllTypeKeys();
      const data = typeKeys.map((tk) => ({
        type_key: tk.type_key,
        title: tk.title,
        operations: tk.operations.join(", "),
        aliases: tk.aliases.join(", "),
      }));
      print(formatOutput(data, opts.output as OutputFormat, opts.pretty));
    });
}
