# 易助 ERP AI Agent 技能路由架构

> 版本: 3.0 | 最后更新: 2026-05-06
>
> 本文档定义 AI Agent 如何将自然语言输入自动路由到正确的工具和命令。是整个技能系统的核心决策引擎。

---

## 1. 架构总览

### 1.1 分层路由模型

```
┌─────────────────────────────────────────────────────────┐
│                    用户自然语言输入                        │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│   Layer 1: 意图分类器 (Intent Classifier)                │
│   识别用户核心意图 → 粗粒度路由                           │
│   ├─ "查订单" → 单据操作                                 │
│   ├─ "统计/汇总" → 数据分析(API聚合)                     │
│   ├─ "库存余额/成本" → 数据分析(DB直连)                  │
│   └─ "查品号/客户/供应商" → 基础资料查询                  │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│   Layer 2: 参数提取器 (Parameter Extractor)              │
│   从自然语言提取结构化参数                                │
│   ├─ 实体识别: 单号、品号、客户、日期、金额               │
│   ├─ 操作识别: 创建/查询/审核/删除/统计                  │
│   └─ 条件提取: 时间范围、排序方式、数量限制               │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│   Layer 3: 路由执行器 (Route Executor)                   │
│   根据意图+参数 → 确定具体工具和命令                      │
│   ├─ Route A: erp_generic_adapter.py (单据CRUD)         │
│   ├─ Route B: erp_analyzer.py --mode (API聚合)          │
│   ├─ Route C: erp_analyzer.py --mode db-* (DB直连)      │
│   └─ Route D: 组合调用(多步操作)                         │
└──────────────────┬──────────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────────┐
│   Layer 4: 执行引擎 (Execution Engine)                   │
│   构造命令、调用CLI、解析结果、返回用户                    │
│   ├─ 命令构造: type-key + action + data                 │
│   ├─ 字段映射: 根据规格文件填入正确的字段名               │
│   ├─ 结果处理: JSON解析/格式化/异常提取                   │
│   └─ 用户输出: 中文自然语言描述结果                      │
└─────────────────────────────────────────────────────────┘
```

### 1.2 工具全景

| 工具 | 定位 | 数据源 | 适用范围 |
|------|------|--------|---------|
| `erp_generic_adapter.py` | 单据操作桥梁 | ERP OpenAPI | 6种操作：create, getMultiple, fastquery, approve, disapprove, delete, update |
| `erp_analyzer.py (API模式)` | 统计聚合 | ERP OpenAPI | 4种模式：summary, top-items, top-customers, item-sales |
| `erp_analyzer.py (DB模式)` | 数据仓库查询 | SQL Server (pymssql) | 4种模式：db-stock, db-profit, db-dupont, db-sales-detail |
| `erp_db_connector.py` | 只读DB连接器 | SQL Server | 被analyzer调用，禁止写操作 |

---

## 2. 意图分类器 — 详细规则

### 2.1 五大意图类别

```
 ┌──────────────────────────────────────────────────────────┐
 │  输入: "帮我查一下销售订单SO202605001的内容"               │
 │                                                          │
 │  ┌─ Intent A: DOCUMENT_QUERY    (单据查询)               │
 │  │  置信度: 95%                                          │
 │  │  依据: "查" + "销售订单" + "SO202605001"(单号格式)    │
 │  └─ → Route: getMultiple / sales.order                  │
 └──────────────────────────────────────────────────────────┘

 ┌──────────────────────────────────────────────────────────┐
 │  输入: "这个月销售额汇总是多少"                           │
 │                                                          │
 │  ┌─ Intent B: SALES_ANALYSIS   (销售分析)                │
 │  │  置信度: 92%                                          │
 │  │  依据: "汇总" + "销售额"                              │
 │  └─ → Route: erp_analyzer.py --mode summary             │
 └──────────────────────────────────────────────────────────┘

 ┌──────────────────────────────────────────────────────────┐
 │  输入: "查一下品号BM280B的库存还有多少"                   │
 │                                                          │
 │  ┌─ Intent C: INVENTORY_BALANCE (库存余额)               │
 │  │  置信度: 95%                                          │
 │  │  依据: "库存" + "多少" + "BM280B"(品号格式)           │
 │  └─ → Route: erp_analyzer.py --mode db-stock            │
 └──────────────────────────────────────────────────────────┘

 ┌──────────────────────────────────────────────────────────┐
 │  输入: "创建一个销售订单，客户K00049，品号2000000110"    │
 │                                                          │
 │  ┌─ Intent D: DOCUMENT_CREATE  (单据创建)                │
 │  │  置信度: 97%                                          │
 │  │  依据: "创建" + "销售订单" + 客户+品号                │
 │  └─ → Route: erp_generic_adapter.py create              │
 └──────────────────────────────────────────────────────────┘

 ┌──────────────────────────────────────────────────────────┐
 │  输入: "查一下万森这个客户的信息"                         │
 │                                                          │
 │  ┌─ Intent E: MASTER_DATA_QUERY (基础资料查询)           │
 │  │  置信度: 93%                                          │
 │  │  依据: "客户" + "万森"(非编码格式)                    │
 │  └─ → Route: erp_generic_adapter.py fastquery / customer│
 └──────────────────────────────────────────────────────────┘
```

