# 路由决策树

> 本文档提供完整的路由决策逻辑，帮助 Agent 精确选择操作路径。

## 4 层路由模型

```
Layer 1: 意图分类器 (Intent Classifier)
  → 将用户输入分为 5 类意图
Layer 2: 参数提取器 (Parameter Extractor)
  → 从自然语言中提取结构化参数
Layer 3: 路由执行器 (Route Executor)
  → 根据意图+参数选择 MCP 工具调用路径
Layer 4: 执行引擎 (Execution Engine)
  → 调用 yzcli_run 完成实际操作
```

## 意图分类（5 类）

| 意图类别 | 典型表达 | 路由目标 |
|---------|---------|---------|
| **单据操作** | "创建订单"、"审核采购单"、"查看出货单" | yzcli_run + 对应 operation |
| **基础资料查询** | "查客户"、"看看这个品号"、"供应商有哪些" | yzcli_run(operation=fastquery) + 快速匹配 |
| **数据统计** | "这个月销售汇总"、"热销品号"、"客户排名" | yzcli_run(operation=fastquery) + 聚合 |
| **库存/财务** | "查库存"、"这个月利润" | 当前版本不支持（需 DB 直连） |
| **合规检查** | "合同比对"、"订单核对" | 当前版本不支持 |

## 决策优先级

单据操作 > 基础资料查询 > 数据统计 > 其他（询问用户）

## 单据操作路由

```
用户输入
  │
  ├─ 识别业务对象 → 确定 TypeKey（查服务查找表）
  │
  ├─ 识别操作意图
  │   ├─ "查询/列表/搜索" → operation: fastquery
  │   ├─ "读取/详情/查看/看看" → operation: getMultiple
  │   ├─ "创建/新增/录入" → operation: create
  │   ├─ "修改/更新/改" → operation: update
  │   ├─ "删除" → operation: delete
  │   ├─ "审核/批准" → operation: approve
  │   └─ "撤审/取消审核" → operation: disapprove
  │
  ├─ 提取参数
  │   ├─ query: 日期范围、客户、品号、分页
  │   ├─ get: 单号
  │   ├─ create/update: 客户、品号、数量、单价、日期
  │   └─ approve/delete/disapprove: 单号
  │
  └─ 检查参数完整性
      ├─ 缺失必填项 → 询问用户
      ├─ 中文名称 → 先查基础资料获取编码
      └─ 编码格式正确 → 直接使用
```

## 基础资料查询路由

```
用户输入
  │
  ├─ 识别查询对象
  │   ├─ "品号/商品/物料" → TypeKey: item
  │   ├─ "客户" → TypeKey: customer
  │   ├─ "供应商" → TypeKey: supplier
  │   ├─ "部门" → TypeKey: department
  │   └─ "仓库" → TypeKey: warehouse
  │
  ├─ 应用快速匹配规则
  │   ├─ 纯数字/英文字母+数字 → 编号精确匹配 (=)
  │   ├─ 含中文 → 名称模糊匹配 (like + %)
  │   └─ 无关键词 → 列出前 N 条
  │
  └─ 调用 yzcli_run(operation=fastquery)
```

## 防上下文泄漏规则

**切换单据类型时必须重置上下文**：
- 从销售订单切到采购单 → 必须重新调用 `yzcli_help`
- 从客户查询切到商品查询 → 必须重新调用 `yzcli_help`
- **每种 TypeKey 有独立的字段体系**，禁止混用

## 数据统计路由

| 需求类型 | 处理方式 |
|---------|---------|
| "这个月销售汇总" | query 操作 + 日期条件 + 聚合 |
| "热销品号 TOP N" | query 操作 + 排序 + 分页 |
| "客户销售排名" | query 操作 + 按客户分组 |

注意：当前版本的 yzcli_run 只支持基础 CRUD 操作，复杂聚合需在 Agent 端处理返回结果。
