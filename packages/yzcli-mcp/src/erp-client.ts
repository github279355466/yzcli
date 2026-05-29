/**
 * ERP Client factory — creates ErpClient instances for MCP tools.
 *
 * Supports two modes:
 * 1. Config-based: reads from ~/.yzcli/config.yaml (default)
 * 2. Token-passing: accepts token from HTTP Header (centralized gateway)
 */
import { ErpClient, loadConfig, type ErpConfig } from "yzcli-sdk";
import { mcpLog } from "./logger.js";

let _sharedClient: ErpClient | null = null;

/**
 * Get or create an ErpClient for the given token.
 * In stdio mode: uses config file token.
 * In HTTP mode: uses token from Authorization header.
 */
export function getErpClient(token?: string, baseUrl?: string): ErpClient {
  if (token) {
    // HTTP gateway mode: create per-request client with passed token
    const config = loadConfig();
    return new ErpClient({
      baseUrl: baseUrl || config.erp.baseUrl,
      token,
      timeout: config.erp.timeout,
    });
  }

  // Stdio mode: reuse shared client from config
  if (!_sharedClient) {
    const config = loadConfig();
    if (!config.erp.token) {
      mcpLog("warning", { msg: "No ERP token configured. Set ERP_TOKEN env or ~/.yzcli/config.yaml" });
    }
    _sharedClient = new ErpClient(config.erp);
    mcpLog("erp_client_init", { baseUrl: config.erp.baseUrl });
  }
  return _sharedClient;
}

/**
 * Reset shared client (for testing)
 */
export function resetClient(): void {
  _sharedClient = null;
}
