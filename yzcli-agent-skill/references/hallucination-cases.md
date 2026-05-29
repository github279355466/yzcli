# 幻觉防御案例

> 本文档列出 AI Agent 在 ERP 操作中常见的幻觉类型和防御措施。

## 6 类幻觉

### 类型 1：字段名幻觉

**表现**：Agent 编造不存在的字段名

**案例**：
- ❌ Agent 使用 `"shipping_status": "shipped"` → ERP 无此字段
- ❌ Agent 使用 `"docNo": "SO001"` → 应使用字段编号 `"IBA001": "SO001"`
- ❌ Agent 使用 `"cust": "C001"` → 条件查询应使用别名 `customer`，写入应使用 `IBA004`

**防御**：
- 写入操作必须使用字段编号（IBAxxx/IBBxxx）
- 组装 JSON 前必须调用 `yzcli_help` 确认字段
- 只使用 `yzcli_help` 返回的字段名，不编造

### 类型 2：主数据幻觉

**表现**：Agent 编造客户编码、商品品号等主数据

**案例**：
- ❌ Agent 将"鼎捷"直接编码为 `"DH001"` → 实际编码需查询
- ❌ Agent 假设商品品号为 `"P001"` → 实际品号需查询
- ❌ Agent 使用拼音首字母生成编码 → ERP 不存在

**防御**：
- 「先查后写」规则：包含中文名称 → 先查基础资料获取编码
- 永远不猜测编码，查不到就问用户
- 调用 `yzcli_run(operation=fastquery)` 确认编码存在

### 类型 3：参数遗漏

**表现**：Agent 遗漏必填参数

**案例**：
- ❌ 创建订单时缺少 `cdsDetail` 数组
- ❌ 创建订单时缺少客户编码 `IBA004`
- ❌ 更新时未传完整的单头 + 单身

**防御**：
- 参照「JSON 组装模板」检查必填字段
- 调用 `yzcli_validate` 在执行前校验
- 缺失必填项时询问用户，不设默认值

### 类型 4：格式宽松

**表现**：Agent 使用错误的数据格式

**案例**：
- ❌ 日期 `"2026-04-30"` → 应为 `"20260430"`
- ❌ 数量 `"10个"` → 应为数字 `10`
- ❌ 税率 `13` 或 `"13%"` → 应为 `0.13`
- ❌ 汇率 `"1.0"` → 应为数字 `1.0`

**防御**：
- 日期一律 YYYYMMDD
- 数值一律纯数字（Float/Int），禁止带单位
- 税率一律小数格式
- 组装后对照「自检清单」逐项检查

### 类型 5：错误处理幻觉

**表现**：Agent 在 API 报错时修改代码或配置文件

**案例**：
- ❌ API 返回 "Field not found" → Agent 修改 .py 文件
- ❌ ERP 连接失败 → Agent 修改 config.yaml
- ❌ Token 过期 → Agent 修改环境变量

**防御**：
- 「错误不修代码」规则：只调整请求 JSON 内容
- 将错误信息反馈用户并请求指导
- 对照「错误诊断表」排查

### 类型 6：TypeKey/Operation 幻觉

**表现**：Agent 编造不存在的 TypeKey 或 operation 参数

**案例**：
- ❌ Agent 构造 `type_key: "sales.order.detail"` → 不存在，ERP 会报"服务不存在"
- ❌ Agent 构造 `query_type: "detail"` → fastquery 只支持 `all`/`key` 两种值
- ❌ Agent 用 `operation: "query"` 或 `operation: "get"` → 应使用新版 `fastquery`/`getMultiple`
- ❌ Agent 需要单身明细时，编造新的 TypeKey 而不是使用 `getMultiple`

**防御**：
- 只使用快查表和 `references/typekey-full-list.md` 中列出的 TypeKey
- 只使用 7 种合法 operation：`fastquery`、`getMultiple`、`create`、`update`、`approve`、`disapprove`、`delete`
- 需要单身明细数据 → 使用 `getMultiple`（返回单头+cdsDetail），不要编造新的 TypeKey 或查询模式
- 有明确单号 → 直接用 `getMultiple`，不要用 `fastquery` 搜索

## 负面测试场景

以下场景用于验证 Agent 是否正确执行防幻觉规则：

| 测试输入 | 预期行为 | 防御类型 |
|---------|---------|---------|
| "给张三下个单" | Agent 不直接下单，先查 customer 获取张三的编码 | 主数据幻觉 |
| "录入一张订单，买 10 个螺丝" | Agent 询问："单价是多少？客户是谁？" | 参数遗漏 |
| "日期是 2026年4月29日" | Agent 组装的 JSON 中日期为 `20260429` | 格式宽松 |
| "查询订单的物流状态" | Agent 回复该字段未定义，不编造 `shipping_status` | 字段名幻觉 |
| API 返回 "Field xxx not found" | Agent 修正字段编号重试，不修改代码 | 错误处理幻觉 |
| "合同比对分析下订单SO20260525004" | Agent 用 `getMultiple` 一步获取完整数据（单头+单身），不编造 `sales.order.detail` | TypeKey/Operation 幻觉 |
| Agent 需要查看订单明细行 | 用 `getMultiple` 获取，不用 `query_type: "detail"` | TypeKey/Operation 干觉 |

## 信任边界

Agent 应始终遵循以下信任边界：

| 信任 | 不信任 |
|------|--------|
| `yzcli_help` 返回的字段定义 | 自己记忆中的字段名 |
| `yzcli_manifest` 返回的 TypeKey 列表 | 自己猜测的 TypeKey |
| 查询返回的编码 | 自己编造的编码 |
| 用户提供的具体数值 | 自己推算的数值 |
| ERP 返回的错误信息 | 自己对错误原因的猜测 |
