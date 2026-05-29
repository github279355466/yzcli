# JSON 组装示例

> 本文档提供各操作类型的完整 JSON 组装示例和字段命名规则。

## 通用字段命名规则

| 操作 | 使用字段 | 示例 |
|------|---------|------|
| 创建/更新 | **字段编号**（IBAxxx/IBBxxx/DFAxxx） | `{"IBA001": "", "IBA003": "20260430"}` |
| 读取详情 (getMultiple) | 输入用**字段编号**，返回含别名 | `{"datakeys": [{"IBA001": "?"}]}` |
| 条件搜索 (fastquery) | 条件字段用**别名**（customer, item_no） | `{"field_name": "customer", "value": "?"}` |
| 审批/删除 | **字段编号**（主键） | `{"datakeys": [{"IBA001": "?"}]}` |

## 数据范围差异

| operation | 返回数据 | 适用场景 |
|-----------|---------|---------|
| `fastquery` | 仅单头数据（列表级） | 搜索/筛选/列表展示 |
| `getMultiple` | 单头 + cdsDetail 单身明细（完整级） | 查看详情、分析比对、核对 |

> **有明确单号时直接用 `getMultiple`**，不要用 `fastquery` 搜索后再逐条获取。

## 条件搜索操作 (fastquery)

### 基础搜索（无条件）
```json
{
  "type_key": "sales.order",
  "operation": "fastquery",
  "input": {
    "page_no": 1,
    "page_size": 20,
    "query_type": "all"
  }
}
```

### 条件搜索（按客户 + 日期范围）
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
            "operator": "=",
            "value": "C0092"
          }
        ]
      }
    ]
  }
}
```

### 条件搜索（模糊搜索 + 排序）
```json
{
  "type_key": "customer",
  "operation": "fastquery",
  "input": {
    "page_no": 1,
    "page_size": 10,
    "conditions": [
      {
        "fields": [
          {
            "field_name": "full_name_of_customer",
            "operator": "like",
            "value": "鼎捷%"
          }
        ]
      }
    ]
  }
}
```

### 条件操作符
- `=` : 等于
- `!=` : 不等于
- `like` : 模糊匹配（值中加 `%` 作为通配符）
- `>`, `>=`, `<`, `<=` : 大于、大于等于、小于、小于等于

### 多条件组合（AND）
```json
{
  "conditions": [
    {
      "fields": [
        { "field_name": "customer", "operator": "=", "value": "C0092" },
        { "field_name": "IBA003", "operator": ">=", "value": "20260401" }
      ]
    }
  ]
}
```

## 读取详情操作 (getMultiple)

> **getMultiple 返回单头 + cdsDetail 单身明细**，适合查看详情、分析比对等需要完整数据的场景。

### 按单号读取
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

### 按客户编码读取（基础资料）
```json
{
  "type_key": "customer",
  "operation": "getMultiple",
  "input": {
    "datakeys": [
      { "DFA001": "C0092" }
    ]
  }
}
```

## 创建操作 (create)

### 创建销售订单
```json
{
  "type_key": "sales.order",
  "operation": "create",
  "input": {
    "cdsMaster": [
      {
        "IBA001": "",
        "IBA003": "20260430",
        "IBA004": "K00049",
        "IBA005": "060600",
        "IBA007": "CNY",
        "IBA008": 1.0,
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

### 创建多行明细
```json
{
  "type_key": "sales.order",
  "operation": "create",
  "input": {
    "cdsMaster": [
      {
        "IBA001": "",
        "IBA003": "20260430",
        "IBA004": "K00049",
        "cdsDetail": [
          {
            "IBB003": "2000000110",
            "IBB005": "件",
            "IBB006": 10
          },
          {
            "IBB003": "2000000111",
            "IBB005": "件",
            "IBB006": 5
          }
        ]
      }
    ]
  }
}
```

## 更新操作 (update)

### 更新销售订单
```json
{
  "type_key": "sales.order",
  "operation": "update",
  "input": {
    "cdsMaster": [
      {
        "IBA001": "SO20260525007",
        "IBA003": "20260430",
        "IBA004": "K00049",
        "cdsDetail": [
          {
            "IBB003": "2000000110",
            "IBB005": "件",
            "IBB006": 20
          }
        ]
      }
    ]
  }
}
```

**注意**：更新时必须包含完整的单头和单身数据。

## 审核操作 (approve)

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

## 撤审操作 (disapprove)

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

## 删除操作 (delete)

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

## 自检清单（组装 JSON 后必检）

- [ ] 日期已是 `YYYYMMDD` 格式
- [ ] 字段名是当前 TypeKey 的字段编号（不是别名）
- [ ] 没有多余字段（让 ERP 自动计算金额等）
- [ ] 编码已通过查询确认有效
- [ ] 有 `cdsDetail` 数组（交易单据）
- [ ] 数值是纯数字（无单位字符串）
- [ ] 税率是小数值（0.13 而非 13）
