# CLI 规格说明书：退货单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `purchase.return` |
| **DLL** | `PURJC07` |
| **服务名称** | `退货单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.return" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.return" \
  --action "getMultiple" \
  --data '{"datakeys":[{"JFA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.return" \
  --action "create" \
  --data '{"JFA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.return" \
  --action "approve" \
  --data '{"datakeys":[{"JFA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `JFA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKJFA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JFA001` | 单号 | `docNo` | string | 主键 |
| `JFA002` | 性质 | `nature` | string |  |
| `JFA003` | 日期 | `date` | string |  |
| `JFA004` | 供应商 | `supplier` | string |  |
| `JFA005` | 经办人 | `handler` | string |  |
| `JFA006` | 部门 | `dept` | string |  |
| `JFA007` | 币种 | `currency` | string |  |
| `JFA008` | 汇率 | `exchange_rate` | float |  |
| `JFA009` | 预结帐日 | `preclosing_date` | string |  |
| `JFA010` | 预付款日 | `prepayment_date` | string |  |
| `JFA011` | 专案 | `project` | string |  |
| `JFA012` | 预留字段 | `reserved_field1` | string |  |
| `JFA013` | 发票种类 | `invoice_type` | string |  |
| `JFA014` | 税率 | `tax_rate` | float |  |
| `JFA015` | 无税金额 | `amt_excluding_tax` | float |  |
| `JFA016` | 原币税额 | `org_currency_tax_amt` | float |  |
| `JFA017` | 本币无税金额 | `amt_in_local_currency_excluding_tax` | float |  |
| `JFA018` | 本币税额 | `domestic_currency_tax_amt` | float |  |
| `JFA019` | 抛转否 | `is_transfer` | string |  |
| `JFA020` | 凭证 | `voucher` | string |  |
| `JFA021` | 价税合计 | `sum_price_include_tax` | float |  |
| `JFA022` | 本币价税合计 | `total_price_include_tax_in_local_currency` | float |  |
| `JFA023` | 地址邮编 | `addr_postal_code` | string |  |
| `JFA024` | 地址 | `addr` | string |  |
| `JFA025` | 备注 | `remarks` | string |  |
| `JFA026` | 审核码 | `approve_status` | string |  |
| `JFA027` | 预留字段 | `reserved_field2` | string |  |
| `JFA028` | 复核编号 | `review_no` | string |  |
| `JFA029` | 复核姓名 | `review_name` | string |  |
| `JFA030` | 预留字段 | `reserved_field3` | string |  |
| `JFA031` | 预留字段 | `reserved_field4` | string |  |
| `JFA032` | 预留字段 | `reserved_field5` | string |  |
| `JFA033` | 预留字段 | `reserved_field6` | string |  |
| `JFA034` | 预留字段 | `reserved_field7` | float |  |
| `JFA035` | 预留字段 | `reserved_field8` | float |  |
| `JFA036` | 抛增值税否 | `is_exclude_vat` | string |  |
| `JFA037` | 预留字段 | `reserved_field9` | string |  |
| `JFA038` | 运费 | `freight` | float |  |
| `JFA039` | 折让 | `allowance` | float |  |
| `JFA040` | 前置来源 | `prefix_source` | string |  |
| `JFA041` | 前置单号 | `previous_docNo` | string |  |
| `JFA042` | 预留字段 | `reserved_field10` | string |  |
| `JFA043` | 预留字段 | `reserved_field11` | string |  |
| `JFA044` | 预留字段 | `reserved_field12` | string |  |
| `JFA045` | 预留字段 | `reserved_field13` | string |  |
| `JFA046` | 预留字段 | `reserved_field14` | string |  |
| `JFA047` | 预留字段 | `reserved_field15` | float |  |
| `JFA048` | 预留字段 | `reserved_field16` | float |  |
| `JFA049` | 审核人 | `auditor` | string |  |
| `JFA050` | 审核时间 | `review_time1` | string |  |
| `JFA051` | 凭证类别 | `voucher_type` | string |  |
| `JFA052` | 现退 | `current_refund` | string |  |
| `JFA053` | 结算方式 | `settlement_method` | string |  |
| `JFA054` | 票据号码 | `bill_no` | string |  |
| `JFA055` | 结算科目 | `settlement_account` | string |  |
| `JFA056` | 付款单号 | `payment_docNo` | string |  |
| `JFA057` | 直接生成发票信息 | `directly_generate_invoice_info` | string |  |
| `JFA058` | 发票号码 | `invoice_no` | string |  |
| `JFA901` | 录入者编号 | `entry_person_no` | string |  |
| `JFA902` | 录入时间 | `entry_time` | string |  |
| `JFA903` | 更改者编号 | `changer_no` | string |  |
| `JFA904` | 更改时间 | `change_time` | string |  |
| `JFA905` | 更新标记 | `update_flag` | integer |  |
| `JFA906` | 打印次数 | `print_count` | integer |  |
| `JFA907` | 打印时间 | `print_time` | string |  |
| `JFA908` | 打印人员 | `printer` | string |  |
| `JFA909` | 打印人员姓名 | `printer_name` | string |  |
| `JFA910` | 送审状态 | `submission_status` | string |  |
| `JFA911` | 送审人 | `reviewer` | string |  |
| `JFA912` | 审批人1 | `approver1` | string |  |
| `JFA913` | 审批结果 | `approval_result1` | string |  |
| `JFA914` | 审批意见 | `approval_opinion1` | string |  |
| `JFA915` | 审批人2 | `approver2` | string |  |
| `JFA916` | 审批结果 | `approval_result2` | string |  |
| `JFA917` | 审批意见 | `approval_opinion2` | string |  |
| `JFA918` | 审批人3 | `approver3` | string |  |
| `JFA919` | 审批结果 | `approval_result3` | string |  |
| `JFA920` | 审批意见 | `approval_opinion3` | string |  |
| `JFA921` | 审批人4 | `approver4` | string |  |
| `JFA922` | 审批结果 | `approval_result4` | string |  |
| `JFA923` | 审批意见 | `approval_opinion4` | string |  |
| `JFA924` | 审批人5 | `approver5` | string |  |
| `JFA925` | 审批结果 | `approval_result5` | string |  |
| `JFA926` | 审批意见 | `approval_opinion5` | string |  |
| `JFA927` | 审批人6 | `approver6` | string |  |
| `JFA928` | 审批结果 | `approval_result6` | string |  |
| `JFA929` | 审批意见 | `approval_opinion6` | string |  |
| `JFA930` | 终审人 | `final_approver` | string |  |
| `JFA931` | 审批结果 | `approval_result7` | string |  |
| `JFA932` | 审批意见 | `approval_opinion7` | string |  |
| `JFA933` | 通知人1 | `notifier1` | string |  |
| `JFA934` | 通知人2 | `notifier2` | string |  |
| `JFA935` | 通知人3 | `notifier3` | string |  |
| `JFA940` | 签核码 | `approval_code` | string |  |
| `JFA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `JFA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `JFA960` | 自定文字1 | `udf_text1` | string |  |
| `JFA961` | 自定文字2 | `udf_text2` | string |  |
| `JFA962` | 自定文字3 | `udf_text3` | string |  |
| `JFA963` | 自定文字4 | `udf_text4` | string |  |
| `JFA964` | 自定文字5 | `udf_text5` | string |  |
| `JFA965` | 自定文字6 | `udf_text6` | string |  |
| `JFA966` | 自定文字7 | `udf_text7` | string |  |
| `JFA967` | 自定文字8 | `udf_text8` | string |  |
| `JFA968` | 自定文字9 | `udf_text9` | string |  |
| `JFA969` | 自定文字10 | `udf_text10` | string |  |
| `JFA970` | 自定文字11 | `udf_text11` | string |  |
| `JFA971` | 自定文字12 | `udf_text12` | string |  |
| `JFA972` | 自定文字13 | `udf_text13` | string |  |
| `JFA973` | 自定文字14 | `udf_text14` | string |  |
| `JFA974` | 自定文字15 | `udf_text15` | string |  |
| `JFA975` | 自定文字16 | `udf_text16` | string |  |
| `JFA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `JFA980` | 自定数字1 | `udf_no1` | float |  |
| `JFA981` | 自定数字2 | `udf_no2` | float |  |
| `JFA982` | 自定数字3 | `udf_no3` | float |  |
| `JFA983` | 自定数字4 | `udf_no4` | float |  |
| `JFA984` | 自定数字5 | `udf_no5` | float |  |
| `JFA985` | 自定数字6 | `udf_no6` | float |  |
| `JFA986` | 自定数字7 | `udf_no7` | float |  |
| `JFA987` | 自定数字8 | `udf_no8` | float |  |
| `JFA988` | 自定数字9 | `udf_no9` | float |  |
| `JFA989` | 自定数字10 | `udf_no10` | float |  |
| `JFA990` | 自定数字11 | `udf_no11` | float |  |
| `JFA991` | 自定数字12 | `udf_no12` | float |  |
| `JFA992` | 自定数字13 | `udf_no13` | float |  |
| `JFA993` | 自定数字14 | `udf_no14` | float |  |
| `JFA994` | 自定数字15 | `udf_no15` | float |  |
| `JFA995` | 自定数字16 | `udf_no16` | float |  |
| `JFA950` | 送审时间 | `submission_time_for_review` | string |  |
| `JFA951` | 审批时间1 | `approval_time1` | string |  |
| `JFA952` | 审批时间2 | `approval_time2` | string |  |
| `JFA953` | 审批时间3 | `approval_time3` | string |  |
| `JFA954` | 审批时间4 | `approval_time4` | string |  |
| `JFA955` | 审批时间5 | `approval_time5` | string |  |
| `JFA956` | 审批时间6 | `approval_time6` | string |  |
| `JFA957` | 终审时间 | `final_review_time` | string |  |
| `JFA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKJFB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JFB001` | 单号 | `docNo` | string |  |
| `JFB002` | 序号 | `seq` | string |  |
| `JFB003` | 品号 | `item_no` | string |  |
| `JFB004` | 品名 | `product_name` | string |  |
| `JFB005` | 单位 | `unit` | string |  |
| `JFB006` | 仓库 | `warehouse` | string |  |
| `JFB007` | 数量 | `qty` | float |  |
| `JFB008` | 已开票数量 | `invoiced_qty` | float |  |
| `JFB009` | 单价 | `unit_price` | float |  |
| `JFB010` | 金额 | `amt` | string |  |
| `JFB011` | 本币金额 | `local_currency_amt` | string |  |
| `JFB012` | 赠品 | `gift` | string |  |
| `JFB013` | 前置来源 | `prefix_source` | string |  |
| `JFB014` | 前置单号 | `previous_docNo` | string |  |
| `JFB015` | 前置序号 | `prefix_seq` | string |  |
| `JFB016` | 来源 | `source` | string |  |
| `JFB017` | 来源单号 | `source_docNo` | string |  |
| `JFB018` | 来源序号 | `source_seq` | string |  |
| `JFB019` | 审核码 | `approve_status` | string |  |
| `JFB020` | 预留字段 | `reserved_field1` | string |  |
| `JFB021` | 预留字段 | `reserved_field2` | float |  |
| `JFB022` | 原币税额 | `org_currency_tax_amt` | string |  |
| `JFB023` | 本币税额 | `domestic_currency_tax_amt` | string |  |
| `JFB024` | 预留字段 | `reserved_field3` | string |  |
| `JFB025` | 预留字段 | `reserved_field4` | string |  |
| `JFB026` | 预留字段 | `reserved_field5` | string |  |
| `JFB027` | 预留字段 | `reserved_field6` | string |  |
| `JFB028` | 预留字段 | `reserved_field7` | float |  |
| `JFB029` | 预留字段 | `reserved_field8` | float |  |
| `JFB030` | 含税单价 | `unit_price_including_tax` | float |  |
| `JFB031` | 价税合计 | `sum_price_include_tax` | string |  |
| `JFB032` | 本币价税合计 | `total_price_include_tax_in_local_currency` | string |  |
| `JFB033` | 含税 | `include_tax` | string |  |
| `JFB034` | 暂估已开票原币金额 | `provisionally_invoiced_amt_in_org_currency` | string |  |
| `JFB035` | 暂估已开票本币金额 | `estimated_invoiced_local_currency_amt` | string |  |
| `JFB036` | 批号 | `batch_no` | string |  |
| `JFB037` | 换算分子 | `conversion_numerator` | float |  |
| `JFB038` | 换算分母 | `conversion_denominator` | float |  |
| `JFB039` | 辅助单位 | `auxiliary_unit` | string |  |
| `JFB040` | 辅助数量 | `auxiliary_qty` | float |  |
| `JFB041` | 税率 | `tax_rate` | float |  |
| `JFB042` | 规格 | `specification` | string |  |
| `JFB043` | 分摊金额 | `allocated_amt` | string |  |
| `JFB901` | 录入者编号 | `entry_person_no` | string |  |
| `JFB902` | 录入时间 | `entry_time` | string |  |
| `JFB903` | 更改者编号 | `changer_no` | string |  |
| `JFB904` | 更改时间 | `change_time` | string |  |
| `JFB905` | 更新标记 | `update_flag` | integer |  |
| `JFB960` | 自定文字1 | `udf_text1` | string |  |
| `JFB961` | 自定文字2 | `udf_text2` | string |  |
| `JFB962` | 自定文字3 | `udf_text3` | string |  |
| `JFB963` | 自定文字4 | `udf_text4` | string |  |
| `JFB964` | 自定文字5 | `udf_text5` | string |  |
| `JFB965` | 自定文字6 | `udf_text6` | string |  |
| `JFB966` | 自定文字7 | `udf_text7` | string |  |
| `JFB967` | 自定文字8 | `udf_text8` | string |  |
| `JFB968` | 自定文字9 | `udf_text9` | string |  |
| `JFB969` | 自定文字10 | `udf_text10` | string |  |
| `JFB970` | 自定文字11 | `udf_text11` | string |  |
| `JFB971` | 自定文字12 | `udf_text12` | string |  |
| `JFB972` | 自定文字13 | `udf_text13` | string |  |
| `JFB973` | 自定文字14 | `udf_text14` | string |  |
| `JFB974` | 自定文字15 | `udf_text15` | string |  |
| `JFB975` | 自定文字16 | `udf_text16` | string |  |
| `JFB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `JFB980` | 自定数字1 | `udf_no1` | float |  |
| `JFB981` | 自定数字2 | `udf_no2` | float |  |
| `JFB982` | 自定数字3 | `udf_no3` | float |  |
| `JFB983` | 自定数字4 | `udf_no4` | float |  |
| `JFB984` | 自定数字5 | `udf_no5` | float |  |
| `JFB985` | 自定数字6 | `udf_no6` | float |  |
| `JFB986` | 自定数字7 | `udf_no7` | float |  |
| `JFB987` | 自定数字8 | `udf_no8` | float |  |
| `JFB988` | 自定数字9 | `udf_no9` | float |  |
| `JFB989` | 自定数字10 | `udf_no10` | float |  |
| `JFB990` | 自定数字11 | `udf_no11` | float |  |
| `JFB991` | 自定数字12 | `udf_no12` | float |  |
| `JFB992` | 自定数字13 | `udf_no13` | float |  |
| `JFB993` | 自定数字14 | `udf_no14` | float |  |
| `JFB994` | 自定数字15 | `udf_no15` | float |  |
| `JFB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "JFA001": ""
  ,"JFA002": ""
  ,"JFA003": ""
  ,"JFA004": ""
  ,"cdsDetail": [{
    "JFB001": ""
    ,"JFB001": ""
    ,"JFB002": ""
    ,"JFB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"JFA001": "?"}]}
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
| `JFA001` | `docNo` | 单号 | 主键 |
| `JFA002` | `nature` | 性质 | |
| `JFA003` | `date` | 日期 | |
| `JFA004` | `supplier` | 供应商 | |
| `JFA005` | `handler` | 经办人 | |
| `JFA006` | `dept` | 部门 | |
| `JFA007` | `currency` | 币种 | |
| `JFA008` | `exchange_rate` | 汇率 | |
| `JFA009` | `preclosing_date` | 预结帐日 | |
| `JFA010` | `prepayment_date` | 预付款日 | |
| `JFB001` | `docNo` | 单号 (单身) | |
| `JFB002` | `seq` | 序号 (单身) | |
| `JFB003` | `item_no` | 品号 (单身) | |
| `JFB004` | `product_name` | 品名 (单身) | |
| `JFB005` | `unit` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `JFA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `JFA001`