### 2.2 意图判断矩阵

| 用户输入关键词 | 意图 | 路由 | 优先级 |
|---------------|------|------|--------|
| 创建/新增/录入 + 单据名 | DOCUMENT_CREATE | generic_adapter create | 1 |
| 修改/更新 + 单据名 | DOCUMENT_UPDATE | generic_adapter update | 1 |
| 审核 + 单据名 | DOCUMENT_APPROVE | generic_adapter approve | 1 |
| 撤审/取消审核 + 单据名 | DOCUMENT_DISAPPROVE | generic_adapter disapprove | 1 |
| 删除 + 单据名 | DOCUMENT_DELETE | generic_adapter delete | 1 |
| 查/看/显示 + 单号/订单 | DOCUMENT_READ | generic_adapter getMultiple | 1 |
| 汇总/统计 + 销售/金额 | SALES_SUMMARY | analyzer summary | 2 |
| 热销/排名 + 品号 | TOP_ITEMS | analyzer top-items | 2 |
| 客户排名/TOP客户 | TOP_CUSTOMERS | analyzer top-customers | 2 |
| 单品/品号 + 销售 | ITEM_SALES | analyzer item-sales | 2 |
| 库存/存量/还有多少 | INVENTORY_BALANCE | analyzer db-stock | 3 |
| 利润/收入/成本 + 财务 | PROFIT_ANALYSIS | analyzer db-profit | 3 |
| 杜邦/ROE/净资产 | DUPONT_ANALYSIS | analyzer db-dupont | 3 |
| 查/搜索 + 品号/客户/供应商 | MASTER_QUERY | generic_adapter fastquery | 1 |
| 模糊匹配 + 基础资料 | MASTER_QUERY_MIXED | generic_adapter fastquery | 1 |
| 合规/合同比对/对比分析 | COMPLIANCE_CHECK | NANA合规助手工作流 | 1 |
| NANA/小娜/合同检查 | COMPLIANCE_CHECK | NANA合规助手工作流 | 1 |
| 订单核对/订单合规 | COMPLIANCE_CHECK | NANA合规助手工作流 | 1 |

> **优先级说明**: 1=单据操作(首选), 1c=合规检查(与单据同优先级), 2=API聚合分析, 3=DB直连(最后手段)

---

## 3. 路由决策树（完整版）

### 3.1 顶层决策

```
用户输入
  │
  ├─ 是否包含明确的单据名或操作动作？
  │   ├─ 是 → 进入 3.2 单据操作路由
  │   └─ 否 → 进入 3.3 数据分析路由
  │
  ├─ 是否包含统计/汇总/排名关键词？
  │   ├─ 是 → 进入 3.4 分析模式路由
  │   └─ 否 → 继续判断
  │
  ├─ 是否包含库存/财务/数据库相关词？
  │   ├─ 是 → 进入 3.5 DB直连路由
  │   └─ 否 → 继续判断
  │
  ├─ 是否包含合规/合同比对/订单核对关键词？
  │   ├─ 是 → 进入 3.7 合规检查路由
  │   └─ 否 → 继续判断
  │
  └─ 是否为基础资料查询？
      ├─ 是 → 进入 3.6 基础资料路由
      └─ 否 → 询问用户明确需求
```

### 3.2 单据操作路由

