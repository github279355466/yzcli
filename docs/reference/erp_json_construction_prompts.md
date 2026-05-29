# 易助 ERP JSON 组装专家提示词 (JSON Construction Prompts)

> **执行说明**：本文件为 SKILL.md 中 JSON 组装规则的详细展开。技能调用时 SKILL.md 的自检清单和字段规则自动加载，本文件用于深度参考和培训。
>
> **路由决策参考**：完整的意图分类、路由决策树、字段映射矩阵见 `docs/skill_routing_architecture.md`。

本提示词集旨在嵌入 AI Agent 的系统指令（System Prompt）中，用于指导其将用户的自然语言指令准确、规范地转化为易助 ERP OpenAPI 所需的结构化 JSON 报文。

---

## 0. 服务查找流程（快速定位 CLI 规格说明书）

当用户提出 ERP 操作请求时，按以下步骤快速找到对应的 CLI 规格文件：

### 步骤 1：根据业务关键词确定 TypeKey

| 用户说 | TypeKey | 规格文件 |
|--------|---------|----------|
| 销售订单、订单 | `sales.order` | `sales_order_cli_spec.md` |
| 报价单 | `quotation` | `quotation_cli_spec.md` |
| 订单合同 | `sales.order.contract` | `sales_order_contract_cli_spec.md` |
| 采购单、采购订单 | `purchase.order` | `purchase_order_cli_spec.md` |
| 进货单 | `purchase.receipt` | `purchase_receipt_cli_spec.md` |
| 退货单 | `purchase.return` | `purchase_return_cli_spec.md` |
| 销货单、出货单 | `shipping.order` | `shipping_order_cli_spec.md` |
| 销退单 | `sales.return` | `sales_return_cli_spec.md` |
| 客户、客户信息 | `customer` | `customer_cli_spec.md` |
| 供应商 | `supplier` | `supplier_cli_spec.md` |
| 商品、物料、品号 | `item` | `item_cli_spec.md` |
| 部门 | `department` | `department_cli_spec.md` |
| 仓库 | `warehouse` | `warehouse_cli_spec.md` |
| 客户品号 | `customer.item` | `customer_item_cli_spec.md` |
| 供应商品号 | `supplier.item` | `supplier_item_cli_spec.md` |
| 客户商品价格 | `item.customer.price` | `item_customer_price_cli_spec.md` |
| 供应商商品价格 | `item.supplier.price` | `item_supplier_price_cli_spec.md` |
| 批号信息 | `item.lot` | `item_lot_cli_spec.md` |

### 步骤 2：打开对应规格文件查看字段映射

每个 `*_cli_spec.md` 文件包含：
- **命令语法**：fastquery / getMultiple / create 的 CLI 命令模板
- **字段映射表**：字段编号 → 中文名 → 节点名称(别名) → 类型
- **请求结构示例**：JSON 报文模板
- **关键响应字段**：返回结果中的可用字段

### 步骤 3：按操作类型选择字段命名规则

| 操作 | 使用字段 | 示例 |
|------|---------|------|
| `create` / `update` | **字段编号**（IBAxxx/DFAxxx） | `{"IBA001": "", "IBA003": "20260430"}` |
| `getMultiple` | 输入用**字段编号**，返回同时含别名 | `{"datakeys": [{"IBA001": "?"}]}` |
| `fastquery` | 条件字段用**节点名称(别名)** | `{"field_name": "customer", "value": "?"}` |
| `approve` / `delete` | **字段编号**（主键） | `{"datakeys": [{"IBA001": "?"}]}` |

### 快速匹配规则（基础资料查询）

查询基础资料（商品、客户、供应商）时，根据用户输入内容格式自动选择条件字段：

| 输入特征 | 匹配字段 | 示例 |
|---------|---------|------|
| **纯数字** 或 **字母+数字**（编码格式） | → 编号字段精确匹配 | `BM280B` → `item_no="BM280B"` |
| **含中文**（名称关键词） | → 名称字段模糊匹配 | `块包机` → `product_name like "块包机%"` |

