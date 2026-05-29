# CLI 规格说明书：客户商品价格

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `item.customer.price` |
| **DLL** | `TPAGC14` |
| **服务名称** | `客户商品价格` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.customer.price" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.customer.price" \
  --action "getMultiple" \
  --data '{"datakeys":[{"DFB001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.customer.price" \
  --action "create" \
  --data '{"DFB001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `DFB001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPADFB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DFB001` | 客户 | `customer` | string |  |
| `DFB002` | 品号 | `item_no` | string |  |
| `DFB003` | 单位 | `unit` | string |  |
| `DFB004` | 币种 | `currency` | string |  |
| `DFB005` | 单价 | `unit_price` | float |  |
| `DFB006` | 更新日期 | `update_date` | string |  |
| `DFB007` | 备注 | `remarks` | string |  |
| `DFB008` | 预留字段 | `reserved_field1` | string |  |
| `DFB009` | 预留字段 | `reserved_field2` | string |  |
| `DFB010` | 预留字段 | `reserved_field3` | string |  |
| `DFB011` | 预留字段 | `reserved_field4` | string |  |
| `DFB012` | 预留字段 | `reserved_field5` | float |  |
| `DFB013` | 预留字段 | `reserved_field6` | float |  |
| `DFB014` | 含税 | `include_tax` | string |  |
| `DFB901` | 录入者编号 | `entry_person_no` | string |  |
| `DFB902` | 录入时间 | `entry_time` | string |  |
| `DFB903` | 更改者编号 | `changer_no` | string |  |
| `DFB904` | 更改时间 | `change_time` | string |  |
| `DFB905` | 更新标记 | `update_flag` | integer |  |
| `DFB960` | 自定文字1 | `udf_text1` | string |  |
| `DFB961` | 自定文字2 | `udf_text2` | string |  |
| `DFB962` | 自定文字3 | `udf_text3` | string |  |
| `DFB963` | 自定文字4 | `udf_text4` | string |  |
| `DFB964` | 自定文字5 | `udf_text5` | string |  |
| `DFB965` | 自定文字6 | `udf_text6` | string |  |
| `DFB980` | 自定数字1 | `udf_no1` | float |  |
| `DFB981` | 自定数字2 | `udf_no2` | float |  |
| `DFB982` | 自定数字3 | `udf_no3` | float |  |
| `DFB983` | 自定数字4 | `udf_no4` | float |  |
| `DFB984` | 自定数字5 | `udf_no5` | float |  |
| `DFB985` | 自定数字6 | `udf_no6` | float |  |
| `DFB966` | 自定文字7 | `udf_text7` | string |  |
| `DFB967` | 自定文字8 | `udf_text8` | string |  |
| `DFB968` | 自定文字9 | `udf_text9` | string |  |
| `DFB969` | 自定文字10 | `udf_text10` | string |  |
| `DFB970` | 自定文字11 | `udf_text11` | string |  |
| `DFB971` | 自定文字12 | `udf_text12` | string |  |
| `DFB972` | 自定文字13 | `udf_text13` | string |  |
| `DFB973` | 自定文字14 | `udf_text14` | string |  |
| `DFB974` | 自定文字15 | `udf_text15` | string |  |
| `DFB975` | 自定文字16 | `udf_text16` | string |  |
| `DFB986` | 自定数字7 | `udf_no7` | float |  |
| `DFB987` | 自定数字8 | `udf_no8` | float |  |
| `DFB988` | 自定数字9 | `udf_no9` | float |  |
| `DFB989` | 自定数字10 | `udf_no10` | float |  |
| `DFB990` | 自定数字11 | `udf_no11` | float |  |
| `DFB991` | 自定数字12 | `udf_no12` | float |  |
| `DFB992` | 自定数字13 | `udf_no13` | float |  |
| `DFB993` | 自定数字14 | `udf_no14` | float |  |
| `DFB994` | 自定数字15 | `udf_no15` | float |  |
| `DFB995` | 自定数字16 | `udf_no16` | float |  |
| `DFB906` | 打印次数 | `print_count` | integer |  |
| `DFB907` | 打印时间 | `print_time` | string |  |
| `DFB908` | 打印人员 | `printer` | string |  |
| `DFB909` | 打印人员姓名 | `printer_name` | string |  |

### 3.2 单身表 (TPADFB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DFB001` | 客户 | `customer` | string |  |
| `DFB002` | 品号 | `item_no` | string |  |
| `DFB003` | 单位 | `unit` | string |  |
| `DFB004` | 币种 | `currency` | string |  |
| `DFB005` | 单价 | `unit_price` | float |  |
| `DFB006` | 更新日期 | `update_date` | string |  |
| `DFB007` | 备注 | `remarks` | string |  |
| `DFB008` | 预留字段 | `reserved_field1` | string |  |
| `DFB009` | 预留字段 | `reserved_field2` | string |  |
| `DFB010` | 预留字段 | `reserved_field3` | string |  |
| `DFB011` | 预留字段 | `reserved_field4` | string |  |
| `DFB012` | 预留字段 | `reserved_field5` | float |  |
| `DFB013` | 预留字段 | `reserved_field6` | float |  |
| `DFB014` | 含税 | `include_tax` | string |  |
| `DFB901` | 录入者编号 | `entry_person_no` | string |  |
| `DFB902` | 录入时间 | `entry_time` | string |  |
| `DFB903` | 更改者编号 | `changer_no` | string |  |
| `DFB904` | 更改时间 | `change_time` | string |  |
| `DFB905` | 更新标记 | `update_flag` | integer |  |
| `DFB960` | 自定文字1 | `udf_text1` | string |  |
| `DFB961` | 自定文字2 | `udf_text2` | string |  |
| `DFB962` | 自定文字3 | `udf_text3` | string |  |
| `DFB963` | 自定文字4 | `udf_text4` | string |  |
| `DFB964` | 自定文字5 | `udf_text5` | string |  |
| `DFB965` | 自定文字6 | `udf_text6` | string |  |
| `DFB980` | 自定数字1 | `udf_no1` | float |  |
| `DFB981` | 自定数字2 | `udf_no2` | float |  |
| `DFB982` | 自定数字3 | `udf_no3` | float |  |
| `DFB983` | 自定数字4 | `udf_no4` | float |  |
| `DFB984` | 自定数字5 | `udf_no5` | float |  |
| `DFB985` | 自定数字6 | `udf_no6` | float |  |
| `DFB966` | 自定文字7 | `udf_text7` | string |  |
| `DFB967` | 自定文字8 | `udf_text8` | string |  |
| `DFB968` | 自定文字9 | `udf_text9` | string |  |
| `DFB969` | 自定文字10 | `udf_text10` | string |  |
| `DFB970` | 自定文字11 | `udf_text11` | string |  |
| `DFB971` | 自定文字12 | `udf_text12` | string |  |
| `DFB972` | 自定文字13 | `udf_text13` | string |  |
| `DFB973` | 自定文字14 | `udf_text14` | string |  |
| `DFB974` | 自定文字15 | `udf_text15` | string |  |
| `DFB975` | 自定文字16 | `udf_text16` | string |  |
| `DFB986` | 自定数字7 | `udf_no7` | float |  |
| `DFB987` | 自定数字8 | `udf_no8` | float |  |
| `DFB988` | 自定数字9 | `udf_no9` | float |  |
| `DFB989` | 自定数字10 | `udf_no10` | float |  |
| `DFB990` | 自定数字11 | `udf_no11` | float |  |
| `DFB991` | 自定数字12 | `udf_no12` | float |  |
| `DFB992` | 自定数字13 | `udf_no13` | float |  |
| `DFB993` | 自定数字14 | `udf_no14` | float |  |
| `DFB994` | 自定数字15 | `udf_no15` | float |  |
| `DFB995` | 自定数字16 | `udf_no16` | float |  |
| `DFB906` | 打印次数 | `print_count` | integer |  |
| `DFB907` | 打印时间 | `print_time` | string |  |
| `DFB908` | 打印人员 | `printer` | string |  |
| `DFB909` | 打印人员姓名 | `printer_name` | string |  |

### 3.3 扩展表 (TPADFC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DFC001` | 客户类型 | `DFC001` | string | 主键 |
| `DFC002` | 对应编码 | `DFC002` | string |  |
| `DFC901` | 录入者编号 | `entry_person_no` | string |  |
| `DFC902` | 录入时间 | `entry_time` | string |  |
| `DFC903` | 更改者编号 | `changer_no` | string |  |
| `DFC904` | 更改时间 | `change_time` | string |  |
| `DFC905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "DFB001": ""
  ,"DFB001": ""
  ,"DFB002": ""
  ,"DFB003": ""
  ,"cdsDetail": [{
    "DFB001": ""
    ,"DFB001": ""
    ,"DFB002": ""
    ,"DFB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"DFB001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"customer","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `DFB001` | `customer` | 客户 | |
| `DFB002` | `item_no` | 品号 | |
| `DFB003` | `unit` | 单位 | |
| `DFB004` | `currency` | 币种 | |
| `DFB005` | `unit_price` | 单价 | |
| `DFB006` | `update_date` | 更新日期 | |
| `DFB007` | `remarks` | 备注 | |
| `DFB008` | `reserved_field1` | 预留字段 | |
| `DFB009` | `reserved_field2` | 预留字段 | |
| `DFB010` | `reserved_field3` | 预留字段 | |
| `DFB001` | `customer` | 客户 (单身) | |
| `DFB002` | `item_no` | 品号 (单身) | |
| `DFB003` | `unit` | 单位 (单身) | |
| `DFB004` | `currency` | 币种 (单身) | |
| `DFB005` | `unit_price` | 单价 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `DFB001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `DFB001`