```
用户输入 → 识别TypeKey + Action
  │
  ├─ TypeKey 识别（服务注册表110个, 常用18+）
  │   ├─ "销售订单/订单"                  → sales.order
  │   ├─ "采购单/采购订单"               → purchase.order
  │   ├─ "进货单"                        → purchase.receipt
  │   ├─ "退货单"                        → purchase.return
  │   ├─ "销货单/出货单"                 → shipping.order
  │   ├─ "销退单"                        → sales.return
  │   ├─ "报价单"                        → quotation
  │   ├─ "订单合同"                      → sales.order.contract
  │   ├─ "工单"                          → wo
  │   ├─ "调拨单"                        → transfer
  │   ├─ "盘点单"                        → inventory.sheet
  │   ├─ "报废单"                        → scrap.order
  │   ├─ "请购单"                        → purchase.requisitions
  │   ├─ "收款单"                        → collection.doc
  │   ├─ "付款单"                        → payable.doc
  │   ├─ "其他入库单"                    → other.stock.in
  │   ├─ "其他出库单"                    → other.stock.out
  │   ├─ "请假单"                        → absence.request
  │   ├─ "合同比对/合规检查/订单核对"   → COMPLIANCE_CHECK (详见 3.7)
  │   └─ 不明确的单据名 → 提醒用户确认后再操作
  │
  ├─ Action 识别
  │   ├─ "创建/新增/录入/开单"           → create
  │   ├─ "修改/更新/编辑"                → update
  │   ├─ "查询/查看/读取/显示某单"       → getMultiple
  │   ├─ "搜索/查找/筛选/查列表"         → fastquery
  │   ├─ "审核/审批/通过"                → approve
  │   ├─ "撤审/取消审核/反审核"          → disapprove
  │   └─ "删除/作废"                     → delete
  │
  └─ 命令构造
      ├─ create/update:
      │   → python3 scripts/erp_generic_adapter.py
      │     --type-key "<type_key>"
      │     --action "create"
      │     --data '<JSON>'           ← 字段编号(IBAxxx/IBBxxx)
      │     --json
      │
      ├─ fastquery:
      │   → python3 scripts/erp_generic_adapter.py
      │     --type-key "<type_key>"
      │     --action "fastquery"
      │     --data '<JSON>'           ← 条件用别名(customer/item_no)
      │     --json
      │
      └─ approve/disapprove/delete/getMultiple:
          → python3 scripts/erp_generic_adapter.py
            --type-key "<type_key>"
            --action "<action>"
            --data '{"datakeys":[{"IBA001":"<单号>"}]}'
            --json
```

### 3.3 数据分析路由

```
用户要求"分析/统计/报表"
  │
  ├─ 数据性质判定 (关键决策点)
  │   │
  │   ├─ 有单号/单据范围的数据？
  │   │   ├─ 是 → 单据路由(API)
  │   │   │   例: "查订单SO202605001的内容"
  │   │   │   → sales.order getMultiple
  │   │   │
  │   │   └─ 否 → 继续判断
  │   │
  │   ├─ 单据列表级别的统计？
  │   │   ├─ 是 → 分析模式(API聚合)
  │   │   │   例: "本月的销售汇总"
  │   │   │   → erp_analyzer.py --mode summary
  │   │   │
  │   │   └─ 否 → 继续判断
  │   │
  │   ├─ 无单据概念的存量数据？
  │   │   ├─ 是 → DB直连
  │   │   │   例: "品号BM280B的库存余额"
  │   │   │   → erp_analyzer.py --mode db-stock
  │   │   │
  │   │   └─ 否 → 继续判断
  │   │
  │   └─ 财务科目/利润类？
  │       ├─ 是 → DB直连
  │       │   例: "这个月的利润分析"
  │       │   → erp_analyzer.py --mode db-profit
  │       │
  │       └─ 否 → 询问用户明确需求
  │
  └─ 路由结果
      ├─ 单头级分析 → API聚合模式
      ├─ 品号级分析 → API逐单抽样模式
      ├─ 库存余额   → DB直连模式
      └─ 财务分析   → DB直连模式
```

### 3.4 分析模式路由

```
┌──────────────────────────────────────────────────────────┐
│  用户输入 → 分析模式匹配                                  │
├──────────────────────────────────────────────────────────┤
│  关键词: "汇总/合计/总额/总计/统计"                       │
│  → --mode summary --months <N>                           │
│  例: "最近3个月的销售汇总"                                │
│  → python3 scripts/erp_analyzer.py --mode summary --months 3│
├──────────────────────────────────────────────────────────┤
│  关键词: "热销/最畅销/排名/TOP"                          │
│  → --mode top-items --limit <N> --sample <N>             │
│  例: "热销品号TOP10"                                      │
│  → python3 scripts/erp_analyzer.py --mode top-items --limit 10│
├──────────────────────────────────────────────────────────┤
│  关键词: "客户排名/TOP客户/大客户"                       │
│  → --mode top-customers --limit <N>                      │
│  例: "客户销售额排名"                                     │
│  → python3 scripts/erp_analyzer.py --mode top-customers   │
├──────────────────────────────────────────────────────────┤
│  关键词: "单品/品号XXX销售/销售记录"                     │
│  → --mode item-sales --item <品号> --sample <N>          │
│  例: "品号BM280B的销售记录"                               │
│  → python3 scripts/erp_analyzer.py --mode item-sales --item BM280B│
└──────────────────────────────────────────────────────────┘
```

