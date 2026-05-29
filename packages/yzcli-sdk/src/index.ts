/**
 * yzcli-sdk: 入口
 *
 * ERP OpenAPI TypeScript SDK
 * 供 yzcli-mcp 和 yzcli-cli 共享使用
 */

export { ErpClient } from "./client.js";
export { loadConfig, getErpConfig } from "./config.js";
export {
  getAllTypeKeys,
  findTypeKey,
  findTypeKeyByAlias,
  supportsOperation,
} from "./field-mapper.js";
export type { YzcliConfig } from "./config.js";
export type {
  ErpConfig,
  ApiResponse,
  QueryParams,
  Condition,
  ConditionGroup,
  ConditionField,
  Order,
  DataKey,
  CdsRecord,
  TypeKeyInfo,
  FieldMeta,
  ManifestData,
} from "./types.js";
export { ApiClientError } from "./types.js";
