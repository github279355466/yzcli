/**
 * yzcli agent — AI Agent 接口命令组 (manifest/validate/run)
 */
import { Command } from "commander";
import { ErpClient, getAllTypeKeys } from "yzcli-sdk";
import { formatOutput, readJsonInput, print, exitError, type OutputFormat } from "../output.js";

export function createAgentCommand(clientFactory: () => ErpClient): Command {
  const agent = new Command("agent")
    .description("AI Agent 接口（manifest / validate / run）");

  // yzcli agent manifest
  agent.command("manifest")
    .description("输出业务索引（TypeKey 列表 + 请求 Schema）")
    .option("-o, --output <format>", "输出格式", "json")
    .option("--no-pretty", "紧凑 JSON 输出")
    .action((opts) => {
      const typeKeys = getAllTypeKeys();
      const manifest = {
        schema_version: "1",
        tool: {
          name: "yzcli.agent",
          commands: ["manifest", "validate", "run"],
          operations: ["fastquery", "getMultiple", "create", "update", "delete", "approve", "disapprove"],
        },
        business_index: typeKeys.map((tk) => ({
          type_key: tk.type_key,
          title: tk.title,
          dll: tk.dll,
          aliases: tk.aliases,
          operations: tk.operations,
          operation_aliases: tk.operation_aliases,
        })),
      };
      print(formatOutput(manifest, opts.output as OutputFormat, opts.pretty));
    });

  // yzcli agent validate
  agent.command("validate")
    .description("验证请求 JSON 结构")
    .argument("<json>", "请求 JSON（内联或 @file.json）")
    .option("-o, --output <format>", "输出格式", "json")
    .option("--no-pretty", "紧凑 JSON 输出")
    .action((jsonStr, opts) => {
      try {
        const request = readJsonInput(jsonStr);
        const errors: string[] = [];

        if (!request.type_key) errors.push("缺少 type_key");
        if (!request.operation) errors.push("缺少 operation");

        const validOps = ["fastquery", "getMultiple", "create", "update", "delete", "approve", "disapprove"];
        if (request.operation && !validOps.includes(request.operation)) {
          errors.push(`无效 operation: ${request.operation}，可选: ${validOps.join(", ")}`);
        }

        if (errors.length > 0) {
          print(formatOutput({ success: false, error: { type: "validation_error", message: errors.join("; ") } }, opts.output as OutputFormat, opts.pretty));
          process.exit(2);
        }

        print(formatOutput({ success: true, request }, opts.output as OutputFormat, opts.pretty));
      } catch (e: any) {
        exitError(e.message);
      }
    });

  // yzcli agent run
  agent.command("run")
    .description("执行 ERP 操作")
    .argument("<json>", "请求 JSON（内联或 @file.json）")
    .option("--explain", "包含解析详情")
    .option("-o, --output <format>", "输出格式", "json")
    .option("--no-pretty", "紧凑 JSON 输出")
    .action(async (jsonStr, opts) => {
      try {
        const request = readJsonInput(jsonStr);
        const { type_key, operation, input = {} } = request;
        const client = clientFactory();

        let resolvedKey = type_key;
        const { findTypeKey, findTypeKeyByAlias } = await import("yzcli-sdk");
        let tk = findTypeKey(type_key);
        if (!tk) {
          const alias = findTypeKeyByAlias(type_key);
          if (alias) { tk = findTypeKey(alias); resolvedKey = alias; }
        }
        if (!tk) {
          exitError(`未知 TypeKey: "${type_key}"`);
          return;
        }
        resolvedKey = tk.type_key;

        let result: any;
        switch (operation) {
          case "fastquery": result = await client.query(resolvedKey, input); break;
          case "getMultiple": result = await client.get(resolvedKey, input.datakeys || []); break;
          case "create": result = await client.create(resolvedKey, input.cdsMaster || []); break;
          case "update": result = await client.update(resolvedKey, input.cdsMaster || []); break;
          case "delete": result = await client.delete(resolvedKey, input.datakeys || []); break;
          case "approve": result = await client.approve(resolvedKey, input.datakeys || []); break;
          case "disapprove": result = await client.disapprove(resolvedKey, input.datakeys || []); break;
          default: exitError(`未知操作: ${operation}`); return;
        }

        const output: any = {
          success: result.success,
          type_key: resolvedKey,
          operation,
          result: result.data,
          raw: { code: result.code, message: result.message },
        };

        if (opts.explain) {
          output.explain = {
            resolved: { type_key: resolvedKey, operation, service: `${resolvedKey}.${operation}` },
          };
        }

        print(formatOutput(output, opts.output as OutputFormat, opts.pretty));
        if (!result.success) process.exit(1);
      } catch (e: any) {
        exitError(e.message);
      }
    });

  return agent;
}