### 3.5 DB 直连路由

```
┌──────────────────────────────────────────────────────────┐
│  前置条件检查                                              │
│  1. 是否已安装 pymssql?       pip install pymssql        │
│  2. 是否已配置 config/db_connections.json?               │
│  3. 是否有可用员工账号?       --mode db-users 查看        │
├──────────────────────────────────────────────────────────┤
│  判断: 第一次使用或不确定DB状态?                          │
│  → 先执行: python3 scripts/erp_analyzer.py --mode db-users│
│  → 选择可用账号后执行分析                                  │
├──────────────────────────────────────────────────────────┤
│  用户输入 → DB模式匹配                                    │
├──────────────────────────────────────────────────────────┤
│  关键词: "库存余额/现存量/库存还有/在库"                 │
│  → --mode db-stock [--item <品号>] --db-user <员工ID>    │
│  例: "查BM280B库存"                                      │
│  → python3 scripts/erp_analyzer.py --mode db-stock --item BM280B │
├──────────────────────────────────────────────────────────┤
│  关键词: "利润/损益/收入成本"                            │
│  → --mode db-profit [--year <年份>] --db-user <员工ID>  │
│  例: "查2026年利润"                                      │
│  → python3 scripts/erp_analyzer.py --mode db-profit --year 2026 │
├──────────────────────────────────────────────────────────┤
│  关键词: "杜邦/ROE/净资产收益率"                         │
│  → --mode db-dupont [--year <年份>] --db-user <员工ID>  │
│  例: "杜邦分析2026"                                      │
│  → python3 scripts/erp_analyzer.py --mode db-dupont --year 2026 │
└──────────────────────────────────────────────────────────┘
```

### 3.6 基础资料路由

```
用户输入 → 识别资料类型
  │
  ├─ 实体类型识别
  │   ├─ "品号/商品/物料"                    → item
  │   ├─ "客户"                              → customer
  │   ├─ "供应商"                            → supplier
  │   ├─ "部门"                              → department
  │   ├─ "仓库"                              → warehouse
  │   ├─ "员工/人员"                         → employee
  │   ├─ "客户品号"                          → customer.item
  │   ├─ "供应商品号"                        → supplier.item
  │   ├─ "客户商品价格"                      → item.customer.price
  │   └─ "批号"                              → item.lot
  │
  ├─ 快速匹配规则（根据输入内容格式自动选字段）
  │   │
  │   ├─ 纯数字 或 字母+数字组合（编码格式）
  │   │   ├─ 品号查询   → item_no = "输入值" (精确匹配)
  │   │   ├─ 客户查询   → customer_no = "输入值"
  │   │   └─ 供应商查询 → supplier_no = "输入值"
  │   │
  │   └─ 含中文（自然语言关键词）
  │       ├─ 品号查询   → product_name like "输入值%" (模糊匹配)
  │       ├─ 客户查询   → full_name_of_customer like "输入值%"
  │       └─ 供应商查询 → supplier_name like "输入值%"
  │
  └─ 命令构造
      → python3 scripts/erp_generic_adapter.py
        --type-key "<实体类型>"
        --action "fastquery"
        --data '{
          "page_no": 1,
          "page_size": <数量>,
          "use_has_next": true,
          "conditions": [{
            "fields": [{
              "field_name": "<匹配字段>",
              "value": "<值>",
              "operator": "<= 或 like>"
            }]
          }]
        }'
        --json
```

---

### 3.7 合规检查路由（NANA 助手）

