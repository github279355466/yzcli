# CLI 规格说明书：采购单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `purchase.order` |
| **DLL** | `PURCC04` |
| **服务名称** | `采购单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.order" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.order" \
  --action "getMultiple" \
  --data '{"datakeys":[{"HDA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.order" \
  --action "create" \
  --data '{"HDA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.order" \
  --action "approve" \
  --data '{"datakeys":[{"HDA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `HDA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (DCSHDA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HDA001` | 单号 | `docNo` | string | 主键 |
| `HDA002` | 性质 | `nature` | string |  |
| `HDA003` | 日期 | `date` | string |  |
| `HDA004` | 供应商 | `supplier` | string |  |
| `HDA005` | 采购人 | `purchaser` | string |  |
| `HDA006` | 部门 | `dept` | string |  |
| `HDA007` | 币种 | `currency` | string |  |
| `HDA008` | 汇率 | `exchange_rate` | float |  |
| `HDA009` | 专案编号 | `project_no` | string |  |
| `HDA010` | 送货邮编 | `delivery_postal_code` | string |  |
| `HDA011` | 送货地址 | `delivery_addr` | string |  |
| `HDA012` | 备注 | `remarks` | string |  |
| `HDA013` | 复核编号 | `review_no` | string |  |
| `HDA014` | 复核姓名 | `review_name` | string |  |
| `HDA015` | 发票种类 | `invoice_type` | string |  |
| `HDA016` | 税率 | `tax_rate` | float |  |
| `HDA017` | 无税金额 | `amt_excluding_tax` | float |  |
| `HDA018` | 本币无税金额 | `amt_in_local_currency_excluding_tax` | float |  |
| `HDA019` | 本币税额 | `domestic_currency_tax_amt` | float |  |
| `HDA020` | 原币税额 | `org_currency_tax_amt` | float |  |
| `HDA021` | 审核码 | `approve_status` | string |  |
| `HDA022` | 预留字段 | `reserved_field1` | string |  |
| `HDA023` | 订金金额 | `deposit_amt` | string |  |
| `HDA024` | 订金已开票金额 | `deposit_invoiced_amt` | string |  |
| `HDA025` | 预留字段 | `reserved_field2` | string |  |
| `HDA026` | 预留字段 | `reserved_field3` | string |  |
| `HDA027` | 预留字段 | `reserved_field4` | string |  |
| `HDA028` | 预留字段 | `reserved_field5` | string |  |
| `HDA029` | 预留字段 | `reserved_field6` | string |  |
| `HDA030` | 预留字段 | `reserved_field7` | string |  |
| `HDA031` | 预留字段 | `reserved_field8` | string |  |
| `HDA032` | 预留字段 | `reserved_field9` | string |  |
| `HDA033` | 预留字段 | `reserved_field10` | string |  |
| `HDA034` | 运费 | `freight` | float |  |
| `HDA035` | 折让 | `allowance` | float |  |
| `HDA036` | 预留字段 | `reserved_field11` | string |  |
| `HDA037` | 预留字段 | `reserved_field12` | string |  |
| `HDA038` | 预留字段 | `reserved_field13` | string |  |
| `HDA039` | 预留字段 | `reserved_field14` | string |  |
| `HDA040` | 价税合计 | `sum_price_include_tax` | float |  |
| `HDA041` | 本币价税合计 | `total_price_include_tax_in_local_currency` | float |  |
| `HDA042` | 预留字段 | `reserved_field15` | string |  |
| `HDA043` | 审核人 | `auditor` | string |  |
| `HDA044` | 变更版本 | `change_version` | string |  |
| `HDA045` | 变更日期 | `change_date` | string |  |
| `HDA046` | 变更原因 | `reason_for_change` | string |  |
| `HDA047` | 订金已开票价税合计 | `deposit_invoiced_amt_including_tax` | string |  |
| `HDA048` | 订金已付价税合计 | `total_paid_deposit_including_tax` | float |  |
| `HDA049` | 结账方式描述 | `descpt_of_settlement_way` | string |  |
| `HDA050` | 收款方式描述 | `payment_way_descpt` | string |  |
| `HDA051` | 票期方式描述 | `description_of_bill_date_method` | string |  |
| `HDA052` | 打印次数 | `print_count1` | integer |  |
| `HDA053` | 打印人员 | `printer1` | string |  |
| `HDA054` | 打印时间 | `print_time1` | string |  |
| `HDA901` | 录入者编号 | `entry_person_no` | string |  |
| `HDA902` | 录入时间 | `entry_time` | string |  |
| `HDA903` | 更改者编号 | `changer_no` | string |  |
| `HDA904` | 更改时间 | `change_time` | string |  |
| `HDA905` | 更新标记 | `update_flag` | integer |  |
| `HDA906` | 打印次数 | `print_count2` | integer |  |
| `HDA907` | 打印时间 | `print_time2` | string |  |
| `HDA908` | 打印人员 | `printer2` | string |  |
| `HDA909` | 打印人员姓名 | `printer_name` | string |  |
| `HDA910` | 送审状态 | `submission_status` | string |  |
| `HDA911` | 送审人 | `reviewer` | string |  |
| `HDA912` | 审批人1 | `approver1` | string |  |
| `HDA913` | 审批结果 | `approval_result1` | string |  |
| `HDA914` | 审批意见 | `approval_opinion1` | string |  |
| `HDA915` | 审批人2 | `approver2` | string |  |
| `HDA916` | 审批结果 | `approval_result2` | string |  |
| `HDA917` | 审批意见 | `approval_opinion2` | string |  |
| `HDA918` | 审批人3 | `approver3` | string |  |
| `HDA919` | 审批结果 | `approval_result3` | string |  |
| `HDA920` | 审批意见 | `approval_opinion3` | string |  |
| `HDA921` | 审批人4 | `approver4` | string |  |
| `HDA922` | 审批结果 | `approval_result4` | string |  |
| `HDA923` | 审批意见 | `approval_opinion4` | string |  |
| `HDA924` | 审批人5 | `approver5` | string |  |
| `HDA925` | 审批结果 | `approval_result5` | string |  |
| `HDA926` | 审批意见 | `approval_opinion5` | string |  |
| `HDA927` | 审批人6 | `approver6` | string |  |
| `HDA928` | 审批结果 | `approval_result6` | string |  |
| `HDA929` | 审批意见 | `approval_opinion6` | string |  |
| `HDA930` | 终审人 | `final_approver` | string |  |
| `HDA931` | 审批结果 | `approval_result7` | string |  |
| `HDA932` | 审批意见 | `approval_opinion7` | string |  |
| `HDA933` | 通知人1 | `notifier1` | string |  |
| `HDA934` | 通知人2 | `notifier2` | string |  |
| `HDA935` | 通知人3 | `notifier3` | string |  |
| `HDA940` | 签核码 | `approval_code` | string |  |
| `HDA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `HDA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `HDA950` | 送审时间 | `submission_time_for_review` | string |  |
| `HDA951` | 审批时间1 | `approval_time1` | string |  |
| `HDA952` | 审批时间2 | `approval_time2` | string |  |
| `HDA953` | 审批时间3 | `approval_time3` | string |  |
| `HDA954` | 审批时间4 | `approval_time4` | string |  |
| `HDA955` | 审批时间5 | `approval_time5` | string |  |
| `HDA956` | 审批时间6 | `approval_time6` | string |  |
| `HDA957` | 终审时间 | `final_review_time` | string |  |
| `HDA959` | 审核时间 | `review_time` | string |  |
| `HDA960` | 自定文字1 | `udf_text1` | string |  |
| `HDA961` | 自定文字2 | `udf_text2` | string |  |
| `HDA962` | 自定文字3 | `udf_text3` | string |  |
| `HDA963` | 自定文字4 | `udf_text4` | string |  |
| `HDA964` | 自定文字5 | `udf_text5` | string |  |
| `HDA965` | 自定文字6 | `udf_text6` | string |  |
| `HDA966` | 自定文字7 | `udf_text7` | string |  |
| `HDA967` | 自定文字8 | `udf_text8` | string |  |
| `HDA968` | 自定文字9 | `udf_text9` | string |  |
| `HDA969` | 自定文字10 | `udf_text10` | string |  |
| `HDA970` | 自定文字11 | `udf_text11` | string |  |
| `HDA971` | 自定文字12 | `udf_text12` | string |  |
| `HDA972` | 自定文字13 | `udf_text13` | string |  |
| `HDA973` | 自定文字14 | `udf_text14` | string |  |
| `HDA974` | 自定文字15 | `udf_text15` | string |  |
| `HDA975` | 自定文字16 | `udf_text16` | string |  |
| `HDA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `HDA980` | 自定数字1 | `udf_no1` | float |  |
| `HDA981` | 自定数字2 | `udf_no2` | float |  |
| `HDA982` | 自定数字3 | `udf_no3` | float |  |
| `HDA983` | 自定数字4 | `udf_no4` | float |  |
| `HDA984` | 自定数字5 | `udf_no5` | float |  |
| `HDA985` | 自定数字6 | `udf_no6` | float |  |
| `HDA986` | 自定数字7 | `udf_no7` | float |  |
| `HDA987` | 自定数字8 | `udf_no8` | float |  |
| `HDA988` | 自定数字9 | `udf_no9` | float |  |
| `HDA989` | 自定数字10 | `udf_no10` | float |  |
| `HDA990` | 自定数字11 | `udf_no11` | float |  |
| `HDA991` | 自定数字12 | `udf_no12` | float |  |
| `HDA992` | 自定数字13 | `udf_no13` | float |  |
| `HDA993` | 自定数字14 | `udf_no14` | float |  |
| `HDA994` | 自定数字15 | `udf_no15` | float |  |
| `HDA995` | 自定数字16 | `udf_no16` | float |  |

### 3.2 单身表 (DCSHDB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HDB001` | 单号 | `docNo` | string |  |
| `HDB002` | 序号 | `seq` | string |  |
| `HDB003` | 品号 | `item_no` | string |  |
| `HDB004` | 品名 | `product_name` | string |  |
| `HDB005` | 单位 | `unit` | string |  |
| `HDB006` | 数量 | `qty` | float |  |
| `HDB007` | 单价 | `unit_price` | float |  |
| `HDB008` | 金额 | `amt` | string |  |
| `HDB009` | 本币金额 | `local_currency_amt` | string |  |
| `HDB010` | 预交货日期 | `predelivery_date` | string |  |
| `HDB011` | 赠品 | `gift` | string |  |
| `HDB012` | 结束 | `end` | string |  |
| `HDB013` | 前置来源 | `prefix_source` | string |  |
| `HDB014` | 前置单据 | `previous_doc` | string |  |
| `HDB015` | 前置序号 | `prefix_seq` | string |  |
| `HDB016` | 底稿单号 | `draft_docNo` | string |  |
| `HDB017` | 底稿序号 | `draft_seq` | string |  |
| `HDB018` | 已交量 | `delivered_qty` | float |  |
| `HDB019` | 审核码 | `approve_status` | string |  |
| `HDB020` | 已收料量 | `received_material_qty` | float |  |
| `HDB021` | 预留字段 | `reserved_field1` | float |  |
| `HDB022` | 原币税额 | `org_currency_tax_amt` | string |  |
| `HDB023` | 本币税额 | `domestic_currency_tax_amt` | string |  |
| `HDB024` | 发放方式 | `distribution_way` | string |  |
| `HDB025` | 预留字段 | `reserved_field2` | string |  |
| `HDB026` | 预留字段 | `reserved_field3` | string |  |
| `HDB027` | 预留字段 | `reserved_field4` | string |  |
| `HDB028` | 预留字段 | `reserved_field5` | float |  |
| `HDB029` | 预留字段 | `reserved_field6` | float |  |
| `HDB030` | 预留字段 | `reserved_field7` | string |  |
| `HDB031` | 含税单价 | `unit_price_including_tax` | float |  |
| `HDB032` | 价税合计 | `sum_price_include_tax` | string |  |
| `HDB033` | 本币价税合计 | `total_price_include_tax_in_local_currency` | string |  |
| `HDB034` | 含税 | `include_tax` | string |  |
| `HDB035` | 换算分子 | `conversion_numerator` | float |  |
| `HDB036` | 换算分母 | `conversion_denominator` | float |  |
| `HDB037` | 辅助单位 | `auxiliary_unit` | string |  |
| `HDB038` | 辅助数量 | `auxiliary_qty` | float |  |
| `HDB039` | 税率 | `tax_rate` | float |  |
| `HDB040` | 规格 | `specification` | string |  |
| `HDB041` | 指定结束原因 | `specified_end_reason` | string |  |
| `HDB901` | 录入者编号 | `entry_person_no` | string |  |
| `HDB902` | 录入时间 | `entry_time` | string |  |
| `HDB903` | 更改者编号 | `changer_no` | string |  |
| `HDB904` | 更改时间 | `change_time` | string |  |
| `HDB905` | 更新标记 | `update_flag` | integer |  |
| `HDB960` | 自定文字1 | `udf_text1` | string |  |
| `HDB961` | 自定文字2 | `udf_text2` | string |  |
| `HDB962` | 自定文字3 | `udf_text3` | string |  |
| `HDB963` | 自定文字4 | `udf_text4` | string |  |
| `HDB964` | 自定文字5 | `udf_text5` | string |  |
| `HDB965` | 自定文字6 | `udf_text6` | string |  |
| `HDB966` | 自定文字7 | `udf_text7` | string |  |
| `HDB967` | 自定文字8 | `udf_text8` | string |  |
| `HDB968` | 自定文字9 | `udf_text9` | string |  |
| `HDB969` | 自定文字10 | `udf_text10` | string |  |
| `HDB970` | 自定文字11 | `udf_text11` | string |  |
| `HDB971` | 自定文字12 | `udf_text12` | string |  |
| `HDB972` | 自定文字13 | `udf_text13` | string |  |
| `HDB973` | 自定文字14 | `udf_text14` | string |  |
| `HDB974` | 自定文字15 | `udf_text15` | string |  |
| `HDB975` | 自定文字16 | `udf_text16` | string |  |
| `HDB979` | 单身二维码 | `detail_qrcode` | string |  |
| `HDB980` | 自定数字1 | `udf_no1` | float |  |
| `HDB981` | 自定数字2 | `udf_no2` | float |  |
| `HDB982` | 自定数字3 | `udf_no3` | float |  |
| `HDB983` | 自定数字4 | `udf_no4` | float |  |
| `HDB984` | 自定数字5 | `udf_no5` | float |  |
| `HDB985` | 自定数字6 | `udf_no6` | float |  |
| `HDB986` | 自定数字7 | `udf_no7` | float |  |
| `HDB987` | 自定数字8 | `udf_no8` | float |  |
| `HDB988` | 自定数字9 | `udf_no9` | float |  |
| `HDB989` | 自定数字10 | `udf_no10` | float |  |
| `HDB990` | 自定数字11 | `udf_no11` | float |  |
| `HDB991` | 自定数字12 | `udf_no12` | float |  |
| `HDB992` | 自定数字13 | `udf_no13` | float |  |
| `HDB993` | 自定数字14 | `udf_no14` | float |  |
| `HDB994` | 自定数字15 | `udf_no15` | float |  |
| `HDB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "HDA001": ""
  ,"HDA002": ""
  ,"HDA003": ""
  ,"HDA004": ""
  ,"cdsDetail": [{
    "HDB001": ""
    ,"HDB001": ""
    ,"HDB002": ""
    ,"HDB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"HDA001": "?"}]}
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
| `HDA001` | `docNo` | 单号 | 主键 |
| `HDA002` | `nature` | 性质 | |
| `HDA003` | `date` | 日期 | |
| `HDA004` | `supplier` | 供应商 | |
| `HDA005` | `purchaser` | 采购人 | |
| `HDA006` | `dept` | 部门 | |
| `HDA007` | `currency` | 币种 | |
| `HDA008` | `exchange_rate` | 汇率 | |
| `HDA009` | `project_no` | 专案编号 | |
| `HDA010` | `delivery_postal_code` | 送货邮编 | |
| `HDB001` | `docNo` | 单号 (单身) | |
| `HDB002` | `seq` | 序号 (单身) | |
| `HDB003` | `item_no` | 品号 (单身) | |
| `HDB004` | `product_name` | 品名 (单身) | |
| `HDB005` | `unit` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `HDA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `HDA001`
