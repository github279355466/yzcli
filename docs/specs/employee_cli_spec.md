# CLI 规格说明书：人员信息

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `employee` |
| **DLL** | `TPAGC47` |
| **服务名称** | `人员信息` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "employee" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "employee" \
  --action "getMultiple" \
  --data '{"datakeys":[{"DIA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "employee" \
  --action "create" \
  --data '{"DIA001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `DIA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPADIA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DIA001` | 签核编号 | `DIA001` | string | 主键 |
| `DIA002` | 签核名称 | `DIA002` | string |  |
| `DIA003` | 签核一 | `DIA003` | string |  |
| `DIA004` | 签核二 | `DIA004` | string |  |
| `DIA005` | 签核三 | `DIA005` | string |  |
| `DIA006` | 签核四 | `DIA006` | string |  |
| `DIA007` | 签核五 | `DIA007` | string |  |
| `DIA008` | 预留字段 | `DIA008` | string |  |
| `DIA009` | 预留字段 | `DIA009` | string |  |
| `DIA010` | 预留字段 | `DIA010` | string |  |
| `DIA901` | 录入者编号 | `entry_person_no` | string |  |
| `DIA902` | 录入时间 | `entry_time` | string |  |
| `DIA903` | 更改者编号 | `changer_no` | string |  |
| `DIA904` | 更改时间 | `change_time` | string |  |
| `DIA905` | 更新标记 | `update_flag` | integer |  |

### 3.2 单身表 (TPADIB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DIB001` | 签核编号 | `DIB001` | string |  |
| `DIB002` | 程序编号 | `DIB002` | string |  |
| `DIB003` | 人员一 | `DIB003` | string |  |
| `DIB004` | 人员二 | `DIB004` | string |  |
| `DIB005` | 人员三 | `DIB005` | string |  |
| `DIB006` | 人员四 | `DIB006` | string |  |
| `DIB007` | 人员五 | `DIB007` | string |  |
| `DIB008` | 预留字段 | `DIB008` | string |  |
| `DIB009` | 预留字段 | `DIB009` | string |  |
| `DIB010` | 预留字段 | `DIB010` | string |  |
| `DIB901` | 录入者编号 | `entry_person_no` | string |  |
| `DIB902` | 录入时间 | `entry_time` | string |  |
| `DIB903` | 更改者编号 | `changer_no` | string |  |
| `DIB904` | 更改时间 | `change_time` | string |  |
| `DIB905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "DIA001": ""
  ,"DIA002": ""
  ,"DIA003": ""
  ,"DIA004": ""
  ,"cdsDetail": [{
    "DIB001": ""
    ,"DIB001": ""
    ,"DIB002": ""
    ,"DIB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"DIA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"DIA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `DIA001` | `DIA001` | 签核编号 | 主键 |
| `DIA002` | `DIA002` | 签核名称 | |
| `DIA003` | `DIA003` | 签核一 | |
| `DIA004` | `DIA004` | 签核二 | |
| `DIA005` | `DIA005` | 签核三 | |
| `DIA006` | `DIA006` | 签核四 | |
| `DIA007` | `DIA007` | 签核五 | |
| `DIA008` | `DIA008` | 预留字段 | |
| `DIA009` | `DIA009` | 预留字段 | |
| `DIA010` | `DIA010` | 预留字段 | |
| `DIB001` | `DIB001` | 签核编号 (单身) | |
| `DIB002` | `DIB002` | 程序编号 (单身) | |
| `DIB003` | `DIB003` | 人员一 (单身) | |
| `DIB004` | `DIB004` | 人员二 (单身) | |
| `DIB005` | `DIB005` | 人员三 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `DIA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `DIA001`
