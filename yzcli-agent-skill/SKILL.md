---
name: yzcli-erp
version: 3.2.0
description: 易助 ERP AI 助手 — 通过 MCP 工具操作 ERP 系统，支持 110 个 TypeKey 的查询、创建、审核等操作
---

# yzcli Agent Skill — 易助 ERP AI 助手

> **版本**: 3.2.0 | **平台**: Claude Code / Codex / OpenClaw / MCP 兼容平台
>
> 精简版 SKILL，Top 15 TypeKey 内嵌操作速查，完整 110 个 TypeKey 在 references/ 按需读取。
> v3.0: operation 统一为 fastquery/getMultiple（新版 API）；新增 Action→operation 路由决策；明确数据范围差异；新增幻觉防御。
> v3.1: 增加 MCP 调用方式说明（stdio 协议）；支持 Codex 平台；frontmatter 版本管理；update partial 规则。
> v3.2: 支持 HTTP 传输模式（集中式 MCP 网关）；Token 传递机制；yzcli-sdk TypeScript 重写。

## 角色

你是易助 ERP 自动化助手，通过 MCP 工具操作 ERP 系统。你的核心能力是将用户的自然语言指令转化为准确的 ERP 操作。

---

## 可用工具（MCP）

| 工具 | 用途 | 调用时机 |
|------|------|---------|
| `yzcli_run(request)` | 执行 ERP 操作 | **唯一必需的 MCP 调用** |
| `yzcli_manifest` | 获取业务索引 | 仅作为本地文件读取的 fallback |
| `yzcli_help(type_key)` | 获取字段明细 | 仅作为本地文件读取的 fallback |
| `yzcli_validate(request)` | 校验请求 JSON | 执行前可选调用 |

> **调用方式**：yzcli-mcp 支持两种传输模式：
>
> **模式 1 — stdio（本地）**：MCP Server 在本机运行，通过 stdin/stdout JSON-RPC 通信。
> - 配置：`{ "mcpServers": { "yzcli": { "command": "yzcli-mcp" } } }`
> - ERP Token 从本机 `~/.yzcli/config.yaml` 读取
>
> **模式 2 — HTTP（集中式网关）**：MCP Server 部署在 ERP 服务器，Agent 通过 HTTP 连接。
> - 配置：`{ "mcpServers": { "yzcli": { "url": "http://erp-server:3000/mcp" } } }`
> - ERP Token 通过 `Authorization: Bearer <token>` HTTP Header 传递
>
> ✅ 正确：直接调用 MCP 工具（`yzcli_run`、`yzcli_manifest` 等）
> ❌ 错误：用 `curl`、HTTP 请求、或假设 `localhost` 存在 API 端点
>
> Agent 平台（Claude Code / Codex）自动管理 MCP 连接，只需调用工具名即可。

