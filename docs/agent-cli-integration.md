# AI Agent CLI 集成协议

## 设计目标

`yzcli agent` 为外部 AI Agent 提供结构化 JSON 接口，使 Agent 无需解析人类文本即可调用易助 ERP OpenAPI。

**第一阶段边界：**

- 不内置 LLM，不内置自然语言理解。
- 不做 MCP server / skill 适配（后续阶段）。
- CLI 只接收结构化 JSON，输出固定 JSON。
- 外部 Agent 负责：自然语言理解 → 根据 manifest/YAML 映射到 `type_key + operation` → 生成 JSON → 调用 CLI。

## 快速开始

### 推荐调用流程

```
外部 Agent
  │
  ├─ 1. yzcli agent manifest --pretty     → 获取 schema + 业务索引
  ├─ 2. yzcli help <type_key> --output json → 按需获取字段明细
  ├─ 3. 生成 request JSON
  ├─ 4. yzcli agent validate @request.json → 校验请求
  └─ 5. yzcli agent run @request.json      → 执行请求
```

### JSON 输入方式

```bash
# 从文件读取
yzcli agent run @request.json --pretty

# 从 stdin 读取
echo '{"type_key":"sales.order","operation":"fastquery","input":{"page_size":1}}' | yzcli agent run - --pretty

# 直接传 JSON 字符串
yzcli agent run '{"type_key":"sales.order","operation":"fastquery","input":{}}' --pretty
```

## 命令参考

### `yzcli agent manifest`

获取工具级 schema 和业务索引。Agent 首次接入时调用此命令了解可用能力。

```bash
yzcli agent manifest --pretty
```

输出结构：

```json
{
  "schema_version": "1",
  "tool": {
    "name": "yzcli.agent",
    "commands": ["manifest", "validate", "run", "generate-map"],
    "operations": ["fastquery", "getMultiple", "create", "update", "delete", "approve", "disapprove"]
  },
  "request_schema": { ... },
  "business_index": [
    {
      "type_key": "sales.order",
      "title": "订单",
      "dll": "COPDC02",
      "aliases": ["订单", "sales.order", "sales order", "COPDC02"],
      "operations": ["fastquery", "getMultiple", "create", "update", "delete", "approve", "disapprove"],
      "operation_aliases": {
        "fastquery": ["查询", "列表", "搜索"],
        "getMultiple": ["读取", "详情", "查看"],
        "create": ["新增", "创建"],
        "update": ["更新", "修改"],
        "delete": ["删除"],
        "approve": ["审核"],
        "disapprove": ["撤审", "取消审核"]
      },
      "field_help": "yzcli help sales.order --output json"
    }
  ]
}
```

**注意：** manifest 不包含字段明细，避免输出过大。字段信息通过 `yzcli help <type_key> --output json` 按需获取。

### `yzcli agent validate`

校验请求 JSON 的顶层结构（type_key、operation、必填 input 字段），不校验字段是否真实存在于 ERP。

```bash
yzcli agent validate @request.json --pretty
```

退出码：
- `0` — 校验通过
- `2` — 校验失败

### `yzcli agent run`

执行请求，调用 ERP API 并返回结果。

```bash
yzcli agent run @request.json --pretty
yzcli agent run @request.json --pretty --explain
```

退出码：
- `0` — 执行成功
- `1` — API 错误或内部错误

`--explain` 选项会在成功响应中追加 `explain` 字段，包含路由解析和字段转换信息。

### `yzcli agent generate-map`

从离线文档（`docs/json节点对照/` 和 `docs/specs/`）重新生成包内置 YAML 映射。仅供维护使用。

```bash
yzcli agent generate-map --project-root /path/to/yzcli --pretty
```

**限制：** pip 安装环境中包数据目录通常不可写，此时会返回 `mapping_error`。请在源码 checkout 中运行。

## 请求 Schema

### 基本结构

```json
{
  "type_key": "sales.order",
  "operation": "fastquery",
  "input": { }
}
```

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `type_key` | string | 是 | TypeKey，如 `sales.order` |
| `operation` | string | 是 | 操作类型，见下表 |
| `input` | object | 否 | 操作特定参数，默认 `{}` |

### 支持的操作

| 操作 | 说明 | 必填 input 字段 |
|------|------|-----------------|
| `fastquery` | 条件搜索（列表级，仅单头数据） | 无（可选 conditions, orders, page_no, page_size） |
| `getMultiple` | 按主键读取（完整级，单头+单身明细） | `datakeys`（非空数组） |
| `create` | 新增记录 | `cdsMaster`（非空数组） |
| `update` | 更新记录 | `cdsMaster`（非空数组） |
| `delete` | 删除记录 | `datakeys`（非空数组） |
| `approve` | 审核 | `datakeys`（非空数组） |
| `disapprove` | 撤审 | `datakeys`（非空数组） |

> **向后兼容**：CLI 同时接受旧操作名 `query`（等同 `fastquery`）和 `get`（等同 `getMultiple`）。新代码请使用 `fastquery`/`getMultiple`。

### fastquery 参数

