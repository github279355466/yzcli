# CLI 规格说明书：品号换算单位

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `item.unit` |
| **DLL** | `TPAGC09` |
| **服务名称** | `品号换算单位` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.unit" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.unit" \
  --action "getMultiple" \
  --data '{"datakeys":[{"DCA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.unit" \
  --action "create" \
  --data '{"DCA001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `DCA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPADCA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DCA001` | 部门编号 | `DCA001` | string |  |
| `DCA002` | 年度 | `DCA002` | string |  |
| `DCA003` | 预留字段 | `DCA003` | string |  |
| `DCA004` | 预留字段 | `DCA004` | string |  |
| `DCA005` | 预留字段 | `DCA005` | string |  |
| `DCA006` | 预留字段 | `DCA006` | string |  |
| `DCA007` | 预留字段 | `DCA007` | float |  |
| `DCA008` | 预留字段 | `DCA008` | float |  |
| `DCA901` | 录入者编号 | `entry_person_no` | string |  |
| `DCA902` | 录入时间 | `entry_time` | string |  |
| `DCA903` | 更改者编号 | `changer_no` | string |  |
| `DCA904` | 更改时间 | `change_time` | string |  |
| `DCA905` | 更新标记 | `update_flag` | integer |  |

### 3.2 单身表 (TPADCB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DCB001` | 部门编号 | `DCB001` | string |  |
| `DCB002` | 年度 | `DCB002` | string |  |
| `DCB003` | 业务员编号 | `DCB003` | string |  |
| `DCB004` | 1月目标金额 | `DCB004` | string |  |
| `DCB005` | 2月目标金额 | `DCB005` | string |  |
| `DCB006` | 3月目标金额 | `DCB006` | string |  |
| `DCB007` | 4月目标金额 | `DCB007` | string |  |
| `DCB008` | 5月目标金额 | `DCB008` | string |  |
| `DCB009` | 6月目标金额 | `DCB009` | string |  |
| `DCB010` | 7月目标金额 | `DCB010` | string |  |
| `DCB011` | 8月目标金额 | `DCB011` | string |  |
| `DCB012` | 9月目标金额 | `DCB012` | string |  |
| `DCB013` | 10月目标金额 | `DCB013` | string |  |
| `DCB014` | 11月目标金额 | `DCB014` | string |  |
| `DCB015` | 12月目标金额 | `DCB015` | string |  |
| `DCB016` | 预留字段 | `DCB016` | string |  |
| `DCB017` | 预留字段 | `DCB017` | string |  |
| `DCB018` | 预留字段 | `DCB018` | string |  |
| `DCB019` | 预留字段 | `DCB019` | string |  |
| `DCB020` | 预留字段 | `DCB020` | float |  |
| `DCB021` | 预留字段 | `DCB021` | float |  |
| `DCB901` | 录入者编号 | `entry_person_no` | string |  |
| `DCB902` | 录入时间 | `entry_time` | string |  |
| `DCB903` | 更改者编号 | `changer_no` | string |  |
| `DCB904` | 更改时间 | `change_time` | string |  |
| `DCB905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "DCA001": ""
  ,"DCA001": ""
  ,"DCA002": ""
  ,"DCA003": ""
  ,"cdsDetail": [{
    "DCB001": ""
    ,"DCB001": ""
    ,"DCB002": ""
    ,"DCB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"DCA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"DCA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `DCA001` | `DCA001` | 部门编号 | |
| `DCA002` | `DCA002` | 年度 | |
| `DCA003` | `DCA003` | 预留字段 | |
| `DCA004` | `DCA004` | 预留字段 | |
| `DCA005` | `DCA005` | 预留字段 | |
| `DCA006` | `DCA006` | 预留字段 | |
| `DCA007` | `DCA007` | 预留字段 | |
| `DCA008` | `DCA008` | 预留字段 | |
| `DCA901` | `entry_person_no` | 录入者编号 | |
| `DCA902` | `entry_time` | 录入时间 | |
| `DCB001` | `DCB001` | 部门编号 (单身) | |
| `DCB002` | `DCB002` | 年度 (单身) | |
| `DCB003` | `DCB003` | 业务员编号 (单身) | |
| `DCB004` | `DCB004` | 1月目标金额 (单身) | |
| `DCB005` | `DCB005` | 2月目标金额 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `DCA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `DCA001`
