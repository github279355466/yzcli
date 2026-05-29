# CLI 规格说明书：币种汇率

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `currency` |
| **DLL** | `TPAGC06` |
| **服务名称** | `币种汇率` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "currency" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "currency" \
  --action "getMultiple" \
  --data '{"datakeys":[{"BBA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "currency" \
  --action "create" \
  --data '{"BBA001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `BBA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPABBA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `BBA001` | 币种编号 | `BBA001` | string | 主键 |
| `BBA002` | 货币名称 | `currency_name` | string |  |
| `BBA003` | 汇率 | `BBA003` | float |  |
| `BBA004` | 英文名称 | `BBA004` | string |  |
| `BBA005` | 预留字段1 | `BBA005` | string |  |
| `BBA006` | 预留字段2 | `BBA006` | float |  |
| `BBA007` | 货币符号 | `BBA007` | string |  |
| `BBA901` | 录入者编号 | `entry_person_no` | string |  |
| `BBA902` | 录入时间 | `entry_time` | string |  |
| `BBA903` | 更改者编号 | `changer_no` | string |  |
| `BBA904` | 更改时间 | `change_time` | string |  |
| `BBA905` | 更新标记 | `update_flag` | integer |  |

### 3.2 单身表 (TPABBB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `BBB001` | 生效日期 | `BBB001` | string |  |
| `BBB002` | 币种 | `BBB002` | string |  |
| `BBB003` | 记帐汇率 | `BBB003` | float |  |
| `BBB004` | 调整汇率 | `BBB004` | float |  |
| `BBB005` | 预留字段 | `BBB005` | float |  |
| `BBB006` | 预留字段 | `BBB006` | string |  |
| `BBB007` | 预留字段 | `BBB007` | string |  |
| `BBB008` | 预留字段 | `BBB008` | float |  |
| `BBB901` | 录入者编号 | `entry_person_no` | string |  |
| `BBB902` | 录入时间 | `entry_time` | string |  |
| `BBB903` | 更改者编号 | `changer_no` | string |  |
| `BBB904` | 更改时间 | `change_time` | string |  |
| `BBB905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "BBA001": ""
  ,"BBA002": ""
  ,"BBA003": 1
  ,"BBA004": ""
  ,"cdsDetail": [{
    "BBB001": ""
    ,"BBB001": ""
    ,"BBB002": ""
    ,"BBB003": 1
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"BBA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"BBA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `BBA001` | `BBA001` | 币种编号 | 主键 |
| `BBA002` | `currency_name` | 货币名称 | |
| `BBA003` | `BBA003` | 汇率 | |
| `BBA004` | `BBA004` | 英文名称 | |
| `BBA005` | `BBA005` | 预留字段1 | |
| `BBA006` | `BBA006` | 预留字段2 | |
| `BBA007` | `BBA007` | 货币符号 | |
| `BBA901` | `entry_person_no` | 录入者编号 | |
| `BBA902` | `entry_time` | 录入时间 | |
| `BBA903` | `changer_no` | 更改者编号 | |
| `BBB001` | `BBB001` | 生效日期 (单身) | |
| `BBB002` | `BBB002` | 币种 (单身) | |
| `BBB003` | `BBB003` | 记帐汇率 (单身) | |
| `BBB004` | `BBB004` | 调整汇率 (单身) | |
| `BBB005` | `BBB005` | 预留字段 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `BBA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `BBA001`