```
用户输入 → 识别合规检查意图
  │
  ├─ 触发关键词
  │   ├─ "合规/合同比对/对比分析"
  │   ├─ "NANA/小娜"
  │   ├─ "合同检查/订单核对/订单合规"
  │   └─ 同时包含"订单/合同" + "比对/检查/核对/合规"
  │
  ├─ 工作流步骤
  │   ├─ Step 1: 意图识别 → 提取订单号 (prompts/01-intent-extraction.md)
  │   ├─ Step 2: 参数校验 → 检查订单号+合同附件
  │   ├─ Step 3: API调用 → sales.order getMultiple (详见 workflow.md)
  │   ├─ Step 4: 合同解析 → LLM提取合同字段 (prompts/02-contract-parsing.md)
  │   ├─ Step 5: 数据比对 → 系统vs合同差异报告 (prompts/03-data-comparison.md)
  │   └─ Step 6: 合规审查 → 民法典风险分析 (prompts/04-compliance-review.md)
  │
  ├─ API依赖
  │   └─ yz.oapi.sales.order.getMultiple (通过erp_generic_adapter调用)
  │
  └─ 输出格式
      ├─ 完全一致: "✅ 比对完成！合同与系统数据完全一致，未发现法律风险。"
      └─ 存在差异: "⚠️ 比对发现以下差异：... 📋 法律风险提示：..."
```
---

## 4. 字段映射规则（执行层）

### 4.1 字段选择矩阵

| 操作 | 单头字段 | 单身字段 | 条件字段 | 主键字段 |
|------|---------|---------|---------|---------|
| create | IBAxxx | IBBxxx | — | IBA001=""(自动生成) |
| update | IBAxxx | IBBxxx | — | IBA001(在datakeys中) |
| getMultiple | — | — | — | IBA001(在datakeys中) |
| approve | — | — | — | IBA001(在datakeys中) |
| disapprove | — | — | — | IBA001(在datakeys中) |
| delete | — | — | — | IBA001(在datakeys中) |
| fastquery | — | — | **别名** | — |

### 4.2 常用TypeKey的字段映射前缀

| TypeKey | 单头前缀 | 单身前缀 | 表名 |
|---------|---------|---------|------|
| sales.order | IBA | IBB | DCSIBA/DCSIBB |
| purchase.order | DFA | DFB | PURDFA/PURDFB |
| shipping.order | DGA | DGB | COPDGA/COPDGB |
| purchase.receipt | DHA | DHB | PURDHA/PURDHB |
| sales.return | DIA | DIB | COPDIA/COPDIB |
| purchase.return | DJA | DJB | PURDJA/PURDJB |
| item | DEA | — | TPADEA |
| customer | DFA | — | TPADFA |
| supplier | DGA | — | TPADGA |

> **注意**: 每种单据的字段编号不通用！
> 销售订单用 IBAxxx，采购订单用 DFAxxx，两者不同。
> **切换TypeKey时，必须读取对应 *_cli_spec.md 文件确认字段。**

### 4.3 数据格式化规则

| 数据类型 | 规则 | 正确示例 | 错误示例 |
|---------|------|---------|---------|
| 日期 | YYYYMMDD, 8位数字 | `20260430` | `2026-04-30` |
| 税率 | 小数, 如13%=0.13 | `0.13` | `13` 或 `"13%"` |
| 数量 | 纯数字 | `100` | `"100个"` |
| 单价 | 浮点数 | `99.50` | `"99.5元"` |
| 编码 | 字符串 | `"K00049"` | `K00049`(未加引号) |
| 汇率 | 浮点数 | `1.0` | `"1"` |

---

## 5. 完整执行协议

### 5.1 执行前自检清单

```
在执行任何命令前，逐项检查：

□ 0. 是否切换了 TypeKey？
   如果是，是否已读取新 TypeKey 的 *_cli_spec.md 文件确认字段？
   └─ 严禁使用上一单据的字段结构

□ 1. TypeKey 是否正确匹配用户意图？
   └─ 查注册表确认 TypeKey 存在

□ 2. Action 是否正确？
   create / getMultiple / fastquery / approve / disapprove / delete / update

□ 3. 字段名是否正确？
   └─ create/update → 字段编号 (IBAxxx/DFAxxx)
   └─ fastquery → 别名 (customer/item_no)

□ 4. 日期格式是否为 YYYYMMDD？
   └─ 8位数字，无横线、斜杠、中文

□ 5. 是否包含多余字段？
   └─ 价税合计等系统自动计算的字段不要写入

□ 6. 交易单据是否有 cdsDetail？
   └─ 单身明细数组

□ 7. 数值是否为纯数字？
   └─ 数量=100 不是 "100个"

□ 8. 税率是否为小数值？
   └─ 13% → 0.13，不是 13 也不是 "13%"

□ 9. 单位是否为查询返回的真实值？
   └─ 不是猜测的

□ 10. 编码是否已通过查询确认？
    └─ 不是编造的
```

### 5.2 命令执行格式

