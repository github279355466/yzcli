/**
 * yzcli-sdk: ERP OpenAPI 类型定义
 */

export interface ErpConfig {
  baseUrl: string;
  token: string;
  timeout?: number;
  fieldMode?: "field_number" | "english_name";
}

export interface ApiResponse {
  success: boolean;
  code: string;
  message: string;
  data: Record<string, any>;
  rawResponse: Record<string, any>;
}

export interface QueryParams {
  conditions?: Condition[];
  orders?: Order[];
  page_no?: number;
  page_size?: number;
  query_type?: "all" | "key";
  use_has_next?: boolean;
  load_data_browse_config?: boolean;
}

export interface Condition {
  groups?: ConditionGroup[];
  [key: string]: any;
}

export interface ConditionGroup {
  fields?: ConditionField[];
  [key: string]: any;
}

export interface ConditionField {
  field_name: string;
  operator: string;
  value: any;
  [key: string]: any;
}

export interface Order {
  field_name: string;
  order?: "asc" | "desc";
  [key: string]: any;
}

export type DataKey = Record<string, any>;
export type CdsRecord = Record<string, any>;

export interface TypeKeyInfo {
  type_key: string;
  title: string;
  dll: string;
  aliases: string[];
  operations: string[];
  operation_aliases: Record<string, string[]>;
}

export interface FieldMeta {
  fieldNumber: string;
  jsonName: string;
  displayLabel: string;
  dataType: string;
  size: number;
  required: boolean;
  readOnly: boolean;
  visible: boolean;
  fieldKind: string;
}

export interface ManifestData {
  schema_version: string;
  tool: {
    name: string;
    commands: string[];
    operations: string[];
  };
  request_schema: Record<string, any>;
  business_index: TypeKeyInfo[];
}

export class ApiClientError extends Error {
  constructor(
    message: string,
    public readonly type: string = "api_error",
    public readonly statusCode?: number,
  ) {
    super(message);
    this.name = "ApiClientError";
  }
}
