# 字段映射矩阵

> 本文档列出各 TypeKey 的字段编号前缀及其业务含义，帮助理解字段结构。

## 字段编号前缀规则

| 前缀 | 含义 | 常见 TypeKey |
|------|------|-------------|
| `IBA` | 单据单头字段（Header） | sales.order, purchase.order, shipping.order |
| `IBB` | 单据单身字段（Detail） | sales.order, purchase.order |
| `DFA` | 客户基础资料字段 | customer |
| `DEA` | 商品基础资料字段 | item |
| `DGA` | 供应商基础资料字段 | supplier |
| `DHA` | 部门基础资料字段 | department |
| `DIA` | 仓库基础资料字段 | warehouse |
| `TPAGC` | 系统参数/通用字段 | 多种基础资料 |
| `COPDC` | 销售订单 DLL 标识 | sales.order |
| `PURCC` | 采购单 DLL 标识 | purchase.order |

## 核心 TypeKey 字段详解

### 销售订单 (sales.order)

**单头字段（IBA 系列）**：

| 字段编号 | 字段名 | 说明 | 类型 |
|---------|--------|------|------|
| IBA001 | 单号 | 订单编号 | string |
| IBA003 | 日期 | 订单日期 (YYYYMMDD) | string |
| IBA004 | 客户编码 | 关联客户 | string |
| IBA005 | 业务员 | 关联业务员 | string |
| IBA007 | 币种 | 货币代码 | string |
| IBA008 | 汇率 | 货币汇率 | float |
| IBA022 | 审批状态 | F=未审, T=已审 | string |

**单身字段（IBB 系列）**：

| 字段编号 | 字段名 | 说明 | 类型 |
|---------|--------|------|------|
| IBB003 | 品号 | 商品编号 | string |
| IBB005 | 单位 | 计量单位 | string |
| IBB006 | 数量 | 数量 | float |
| IBB013 | 预交日 | 预计交货日 (YYYYMMDD) | string |
| IBB031 | 含税单价 | 含税单价（ERP自动计算，禁止写入） | float |
| IBB032 | 价税合计 | 价税合计（ERP自动计算，禁止写入） | float |

**条件查询别名映射**：

| 别名 | 对应字段编号 | 用途 |
|------|-------------|------|
| customer | IBA004 | 按客户查询 |
| salesperson | IBA005 | 按业务员查询 |
| currency | IBA007 | 按币种查询 |
| item_no | IBB003 | 按品号查询（单身条件） |

### 客户 (customer)

| 字段编号 | 字段名 | 说明 | 类型 |
|---------|--------|------|------|
| DFA001 | 客户编码 | 主键 | string |
| DFA002 | 客户简称 | 简称 | string |
| DFA003 | 客户全名 | 全名 | string |

**条件查询别名**：customer_no→DFA001, customer_abbreviation→DFA002, full_name_of_customer→DFA003

### 商品 (item)

| 字段编号 | 字段名 | 说明 | 类型 |
|---------|--------|------|------|
| DEA001 | 品号 | 主键 | string |
| DEA002 | 品名 | 名称 | string |
| DEA003 | 规格 | 规格型号 | string |
| DEA036 | 快速代号 | 快速检索码 | string |

**条件查询别名**：item_no→DEA001, product_name→DEA002, quick_code→DEA036

### 供应商 (supplier)

| 字段编号 | 字段名 | 说明 | 类型 |
|---------|--------|------|------|
| DGA001 | 供应商编码 | 主键 | string |
| DGA002 | 供应商名称 | 名称 | string |

**条件查询别名**：supplier_no→DGA001, supplier_name→DGA002

## 字段使用规则

| 操作类型 | 使用字段 | 示例 |
|---------|---------|------|
| 创建/更新 | **字段编号** (IBAxxx/IBBxxx/DFAxxx) | `{"IBA001": "", "IBA003": "20260430"}` |
| 读取详情 | 输入用**字段编号**，返回含别名 | `{"datakeys": [{"IBA001": "?"}]}` |
| 条件查询 | 条件字段用**别名** | `{"field_name": "customer", "value": "?"}` |
| 审批/删除 | **字段编号**（主键） | `{"datakeys": [{"IBA001": "?"}]}` |
