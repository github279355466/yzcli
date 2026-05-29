# CLI 规格说明书：仓库信息

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `warehouse` |
| **DLL** | `TPAGC07` |
| **服务名称** | `仓库信息` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "warehouse" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "warehouse" \
  --action "getMultiple" \
  --data '{"datakeys":[{"DDA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "warehouse" \
  --action "create" \
  --data '{"DDA001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `DDA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPADDA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DDA001` | 仓库编号 | `warehouse_no` | string | 主键 |
| `DDA002` | 仓库性质 | `warehouse_nature` | string |  |
| `DDA003` | 仓库名称 | `warehouse_name` | string |  |
| `DDA004` | 纳入需求计算 | `include_demand_calculation` | string |  |
| `DDA005` | 电话 | `tel` | string |  |
| `DDA006` | 传真 | `fax` | string |  |
| `DDA007` | 邮编 | `postal_code` | string |  |
| `DDA008` | 地址 | `addr` | string |  |
| `DDA009` | 预留字段 | `reserved_field1` | string |  |
| `DDA010` | 预留字段 | `reserved_field2` | string |  |
| `DDA011` | 备注 | `remarks` | string |  |
| `DDA012` | 预留字段 | `reserved_field3` | string |  |
| `DDA013` | 失效 | `invalidation` | string |  |
| `DDA901` | 录入者编号 | `entry_person_no` | string |  |
| `DDA902` | 录入时间 | `entry_time` | string |  |
| `DDA903` | 更改者编号 | `changer_no` | string |  |
| `DDA904` | 更改时间 | `change_time` | string |  |
| `DDA905` | 更新标记 | `update_flag` | integer |  |
| `DDA906` | 打印次数 | `print_count` | integer |  |
| `DDA907` | 打印时间 | `print_time` | string |  |
| `DDA908` | 打印人员 | `printer` | string |  |
| `DDA909` | 打印人员姓名 | `printer_name` | string |  |
| `DDA960` | 自定文字1 | `udf_text1` | string |  |
| `DDA961` | 自定文字2 | `udf_text2` | string |  |
| `DDA962` | 自定文字3 | `udf_text3` | string |  |
| `DDA963` | 自定文字4 | `udf_text4` | string |  |
| `DDA964` | 自定文字5 | `udf_text5` | string |  |
| `DDA965` | 自定文字6 | `udf_text6` | string |  |
| `DDA966` | 自定文字7 | `udf_text7` | string |  |
| `DDA967` | 自定文字8 | `udf_text8` | string |  |
| `DDA968` | 自定文字9 | `udf_text9` | string |  |
| `DDA969` | 自定文字10 | `udf_text10` | string |  |
| `DDA970` | 自定文字11 | `udf_text11` | string |  |
| `DDA971` | 自定文字12 | `udf_text12` | string |  |
| `DDA972` | 自定文字13 | `udf_text13` | string |  |
| `DDA973` | 自定文字14 | `udf_text14` | string |  |
| `DDA974` | 自定文字15 | `udf_text15` | string |  |
| `DDA975` | 自定文字16 | `udf_text16` | string |  |
| `DDA979` | 二维码 | `qr_code_on_doc_header` | string |  |
| `DDA980` | 自定数字1 | `udf_no1` | float |  |
| `DDA981` | 自定数字2 | `udf_no2` | float |  |
| `DDA982` | 自定数字3 | `udf_no3` | float |  |
| `DDA983` | 自定数字4 | `udf_no4` | float |  |
| `DDA984` | 自定数字5 | `udf_no5` | float |  |
| `DDA985` | 自定数字6 | `udf_no6` | float |  |
| `DDA986` | 自定数字7 | `udf_no7` | float |  |
| `DDA987` | 自定数字8 | `udf_no8` | float |  |
| `DDA988` | 自定数字9 | `udf_no9` | float |  |
| `DDA989` | 自定数字10 | `udf_no10` | float |  |
| `DDA990` | 自定数字11 | `udf_no11` | float |  |
| `DDA991` | 自定数字12 | `udf_no12` | float |  |
| `DDA992` | 自定数字13 | `udf_no13` | float |  |
| `DDA993` | 自定数字14 | `udf_no14` | float |  |
| `DDA994` | 自定数字15 | `udf_no15` | float |  |
| `DDA995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "DDA001": ""
  ,"DDA002": ""
  ,"DDA003": ""
  ,"DDA004": ""
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"DDA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"warehouse_no","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `DDA001` | `warehouse_no` | 仓库编号 | 主键 |
| `DDA002` | `warehouse_nature` | 仓库性质 | |
| `DDA003` | `warehouse_name` | 仓库名称 | |
| `DDA004` | `include_demand_calculation` | 纳入需求计算 | |
| `DDA005` | `tel` | 电话 | |
| `DDA006` | `fax` | 传真 | |
| `DDA007` | `postal_code` | 邮编 | |
| `DDA008` | `addr` | 地址 | |
| `DDA009` | `reserved_field1` | 预留字段 | |
| `DDA010` | `reserved_field2` | 预留字段 | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `DDA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `DDA001`
