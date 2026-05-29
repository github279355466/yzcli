/**
 * yzcli-sdk: 配置加载
 * 读取 ~/.yzcli/config.yaml
 */
import { readFileSync, existsSync, mkdirSync } from "node:fs";
import { join } from "node:path";
import { homedir } from "node:os";
import { parse as parseYaml } from "yaml";
import type { ErpConfig } from "./types.js";

const DEFAULT_CONFIG_DIR = join(homedir(), ".yzcli");
const DEFAULT_CONFIG_FILE = join(DEFAULT_CONFIG_DIR, "config.yaml");

export interface YzcliConfig {
  erp: ErpConfig;
  fieldMode: "field_number" | "english_name";
}

const DEFAULT_CONFIG: YzcliConfig = {
  erp: {
    baseUrl: "http://172.16.6.22:8103",
    token: "",
    timeout: 30,
  },
  fieldMode: "field_number",
};

let _cachedConfig: YzcliConfig | null = null;

/**
 * 加载 ~/.yzcli/config.yaml
 * 优先级：环境变量 > config.yaml > 默认值
 */
export function loadConfig(configPath?: string): YzcliConfig {
  if (_cachedConfig && !configPath) return _cachedConfig;

  const filePath = configPath || DEFAULT_CONFIG_FILE;
  let fileData: Record<string, any> = {};

  if (existsSync(filePath)) {
    try {
      const content = readFileSync(filePath, "utf-8");
      fileData = parseYaml(content) || {};
    } catch {
      // 配置文件解析失败，使用默认值
    }
  }

  const erp = fileData.erp || {};
  const config: YzcliConfig = {
    erp: {
      baseUrl: process.env.ERP_BASE_URL || erp.base_url || DEFAULT_CONFIG.erp.baseUrl,
      token: process.env.ERP_TOKEN || erp.user_token || DEFAULT_CONFIG.erp.token,
      timeout: erp.timeout || DEFAULT_CONFIG.erp.timeout,
    },
    fieldMode: fileData.field_mode || DEFAULT_CONFIG.fieldMode,
  };

  if (!configPath) _cachedConfig = config;
  return config;
}

/**
 * 创建 ErpConfig（供 ErpClient 使用）
 */
export function getErpConfig(token?: string, baseUrl?: string): ErpConfig {
  const config = loadConfig();
  return {
    baseUrl: baseUrl || config.erp.baseUrl,
    token: token || config.erp.token,
    timeout: config.erp.timeout,
    fieldMode: config.fieldMode,
  };
}