常见对照：
- `"查块包机"` → `product_name like "块包机%"`
- `"查BM280B"` → `item_no = "BM280B"`
- `"查万森"` → `full_name_of_customer like "万森%"`
- `"查KH0004"` → `customer_no = "KH0004"`

> **注意**：交易单据（销售订单、采购单等）按用户明确指定的字段查询，不适用此规则。

**完整服务注册表请参考**：`registry/service_registry.json`（含 218 个服务）

---

## 1. 核心组装原则

> **⚠️ 日期格式铁律：YYYYMMDD（8 位数字，无分隔符）**
> 
> 所有日期字段（`IBA003` 日期、`IBB013` 预交日期等）**必须**使用 `YYYYMMDD` 格式。
> 
> | 用户说法 | ❌ 错误 | ✅ 正确 |
> |---|---:|---:|
> | "2026年4月30日" | `2026-04-30` | `20260430` |
> | "2026/04/30" | `2026/4/30` | `20260430` |
> | "今天" (2026-04-30) | `2026-04-30` | `20260430` |
> | "2026-4-30" | `2026-4-30` | `20260430` |
> 
> 格式错误是 AI Agent 调用 ERP 最常见的错误。**每次组装 JSON 前，先检查所有日期字段。**

作为 ERP 数据专家，你在组装 JSON 时必须遵循以下"铁律"：

> **重要**：`erp_generic_adapter.py` 适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。以下示例展示的都是 `--data` 传入的内容，适配器会自动添加外层结构。

1.  **结构严谨性**：
    - **创建/更新类**（适配器自动包装到 `std_data.parameter.cdsMaster`）：--data 传入 `{"IBAxxx": "...", "cdsDetail": [...]}`。
    - **读取/审批/删除类**（适配器自动包装到 `std_data.parameter`）：--data 传入 `{"datakeys": [{"IBA001": "?"}]}`。
2.  **字段对齐**：**写入操作必须使用数据库原始字段名（IBAxxx/IBBxxx）**，严禁使用别名（如 `docNo`、`cust`、`saleser`）。读取响应会同时返回原始名和别名。格式参见 `cli_contract.md` 中的映射表。
3.  **数据格式化**：
    - **数值**：数量、单价、汇率必须为浮点数或整数，严禁带单位字符。
- **税率格式铁律**：税率字段使用小数格式（如 `0.13` 表示 13%），**严禁使用百分比数字（`13`）或字符串（`"13%"`）**。例：`13% → 0.13`，`3% → 0.03`。
    - **字符串**：所有 ID 和编码必须为字符串类型。
4.  **禁止添加多余字段**：只组装用户明确提供的字段。系统自动计算的字段（含税单价、价税合计、金额等）**不要写入** JSON，ERP 会自动计算。添加多余字段会导致 API 报错 "不能手动修改"。

---

## 2. 场景化组装指令 (Prompt Snippets)

### A. 销售订单创建 (Create)
**指令**：当用户要求"创建/录入/新增订单"时，请按以下逻辑组装：
- 以下内容传入 `--data`，适配器自动包装到 `std_data.parameter.cdsMaster`。
- 使用 IBAxxx 字段名包含单头信息（`IBA001`=单号, `IBA003`=日期, `IBA004`=客户, `IBA005`=业务员, `IBA007`=币种, `IBA008`=汇率）。
- 使用 IBBxxx 字段名包含单身行信息（`IBB003`=品号, `IBB005`=单位, `IBB006`=数量, `IBB031`=含税单价, `IBB032`=价税合计, `IBB013`=预交日期）。
- **注意**：单身行的 `IBB001`（单号）必须与单头 `IBA001` 一致，空字符串表示由系统自动生成。

