/**
 * yzcli config — 配置管理
 */
import { Command } from "commander";
import { readFileSync, writeFileSync, existsSync, mkdirSync } from "node:fs";
import { join } from "node:path";
import { homedir } from "node:os";
import { formatOutput, print, exitError, type OutputFormat } from "../output.js";

const CONFIG_DIR = join(homedir(), ".yzcli");
const CONFIG_FILE = join(CONFIG_DIR, "config.yaml");

function loadRawConfig(): Record<string, any> {
  if (!existsSync(CONFIG_FILE)) return {};
  try {
    const yaml = require("yaml");
    return yaml.parse(readFileSync(CONFIG_FILE, "utf-8")) || {};
  } catch {
    return {};
  }
}

export function createConfigCommand(): Command {
  const config = new Command("config")
    .description("配置管理");

  config.command("show")
    .description("显示当前配置")
    .option("-o, --output <format>", "输出格式", "json")
    .option("--no-pretty", "紧凑 JSON 输出")
    .action((opts) => {
      const cfg = loadRawConfig();
      // Mask token for security
      const masked = JSON.parse(JSON.stringify(cfg));
      if (masked.erp?.user_token) {
        masked.erp.user_token = masked.erp.user_token.slice(0, 8) + "...";
      }
      print(formatOutput(masked, opts.output as OutputFormat, opts.pretty));
    });

  config.command("get")
    .description("获取配置项")
    .argument("<key>", "配置键，如 erp.base_url")
    .action((key) => {
      const cfg = loadRawConfig();
      const parts = key.split(".");
      let val: any = cfg;
      for (const p of parts) {
        val = val?.[p];
      }
      if (val === undefined) {
        exitError(`配置项 "${key}" 不存在`);
        return;
      }
      print(typeof val === "object" ? JSON.stringify(val, null, 2) : String(val));
    });

  config.command("set")
    .description("设置配置项")
    .argument("<key>", "配置键，如 erp.base_url")
    .argument("<value>", "配置值")
    .action((key, value) => {
      const cfg = loadRawConfig();
      const parts = key.split(".");
      let obj: any = cfg;
      for (let i = 0; i < parts.length - 1; i++) {
        if (!obj[parts[i]]) obj[parts[i]] = {};
        obj = obj[parts[i]];
      }
      // Try to parse as number/boolean
      let parsed: any = value;
      if (value === "true") parsed = true;
      else if (value === "false") parsed = false;
      else if (/^\d+$/.test(value)) parsed = parseInt(value, 10);
      else if (/^\d+\.\d+$/.test(value)) parsed = parseFloat(value);

      obj[parts[parts.length - 1]] = parsed;

      mkdirSync(CONFIG_DIR, { recursive: true });
      // Simple YAML output (no yaml dependency needed for write)
      writeFileSync(CONFIG_FILE, yamlStringify(cfg), "utf-8");
      print(`已设置 ${key} = ${value}`);
    });

  return config;
}

function yamlStringify(obj: any, indent = 0): string {
  const lines: string[] = [];
  const prefix = "  ".repeat(indent);
  for (const [key, val] of Object.entries(obj)) {
    if (val && typeof val === "object" && !Array.isArray(val)) {
      lines.push(`${prefix}${key}:`);
      lines.push(yamlStringify(val, indent + 1));
    } else if (typeof val === "string") {
      lines.push(`${prefix}${key}: "${val}"`);
    } else {
      lines.push(`${prefix}${key}: ${val}`);
    }
  }
  return lines.join("\n");
}
