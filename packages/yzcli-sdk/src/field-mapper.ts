/**
 * yzcli-sdk: 字段映射
 * 从 YAML 文件加载字段编号↔别名映射
 */
import { readFileSync, existsSync } from "node:fs";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { parse as parseYaml } from "yaml";
import type { FieldMeta } from "./types.js";

const __dirname = fileURLToPath(new URL(".", import.meta.url));

export interface FieldMappingData {
  version: number;
  generated_from: string[];
  typekeys: Array<{
    type_key: string;
    title: string;
    dll: string;
    aliases: string[];
    operations: string[];
    operation_aliases: Record<string, string[]>;
  }>;
}

let _cachedMapping: FieldMappingData | null = null;

function loadMappingData(): FieldMappingData {
  if (_cachedMapping) return _cachedMapping;

  // 尝试多个可能的路径
  const candidates = [
    join(__dirname, "data", "agent_typekey_map.yaml"),
    join(__dirname, "..", "..", "..", "src", "yzcli", "data", "agent_typekey_map.yaml"),
  ];

  for (const p of candidates) {
    if (existsSync(p)) {
      const content = readFileSync(p, "utf-8");
      _cachedMapping = parseYaml(content, { maxAliasCount: -1 }) as FieldMappingData;
      return _cachedMapping;
    }
  }

  throw new Error("agent_typekey_map.yaml not found");
}

/**
 * 获取所有 TypeKey 信息
 */
export function getAllTypeKeys(): FieldMappingData["typekeys"] {
  return loadMappingData().typekeys;
}

/**
 * 根据 TypeKey 查找信息
 */
export function findTypeKey(typeKey: string) {
  return getAllTypeKeys().find((tk) => tk.type_key === typeKey);
}

/**
 * 根据别名查找 TypeKey（中文名、DLL 标识等）
 */
export function findTypeKeyByAlias(alias: string): string | null {
  const lower = alias.toLowerCase();
  for (const tk of getAllTypeKeys()) {
    if (tk.type_key === alias) return tk.type_key;
    if (tk.aliases.some((a) => a === alias || a.toLowerCase() === lower)) {
      return tk.type_key;
    }
  }
  return null;
}

/**
 * 检查 TypeKey 是否支持某个操作
 */
export function supportsOperation(typeKey: string, operation: string): boolean {
  const tk = findTypeKey(typeKey);
  if (!tk) return false;
  return tk.operations.includes(operation);
}