```bash
# ─── 单据操作 ───────────────────────────────────────────
python3 scripts/erp_generic_adapter.py \
  --type-key "<TypeKey>" \
  --action "<Action>" \
  --data '<JSON>' \
  --json

# ─── 数据分析(API聚合) ──────────────────────────────────
python3 scripts/erp_analyzer.py \
  --mode <模式> \
  [--item <品号>] \
  [--months <月数>] \
  [--limit <数量>] \
  [--sample <样本量>]

# ─── 数据分析(DB直连) ─────────────────────────────────
python3 scripts/erp_analyzer.py \
  --mode <模式> \
  [--item <品号>] \
  [--year <年份>] \
  [--db-user <员工ID>]

# ─── 查看可用DB账号 ─────────────────────────────────────
python3 scripts/erp_analyzer.py --mode db-users

# ─── 调试模式（查看原始hex，处理乱码） ─────────────────
python3 scripts/erp_generic_adapter.py \
  --type-key "<TypeKey>" \
  --action "<Action>" \
  --data '<JSON>' \
  --json --debug
```

### 5.3 结果处理协议

```python
# 解析执行结果
result = json.loads(command_output)
execution = result.get("std_data", {}).get("execution", {})
code = execution.get("code")  # "0"=成功, "-1"=失败

if code == "0":
    # 成功 → 提取数据，用中文呈现给用户
    success_data = result["std_data"]["parameter"]["result"]["success"][0]
    # 格式化输出结果
else:
    # 失败 → 读取错误信息
    error_msg = execution.get("description", "")
    error_details = result.get("std_data", {}).get("parameter", {})\
                          .get("result", {}).get("error", [])
    # 进入错误处理流程
```

---

## 6. 错误处理规则

### 6.1 错误类型与处理

| 错误类型 | 检测方式 | 处理流程 |
|---------|---------|---------|
| **Token无效** | 退出码3 | 提示用户检查 YZ_ERP_TOKEN |
| **URL无效** | 退出码2 | 提示用户检查 YZ_ERP_BASE_URL |
| **字段不存在** | `Field 'xxx' not found` | 读规格文件修正字段→重试，**禁止fallback到fastquery** |
| **列名无效** | `列名 'xxx' 无效` | fastquery检查别名→重试 |
| **单据明细为空** | `单据明细不能为空` | 补充cdsDetail→重试 |
| **编码不存在** | `xxx 不存在` | 先fastquery查正确编码 |
| **系统自动计算** | `不能手动修改` | 移除多余字段→重试 |
| **JSON解析失败** | JSON decode错误 | 加--debug查看原始hex |
| **乱码** | `���` `??` 不可读字符 | 让用户确认真实值，**严禁猜测** |
| **超时/连接失败** | 网络错误 | 检查网络连接和API地址 |

### 6.2 错误处理铁律

```
┌─────────────────────────────────────────────────────────┐
│  🔴 第一条: 不动代码                                    │
│  绝对不修改 .py / .sh / .skill / .json 文件             │
│  只调整 --data 中的 JSON 内容                           │
├─────────────────────────────────────────────────────────┤
│  🔴 第二条: 不猜乱码                                    │
│  乱码=不可用数据，展示给用户，请求协助                   │
├─────────────────────────────────────────────────────────┤
│  🔴 第三条: 不绕路(fallback)                            │
│  "Field not found" → 读规格文件修正字段                  │
│  不得改用 fastquery 替代 create/getMultiple             │
├─────────────────────────────────────────────────────────┤
│  🔴 第四条: 切换TypeKey必须读规格文件                   │
│  从销售订单切到采购单 → 读 purchase_order_cli_spec.md   │
│  错误: 采购单用了 IBAxxx (销售订单的字段)               │
└─────────────────────────────────────────────────────────┘
```

### 6.3 执行失败后的自检流程

```
命令返回错误
    │
    ├─ 1. 读取 execution.code
    │      code == "0" → 成功，处理结果
    │      code != "0" → 进入错误处理
    │
    ├─ 2. 读取 execution.description
    │      提取错误摘要
    │
    ├─ 3. 读取 result.error[].message
    │      获取详细错误信息
    │
    ├─ 4. 对照错误诊断表判断原因
    │      ├─ Field not found   → TypeKey规格文件用错 or 用了别名
    │      ├─ 列名无效          → fastquery用了字段编号
    │      ├─ 单据明细为空      → 缺cdsDetail
    │      └─ 编码不存在        → 需要先查编码
    │
    └─ 5. 修正后重试
           ├─ 字段错误 → 读规格文件，修正字段名
           ├─ 数据错误 → 修正JSON内容
           └─ 不确定错误 → 告知用户并请求指导
```