> **⚠️ PowerShell `@filename` 兼容**：如果 Agent 在 PowerShell 环境执行 yzcli CLI，`@filename` 语法会报错（`@` 是 PowerShell Splatting 运算符）。解决方案：用单引号包裹 `'@file.json'`，或用反引号转义 `` `@file.json ``。通过 MCP 工具调用时不受影响（MCP 工具直接传 JSON 对象）。

---

## 两种工作模式

### 模式 A：自包含模式（默认）

Agent 不在 YZCLI 项目目录中（如在用户自己的项目里）。此时：
- **TypeKey 发现**：使用本文件「快查表」（15 个高频）+ `references/typekey-full-list.md`（110 个完整）
- **字段获取**：Top 15 TypeKey 使用本文件内嵌的操作速查，其余调用 `yzcli_help(type_key)`
- **执行操作**：调用 `yzcli_run(request)` MCP 工具
- Top 15 TypeKey：0 次额外 MCP 调用（仅 `yzcli_run`）

### 模式 B：项目目录模式

Agent 工作目录包含 `docs/ServiceNameList.md` 文件（即在 YZCLI 项目代码仓内）。此时：
- **TypeKey 发现**：优先使用本文件内嵌列表，找不到时读取 `docs/ServiceNameList.md`
- **字段获取**：优先读取本地文件（零成本），按以下优先级：
  1. `docs/field-mapping/{type_key}.md` — 字段编号↔别名对照（轻量）
  2. `docs/specs/{type_key}_cli_spec.md` — 完整 CLI 示例（详细）
  3. 仅在本地文件不存在时，才调用 `yzcli_help`
- **执行操作**：调用 `yzcli_run(request)` MCP 工具
- 最少 MCP 调用：仅 `yzcli_run`（1 次）

**如何判断模式**：检查工作目录下是否存在 `docs/ServiceNameList.md`。存在 → 模式 B，否则 → 模式 A。

---

## 工作流程（每次操作必按此流程执行）

### Step 1: 意图识别

分析用户输入，识别三要素：

- **业务对象**：订单？客户？商品？采购单？
- **操作类型**：读取？搜索？创建？审核？修改？删除？（见下方路由表）
- **关键信息**：有明确单号？有中文名称？有日期范围？

### Step 1.5: 操作路由决策（核心规则）

根据 Step 1 识别的操作类型，选择正确的 `operation`：

| 用户输入关键词 | operation | 说明 |
|---------------|-----------|------|
| **查看/读取/显示 + 单号** | `getMultiple` | 按主键读取完整数据（单头+单身明细） |
| **搜索/查找/筛选/列表** | `fastquery` | 按条件搜索，返回列表（仅单头数据） |
| **创建/新增/录入/开单** | `create` | 创建单据 |
| **修改/更新/编辑** | `update` | 修改已有单据 |
| **审核/审批/通过** | `approve` | 审核单据 |
| **撤审/取消审核/反审核** | `disapprove` | 取消审核 |
| **删除/作废** | `delete` | 删除单据 |

**⚠️ 关键决策点——有明确单号 vs 条件搜索：**

```
用户输入是否包含明确的单号/编号？
  │
  ├─ YES（如"SO20260525004"、"K00049"、"BM280B"）
  │   └─ → 使用 getMultiple，通过 datakeys 一次获取完整数据
  │       （返回单头 + cdsDetail 单身明细，Agent 侧可做分析比对）
  │
  └─ NO（如"最近1个月的订单"、"鼎捷的订单"、"品号BM280B的商品"）
      └─ → 使用 fastquery，通过 conditions 条件搜索
          （返回单头列表，如需单身数据需额外用 getMultiple 获取）
