/**
 * yzcli-sdk: ERP OpenAPI 客户端
 * 移植自 Python api_client.py
 */
import type {
  ErpConfig,
  ApiResponse,
  QueryParams,
  DataKey,
  CdsRecord,
  TypeKeyInfo,
  ManifestData,
} from "./types.js";
import { ApiClientError } from "./types.js";

export class ErpClient {
  private baseUrl: string;
  private token: string;
  private timeout: number;

  constructor(config: ErpConfig) {
    this.baseUrl = config.baseUrl.replace(/\/+$/, "");
    this.token = config.token;
    this.timeout = (config.timeout || 30) * 1000;
  }

  private buildHeaders(serviceName: string): Record<string, string> {
    return {
      "Content-Type": "application/json; charset=utf-8",
      "digi-service": JSON.stringify({ name: serviceName }),
      "digi-user-token": this.token,
    };
  }

  private parseResponse(raw: Record<string, any>): ApiResponse {
    const stdData = raw.std_data || {};
    const execution = stdData.execution || {};
    const code = execution.code || "-1";
    const description = execution.description || "";
    const success = code === "0" || code === "-0";

    return {
      success,
      code,
      message: description,
      data: stdData.parameter || {},
      rawResponse: raw,
    };
  }

  /**
   * 核心：调用 ERP OpenAPI
   */
  async call(serviceName: string, parameter?: Record<string, any>): Promise<ApiResponse> {
    const fullName = serviceName.startsWith("yz.oapi.")
      ? serviceName
      : `yz.oapi.${serviceName}`;

    const headers = this.buildHeaders(fullName);
    const body = { std_data: { parameter: parameter || {} } };

    try {
      const controller = new AbortController();
      const timer = setTimeout(() => controller.abort(), this.timeout);

      const response = await fetch(this.baseUrl, {
        method: "POST",
        headers,
        body: JSON.stringify(body),
        signal: controller.signal,
      });

      clearTimeout(timer);

      if (!response.ok) {
        throw new ApiClientError(
          `HTTP ${response.status}: ${response.statusText}`,
          "http_error",
          response.status,
        );
      }

      // 强制 UTF-8 解码（ERP 可能返回 Content-Type: text/html）
      const buffer = await response.arrayBuffer();
      let text: string;
      try {
        text = new TextDecoder("utf-8").decode(buffer);
      } catch {
        text = new TextDecoder("latin1").decode(buffer);
      }

      // 去除 BOM 和控制字符
      text = text.replace(/^﻿/, "");
      text = text.replace(/[\x00-\x08\x0B\x0C\x0E-\x1F]/g, "");

      let raw: Record<string, any>;
      try {
        raw = JSON.parse(text);
      } catch (e) {
        throw new ApiClientError(
          `响应不是有效的JSON: ${text.slice(0, 300)}`,
          "parse_error",
        );
      }

      return this.parseResponse(raw);
    } catch (e) {
      if (e instanceof ApiClientError) throw e;
      throw new ApiClientError(
        `HTTP请求失败: ${(e as Error).message}`,
        "network_error",
      );
    }
  }

  // ===== 便捷方法 =====

  async query(typeKey: string, params: QueryParams = {}): Promise<ApiResponse> {
    const parameter: Record<string, any> = {
      load_data_browse_config: params.load_data_browse_config ?? false,
      page_no: params.page_no ?? 1,
      page_size: params.page_size ?? 20,
      use_has_next: params.use_has_next ?? true,
      query_type: params.query_type ?? "all",
    };
    if (params.conditions) parameter.conditions = params.conditions;
    if (params.orders) parameter.orders = params.orders;
    return this.call(`${typeKey}.query`, parameter);
  }

  async get(typeKey: string, datakeys: DataKey[]): Promise<ApiResponse> {
    return this.call(`${typeKey}.get`, {
      load_data_browse_config: false,
      datakeys,
    });
  }

  async create(typeKey: string, cdsMaster: CdsRecord[]): Promise<ApiResponse> {
    return this.call(`${typeKey}.create`, { cdsMaster });
  }

  async update(typeKey: string, cdsMaster: CdsRecord[]): Promise<ApiResponse> {
    return this.call(`${typeKey}.update`, { cdsMaster });
  }

  async delete(typeKey: string, datakeys: DataKey[]): Promise<ApiResponse> {
    return this.call(`${typeKey}.delete`, { datakeys });
  }

  async approve(typeKey: string, datakeys: DataKey[]): Promise<ApiResponse> {
    return this.call(`${typeKey}.approve`, { datakeys });
  }

  async disapprove(typeKey: string, datakeys: DataKey[]): Promise<ApiResponse> {
    return this.call(`${typeKey}.disapprove`, { datakeys });
  }

  async typeKeyList(): Promise<TypeKeyInfo[]> {
    const resp = await this.call("typekeyList");
    if (!resp.success) {
      throw new ApiClientError(`获取TypeKey列表失败: ${resp.message}`);
    }
    const result = resp.data.result?.success || [];
    if (result.length > 0) {
      return result[0].typekeys || [];
    }
    return [];
  }
}