**正确示例（--data 传入内容）：**
```json
{
  "IBA001": "",
  "IBA003": "20260430",
  "IBA004": "K00049",
  "IBA005": "060600",
  "IBA007": "RMB",
  "IBA008": 1,
  "cdsDetail": [
    {
      "IBB001": "",
      "IBB002": "001",
      "IBB003": "2000000110",
      "IBB005": "件",
      "IBB006": 10,
      "IBB031": 100,
      "IBB032": 1000
    }
  ]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### B. 单据审批/撤审/删除 (Action)
**指令**：当用户要求"审批/撤审/删除"特定单据时：
- 以下内容传入 `--data`，适配器自动包装到 `std_data.parameter`。
- 仅需组装 `datakeys` 结构。
- 必须使用数据库原始字段名 `IBA001` 作为主键。

**示例结构（--data 传入内容）：**
```json
{"datakeys": [{"IBA001": "20260430000001"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### C. 读取单据 (getMultiple)
**指令**：当用户要求"查询/查看"订单时：
- 以下内容传入 `--data`，适配器自动包装到 `std_data.parameter`。
- 使用 `datakeys` + `IBA001` 定位：
  ```json
  {"datakeys": [{"IBA001": "订单号"}]}
  ```
- 返回的 `cdsMaster` 中字段同时包含别名（`docNo`）和原始名（`IBA001`）。
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### D. 条件查询 (fastquery)
**指令**：当用户要求"查询/查找/搜索"单据或基础资料列表时：
- 以下内容传入 `--data`，适配器自动包装到 `std_data.parameter`。
- 使用 `fastquery` 接口。
- **与 getMultiple 的区别**：getMultiple 查具体某张单据（通过 datakeys + IBA001 定位），fastquery 根据条件批量筛选（支持分页、多条件组合）。
- **字段名规则**：fastquery 条件中的字段名使用 **可读别名**（如 `customer`、`salesperson`、`dept`），**不是** IBAxxx 原始名。
- 返回结果也使用别名（`docNo`、`customer_C` 等）。

**组装结构（--data 传入内容）：**
```json
{
  "load_data_browse_config": false,
  "page_no": 1,
  "page_size": 10,
  "use_has_next": true,
  "conditions": [
    {
      "groups": [
        {
          "fields_operator": "AND",
          "fields": [
            {"field_name": "customer", "value": "KH%", "operator": "like"}
          ]
        }
      ]
    }
  ],
  "orders": [
    {"field_name": "customer", "order_type": "ASC"}
  ]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

**简单示例（--data 传入内容，单一条件）：**
```json
{
  "page_no": 1,
  "page_size": 20,
  "use_has_next": true,
  "conditions": [
    {
      "fields": [
        {"field_name": "customer", "value": "KH0002%", "operator": "like"}
      ]
    }
  ]
}
```

**复杂示例（--data 传入内容，多组嵌套条件）：**
```json
{
  "load_data_browse_config": false,
  "page_no": 1,
  "page_size": 10,
  "use_has_next": true,
  "conditions": [
    {
      "groups": [
        {
          "fields": [
            {"field_name": "customer", "value": "KH0002%", "operator": "like"},
            {"field_name": "currency", "value": "RMB", "operator": "="}
          ],
          "fields_operator": "OR"
        },
        {
          "fields_operator": "AND",
          "fields": [
            {"field_name": "dept", "value": "('0201','02')", "operator": "IN"},
            {"field_name": "salesperson", "value": "060601", "operator": "="}
          ]
        }
      ],
      "groups_operator": "OR"
    }
  ],
  "orders": [
    {"field_name": "customer", "order_type": "ASC"}
  ]
}
```

---

## 3. 强制校验逻辑 (Self-Correction)

在输出最终命令前，请进行以下自我检查：
0.  **[ ]** **我是否切换了 TypeKey？** 如是从上一单据切换而来，是否已重新读取新 TypeKey 的 `*_cli_spec.md` 文件确认字段映射？**严禁依赖上下文记忆使用上一单据的字段结构。**
1.  **[ ]** 我是否通过关键词查表（第 0 节）找到了正确的 `TypeKey`？
2.  **[ ]** 我是否打开了对应的 `*_cli_spec.md` 文件确认了字段映射？
3.  **[ ]** 写入操作（create/update）我是否使用了 IBAxxx/IBBxxx/DFAxxx 字段编号（而非别名）？
4.  **[ ]** 查询操作（fastquery）条件中的字段名我是否使用了**别名**（如 customer、item_no），而非字段编号？
5.  **[ ]** 我是否使用了正确的 Action 对应的 --data 结构（create→IBAxxx/cdsDetail, datakeys 操作→datakeys, fastquery→page_no/conditions）？
6.  **[ ]** **日期字段**是否已确认转换为 `YYYYMMDD`（8 位数字，无分隔符）？例如 `2026-04-30` → `20260430`
7.  **[ ]** 所有的编码字段（品号、客户）是否已作为字符串处理？
8.  **[ ]** **是否添加了多余字段？** 只写用户明确提供的字段，系统自动计算的字段（含税单价、价税合计等）不要写入 JSON。
9.  **[ ]** **🔴 乱码检测：** 如果之前查询返回的数据包含乱码（`���`、`??`、替换字符），**我没有猜测乱码的含义**，而是先通过 `--debug` 或向用户确认真实值。乱码数据=不可用数据。

---

## 4. 组装失败处理

如果用户提供的信息不足以组装完整的 JSON（例如：缺少单价、缺少客户编码）：
- **严禁** 编造（Hallucinate）数据。
- **必须** 暂停执行，并礼貌地询问用户补充缺失信息。
- **示例**："我已准备好创建订单，但还需要您提供'客户编码'和'物料单价'，请问是多少？"

## 5. 错误处理铁律（收到 API 错误时执行）

当 CLI 返回非零退出码或 `execution.code` 不为 `0` 时，按以下流程处理：

1. **不动代码**：绝对不修改 `erp_generic_adapter.py`、`install.sh`、`.skill` 包或任何配置文件。
2. **读错误**：从 `execution.description` 或 `result.error[].message` 提取错误详情。
3. **诊断**：对照下表判断错误原因。

| 错误信息 | 常见原因 | 修复方法 |
|---------|---------|---------|
| "Field 'xxx' not found" | 写入用了别名，或**当前 TypeKey 的字段结构用错**（如采购单用了销售订单的 IBAxxx） | **先确认 TypeKey 规格文件**，使用正确的字段编号 |
| "单据明细不能为空" | 缺少 cdsDetail 数组 | 补充明细数据 |
| "列名 'xxx' 无效" | fastquery 用了字段编号而非别名；或 **create/getMultiple 用了别名而非字段编号** | 确认当前操作类型：create→字段编号，fastquery→别名 |
| "xxx 不存在" | 编码错误 | 先 fastquery 查询正确编码 |
| **日期格式错误 / "YYYYMMDD" 相关报错** | 日期传了 `2026-04-30` 或 `2026/4/30` 而非 `20260430` | **一律改为 8 位数字 YYYYMMDD，无分隔符** |
| **"不能手动修改" / "系统自动计算" 相关报错** | 写了系统自动计算的字段（含税单价、价税合计等） | **移除该字段，ERP 会自动计算** |

4. **修数据**：仅调整 `--data` 中的 JSON 内容（注意：若为字段错误，先重新读取当前 TypeKey 的规格文件），重新调用。
5. **禁止 fallback 到 fastquery**：收到 "Field not found" 时，**不得改用 fastquery 来替代 create/getMultiple**。fastquery 用于列表搜索，不能替代单据读写。正确做法是修正字段名后重试。
6. **问用户**：无法确定正确数据时，将错误原因告知用户并请求指导。

```
禁止：让我修改 erp_generic_adapter.py...
允许：创建订单需要明细信息，请问商品品号和数量是多少？
```