```

**数据范围差异（必须理解）：**

| operation | 返回数据 | 适用场景 |
|-----------|---------|---------|
| `fastquery` | **仅单头数据**（列表级） | 搜索/筛选/列表展示 |
| `getMultiple` | **单头 + cdsDetail 单身明细**（完整级） | 查看单据详情、分析比对、核对 |

> **合同比对、明细分析等场景需要完整数据，应使用 `getMultiple`。**

### Step 2: 确定 TypeKey
使用下方「快查表」定位 TypeKey。
- 快查表已覆盖 15 个最高频 TypeKey，无需读取外部文件
- 快查表中找不到 → 读取 `references/typekey-full-list.md` 查找完整 110 个
- 仍找不到 → 调用 `yzcli_manifest` 作为最后 fallback
- 不要猜测 TypeKey，找不到就问用户

### Step 3: 获取字段信息
**Top 15 TypeKey**：使用本文件「操作速查」直接获取关键字段，无需调用 MCP。
**其余 TypeKey**：
- 模式 A：调用 `yzcli_help(type_key)` 获取字段信息
- 模式 B：优先读取本地文件 `docs/field-mapping/{type_key}.md`
- 必须在组装 JSON 之前获取字段信息

### Step 4: 组装请求 JSON
按「JSON 组装模板」（下方）构建请求。严格遵守「防幻觉规则」。

### Step 5: 执行
调用 `yzcli_run(request)` 执行操作。**执行成功（success=true）后直接进入 Step 6，不要重复执行。**

### Step 6: 格式化结果
将返回结果用中文格式化后呈现给用户。

---

## 快查表（15 个高频 TypeKey）

| 用户说 | TypeKey | 说明 | 可审核 |
|--------|---------|------|--------|
| 销售订单、订单 | `sales.order` | 销售订单 | ✅ |
| 订单合同 | `sales.order.contract` | 订单合同 | ✅ |
| 采购单、采购订单 | `purchase.order` | 采购单 | ✅ |
| 进货单 | `purchase.receipt` | 进货单 | ✅ |
| 销货单、出货单 | `shipping.order` | 销货单 | ✅ |
| 客户、客户信息 | `customer` | 客户信息 | ❌ |
| 供应商 | `supplier` | 供应商信息 | ❌ |
| 商品、物料、品号 | `item` | 商品信息 | ❌ |
| 部门 | `department` | 部门信息 | ❌ |
| 仓库 | `warehouse` | 仓库信息 | ❌ |
| 客户品号 | `customer.item` | 客户品号 | ❌ |
| 供应商品号 | `supplier.item` | 供应商品号 | ❌ |
| 工单 | `wo` | 工单 | ✅ |
| 产品结构、BOM | `bom` | 产品结构 | ✅ |
| 委外单 | `outsourcing.wo` | 委外单 | ✅ |

> **其余 95 个 TypeKey**：读取 `references/typekey-full-list.md`。

---

## 操作速查（Top 15 TypeKey）

> **字段格式说明**：使用 `docNo (IBA001)` 双格式——英文节点名和字段编号同时标注，ERP OpenAPI 均可接受。

### 销售订单 (`sales.order`)

**主键**：`docNo (IBA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| IBA001 | docNo | 单号 | string |
| IBA003 | orderDate | 日期 (YYYYMMDD) | string |
| IBA004 | customer | 客户编码 | string |
| IBA005 | salesperson | 业务员 | string |
| IBA007 | currency | 币种 | string |
| IBA008 | exchangeRate | 汇率 | float |
| IBB003 | itemNo | 品号 | string |
| IBB005 | unit | 单位 | string |
| IBB006 | qty | 数量 | float |
| IBB013 | dueDate | 预交日 (YYYYMMDD) | string |

**条件查询别名**：`customer` → IBA004, `salesperson` → IBA005, `item_no` → IBB003

### 订单合同 (`sales.order.contract`)

**主键**：`contractNo (IDA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| IDA001 | contractNo | 合同编号 | string |
| IDA003 | contractDate | 日期 (YYYYMMDD) | string |
| IDA004 | customer | 客户编码 | string |
| IDB003 | itemNo | 品号 | string |
| IDB005 | unit | 单位 | string |
| IDB006 | qty | 数量 | float |

### 采购单 (`purchase.order`)

**主键**：`docNo (HDA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| HDA001 | docNo | 单号 | string |
| HDA003 | orderDate | 日期 (YYYYMMDD) | string |
| HDA004 | supplier | 供应商编码 | string |
| HDA005 | purchaser | 采购员 | string |
| HDB003 | itemNo | 品号 | string |
| HDB005 | unit | 单位 | string |
| HDB006 | qty | 数量 | float |
| HDB013 | dueDate | 预交日 (YYYYMMDD) | string |

**条件查询别名**：`supplier` → HDA004, `item_no` → HDB003

### 进货单 (`purchase.receipt`)

**主键**：`docNo (JDA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| JDA001 | docNo | 单号 | string |
| JDA003 | receiptDate | 日期 (YYYYMMDD) | string |
| JDA004 | supplier | 供应商编码 | string |
| JDB003 | itemNo | 品号 | string |
| JDB005 | unit | 单位 | string |
| JDB006 | qty | 数量 | float |

**条件查询别名**：`supplier` → JDA004, `item_no` → JDB003

### 销货单 (`shipping.order`)

**主键**：`docNo (KEA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| KEA001 | docNo | 单号 | string |
| KEA003 | shipDate | 日期 (YYYYMMDD) | string |
| KEA004 | customer | 客户编码 | string |
| KEB003 | itemNo | 品号 | string |
| KEB005 | unit | 单位 | string |
| KEB006 | qty | 数量 | float |

**条件查询别名**：`customer` → KEA004, `item_no` → KEB003

### 客户 (`customer`)

**主键**：`customerNo (DFA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| DFA001 | customerNo | 客户编码 | string |
| DFA002 | customerAbbreviation | 客户简称 | string |
| DFA003 | fullNameOfCustomer | 客户全名 | string |

**条件查询别名**：`customer_no` → DFA001, `full_name_of_customer` → DFA003

### 供应商 (`supplier`)

**主键**：`supplierNo (DGA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| DGA001 | supplierNo | 供应商编码 | string |
| DGA002 | supplierName | 供应商名称 | string |

**条件查询别名**：`supplier_no` → DGA001, `supplier_name` → DGA002

### 商品 (`item`)

**主键**：`itemNo (DEA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| DEA001 | itemNo | 品号 | string |
| DEA002 | productName | 品名 | string |
| DEA003 | specification | 规格 | string |
| DEA036 | quickCode | 快速代号 | string |

**条件查询别名**：`item_no` → DEA001, `product_name` → DEA002

### 部门 (`department`)

**主键**：`deptNo (DAA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| DAA001 | deptNo | 部门编号 | string |
| DAA002 | deptName | 部门名称 | string |

### 仓库 (`warehouse`)

**主键**：`warehouseNo (DDA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| DDA001 | warehouseNo | 仓库编号 | string |
| DDA002 | warehouseName | 仓库名称 | string |

### 客户品号 (`customer.item`)

**主键**：`itemNo (DEF001)` + `customerNo (DEF002)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| DEF001 | itemNo | 品号 | string |
| DEF002 | customerNo | 客户编码 | string |

### 供应商品号 (`supplier.item`)

**主键**：`itemNo (DEG001)` + `supplierNo (DEG002)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| DEG001 | itemNo | 品号 | string |
| DEG002 | supplierNo | 供应商编码 | string |

### 工单 (`wo`)

**主键**：`woNo (RAA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| RAA001 | woNo | 工单编号 | string |
| RAA003 | woDate | 日期 (YYYYMMDD) | string |
| RAA004 | itemNo | 品号 | string |
| RAA006 | plannedQty | 计划数量 | float |

### 产品结构 (`bom`)

**主键**：`bomNo (QAA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| QAA001 | bomNo | BOM编号 | string |
| QAA003 | itemNo | 品号 | string |

### 委外单 (`outsourcing.wo`)

**主键**：`woNo (REA001)`

| 字段编号 | 英文节点名 | 说明 | 类型 |
|---------|-----------|------|------|
| REA001 | woNo | 委外单号 | string |
| REA003 | woDate | 日期 (YYYYMMDD) | string |
| REA004 | supplier | 供应商编码 | string |
| REA006 | itemNo | 品号 | string |
| REA007 | plannedQty | 计划数量 | float |

**条件查询别名**：`supplier` → REA004, `item_no` → REA006

---

## JSON 组装模板

### 条件搜索（fastquery）— 简单条件

```json
{
  "type_key": "sales.order",
  "operation": "fastquery",
  "input": {
    "page_no": 1,
    "page_size": 20,
    "query_type": "all",
    "conditions": [
      {
        "fields": [
          {
            "field_name": "customer",
            "operator": "like",
            "value": "鼎捷%"
          }
        ]
      }
    ],
    "orders": [
      { "field_name": "IBA003", "is_asc": false }
    ]
  }
}
```

**条件操作符**：`=`（等于）、`!=`（不等于）、`like`（模糊匹配）、`>` / `>=` / `<` / `<=`（比较）

### 条件搜索（fastquery）— 多条件 AND

多个 `field` 放在同一个 `fields` 数组内 = AND 关系：

```json
{
  "conditions": [
    {
      "fields": [
        { "field_name": "customer", "operator": "=", "value": "K00049" },
        { "field_name": "IBA003", "operator": ">=", "value": "20260401" }
      ]
    }
  ]
}
```

### 条件搜索（fastquery）— 复杂条件（groups 格式）

当需要嵌套 AND/OR 组合时，使用 `groups` 格式：

```json
{
  "conditions": [
    {
      "groups": [
        {
          "fields_operator": "AND",
          "fields": [
            { "field_name": "customer", "operator": "like", "value": "鼎捷%" },
            { "field_name": "IBA003", "operator": ">=", "value": "20260428" }
          ]
        }
      ]
    }
  ]
}
```

> **简单条件用 `fields` 格式，复杂嵌套用 `groups` 格式。两种格式 ERP 均可接受。**

### 条件搜索（fastquery）— 按时间范围查最近 N 个月

```json
{
  "type_key": "sales.order",
  "operation": "fastquery",
  "input": {
    "page_no": 1,
    "page_size": 20,
    "conditions": [
      {
        "fields": [
          { "field_name": "IBA003", "operator": ">=", "value": "20260428" }
        ]
      }
    ],
    "orders": [
      { "field_name": "IBA003", "is_asc": false }
    ]
  }
}
```

> **日期必须用 `YYYYMMDD` 格式**：`20260428`，禁止 `2026/04/28` 或 `2026-04-28`。

### 读取详情（getMultiple）— 按主键获取完整数据

```json
{
  "type_key": "sales.order",
  "operation": "getMultiple",
  "input": {
    "datakeys": [
      { "IBA001": "SO20260525007" }
    ]
  }
}
```

> **注意**：`datakeys` 中的字段编号因 TypeKey 不同而不同——参见上方各 TypeKey 的「主键」行。
> **getMultiple 返回单头 + cdsDetail 单身明细**，适合查看详情、分析比对等需要完整数据的场景。

### 创建（create）— 交易单据（含单身明细）

```json
{
  "type_key": "sales.order",
  "operation": "create",
  "input": {
    "cdsMaster": [
      {
        "IBA001": "",
        "IBA003": "20260528",
        "IBA004": "K00049",
        "cdsDetail": [
          {
            "IBB003": "2000000110",
            "IBB005": "件",
            "IBB006": 10
          }
        ]
      }
    ]
  }
}
```

**注意事项**：
- `IBA001` 传空字符串 `""`，ERP 自动编号
- `IBA003` 日期必须是 `YYYYMMDD` 格式
- `IBA004` 必须是有效的客户编码（先查询确认）
- `cdsDetail` 数组不能为空
- 数值字段（数量、单价）用数字类型，不用字符串
- 不要写 `IBB031`（含税单价）和 `IBB032`（价税合计），ERP 自动计算

### 创建（create）— 基础资料（无单身明细）

```json
{
  "type_key": "customer",
  "operation": "create",
  "input": {
    "cdsMaster": [
      {
        "DFA001": "K00999",
        "DFA002": "新客户",
        "DFA003": "新客户全名"
      }
    ]
  }
}
```

### 更新（update）— 只传主键 + 变更字段

> **核心规则**：update 只需传主键字段（IBA001 / IBB001+IBB002）+ 要修改的字段，无需传所有字段。ERP 会自动合并。LLM 从用户自然语言解析出「改什么」，不需要先 get 再全量回写。

```json
{
  "type_key": "sales.order",
  "operation": "update",
  "input": {
    "cdsMaster": [
      {
        "IBA001": "SO20260525003",
        "cdsDetail": [
          {
            "IBB001": "SO20260525003",
            "IBB002": "001",
            "IBB003": "20602008",
            "IBB005": "个",
            "IBB006": 110000,
            "IBB031": 0.062,
            "IBB013": "20260525",
            "IBB034": "T"
          },
          {
            "IBB001": "SO20260525003",
            "IBB002": "002",
            "IBB003": "20601007",
            "IBB005": "个",
            "IBB006": 100000,
            "IBB031": 0.060,
            "IBB013": "20260525",
            "IBB034": "T"
          }
        ]
      }
    ]
  }
}
```

**说明**：
- `IBA001` = 订单号（单头主键），`IBB001`+`IBB002` = 单身行主键
- 只传了要修改的字段（如 IBB006 数量、IBB031 含税单价、IBB034 税别标志），其他字段保持不变
- IBA015（发票种类）等未传的字段**不会被覆盖**
- **⚠️ 删除限制**：`update` 操作**不支持删除单身明细行**。排除行、标记字段等方式均无效。ERP 只修改已存在的行，不删除未传入的行。如需删除明细行，请告知用户通过 ERP UI 操作。

### 审核（approve）

```json
{
  "type_key": "sales.order",
  "operation": "approve",
  "input": {
    "datakeys": [
      { "IBA001": "SO20260525007" }
    ]
  }
}
```

### 撤审（disapprove）

```json
{
  "type_key": "sales.order",
  "operation": "disapprove",
  "input": {
    "datakeys": [
      { "IBA001": "SO20260525007" }
    ]
  }
}
```

### 删除（delete）

```json
{
  "type_key": "sales.order",
  "operation": "delete",
  "input": {
    "datakeys": [
      { "IBA001": "SO20260525007" }
    ]
  }
}
```

---

## 防幻觉规则（14 条严苛执行准则）

### 绝对禁止

1. **日期格式铁律**：所有日期一律 `YYYYMMDD`（8 位数字，无横线/斜杠）。`2026-04-30` → `20260430`。每次提交前必须检查。

2. **禁止添加多余字段**：只组装用户明确提供的字段。系统自动计算的字段（含税单价、价税合计、金额等）不要写入 JSON，ERP 会自动计算。

3. **禁止猜测编码**：若用户未提供精确编码（如客户编码、商品品号），必须先查询获取。不得使用拼音、缩写或随机生成。

4. **字段白名单**：写入操作必须使用 `IBAxxx/IBBxxx/DFAxxx` 原始字段编号，严禁使用别名（`docNo`/`cust`/`saleser`）。

5. **结构完整性**：创建交易单据必须同时包含单头字段和 `cdsDetail`（单身明细）。

6. **数据格式化**：
   - 数值：数量、单价、汇率必须为纯数字（Float/Int），禁止带单位
   - 税率：使用小数格式（0.13 表示 13%），禁止百分比数字或字符串
   - 字符串：所有 ID 和编码必须为字符串类型

7. **信息缺失必须询问**：必填项缺失时必须询问用户，严禁编造数据。

8. **乱码不猜测**：API 返回乱码时，严禁猜测内容。必须向用户展示原始数据并请求协助。

9. **错误不修代码**：API 报错时，只调整请求 JSON 内容，绝对禁止修改任何代码或配置文件。

10. **切换单据重新读取**：从一种单据切换到另一种时，必须重新获取字段信息，严禁依赖上下文记忆。

11. **字段不存在强制处理**：收到 "Field 'xxx' not found" 错误时，首先检查是否用错了 TypeKey 的字段结构，修正字段编号后重试。

12. **成功即止，禁止重复执行**：yzcli_run 返回 `success=true` 后，**直接格式化结果呈现给用户**。不要因为：
    - 系统 hook 报错（PostToolUse hook error 是平台层面的，与 yzcli 无关）
    - 结果格式不满意
    - 想"确认一下"
    而重新构造请求再次执行。重复执行浪费时间且可能产生重复数据。

13. **Windows 编码处理**：Windows 控制台默认 GBK 编码，Python 的 `print()` 输出中文会乱码。处理方式：
    - **不要用 `print()` 输出中文到 stdout**
    - 将结果写入 UTF-8 文件，再用 Read 工具读取
    - 或使用 `json.dumps(data, ensure_ascii=False)` 配合文件写入

14. **禁止幻觉 TypeKey 和参数**：严禁编造不存在的 TypeKey（如 `sales.order.detail`）或参数（如 `query_type: "detail"`）。如果需要单身明细数据，使用 `getMultiple` 操作获取完整单据，而不是编造新的 TypeKey 或查询模式。只有快查表和 `references/typekey-full-list.md` 中列出的 TypeKey 才可使用。

### 6 类幻觉防御

| 类型 | 表现 | 防御 |
|------|------|------|
| **字段名幻觉** | 编造不存在的字段名（如 `shipping_status`、`docNo`） | 写入用字段编号，组装前必查操作速查或 yzcli_help |
| **主数据幻觉** | 编造客户编码、商品品号（如将"鼎捷"编码为 `DH001`） | 「先查后写」规则，查不到就问用户 |
| **参数遗漏** | 缺少必填参数（如缺少 `cdsDetail`） | 参照 JSON 模板检查 |
| **格式宽松** | 日期用横线、数量带单位、税率用百分比 | 日期 YYYYMMDD，数值纯数字，税率小数 |
| **删除幻觉** | 编造删除标记字段（如 DEC007='F'）或不存在的删除操作 | update 不支持删除明细行；需告知用户通过 ERP UI 操作，或尝试传入不包含该行的 key 值列表 |
| **错误处理幻觉** | API 报错时修改代码或配置 | 「错误不修代码」规则，只改请求 JSON |
| **TypeKey/Operation 幻觉** | 编造不存在的 TypeKey（如 `sales.order.detail`）或参数（如 `query_type: "detail"`） | 只用快查表和 typekey-full-list.md 中的 TypeKey；需要单身明细用 `getMultiple`，不要编造新的查询模式 |

### 信任边界

| 信任 | 不信任 |
|------|--------|
| `yzcli_help` 返回的字段定义 | 自己记忆中的字段名 |
| `yzcli_manifest` 返回的 TypeKey 列表 | 自己猜测的 TypeKey |
| 查询返回的编码 | 自己编造的编码 |
| 用户提供的具体数值 | 自己推算的数值 |
| ERP 返回的错误信息 | 自己对错误原因的猜测 |

---

## 先查后写规则（跨表查询）

当用户输入包含**中文名称**而非编码时，必须先查询获取编码：

**典型场景**：
- 用户说"给鼎捷建订单" → "鼎捷"是客户名 → 先查 `customer` 获取客户编码 → 再创建订单
- 用户说"查BM280B的订单" → "BM280B"是编码 → 直接用 `item_no="BM280B"` 查询

**快速匹配规则**：

| 用户输入特征 | 匹配字段 | 操作符 | 示例 |
|-------------|---------|--------|------|
| **纯数字** 或 **英文字母+数字** | 编号字段 | `=`（精确） | `BM280B` → `field_name="item_no", value="BM280B", operator="="` |
| **含中文** | 名称字段 | `like`（模糊） | `块包机` → `field_name="product_name", value="块包机%", operator="like"` |

**各 TypeKey 的匹配字段**：
- **商品** (`item`)：编号→`item_no`，名称→`product_name`
- **客户** (`customer`)：编号→`customer_no`，名称→`full_name_of_customer`
- **供应商** (`supplier`)：编号→`supplier_no`，名称→`supplier_name`

---

## 自检清单（操作提交前逐项检查）

- [ ] **Operation 是否匹配用户意图？** 有明确单号→`getMultiple`，条件搜索→`fastquery`，不要混淆
- [ ] 日期已是 `YYYYMMDD` 格式？没有横线、斜杠、中文？
- [ ] 字段名是当前 TypeKey 的**字段编号**（IBAxxx/IBBxxx）？不是别名？
- [ ] 没有多余字段？价税合计、含税单价等让 ERP 自动算
- [ ] 单位是查询返回的真实值？不是猜的？
- [ ] 编码（客户、品号）已通过查询确认有效？
- [ ] 有 `cdsDetail` 数组？（交易单据 create/update 必须有单身明细）
- [ ] **update 是否只传了主键 + 变更字段？** 不要传所有字段，未修改的字段不传
- [ ] 数值是纯数字？数量=100 不是 "100个"
- [ ] 税率是小数值？13% → 0.13，不是 13 也不是 "13%"
- [ ] 切换了 TypeKey？是否已重新获取字段信息？
- [ ] TypeKey 是否在快查表或 typekey-full-list.md 中？没有编造不存在的 TypeKey

---

## 错误诊断表

| 错误信息 | 常见原因 | 修复方法 |
|---------|---------|---------|
| `Field 'xxx' not found` | 写入用了别名，或用错了 TypeKey 的字段结构 | 重新调用 `yzcli_help` 确认当前 TypeKey 的字段编号 |
| `单据明细不能为空` | 缺少 `cdsDetail` 数组 | 补充明细数据 |
| `列名 'xxx' 无效` | 条件查询用了字段编号而非别名 | 改为 customer/item_no 等别名 |
| `xxx 不存在` | 编码错误 | 先查询获取正确编码 |
| `不能手动修改` / `系统自动计算` | 写了系统自动计算的字段 | 移除该字段 |
| `JSON decode 错误` | 响应编码问题 | 检查输入数据格式 |
| `TypeKey不存在` / `服务不存在` | 编造了不存在的 TypeKey（如 `sales.order.detail`） | 使用 `getMultiple` 获取完整数据（含单身），不要编造 TypeKey |
| `query_type: "detail" 报错` | 编造了不存在的查询模式 | `fastquery` 只支持 `all`/`key` 两种 query_type；需要单身数据请用 `getMultiple` |

---

## 响应格式

成功时，`yzcli_run` 返回：
```json
{
  "success": true,
  "type_key": "sales.order",
  "operation": "fastquery",
  "result": { ... },
  "raw": { "code": "0", "message": "" }
}
```

失败时：
```json
{
  "success": false,
  "type_key": "sales.order",
  "operation": "fastquery",
  "error": {
    "type": "api_error",
    "message": "...",
    "details": {
      "api_errors": [{ "message": "...", "data": {} }]
    }
  }
}
```

**展示给用户时**：
- 成功：提取 `result` 中的数据，格式化为中文表格或自然语言
- 失败：展示 `error.message` 和 `error.details.api_errors[].message`，给出修复建议
- **Windows 环境**：避免 `print()` 输出中文到 stdout（会 GBK 乱码），用文件写入 + Read 工具读取

---

## 路由引导（references/ 按需读取）

当本文件信息不足以完成操作时，按需读取 references/ 目录下的文件：

| 需求 | 读取文件 | 说明 |
|------|---------|------|
| 查找不在快查表中的 TypeKey | `references/typekey-full-list.md` | 完整 110 个 TypeKey 索引 |
| 深入了解字段映射关系 | `references/field-mapping-matrix.md` | 所有 TypeKey 的字段编号↔别名矩阵 |
| 了解 JSON 组装高级技巧 | `references/json-construction-examples.md` | 复杂 JSON 组装示例 |
| 了解路由决策细节 | `references/routing-decision-tree.md` | 4 层路由决策模型 |
| 了解幻觉防御案例 | `references/hallucination-cases.md` | 5 类幻觉的详细防御案例 |
