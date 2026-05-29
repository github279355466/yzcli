/**
 * yzcli query TYPE_KEY — 条件查询
 */
import { Command } from "commander";
import { ErpClient, findTypeKey, findTypeKeyByAlias, type QueryParams } from "yzcli-sdk";
import { formatOutput, parseConditions, parseKeyValues, print, exitError, type OutputFormat } from "../output.js";

export function createQueryCommand(clientFactory: () => ErpClient): Command {
  return new Command("query")
    .description("查询 ERP 数据（fastquery）")
    .argument("<type-key>", "TypeKey 或别名，如 sales.order、customer")
    .option("-c, --condition <field=value...>", "查询条件（多次指定）", [])
    .option("--order-by <field=asc|desc...>", "排序字段（多次指定）", [])
    .option("-p, --page <n>", "页码", "1")
    .option("-s, --page-size <n>", "每页条数", "20")
    .option("--no-page", "不分页（返回全部）")
    .option("--key-only", "仅返回主键字段")
    .option("-o, --output <format>", "输出格式: json|table|csv", "json")
    .option("--no-pretty", "紧凑 JSON 输出")
    .action(async (typeKey, opts) => {
      try {
        const resolved = resolveTypeKey(typeKey);
        const client = clientFactory();

        const params: QueryParams = {
          page_no: opts.noPage ? 1 : parseInt(opts.page, 10),
          page_size: opts.noPage ? 9999 : parseInt(opts.pageSize, 10),
          query_type: opts.keyOnly ? "key" : "all",
        };

        if (opts.condition?.length > 0) {
          params.conditions = parseConditions(opts.condition);
        }

        if (opts.orderBy?.length > 0) {
          params.orders = opts.orderBy.map((o: string) => {
            const [field, order] = o.split("=");
            return { field_name: field, order: order || "asc" };
          });
        }

        const result = await client.query(resolved, params);

        if (!result.success) {
          print(formatOutput({ success: false, message: result.message, data: result.data }, opts.output as OutputFormat, opts.pretty));
          process.exit(1);
        }

        const output = {
          success: true,
          type_key: resolved,
          data: result.data,
          message: result.message,
        };
        print(formatOutput(output, opts.output as OutputFormat, opts.pretty));
      } catch (e: any) {
        exitError(e.message);
      }
    });
}

export function resolveTypeKey(input: string): string {
  const tk = findTypeKey(input);
  if (tk) return tk.type_key;
  const alias = findTypeKeyByAlias(input);
  if (alias) return alias;
  throw new Error(`未知 TypeKey: "${input}". 使用 yzcli manifest 查看可用 TypeKey`);
}
