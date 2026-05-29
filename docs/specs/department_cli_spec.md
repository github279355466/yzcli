# CLI 规格说明书：部门信息

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `department` |
| **DLL** | `TPAGC02` |
| **服务名称** | `部门信息` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "department" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "department" \
  --action "getMultiple" \
  --data '{"datakeys":[{"DAA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "department" \
  --action "create" \
  --data '{"DAA001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `DAA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPADAA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DAA001` | 部门编号 | `dept_no` | string | 主键 |
| `DAA002` | 部门名称 | `dept_name` | string |  |
| `DAA003` | 部门英文名称 | `dept_english_name` | string |  |
| `DAA004` | 部门级次 | `dept_level` | string |  |
| `DAA005` | 折旧科目 | `depreciation_account` | string |  |
| `DAA006` | 核算项目 | `accounting_item` | string |  |
| `DAA007` | 核算项目名称 | `accounting_item_name` | string |  |
| `DAA008` | 预留字段 | `reserved_field1` | string |  |
| `DAA009` | 预留字段 | `reserved_field2` | string |  |
| `DAA010` | 是工作中心 | `is_work_center` | string |  |
| `DAA011` | 失效 | `invalidation` | string |  |
| `DAA012` | 现场仓 | `onside_warehouse` | string |  |
| `DAA901` | 录入者编号 | `entry_person_no` | string |  |
| `DAA902` | 录入时间 | `entry_time` | string |  |
| `DAA903` | 更改者编号 | `changer_no` | string |  |
| `DAA904` | 更改时间 | `change_time` | string |  |
| `DAA905` | 更新标记 | `update_flag` | integer |  |
| `DAA960` | 自定文字1 | `udf_text1` | string |  |
| `DAA961` | 自定文字2 | `udf_text2` | string |  |
| `DAA962` | 自定文字3 | `udf_text3` | string |  |
| `DAA963` | 自定文字4 | `udf_text4` | string |  |
| `DAA964` | 自定文字5 | `udf_text5` | string |  |
| `DAA965` | 自定文字6 | `udf_text6` | string |  |
| `DAA980` | 自定数字1 | `udf_no1` | float |  |
| `DAA981` | 自定数字2 | `udf_no2` | float |  |
| `DAA982` | 自定数字3 | `udf_no3` | float |  |
| `DAA983` | 自定数字4 | `udf_no4` | float |  |
| `DAA984` | 自定数字5 | `udf_no5` | float |  |
| `DAA985` | 自定数字6 | `udf_no6` | float |  |
| `DAA966` | 自定文字7 | `udf_text7` | string |  |
| `DAA967` | 自定文字8 | `udf_text8` | string |  |
| `DAA968` | 自定文字9 | `udf_text9` | string |  |
| `DAA969` | 自定文字10 | `udf_text10` | string |  |
| `DAA970` | 自定文字11 | `udf_text11` | string |  |
| `DAA971` | 自定文字12 | `udf_text12` | string |  |
| `DAA972` | 自定文字13 | `udf_text13` | string |  |
| `DAA973` | 自定文字14 | `udf_text14` | string |  |
| `DAA974` | 自定文字15 | `udf_text15` | string |  |
| `DAA975` | 自定文字16 | `udf_text16` | string |  |
| `DAA986` | 自定数字7 | `udf_no7` | float |  |
| `DAA987` | 自定数字8 | `udf_no8` | float |  |
| `DAA988` | 自定数字9 | `udf_no9` | float |  |
| `DAA989` | 自定数字10 | `udf_no10` | float |  |
| `DAA990` | 自定数字11 | `udf_no11` | float |  |
| `DAA991` | 自定数字12 | `udf_no12` | float |  |
| `DAA992` | 自定数字13 | `udf_no13` | float |  |
| `DAA993` | 自定数字14 | `udf_no14` | float |  |
| `DAA994` | 自定数字15 | `udf_no15` | float |  |
| `DAA995` | 自定数字16 | `udf_no16` | float |  |
| `DAA906` | 打印次数 | `print_count` | integer |  |
| `DAA907` | 打印时间 | `print_time` | string |  |
| `DAA908` | 打印人员 | `printer` | string |  |
| `DAA909` | 打印人员姓名 | `printer_name` | string |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "DAA001": ""
  ,"DAA002": ""
  ,"DAA003": ""
  ,"DAA004": ""
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"DAA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"dept_no","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `DAA001` | `dept_no` | 部门编号 | 主键 |
| `DAA002` | `dept_name` | 部门名称 | |
| `DAA003` | `dept_english_name` | 部门英文名称 | |
| `DAA004` | `dept_level` | 部门级次 | |
| `DAA005` | `depreciation_account` | 折旧科目 | |
| `DAA006` | `accounting_item` | 核算项目 | |
| `DAA007` | `accounting_item_name` | 核算项目名称 | |
| `DAA008` | `reserved_field1` | 预留字段 | |
| `DAA009` | `reserved_field2` | 预留字段 | |
| `DAA010` | `is_work_center` | 是工作中心 | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `DAA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `DAA001`
