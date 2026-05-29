/**
 * MCP Logger: structured stderr logging
 * All output goes to stderr to avoid interfering with MCP JSON-RPC on stdout.
 */
const MCP_PREFIX = "[MCP]";

function isoNow(): string {
  return new Date().toISOString();
}

function formatKv(pairs: Record<string, unknown>): string {
  return Object.entries(pairs)
    .map(([k, v]) => `${k}=${v}`)
    .join(" ");
}

export function mcpLog(message: string, meta?: Record<string, unknown>): void {
  const ts = isoNow();
  const kv = meta ? " " + formatKv(meta) : "";
  process.stderr.write(`${MCP_PREFIX} ${ts} ${message}${kv}\n`);
}

export function mcpTimer(label: string) {
  const start = performance.now();
  return {
    stop(extra?: Record<string, unknown>) {
      const elapsed = Math.round(performance.now() - start);
      mcpLog(label, { elapsed: `${elapsed}ms`, ...extra });
      return elapsed;
    },
  };
}