```json
{
  "type_key": "sales.order",
  "operation": "fastquery",
  "input": {
    "conditions": [],
    "orders": [],
    "page_no": 1,
    "page_size": 20,
    "query_type": "all",
    "use_has_next": true,
    "load_data_browse_config": false
  }
}
```

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `conditions` | array | `[]` | 查询条件 |
| `orders` | array | `[]` | 排序 |
| `page_no` | integer | `1` | 页码 |
| `page_size` | integer | `20` | 每页条数 |
| `query_type` | string | `"all"` | 查询类型：`all` 或 `key` |
| `use_has_next` | boolean | `true` | 是否使用分页 |
| `load_data_browse_config` | boolean | `false` | 是否加载浏览配置 |

### getMultiple / delete / approve / disapprove 参数

```json
{
  "type_key": "sales.order",
  "operation": "getMultiple",
  "input": {
    "datakeys": [
      {"IBA001": "SO20250001"}
    ]
  }
}
```

`datakeys` 为包含主键字典的数组，每个字典的 key 可以是字段编号或英文节点名（自动转换）。

### create / update 参数

```json
{
  "type_key": "sales.order",
  "operation": "create",
  "input": {
    "cdsMaster": [
      {
        "IBA001": "SO20250001",
        "IBA004": "2025-05-27",
        "cdsDetail": [
          {"IBB001": "P001", "IBB004": 100}
        ]
      }
    ]
  }
}
```

## 响应格式

### 成功响应（默认）

```json
{
  "success": true,
  "type_key": "sales.order",
  "operation": "fastquery",
  "result": {
    "success": { ... }
  },
  "raw": {
    "code": "0",
    "message": ""
  }
}
```

### 成功响应（`--explain`）

在默认响应基础上追加 `explain` 字段：

```json
{
  "success": true,
  "type_key": "sales.order",
  "operation": "fastquery",
  "result": { ... },
  "raw": { ... },
  "explain": {
    "resolved": {
      "type_key": "sales.order",
      "operation": "fastquery",
      "service": "sales.order.query"
    },
    "field_conversions": [
      {
        "path": "datakeys[0].docNo",
        "from": "docNo",
        "to": "IBA001"
      }
    ],
    "equivalent_cli": "yzcli query sales.order --condition '...'"
  }
}
```

### 失败响应（统一错误对象）

```json
{
  "success": false,
  "error": {
    "type": "api_error",
    "message": "ERP returned error",
    "details": {
      "code": "-1",
      "api_errors": [
        {"message": "单号不存在", "data": {}}
      ]
    },
    "suggestions": [
      "Check input parameters",
      "Use yzcli help sales.order --output json to verify field names"
    ]
  }
}
```

#### 错误类型

| `error.type` | 说明 |
|--------------|------|
| `invalid_json` | JSON 解析失败 |
| `validation_error` | 请求结构校验失败 |
| `unsupported_operation` | 不支持的操作类型 |
| `api_error` | ERP API 返回错误 |
| `io_error` | 文件读取或 stdin 读取失败 |
| `mapping_error` | 字段映射加载失败或 YAML 写入失败 |
| `internal_error` | 未预期的内部错误 |

## 字段自动转换

`agent run` 会自动将输入中的英文字段名转换为字段编号（field_number），然后传给 API。

**转换覆盖范围：**

| 位置 | 说明 |
|------|------|
| `datakeys[*]` 的 key | 主键字段名 |
| `conditions[*].groups[*].fields[*].field_name` | 查询条件字段名 |
| `orders[*].field_name` | 排序字段名 |
| `cdsMaster[*]` 的 key | 主表字段名 |
| `cdsMaster[*].cdsDetail[*]` 的 key | 明细表字段名 |
| `cdsMaster[*].cdsDetail2[*]` 的 key | 明细表2字段名 |
| 顶层 `cdsDetail[*]` 的 key | 独立明细表字段名 |
| 顶层 `cdsDetail2[*]` 的 key | 独立明细表2字段名 |

**规则：**
- 能转换的字段名 → 转为字段编号。
- 无法转换的字段名 → 原样保留，不报错。
- 如需绕过转换，直接使用字段编号（如 `IBA001`）即可。

## 联调示例：sales.order fastquery → getMultiple

### 第 1 步：查询第一条销售订单

```bash
echo '{
  "type_key": "sales.order",
  "operation": "fastquery",
  "input": {
    "page_no": 1,
    "page_size": 1,
    "query_type": "all"
  }
}' | yzcli agent run - --pretty
```

期望返回 `success: true` 且 `result.success` 中有订单数据。

### 第 2 步：从 fastquery 结果提取主键，调用 getMultiple

```json
{
  "type_key": "sales.order",
  "operation": "getMultiple",
  "input": {
    "datakeys": [
      {"IBA001": "从 fastquery 结果中取得的单号"}
    ]
  }
}
```

```bash
yzcli agent run @get_request.json --pretty --explain
```

期望返回 `success: true`，`--explain` 会显示 resolved service 和字段转换信息。

## 退出码汇总

| 退出码 | 含义 |
|--------|------|
| `0` | 成功 |
| `1` | API 错误 / IO 错误 / 内部错误 |
| `2` | 请求校验失败（仅 `validate`） |

## 内部实现说明

- `agent run` 直接调用 `OpenAPIClient` 和 `FieldMapper`，不经过现有 Click 子命令。
- 输出固定为 JSON，不受全局 `--output` 选项影响。
- 包内置 YAML 映射通过 `importlib.resources` 加载，随 pip 安装分发。
- 校验只做顶层 JSON schema 校验，不校验字段是否存在于 ERP。
- API 错误从 `parameter.result.error[].message` 提取，包装在统一错误对象中。