---

## 7. 防上下文泄漏规则（重点）

### 7.1 问题的本质

AI Agent 在处理连续多个ERP操作时，容易将前一单据的字段结构误用于后面的单据。例如：

```
用户: "帮我创建一笔销售订单"
  → AI正确使用了 IBAxxx/IBBxxx 字段

用户: "再帮我创建一个采购单"
  → AI错误: 采购单用了 IBAxxx 字段 (正确应为 DFAxxx/DFBxxx)
```

### 7.2 强制防护措施

每次构造命令前，必须执行以下检查：

```
□ 当前 TypeKey 是 ___________ (填入)
□ 上一个 TypeKey 是 _________ (填入)

IF 两者不同:
  → 读取当前 TypeKey 的 *_cli_spec.md
  → 确认字段映射与之前不同
  → 重新组装 JSON
  → 执行前再次核对字段与前一个不同
```

### 7.3 典型案例

| 场景 | 错误 | 正确 |
|------|------|------|
| 先查销售订单，再查采购订单 | 采购订单用了 `IBA001` | 采购订单用 `DFA001` |
| 先创建报价单，再创建销货单 | 销货单用报价单的字段 | 销货单用 `DGAxxx/DGBxxx` |
| 先查客户，再查商品 | 商品查了 `customer` | 商品查 `item_no` |

---

## 8. 路由决策速查卡

### 8.1 一句话决策

| 用户需求 | 一句话决策 |
|---------|-----------|
| "创建/修改某单据" | → 走 generic_adapter，确定TypeKey+Action+字段 |
| "查某张单的内容" | → 走 generic_adapter getMultiple |
| "查某条件的单据列表" | → 走 generic_adapter fastquery |
| "销售统计/汇总/排名" | → 走 analyzer API模式 |
| "库存余额/现存量" | → 走 analyzer db-stock (DB直连) |
| "利润/财务/杜邦分析" | → 走 analyzer db-profit/db-dupont (DB直连) |
| "查品号/客户/供应商信息" | → 走 generic_adapter fastquery (快速匹配规则) |

### 8.2 路由优先级

```
1. 单据操作 (有单号/单据名)          → 最高优先级
2. 基础资料查询 (有实体名+编码/名称) → 
3. 数据分析-API聚合 (统计汇总)       →
4. 数据分析-DB直连 (库存/财务)       → 最低优先级
```

> 当用户输入同时满足多个条件时，按此优先级执行。
> 例: "查订单SO001的库存" → 先解释这是"查订单内容"而不是"查库存"

---

## 9. 命令示例全集

### 9.1 单据操作

```bash
# 创建销售订单
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.order" \
  --action "create" \
  --data '{"IBA001":"","IBA003":"20260430","IBA004":"K00049","IBA005":"060600","IBA007":"RMB","IBA008":1,"cdsDetail":[{"IBB001":"","IBB002":"001","IBB003":"2000000110","IBB005":"件","IBB006":10,"IBB031":100,"IBB032":1000}]}' \
  --json

# 查询销售订单列表 (按客户筛选)
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.order" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"customer","value":"KH%","operator":"like"}]}]}' \
  --json

# 读取销售订单详情
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.order" \
  --action "getMultiple" \
  --data '{"datakeys":[{"IBA001":"20260430000001"}]}' \
  --json

# 审核销售订单
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.order" \
  --action "approve" \
  --data '{"datakeys":[{"IBA001":"20260430000001"}]}' \
  --json

# 创建采购订单
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.order" \
  --action "create" \
  --data '{"DFA001":"","DFA003":"20260430","DFA004":"PG0001","DFA005":"060600","cdsDetail":[{"DFB003":"2000000110","DFB005":"件","DFB006":20}]}' \
  --json
```

### 9.2 数据分析

```bash
# 销售汇总 (近3个月)
python3 scripts/erp_analyzer.py --mode summary --months 3

# 热销品号 TOP10
python3 scripts/erp_analyzer.py --mode top-items --limit 10 --sample 30

# 单品销售追踪
python3 scripts/erp_analyzer.py --mode item-sales --item BM280B --sample 20

# 客户销售排名
python3 scripts/erp_analyzer.py --mode top-customers --limit 10
```

### 9.3 DB直连

```bash
# 查看可用DB账号
python3 scripts/erp_analyzer.py --mode db-users

# 库存余额查询 (指定品号)
python3 scripts/erp_analyzer.py --mode db-stock --item BM280B --db-user zhangsan

# 全部库存
python3 scripts/erp_analyzer.py --mode db-stock --db-user wangwu

# 月度利润
python3 scripts/erp_analyzer.py --mode db-profit --year 2026 --db-user lisi

# 杜邦分析
python3 scripts/erp_analyzer.py --mode db-dupont --year 2026 --db-user lisi
```

