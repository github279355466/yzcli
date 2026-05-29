# CLI 规格说明书：进货单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `purchase.receipt` |
| **DLL** | `PURJC06` |
| **服务名称** | `进货单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.receipt" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.receipt" \
  --action "getMultiple" \
  --data '{"datakeys":[{"JDA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.receipt" \
  --action "create" \
  --data '{"JDA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.receipt" \
  --action "approve" \
  --data '{"datakeys":[{"JDA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `JDA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKJDA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JDA001` | 单号 | `docNo` | string | 主键 |
| `JDA002` | 性质 | `nature` | string |  |
| `JDA003` | 日期 | `date` | string |  |
| `JDA004` | 供应商 | `supplier` | string |  |
| `JDA005` | 经办人 | `handler` | string |  |
| `JDA006` | 部门 | `dept` | string |  |
| `JDA007` | 币种 | `currency` | string |  |
| `JDA008` | 汇率 | `exchange_rate` | float |  |
| `JDA009` | 预结帐日 | `preclosing_date` | string |  |
| `JDA010` | 预付款日 | `prepayment_date` | string |  |
| `JDA011` | 专案 | `project` | string |  |
| `JDA012` | 预留字段 | `reserved_field1` | string |  |
| `JDA013` | 发票种类 | `invoice_type` | string |  |
| `JDA014` | 税率 | `tax_rate` | float |  |
| `JDA015` | 无税金额 | `amt_excluding_tax` | float |  |
| `JDA016` | 原币税额 | `org_currency_tax_amt` | float |  |
| `JDA017` | 本币无税金额 | `amt_in_local_currency_excluding_tax` | float |  |
| `JDA018` | 本币税额 | `domestic_currency_tax_amt` | float |  |
| `JDA019` | 抛转否 | `is_transfer` | string |  |
| `JDA020` | 凭证 | `voucher` | string |  |
| `JDA021` | 价税合计 | `sum_price_include_tax` | float |  |
| `JDA022` | 本币价税合计 | `total_price_include_tax_in_local_currency` | float |  |
| `JDA023` | 送货邮编 | `delivery_postal_code` | string |  |
| `JDA024` | 送货地址 | `delivery_addr` | string |  |
| `JDA025` | 备注 | `remarks` | string |  |
| `JDA026` | 审核码 | `approve_status` | string |  |
| `JDA027` | 预留字段 | `reserved_field2` | string |  |
| `JDA028` | 复核编号 | `review_no` | string |  |
| `JDA029` | 复核姓名 | `review_name` | string |  |
| `JDA030` | 单据来源 | `doc_source` | string |  |
| `JDA031` | 预留字段 | `reserved_field3` | string |  |
| `JDA032` | 预留字段 | `reserved_field4` | string |  |
| `JDA033` | 预留字段 | `reserved_field5` | string |  |
| `JDA034` | 预留字段 | `reserved_field6` | float |  |
| `JDA035` | 预留字段 | `reserved_field7` | float |  |
| `JDA036` | 预留字段 | `reserved_field8` | string |  |
| `JDA037` | 预留字段 | `reserved_field9` | string |  |
| `JDA038` | 预留字段 | `reserved_field10` | string |  |
| `JDA039` | 预留字段 | `reserved_field11` | string |  |
| `JDA040` | 预留字段 | `reserved_field12` | string |  |
| `JDA041` | 预留字段 | `reserved_field13` | string |  |
| `JDA042` | 预留字段 | `reserved_field14` | string |  |
| `JDA043` | 购买票据系统否 | `is_purchase_invoice_system` | string |  |
| `JDA044` | 预留字段 | `reserved_field15` | string |  |
| `JDA045` | 运费 | `freight` | float |  |
| `JDA046` | 折让 | `allowance` | float |  |
| `JDA047` | 预留字段 | `reserved_field16` | string |  |
| `JDA048` | 预留字段 | `reserved_field17` | string |  |
| `JDA049` | 预留字段 | `reserved_field18` | string |  |
| `JDA050` | 预留字段 | `reserved_field19` | string |  |
| `JDA051` | 预留字段 | `reserved_field20` | float |  |
| `JDA052` | 预留字段 | `reserved_field21` | float |  |
| `JDA053` | 审核人 | `auditor` | string |  |
| `JDA054` | 审核时间 | `review_time1` | string |  |
| `JDA055` | 凭证类别 | `JDA055` | string |  |
| `JDA056` | 直接产生发票信息 | `directly_generate_invoice_info` | string |  |
| `JDA057` | 发票号码 | `invoice_no` | string |  |
| `JDA058` | 是否检验 | `is_inspection_required` | string |  |
| `JDA059` | 现采 | `current_purchase` | string |  |
| `JDA060` | 结算方式 | `settlement_method` | string |  |
| `JDA061` | 票据号码 | `bill_no` | string |  |
| `JDA062` | 结算科目 | `settlement_account` | string |  |
| `JDA063` | 付款单号 | `payment_docNo` | string |  |
| `JDA064` | 供应商发货单号 | `supplier_shipment_docNo` | string |  |
| `JDA901` | 录入者编号 | `entry_person_no` | string |  |
| `JDA902` | 录入时间 | `entry_time` | string |  |
| `JDA903` | 更改者编号 | `changer_no` | string |  |
| `JDA904` | 更改时间 | `change_time` | string |  |
| `JDA905` | 更新标记 | `update_flag` | integer |  |
| `JDA906` | 打印次数 | `print_count` | integer |  |
| `JDA907` | 打印时间 | `print_time` | string |  |
| `JDA908` | 打印人员 | `printer` | string |  |
| `JDA909` | 打印人员姓名 | `printer_name` | string |  |
| `JDA910` | 送审状态 | `submission_status` | string |  |
| `JDA911` | 送审人 | `reviewer` | string |  |
| `JDA912` | 审批人1 | `approver1` | string |  |
| `JDA913` | 审批结果 | `approval_result1` | string |  |
| `JDA914` | 审批意见 | `approval_opinion1` | string |  |
| `JDA915` | 审批人2 | `approver2` | string |  |
| `JDA916` | 审批结果 | `approval_result2` | string |  |
| `JDA917` | 审批意见 | `approval_opinion2` | string |  |
| `JDA918` | 审批人3 | `approver3` | string |  |
| `JDA919` | 审批结果 | `approval_result3` | string |  |
| `JDA920` | 审批意见 | `approval_opinion3` | string |  |
| `JDA921` | 审批人4 | `approver4` | string |  |
| `JDA922` | 审批结果 | `approval_result4` | string |  |
| `JDA923` | 审批意见 | `approval_opinion4` | string |  |
| `JDA924` | 审批人5 | `approver5` | string |  |
| `JDA925` | 审批结果 | `approval_result5` | string |  |
| `JDA926` | 审批意见 | `approval_opinion5` | string |  |
| `JDA927` | 审批人6 | `approver6` | string |  |
| `JDA928` | 审批结果 | `approval_result6` | string |  |
| `JDA929` | 审批意见 | `approval_opinion6` | string |  |
| `JDA930` | 终审人 | `final_approver` | string |  |
| `JDA931` | 审批结果 | `approval_result7` | string |  |
| `JDA932` | 审批意见 | `approval_opinion7` | string |  |
| `JDA933` | 通知人1 | `notifier1` | string |  |
| `JDA934` | 通知人2 | `notifier2` | string |  |
| `JDA935` | 通知人3 | `notifier3` | string |  |
| `JDA940` | 签核码 | `approval_code` | string |  |
| `JDA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `JDA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `JDA960` | 自定文字1 | `udf_text1` | string |  |
| `JDA961` | 自定文字2 | `udf_text2` | string |  |
| `JDA962` | 自定文字3 | `udf_text3` | string |  |
| `JDA963` | 自定文字4 | `udf_text4` | string |  |
| `JDA964` | 自定文字5 | `udf_text5` | string |  |
| `JDA965` | 自定文字6 | `udf_text6` | string |  |
| `JDA966` | 自定文字7 | `udf_text7` | string |  |
| `JDA967` | 自定文字8 | `udf_text8` | string |  |
| `JDA968` | 自定文字9 | `udf_text9` | string |  |
| `JDA969` | 自定文字10 | `udf_text10` | string |  |
| `JDA970` | 自定文字11 | `udf_text11` | string |  |
| `JDA971` | 自定文字12 | `udf_text12` | string |  |
| `JDA972` | 自定文字13 | `udf_text13` | string |  |
| `JDA973` | 自定文字14 | `udf_text14` | string |  |
| `JDA974` | 自定文字15 | `udf_text15` | string |  |
| `JDA975` | 自定文字16 | `udf_text16` | string |  |
| `JDA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `JDA980` | 自定数字1 | `udf_no1` | float |  |
| `JDA981` | 自定数字2 | `udf_no2` | float |  |
| `JDA982` | 自定数字3 | `udf_no3` | float |  |
| `JDA983` | 自定数字4 | `udf_no4` | float |  |
| `JDA984` | 自定数字5 | `udf_no5` | float |  |
| `JDA985` | 自定数字6 | `udf_no6` | float |  |
| `JDA986` | 自定数字7 | `udf_no7` | float |  |
| `JDA987` | 自定数字8 | `udf_no8` | float |  |
| `JDA988` | 自定数字9 | `udf_no9` | float |  |
| `JDA989` | 自定数字10 | `udf_no10` | float |  |
| `JDA990` | 自定数字11 | `udf_no11` | float |  |
| `JDA991` | 自定数字12 | `udf_no12` | float |  |
| `JDA992` | 自定数字13 | `udf_no13` | float |  |
| `JDA993` | 自定数字14 | `udf_no14` | float |  |
| `JDA994` | 自定数字15 | `udf_no15` | float |  |
| `JDA995` | 自定数字16 | `udf_no16` | float |  |
| `JDA950` | 送审时间 | `submission_time_for_review` | string |  |
| `JDA951` | 审批时间1 | `approval_time1` | string |  |
| `JDA952` | 审批时间2 | `approval_time2` | string |  |
| `JDA953` | 审批时间3 | `approval_time3` | string |  |
| `JDA954` | 审批时间4 | `approval_time4` | string |  |
| `JDA955` | 审批时间5 | `approval_time5` | string |  |
| `JDA956` | 审批时间6 | `approval_time6` | string |  |
| `JDA957` | 终审时间 | `final_review_time` | string |  |
| `JDA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKJDB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JDB001` | 单号 | `docNo` | string |  |
| `JDB002` | 序号 | `seq` | string |  |
| `JDB003` | 品号 | `item_no` | string |  |
| `JDB004` | 品名 | `product_name` | string |  |
| `JDB005` | 单位 | `unit` | string |  |
| `JDB006` | 仓库 | `warehouse` | string |  |
| `JDB007` | 验收量 | `acceptance_qty` | float |  |
| `JDB008` | 验退量 | `qty_rejected_after_inspection` | float |  |
| `JDB009` | 单价 | `unit_price` | float |  |
| `JDB010` | 金额 | `amt` | string |  |
| `JDB011` | 本币金额 | `local_currency_amt` | string |  |
| `JDB012` | 赠品 | `gift` | string |  |
| `JDB013` | 前置来源 | `prefix_source` | string |  |
| `JDB014` | 前置单号 | `previous_docNo` | string |  |
| `JDB015` | 前置序号 | `prefix_seq` | string |  |
| `JDB016` | 审核码 | `approve_status` | string |  |
| `JDB017` | 预留字段 | `reserved_field1` | string |  |
| `JDB018` | 验退已退量 | `qty_returned_after_inspection_and_rejection` | float |  |
| `JDB019` | 已开票数量 | `invoiced_qty` | float |  |
| `JDB020` | 原币税额 | `org_currency_tax_amt` | string |  |
| `JDB021` | 本币税额 | `domestic_currency_tax_amt` | string |  |
| `JDB022` | 退货数量 | `return_qty` | float |  |
| `JDB023` | 预留字段 | `reserved_field2` | string |  |
| `JDB024` | 预留字段 | `reserved_field3` | string |  |
| `JDB025` | 预留字段 | `reserved_field4` | string |  |
| `JDB026` | 预留字段 | `reserved_field5` | string |  |
| `JDB027` | 预留字段 | `reserved_field6` | float |  |
| `JDB028` | 预留字段 | `reserved_field7` | float |  |
| `JDB029` | 含税单价 | `unit_price_including_tax` | float |  |
| `JDB030` | 价税合计 | `sum_price_include_tax` | string |  |
| `JDB031` | 本币价税合计 | `total_price_include_tax_in_local_currency` | string |  |
| `JDB032` | 含税 | `include_tax` | string |  |
| `JDB033` | 暂估已开票原币金额 | `provisionally_invoiced_amt_in_org_currency` | string |  |
| `JDB034` | 暂估已开票本币金额 | `estimated_invoiced_local_currency_amt` | string |  |
| `JDB035` | 批号 | `batch_no` | string |  |
| `JDB036` | 换算分子 | `conversion_numerator` | float |  |
| `JDB037` | 换算分母 | `conversion_denominator` | float |  |
| `JDB038` | 辅助单位 | `auxiliary_unit` | string |  |
| `JDB039` | 辅助数量 | `auxiliary_qty` | float |  |
| `JDB040` | 税率 | `tax_rate` | float |  |
| `JDB041` | 规格 | `specification` | string |  |
| `JDB042` | 分摊金额 | `allocated_amt` | string |  |
| `JDB043` | 批号说明 | `batch_no_descpt` | string |  |
| `JDB044` | 生产日期 | `production_date` | string |  |
| `JDB045` | 有效日期 | `effective_date` | string |  |
| `JDB046` | 检验状态 | `inspection_status` | string |  |
| `JDB047` | 供应商发货序号 | `supplier_shipment_seq` | string |  |
| `JDB901` | 录入者编号 | `entry_person_no` | string |  |
| `JDB902` | 录入时间 | `entry_time` | string |  |
| `JDB903` | 更改者编号 | `changer_no` | string |  |
| `JDB904` | 更改时间 | `change_time` | string |  |
| `JDB905` | 更新标记 | `update_flag` | integer |  |
| `JDB960` | 自定文字1 | `udf_text1` | string |  |
| `JDB961` | 自定文字2 | `udf_text2` | string |  |
| `JDB962` | 自定文字3 | `udf_text3` | string |  |
| `JDB963` | 自定文字4 | `udf_text4` | string |  |
| `JDB964` | 自定文字5 | `udf_text5` | string |  |
| `JDB965` | 自定文字6 | `udf_text6` | string |  |
| `JDB966` | 自定文字7 | `udf_text7` | string |  |
| `JDB967` | 自定文字8 | `udf_text8` | string |  |
| `JDB968` | 自定文字9 | `udf_text9` | string |  |
| `JDB969` | 自定文字10 | `udf_text10` | string |  |
| `JDB970` | 自定文字11 | `udf_text11` | string |  |
| `JDB971` | 自定文字12 | `udf_text12` | string |  |
| `JDB972` | 自定文字13 | `udf_text13` | string |  |
| `JDB973` | 自定文字14 | `udf_text14` | string |  |
| `JDB974` | 自定文字15 | `udf_text15` | string |  |
| `JDB975` | 自定文字16 | `udf_text16` | string |  |
| `JDB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `JDB980` | 自定数字1 | `udf_no1` | float |  |
| `JDB981` | 自定数字2 | `udf_no2` | float |  |
| `JDB982` | 自定数字3 | `udf_no3` | float |  |
| `JDB983` | 自定数字4 | `udf_no4` | float |  |
| `JDB984` | 自定数字5 | `udf_no5` | float |  |
| `JDB985` | 自定数字6 | `udf_no6` | float |  |
| `JDB986` | 自定数字7 | `udf_no7` | float |  |
| `JDB987` | 自定数字8 | `udf_no8` | float |  |
| `JDB988` | 自定数字9 | `udf_no9` | float |  |
| `JDB989` | 自定数字10 | `udf_no10` | float |  |
| `JDB990` | 自定数字11 | `udf_no11` | float |  |
| `JDB991` | 自定数字12 | `udf_no12` | float |  |
| `JDB992` | 自定数字13 | `udf_no13` | float |  |
| `JDB993` | 自定数字14 | `udf_no14` | float |  |
| `JDB994` | 自定数字15 | `udf_no15` | float |  |
| `JDB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "JDA001": ""
  ,"JDA002": ""
  ,"JDA003": ""
  ,"JDA004": ""
  ,"cdsDetail": [{
    "JDB001": ""
    ,"JDB001": ""
    ,"JDB002": ""
    ,"JDB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"JDA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"docNo","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `JDA001` | `docNo` | 单号 | 主键 |
| `JDA002` | `nature` | 性质 | |
| `JDA003` | `date` | 日期 | |
| `JDA004` | `supplier` | 供应商 | |
| `JDA005` | `handler` | 经办人 | |
| `JDA006` | `dept` | 部门 | |
| `JDA007` | `currency` | 币种 | |
| `JDA008` | `exchange_rate` | 汇率 | |
| `JDA009` | `preclosing_date` | 预结帐日 | |
| `JDA010` | `prepayment_date` | 预付款日 | |
| `JDB001` | `docNo` | 单号 (单身) | |
| `JDB002` | `seq` | 序号 (单身) | |
| `JDB003` | `item_no` | 品号 (单身) | |
| `JDB004` | `product_name` | 品名 (单身) | |
| `JDB005` | `unit` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `JDA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `JDA001`
