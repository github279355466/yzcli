/**
 * Output formatter: JSON, table, CSV
 */
import { readFileSync, existsSync } from "node:fs";
import { resolve } from "node:path";

export type OutputFormat = "json" | "table" | "csv";

/**
 * Read JSON from inline string or @file path
 */
export function readJsonInput(input: string): any {
  if (input.startsWith("@")) {
    const filepath = resolve(input.slice(1));
    if (!existsSync(filepath)) {
      throw new Error(`File not found: ${filepath}`);
    }
    return JSON.parse(readFileSync(filepath, "utf-8"));
  }
  return JSON.parse(input);
}

/**
 * Parse key=value pairs into an object
 */
export function parseKeyValues(pairs: string[]): Record<string, string> {
  const result: Record<string, string> = {};
  for (const pair of pairs) {
    const idx = pair.indexOf("=");
    if (idx <= 0) {
      throw new Error(`Invalid key=value format: "${pair}". Use KEY=VALUE`);
    }
    result[pair.slice(0, idx)] = pair.slice(idx + 1);
  }
  return result;
}

/**
 * Parse condition strings like "field=value", "field>100", "field~like_text"
 */
export function parseConditions(conditions: string[]): Record<string, any>[] {
  return conditions.map((c) => {
    for (const op of [">=", "<=", "!=", "~", ">", "<", "="]) {
      const idx = c.indexOf(op);
      if (idx > 0) {
        const field = c.slice(0, idx);
        const value = c.slice(idx + op.length);
        return { field_name: field, operator: mapOperator(op), value };
      }
    }
    throw new Error(`Invalid condition format: "${c}". Use FIELD=VALUE, FIELD>VALUE, etc.`);
  });
}

function mapOperator(op: string): string {
  const map: Record<string, string> = {
    "=": "eq", ">": "gt", "<": "lt", ">=": "gte", "<=": "lte",
    "!=": "neq", "~": "like",
  };
  return map[op] || op;
}

/**
 * Format output based on format type
 */
export function formatOutput(data: any, format: OutputFormat = "json", pretty = true): string {
  if (format === "json") {
    return pretty ? JSON.stringify(data, null, 2) : JSON.stringify(data);
  }

  if (format === "table") {
    return formatTable(data);
  }

  if (format === "csv") {
    return formatCsv(data);
  }

  return JSON.stringify(data, null, 2);
}

function formatTable(data: any): string {
  const rows = Array.isArray(data) ? data : [data];
  if (rows.length === 0) return "(empty)";

  // Flatten nested objects for display
  const flatRows = rows.map((r) => flattenObject(r));
  const keys = [...new Set(flatRows.flatMap((r) => Object.keys(r)))];

  // Calculate column widths
  const widths: Record<string, number> = {};
  for (const k of keys) {
    widths[k] = k.length;
    for (const row of flatRows) {
      const val = String(row[k] ?? "");
      widths[k] = Math.max(widths[k], Math.min(val.length, 40));
    }
  }

  // Header
  const header = keys.map((k) => k.padEnd(widths[k])).join(" | ");
  const sep = keys.map((k) => "-".repeat(widths[k])).join("-+-");
  const lines = [header, sep];

  // Rows
  for (const row of flatRows) {
    const line = keys.map((k) => {
      const val = String(row[k] ?? "");
      return val.length > 40 ? val.slice(0, 37) + "..." : val.padEnd(widths[k]);
    }).join(" | ");
    lines.push(line);
  }

  return lines.join("\n");
}

function formatCsv(data: any): string {
  const rows = Array.isArray(data) ? data : [data];
  if (rows.length === 0) return "";

  const flatRows = rows.map((r) => flattenObject(r));
  const keys = [...new Set(flatRows.flatMap((r) => Object.keys(r)))];

  const lines = [keys.join(",")];
  for (const row of flatRows) {
    const vals = keys.map((k) => {
      const v = String(row[k] ?? "");
      return v.includes(",") || v.includes('"') ? `"${v.replace(/"/g, '""')}"` : v;
    });
    lines.push(vals.join(","));
  }

  return lines.join("\n");
}

function flattenObject(obj: any, prefix = ""): Record<string, any> {
  const result: Record<string, any> = {};
  for (const [key, value] of Object.entries(obj)) {
    const fullKey = prefix ? `${prefix}.${key}` : key;
    if (value && typeof value === "object" && !Array.isArray(value)) {
      Object.assign(result, flattenObject(value, fullKey));
    } else {
      result[fullKey] = Array.isArray(value) ? JSON.stringify(value) : value;
    }
  }
  return result;
}

/**
 * Print to stdout (with UTF-8 safety on Windows)
 */
export function print(text: string): void {
  process.stdout.write(text + "\n");
}

/**
 * Print error to stderr
 */
export function printError(message: string): void {
  process.stderr.write(`[yzcli] ERROR: ${message}\n`);
}

/**
 * Exit with error message
 */
export function exitError(message: string, code = 1): never {
  printError(message);
  process.exit(code);
}