### 9.4 基础资料查询

```bash
# 查商品 (按编号精确)
python3 scripts/erp_generic_adapter.py \
  --type-key "item" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"item_no","value":"BM280B","operator":"="}]}]}' \
  --json

# 查商品 (按名称模糊)
python3 scripts/erp_generic_adapter.py \
  --type-key "item" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"product_name","value":"块包机%","operator":"like"}]}]}' \
  --json

# 查客户 (按名称模糊)
python3 scripts/erp_generic_adapter.py \
  --type-key "customer" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"full_name_of_customer","value":"万森%","operator":"like"}]}]}' \
  --json

# 查供应商
python3 scripts/erp_generic_adapter.py \
  --type-key "supplier" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

---

## 10. 附录

### A. 服务注册表索引 (完整 110 个 TypeKey)

> 完整注册表见: `registry/service_registry.json`

**常用 (18+):**

| TypeKey | 名称 | 支持操作 |
|---------|------|---------|
| sales.order | 销售订单 | CRUD+审批+撤审 |
| purchase.order | 采购订单 | CRUD+审批+撤审 |
| shipping.order | 销货单 | CRUD+审批+撤审 |
| purchase.receipt | 进货单 | CRUD+审批+撤审 |
| sales.return | 销退单 | CRUD+审批+撤审 |
| purchase.return | 退货单 | CRUD+审批+撤审 |
| quotation | 报价单 | CRUD+审批+撤审 |
| sales.order.contract | 订单合同 | CRUD+审批+撤审 |
| item | 商品信息 | 查询 |
| customer | 客户信息 | 查询 |
| supplier | 供应商信息 | 查询 |
| department | 部门信息 | 查询 |
| warehouse | 仓库信息 | 查询 |
| employee | 人员信息 | 查询 |
| wo | 工单 | CRUD+审批+撤审 |
| transfer | 调拨单 | CRUD+审批+撤审 |
| inventory.sheet | 盘点单 | CRUD+审批+撤审 |
| bom | 商品结构 | CRUD+审批+撤审 |

### B. CLI 规格文件索引

| TypeKey | 规格文件 |
|---------|---------|
| sales.order | `docs/sales_order_cli_spec.md` |
| quotation | `docs/quotation_cli_spec.md` |
| sales.order.contract | `docs/sales_order_contract_cli_spec.md` |
| purchase.order | `docs/purchase_order_cli_spec.md` |
| purchase.receipt | `docs/purchase_receipt_cli_spec.md` |
| purchase.return | `docs/purchase_return_cli_spec.md` |
| shipping.order | `docs/shipping_order_cli_spec.md` |
| sales.return | `docs/sales_return_cli_spec.md` |
| customer | `docs/customer_cli_spec.md` |
| supplier | `docs/supplier_cli_spec.md` |
| item | `docs/item_cli_spec.md` |
| department | `docs/department_cli_spec.md` |
| warehouse | `docs/warehouse_cli_spec.md` |
| customer.item | `docs/customer_item_cli_spec.md` |
| supplier.item | `docs/supplier_item_cli_spec.md` |
| item.customer.price | `docs/item_customer_price_cli_spec.md` |
| item.supplier.price | `docs/item_supplier_price_cli_spec.md` |
| item.lot | `docs/item_lot_cli_spec.md` |

### C. 数据库表参考 (DB直连)

| 表名 | 说明 | 用途 |
|------|------|------|
| JSKLOA | 现存量表 | 库存余额查询 |
| TPADEA | 商品信息表 | 品名查询 |
| JSKLAA | 仓库信息表 | 仓库名称 |
| KJSNDA | 会计凭证头 | 财务分析 |
| KJSNDB | 会计凭证身 | 财务分析明细 |
| KJSNBA | 会计科目 | 科目分类 |
| KJSNFA | 科目余额 | 月度利润/杜邦分析 |

### D. 退出码速查

| 退出码 | 含义 | 处理 |
|--------|------|------|
| 0 | 成功 | 正常显示结果 |
| 1 | 一般错误 | 读取错误信息 |
| 2 | 验证错误 | 检查传入参数 |
| 3 | Token无效 | 检查 YZ_ERP_TOKEN |
| 7 | ERP业务逻辑错误 | 读取 execution.description |
