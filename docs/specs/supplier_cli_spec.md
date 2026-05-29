# CLI 规格说明书：供应商信息

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `supplier` |
| **DLL** | `TPAGC16` |
| **服务名称** | `供应商信息` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "supplier" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "supplier" \
  --action "getMultiple" \
  --data '{"datakeys":[{"DGA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "supplier" \
  --action "create" \
  --data '{"DGA001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `DGA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPADGA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DGA001` | 供应商编号 | `supplier_no` | string | 主键 |
| `DGA002` | 供应商简称 | `supplier_abbreviation` | string |  |
| `DGA003` | 供应商全称 | `full_name_of_supplier` | string |  |
| `DGA004` | 供应商类型 | `supplier_type` | string |  |
| `DGA005` | 税号 | `tax_id` | string |  |
| `DGA006` | 国外供应商否 | `is_foreign_supplier` | string |  |
| `DGA007` | 采购人 | `purchaser` | string |  |
| `DGA008` | 法人 | `legal_person` | string |  |
| `DGA009` | 联系人 | `contact_person` | string |  |
| `DGA010` | 会计 | `accountant` | string |  |
| `DGA011` | 联系电话 | `contact_phone_no` | string |  |
| `DGA012` | 会计电话 | `accountant_phone_no` | string |  |
| `DGA013` | 传真号码 | `fax_no` | string |  |
| `DGA014` | EMAIL | `email` | string |  |
| `DGA015` | 网址 | `website` | string |  |
| `DGA016` | 营业邮编 | `business_postal_code` | string |  |
| `DGA017` | 营业地址 | `business_addr` | string |  |
| `DGA018` | 帐单邮编 | `billing_postal_code` | string |  |
| `DGA019` | 帐单地址 | `billing_addr` | string |  |
| `DGA020` | 交易币种 | `transaction_currency` | string |  |
| `DGA021` | 地区 | `region` | string |  |
| `DGA022` | 保留字段 | `reserved_field` | string |  |
| `DGA023` | 质量评级 | `quality_rating` | string |  |
| `DGA024` | 结帐货到 | `payment_on_delivery` | integer |  |
| `DGA025` | 结帐月结日 | `account_closing_date` | integer |  |
| `DGA026` | 月结月 | `monthly_settlement_month` | integer |  |
| `DGA027` | 月结日 | `monthly_settlement_date` | integer |  |
| `DGA028` | 付款天 | `payment_days` | integer |  |
| `DGA029` | 付款日 | `payment_date` | integer |  |
| `DGA030` | 票期天 | `bill_due_date_in_days` | integer |  |
| `DGA031` | 票期月 | `bill_due_month` | integer |  |
| `DGA032` | 票期日 | `bill_due_date` | integer |  |
| `DGA033` | 预留字段 | `reserved_field1` | string |  |
| `DGA034` | 发票种类 | `invoice_type` | string |  |
| `DGA035` | 预留字段 | `reserved_field2` | string |  |
| `DGA036` | 最近交易日 | `recent_transaction_date` | string |  |
| `DGA037` | 结帐方式 | `settlement_way` | string |  |
| `DGA038` | 付款方式 | `payment_way` | string |  |
| `DGA039` | 票期方式 | `bill_due_date_way` | string |  |
| `DGA040` | 备注 | `remarks` | string |  |
| `DGA041` | 付款银行 | `payment_bank` | string |  |
| `DGA042` | 付款帐号 | `payment_account` | string |  |
| `DGA043` | 快捷码 | `quick_code` | string |  |
| `DGA044` | 预留字段 | `reserved_field3` | string |  |
| `DGA045` | 预留字段 | `reserved_field4` | string |  |
| `DGA046` | 预留字段 | `reserved_field5` | string |  |
| `DGA047` | 预留字段 | `reserved_field6` | float |  |
| `DGA048` | 预留字段 | `reserved_field7` | float |  |
| `DGA049` | 税率 | `tax_rate` | float |  |
| `DGA050` | 结算方式 | `settlement_method` | string |  |
| `DGA051` | 付款账号 | `payment_account2` | string |  |
| `DGA052` | 失效 | `invalidation` | string |  |
| `DGA053` | 委外仓 | `outsourced_warehouse` | string |  |
| `DGA054` | QQ | `qq` | string |  |
| `DGA055` | 微信 | `wechat` | string |  |
| `DGA056` | Skype | `skype` | string |  |
| `DGA901` | 录入者编号 | `entry_person_no` | string |  |
| `DGA902` | 录入时间 | `entry_time` | string |  |
| `DGA903` | 更改者编号 | `changer_no` | string |  |
| `DGA904` | 更改时间 | `change_time` | string |  |
| `DGA905` | 更新标记 | `update_flag` | integer |  |
| `DGA906` | 打印次数 | `print_count` | integer |  |
| `DGA907` | 打印时间 | `print_time` | string |  |
| `DGA908` | 打印人员 | `printer` | string |  |
| `DGA909` | 打印人员姓名 | `printer_name` | string |  |
| `DGA960` | 自定文字1 | `udf_text1` | string |  |
| `DGA961` | 自定文字2 | `udf_text2` | string |  |
| `DGA962` | 自定文字3 | `udf_text3` | string |  |
| `DGA963` | 自定文字4 | `udf_text4` | string |  |
| `DGA964` | 自定文字5 | `udf_text5` | string |  |
| `DGA965` | 自定文字6 | `udf_text6` | string |  |
| `DGA966` | 自定文字7 | `udf_text7` | string |  |
| `DGA967` | 自定文字8 | `udf_text8` | string |  |
| `DGA968` | 自定文字9 | `udf_text9` | string |  |
| `DGA969` | 自定文字10 | `udf_text10` | string |  |
| `DGA970` | 自定文字11 | `udf_text11` | string |  |
| `DGA971` | 自定文字12 | `udf_text12` | string |  |
| `DGA972` | 自定文字13 | `udf_text13` | string |  |
| `DGA973` | 自定文字14 | `udf_text14` | string |  |
| `DGA974` | 自定文字15 | `udf_text15` | string |  |
| `DGA975` | 自定文字16 | `udf_text16` | string |  |
| `DGA980` | 自定数字1 | `udf_no1` | float |  |
| `DGA981` | 自定数字2 | `udf_no2` | float |  |
| `DGA982` | 自定数字3 | `udf_no3` | float |  |
| `DGA983` | 自定数字4 | `udf_no4` | float |  |
| `DGA984` | 自定数字5 | `udf_no5` | float |  |
| `DGA985` | 自定数字6 | `udf_no6` | float |  |
| `DGA986` | 自定数字7 | `udf_no7` | float |  |
| `DGA987` | 自定数字8 | `udf_no8` | float |  |
| `DGA988` | 自定数字9 | `udf_no9` | float |  |
| `DGA989` | 自定数字10 | `udf_no10` | float |  |
| `DGA990` | 自定数字11 | `udf_no11` | float |  |
| `DGA991` | 自定数字12 | `udf_no12` | float |  |
| `DGA992` | 自定数字13 | `udf_no13` | float |  |
| `DGA993` | 自定数字14 | `udf_no14` | float |  |
| `DGA994` | 自定数字15 | `udf_no15` | float |  |
| `DGA995` | 自定数字16 | `udf_no16` | float |  |

### 3.2 单身表 (TPADGB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DGB001` | 供应商编号 | `supplier_no` | string |  |
| `DGB002` | 品号 | `item_no` | string |  |
| `DGB003` | 单位 | `unit` | string |  |
| `DGB004` | 币种 | `currency` | string |  |
| `DGB005` | 单价 | `unit_price` | float |  |
| `DGB006` | 更新日期 | `update_date` | string |  |
| `DGB007` | 备注 | `remarks` | string |  |
| `DGB008` | 预留字段 | `reserved_field1` | string |  |
| `DGB009` | 预留字段 | `reserved_field2` | string |  |
| `DGB010` | 预留字段 | `reserved_field3` | string |  |
| `DGB011` | 预留字段 | `reserved_field4` | string |  |
| `DGB012` | 预留字段 | `reserved_field5` | float |  |
| `DGB013` | 预留字段 | `reserved_field6` | float |  |
| `DGB014` | 含税 | `include_tax` | string |  |
| `DGB901` | 录入者编号 | `entry_person_no` | string |  |
| `DGB902` | 录入时间 | `entry_time` | string |  |
| `DGB903` | 更改者编号 | `changer_no` | string |  |
| `DGB904` | 更改时间 | `change_time` | string |  |
| `DGB905` | 更新标记 | `update_flag` | integer |  |
| `DGB960` | 自定文字1 | `udf_text1` | string |  |
| `DGB961` | 自定文字2 | `udf_text2` | string |  |
| `DGB962` | 自定文字3 | `udf_text3` | string |  |
| `DGB963` | 自定文字4 | `udf_text4` | string |  |
| `DGB964` | 自定文字5 | `udf_text5` | string |  |
| `DGB965` | 自定文字6 | `udf_text6` | string |  |
| `DGB980` | 自定数字1 | `udf_no1` | float |  |
| `DGB981` | 自定数字2 | `udf_no2` | float |  |
| `DGB982` | 自定数字3 | `udf_no3` | float |  |
| `DGB983` | 自定数字4 | `udf_no4` | float |  |
| `DGB984` | 自定数字5 | `udf_no5` | float |  |
| `DGB985` | 自定数字6 | `udf_no6` | float |  |
| `DGB966` | 自定文字7 | `udf_text7` | string |  |
| `DGB967` | 自定文字8 | `udf_text8` | string |  |
| `DGB968` | 自定文字9 | `udf_text9` | string |  |
| `DGB969` | 自定文字10 | `udf_text10` | string |  |
| `DGB970` | 自定文字11 | `udf_text11` | string |  |
| `DGB971` | 自定文字12 | `udf_text12` | string |  |
| `DGB972` | 自定文字13 | `udf_text13` | string |  |
| `DGB973` | 自定文字14 | `udf_text14` | string |  |
| `DGB974` | 自定文字15 | `udf_text15` | string |  |
| `DGB975` | 自定文字16 | `udf_text16` | string |  |
| `DGB986` | 自定数字7 | `udf_no7` | float |  |
| `DGB987` | 自定数字8 | `udf_no8` | float |  |
| `DGB988` | 自定数字9 | `udf_no9` | float |  |
| `DGB989` | 自定数字10 | `udf_no10` | float |  |
| `DGB990` | 自定数字11 | `udf_no11` | float |  |
| `DGB991` | 自定数字12 | `udf_no12` | float |  |
| `DGB992` | 自定数字13 | `udf_no13` | float |  |
| `DGB993` | 自定数字14 | `udf_no14` | float |  |
| `DGB994` | 自定数字15 | `udf_no15` | float |  |
| `DGB995` | 自定数字16 | `udf_no16` | float |  |
| `DGB906` | 打印次数 | `print_count` | integer |  |
| `DGB907` | 打印时间 | `print_time` | string |  |
| `DGB908` | 打印人员 | `printer` | string |  |
| `DGB909` | 打印人员姓名 | `printer_name` | string |  |

### 3.3 扩展表 (TPADGC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DGC001` | 供应商类型 | `DGC001` | string | 主键 |
| `DGC002` | 对应编码 | `DGC002` | string |  |
| `DGC901` | 录入者编号 | `entry_person_no` | string |  |
| `DGC902` | 录入时间 | `entry_time` | string |  |
| `DGC903` | 更改者编号 | `changer_no` | string |  |
| `DGC904` | 更改时间 | `change_time` | string |  |
| `DGC905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "DGA001": ""
  ,"DGA002": ""
  ,"DGA003": ""
  ,"DGA004": ""
  ,"cdsDetail": [{
    "DGB001": ""
    ,"DGB001": ""
    ,"DGB002": ""
    ,"DGB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"DGA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"supplier_no","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `DGA001` | `supplier_no` | 供应商编号 | 主键 |
| `DGA002` | `supplier_abbreviation` | 供应商简称 | |
| `DGA003` | `full_name_of_supplier` | 供应商全称 | |
| `DGA004` | `supplier_type` | 供应商类型 | |
| `DGA005` | `tax_id` | 税号 | |
| `DGA006` | `is_foreign_supplier` | 国外供应商否 | |
| `DGA007` | `purchaser` | 采购人 | |
| `DGA008` | `legal_person` | 法人 | |
| `DGA009` | `contact_person` | 联系人 | |
| `DGA010` | `accountant` | 会计 | |
| `DGB001` | `supplier_no` | 供应商编号 (单身) | |
| `DGB002` | `item_no` | 品号 (单身) | |
| `DGB003` | `unit` | 单位 (单身) | |
| `DGB004` | `currency` | 币种 (单身) | |
| `DGB005` | `unit_price` | 单价 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `DGA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `DGA001`
