# CLI 规格说明书：订单变更单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `sales.order.change` |
| **DLL** | `COPDC03` |
| **服务名称** | `订单变更单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.order.change" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.order.change" \
  --action "getMultiple" \
  --data '{"datakeys":[{"ICA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.order.change" \
  --action "create" \
  --data '{"ICA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.order.change" \
  --action "approve" \
  --data '{"datakeys":[{"ICA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `ICA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (DCSICA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `ICA001` | 变更单号 | `change_docNo` | string |  |
| `ICA002` | 变更版本 | `change_version` | string |  |
| `ICA003` | 变更日期 | `change_date` | string |  |
| `ICA004` | 性质 | `nature` | string |  |
| `ICA005` | 销售类型 | `sales_type` | string |  |
| `ICA006` | 客户 | `customer` | string |  |
| `ICA007` | 请款客户 | `request_payment_customer` | string |  |
| `ICA008` | 业务员 | `salesperson` | string |  |
| `ICA009` | 部门 | `dept` | string |  |
| `ICA010` | 币种 | `currency` | string |  |
| `ICA011` | 汇率 | `exchange_rate` | float |  |
| `ICA012` | 项目 | `project` | string |  |
| `ICA013` | 送货邮编 | `delivery_postal_code` | string |  |
| `ICA014` | 送货地址 | `delivery_addr` | string |  |
| `ICA015` | 无税金额 | `amt_excluding_tax` | float |  |
| `ICA016` | 本币无税金额 | `amt_in_local_currency_excluding_tax` | float |  |
| `ICA017` | 税额 | `tax_amt` | float |  |
| `ICA018` | 本币税额 | `domestic_currency_tax_amt` | float |  |
| `ICA019` | 价税合计 | `sum_price_include_tax` | float |  |
| `ICA020` | 本币价税合计 | `total_price_include_tax_in_local_currency` | float |  |
| `ICA021` | 订金金额 | `deposit_amt` | float |  |
| `ICA022` | 本币订金金额 | `local_currency_deposit_amt` | float |  |
| `ICA023` | 客户单号 | `customer_docNo` | string |  |
| `ICA024` | 备注 | `remarks` | string |  |
| `ICA025` | 变更原因 | `reason_for_change` | string |  |
| `ICA026` | 审核码 | `approve_status` | string |  |
| `ICA027` | 审核人 | `auditor` | string |  |
| `ICA028` | 订单日期 | `order_date` | string |  |
| `ICA029` | 原性质 | `org_nature` | string |  |
| `ICA030` | 原销售类型 | `org_sales_type` | string |  |
| `ICA031` | 原业务员 | `org_salesperson` | string |  |
| `ICA032` | 原部门 | `org_dept` | string |  |
| `ICA033` | 原币种 | `org_currency` | string |  |
| `ICA034` | 原汇率 | `org_exchange_rate` | float |  |
| `ICA035` | 原项目 | `org_project` | string |  |
| `ICA036` | 原送货邮编 | `org_delivery_postal_code` | string |  |
| `ICA037` | 原送货地址 | `org_delivery_addr` | string |  |
| `ICA038` | 原无税金额 | `org_taxfree_amt` | float |  |
| `ICA039` | 原本币无税金额 | `org_local_currency_amt_excluding_tax` | float |  |
| `ICA040` | 原税额 | `org_tax_amt` | float |  |
| `ICA041` | 原本币税额 | `org_local_currency_tax_amt` | float |  |
| `ICA042` | 原价税合计 | `org_price_and_tax_total` | float |  |
| `ICA043` | 原本币价税合计 | `sum_org_currency_price_include_tax` | float |  |
| `ICA044` | 原订金金额 | `org_deposit_amt` | float |  |
| `ICA045` | 原本币订金金额 | `org_home_currency_deposit_amt` | float |  |
| `ICA046` | 原客户单号 | `org_customer_docNo` | string |  |
| `ICA047` | 原备注 | `org_remarks` | string |  |
| `ICA048` | 订金已开票金额 | `deposit_invoiced_amt` | float |  |
| `ICA049` | 预留字段 | `reserved_field1` | string |  |
| `ICA050` | 预留字段 | `reserved_field2` | string |  |
| `ICA051` | 预留字段 | `reserved_field3` | string |  |
| `ICA052` | 预留字段 | `reserved_field4` | string |  |
| `ICA053` | 预留字段 | `reserved_field5` | float |  |
| `ICA054` | 预留字段 | `reserved_field6` | float |  |
| `ICA055` | 原自定文字1 | `org_udf_text1` | string |  |
| `ICA056` | 原自定文字2 | `org_udf_text2` | string |  |
| `ICA057` | 原自定文字3 | `org_udf_text3` | string |  |
| `ICA058` | 原自定文字4 | `org_udf_text4` | string |  |
| `ICA059` | 原自定文字5 | `org_udf_text5` | string |  |
| `ICA060` | 原自定文字6 | `org_udf_text6` | string |  |
| `ICA061` | 原自定数字1 | `org_udf_no1` | float |  |
| `ICA062` | 原自定数字2 | `org_udf_no2` | float |  |
| `ICA063` | 原自定数字3 | `org_udf_no3` | float |  |
| `ICA064` | 原自定数字4 | `org_udf_no4` | float |  |
| `ICA065` | 原自定数字5 | `org_udf_no5` | float |  |
| `ICA066` | 原自定数字6 | `org_udf_no6` | float |  |
| `ICA067` | 变更后自定文字1 | `changed_udf_text1` | string |  |
| `ICA068` | 变更后自定文字2 | `changed_udf_text2` | string |  |
| `ICA069` | 变更后自定文字3 | `changed_udf_text3` | string |  |
| `ICA070` | 变更后自定文字4 | `changed_udf_text4` | string |  |
| `ICA071` | 变更后自定文字5 | `changed_udf_text5` | string |  |
| `ICA072` | 变更后自定文字6 | `changed_udf_text6` | string |  |
| `ICA073` | 变更后自定数字1 | `changed_udf_no1` | float |  |
| `ICA074` | 变更后自定数字2 | `changed_usf_no2` | float |  |
| `ICA075` | 变更后自定数字3 | `changed_udf_no3` | float |  |
| `ICA076` | 变更后自定数字4 | `changed_udf_no4` | float |  |
| `ICA077` | 变更后自定数字5 | `change_udf_no5` | float |  |
| `ICA078` | 变更后自定数字6 | `changed_udf_no6` | float |  |
| `ICA079` | 原二维码 | `org_qrcode` | string |  |
| `ICA080` | 变更后二维码 | `changed_qrcode` | string |  |
| `ICA081` | 原自定文字7 | `org_udf_text7` | string |  |
| `ICA082` | 原自定文字8 | `org_udf_text8` | string |  |
| `ICA083` | 原自定文字9 | `org_udf_text_9` | string |  |
| `ICA084` | 原自定文字10 | `org_udf_text10` | string |  |
| `ICA085` | 原自定文字11 | `org_udf_text11` | string |  |
| `ICA086` | 原自定文字12 | `org_udf_text12` | string |  |
| `ICA087` | 原自定文字13 | `org_udf_text13` | string |  |
| `ICA088` | 原自定文字14 | `org_udf_text14` | string |  |
| `ICA089` | 原自定文字15 | `org_udf_text15` | string |  |
| `ICA090` | 原自定文字16 | `org_udf_text16` | string |  |
| `ICA091` | 变更后自定文字7 | `changed_udf_text7` | string |  |
| `ICA092` | 变更后自定文字8 | `changed_udf_text8` | string |  |
| `ICA093` | 变更后自定文字9 | `changed_udf_text9` | string |  |
| `ICA094` | 变更后自定文字10 | `changed_udf_text10` | string |  |
| `ICA095` | 变更后自定文字11 | `changed_udf_text11` | string |  |
| `ICA096` | 变更后自定文字12 | `changed_udf_text12` | string |  |
| `ICA097` | 变更后自定文字13 | `changed_udf_text13` | string |  |
| `ICA098` | 变更后自定文字14 | `changed_udf_text14` | string |  |
| `ICA099` | 变更后自定文字15 | `changed_udf_text15` | string |  |
| `ICA100` | 变更后自定文字16 | `changed_udf_text16` | string |  |
| `ICA101` | 原自定数字7 | `org_udf_no7` | float |  |
| `ICA102` | 原自定数字8 | `org_udf_no8` | float |  |
| `ICA103` | 原自定数字9 | `org_udf_no9` | float |  |
| `ICA104` | 原自定数字10 | `org_udf_no10` | float |  |
| `ICA105` | 原自定数字11 | `org_udf_no11` | float |  |
| `ICA106` | 原自定数字12 | `org_udf_no12` | float |  |
| `ICA107` | 原自定数字13 | `org_udf_no13` | float |  |
| `ICA108` | 原自定数字14 | `org_udf_no14` | float |  |
| `ICA109` | 原自定数字15 | `org_udf_no15` | float |  |
| `ICA110` | 原自定数字16 | `org_udf_no16` | float |  |
| `ICA111` | 变更后自定数字7 | `changed_udf_no7` | float |  |
| `ICA112` | 变更后自定数字8 | `changed_udf_no8` | float |  |
| `ICA113` | 变更后自定数字9 | `changed_udf_no9` | float |  |
| `ICA114` | 变更后自定数字10 | `changed_udf_no10` | float |  |
| `ICA115` | 变更后自定数字11 | `changed_udf_no11` | float |  |
| `ICA116` | 变更后自定数字12 | `changed_udf_no12` | float |  |
| `ICA117` | 变更后自定数字13 | `changed_udf_no13` | float |  |
| `ICA118` | 变更后自定数字14 | `changed_udf_no14` | float |  |
| `ICA119` | 变更后自定数字15 | `changed_udf_no15` | float |  |
| `ICA120` | 变更后自定数字16 | `changed_udf_no16` | float |  |
| `ICA901` | 录入者编号 | `entry_person_no` | string |  |
| `ICA902` | 录入时间 | `entry_time` | string |  |
| `ICA903` | 更改者编号 | `changer_no` | string |  |
| `ICA904` | 更改时间 | `change_time` | string |  |
| `ICA905` | 更新标记 | `update_flag` | integer |  |
| `ICA906` | 打印次数 | `print_count` | integer |  |
| `ICA907` | 打印时间 | `print_time` | string |  |
| `ICA908` | 打印人员 | `printer` | string |  |
| `ICA909` | 打印人员姓名 | `printer_name` | string |  |
| `ICA910` | 送审状态 | `submission_status` | string |  |
| `ICA911` | 送审人 | `reviewer` | string |  |
| `ICA912` | 审批人1 | `approver1` | string |  |
| `ICA913` | 审批结果 | `approval_result1` | string |  |
| `ICA914` | 审批意见 | `approval_opinion1` | string |  |
| `ICA915` | 审批人2 | `approver2` | string |  |
| `ICA916` | 审批结果 | `approval_result2` | string |  |
| `ICA917` | 审批意见 | `approval_opinion2` | string |  |
| `ICA918` | 审批人3 | `approver3` | string |  |
| `ICA919` | 审批结果 | `approval_result3` | string |  |
| `ICA920` | 审批意见 | `approval_opinion3` | string |  |
| `ICA921` | 审批人4 | `approver4` | string |  |
| `ICA922` | 审批结果 | `approval_result4` | string |  |
| `ICA923` | 审批意见 | `approval_opinion4` | string |  |
| `ICA924` | 审批人5 | `approver5` | string |  |
| `ICA925` | 审批结果 | `approval_result5` | string |  |
| `ICA926` | 审批意见 | `approval_opinion5` | string |  |
| `ICA927` | 审批人6 | `approver6` | string |  |
| `ICA928` | 审批结果 | `approval_result6` | string |  |
| `ICA929` | 审批意见 | `approval_opinion6` | string |  |
| `ICA930` | 终审人 | `final_approver` | string |  |
| `ICA931` | 审批结果 | `approval_result7` | string |  |
| `ICA932` | 审批意见 | `approval_opinion7` | string |  |
| `ICA933` | 通知人1 | `notifier1` | string |  |
| `ICA934` | 通知人2 | `notifier2` | string |  |
| `ICA935` | 通知人3 | `notifier3` | string |  |
| `ICA950` | 送审时间 | `submission_time_for_review` | string |  |
| `ICA951` | 审批时间1 | `approval_time1` | string |  |
| `ICA952` | 审批时间2 | `approval_time2` | string |  |
| `ICA953` | 审批时间3 | `approval_time3` | string |  |
| `ICA954` | 审批时间4 | `approval_time4` | string |  |
| `ICA955` | 审批时间5 | `approval_time5` | string |  |
| `ICA956` | 审批时间6 | `approval_time6` | string |  |
| `ICA957` | 终审时间 | `final_review_time` | string |  |
| `ICA959` | 审核时间 | `review_time` | string |  |
| `ICA960` | 自定文字1 | `udf_text1` | string |  |
| `ICA961` | 自定文字2 | `udf_text2` | string |  |
| `ICA962` | 自定文字3 | `udf_text3` | string |  |
| `ICA963` | 自定文字4 | `udf_text4` | string |  |
| `ICA964` | 自定文字5 | `udf_text5` | string |  |
| `ICA965` | 自定文字6 | `udf_text6` | string |  |
| `ICA966` | 自定文字7 | `udf_text7` | string |  |
| `ICA967` | 自定文字8 | `udf_text8` | string |  |
| `ICA968` | 自定文字9 | `udf_text9` | string |  |
| `ICA969` | 自定文字10 | `udf_text10` | string |  |
| `ICA970` | 自定文字11 | `udf_text11` | string |  |
| `ICA971` | 自定文字12 | `udf_text12` | string |  |
| `ICA972` | 自定文字13 | `udf_text13` | string |  |
| `ICA973` | 自定文字14 | `udf_text14` | string |  |
| `ICA974` | 自定文字15 | `udf_text15` | string |  |
| `ICA975` | 自定文字16 | `udf_text16` | string |  |
| `ICA979` | 二维码 | `qr_code` | string |  |
| `ICA980` | 自定数字1 | `udf_no1` | float |  |
| `ICA981` | 自定数字2 | `udf_no2` | float |  |
| `ICA982` | 自定数字3 | `udf_no3` | float |  |
| `ICA983` | 自定数字4 | `udf_no4` | float |  |
| `ICA984` | 自定数字5 | `udf_no5` | float |  |
| `ICA985` | 自定数字6 | `udf_no6` | float |  |
| `ICA986` | 自定数字7 | `udf_no7` | float |  |
| `ICA987` | 自定数字8 | `udf_no8` | float |  |
| `ICA988` | 自定数字9 | `udf_no9` | float |  |
| `ICA989` | 自定数字10 | `udf_no10` | float |  |
| `ICA990` | 自定数字11 | `udf_no11` | float |  |
| `ICA991` | 自定数字12 | `udf_no12` | float |  |
| `ICA992` | 自定数字13 | `udf_no13` | float |  |
| `ICA993` | 自定数字14 | `udf_no14` | float |  |
| `ICA994` | 自定数字15 | `udf_no15` | float |  |
| `ICA995` | 自定数字16 | `udf_no16` | float |  |

### 3.2 单身表 (DCSICB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `ICB001` | 变更单号 | `change_docNo` | string |  |
| `ICB002` | 变更版本 | `change_version` | string |  |
| `ICB003` | 序号 | `seq` | string |  |
| `ICB004` | 操作码 | `operation_code` | string |  |
| `ICB005` | 新序号 | `new_seq` | string |  |
| `ICB006` | 品号 | `item_no` | string |  |
| `ICB007` | 品名 | `product_name` | string |  |
| `ICB008` | 单位 | `unit` | string |  |
| `ICB009` | 规格 | `specification` | string |  |
| `ICB010` | 数量 | `qty` | float |  |
| `ICB011` | 赠品 | `gift` | string |  |
| `ICB012` | 定价 | `pricing` | float |  |
| `ICB013` | 含税 | `include_tax` | string |  |
| `ICB014` | 税率 | `tax_rate` | float |  |
| `ICB015` | 折扣率 | `discount_rate` | float |  |
| `ICB016` | 单价 | `unit_price` | float |  |
| `ICB017` | 含税单价 | `unit_price_including_tax` | float |  |
| `ICB018` | 金额 | `amt` | string |  |
| `ICB019` | 本币金额 | `local_currency_amt` | string |  |
| `ICB020` | 税额 | `tax_amt` | string |  |
| `ICB021` | 本币税额 | `domestic_currency_tax_amt` | string |  |
| `ICB022` | 价税合计 | `sum_price_include_tax` | string |  |
| `ICB023` | 本币价税合计 | `total_price_include_tax_in_local_currency` | string |  |
| `ICB024` | 预交货日期 | `predelivery_date` | string |  |
| `ICB025` | 换算分子 | `conversion_numerator` | float |  |
| `ICB026` | 换算分母 | `conversion_denominator` | float |  |
| `ICB027` | 库存单位 | `inventory_unit` | string |  |
| `ICB028` | 库存数量 | `inventory_qty` | float |  |
| `ICB029` | 结束 | `end` | string |  |
| `ICB030` | 变更原因 | `reason_for_change` | string |  |
| `ICB031` | 原序号 | `org_seq` | string |  |
| `ICB032` | 原品号 | `org_product_no` | string |  |
| `ICB033` | 原品名 | `org_product_name` | string |  |
| `ICB034` | 原单位 | `org_unit` | string |  |
| `ICB035` | 原规格 | `org_spec` | string |  |
| `ICB036` | 原数量 | `org_qty` | float |  |
| `ICB037` | 原赠品 | `org_gift` | string |  |
| `ICB038` | 原定价 | `org_pricing` | float |  |
| `ICB039` | 原含税 | `org_price_including_tax` | string |  |
| `ICB040` | 原税率 | `org_tax_rate` | float |  |
| `ICB041` | 原折扣率 | `org_discount_rate` | float |  |
| `ICB042` | 原单价 | `org_unit_price` | float |  |
| `ICB043` | 原含税单价 | `org_unit_price_include_tax` | float |  |
| `ICB044` | 原金额 | `org_amt` | string |  |
| `ICB045` | 原本币金额 | `org_local_currency_amt` | string |  |
| `ICB046` | 原税额 | `org_tax_amt` | string |  |
| `ICB047` | 原本币税额 | `org_local_currency_tax_amt` | string |  |
| `ICB048` | 原价税合计 | `org_price_and_tax_total` | string |  |
| `ICB049` | 原本币价税合计 | `sum_org_currency_price_include_tax` | string |  |
| `ICB050` | 原预交货日 | `org_expected_delivery_date` | string |  |
| `ICB051` | 原换算分子 | `org_conversion_numerator` | float |  |
| `ICB052` | 原换算分母 | `org_conversion_denominator` | float |  |
| `ICB053` | 原库存单位 | `org_inventory_unit` | string |  |
| `ICB054` | 原库存单位数量 | `org_inventory_unit_qty` | float |  |
| `ICB055` | 原结束 | `org_end` | string |  |
| `ICB056` | 前置来源 | `prefix_source` | string |  |
| `ICB057` | 前置单号 | `previous_docNo` | string |  |
| `ICB058` | 前置序号 | `prefix_seq` | string |  |
| `ICB059` | 已交量 | `delivered_qty` | float |  |
| `ICB060` | 工单数量 | `work_order_qty` | float |  |
| `ICB061` | 委外数量 | `subcontract_qty` | float |  |
| `ICB062` | 生产计划量 | `production_plan_qty` | float |  |
| `ICB063` | MRP量 | `mrp` | float |  |
| `ICB064` | 采购底稿量 | `purchasing_draft_qty` | float |  |
| `ICB065` | 被赠序号 | `gift_seq` | string |  |
| `ICB066` | 原被赠序号 | `org_gift_seq` | string |  |
| `ICB067` | 原自定文字1 | `org_udf_text1` | string |  |
| `ICB068` | 原自定文字2 | `org_udf_text2` | string |  |
| `ICB069` | 原自定文字3 | `org_udf_text3` | string |  |
| `ICB070` | 原自定文字4 | `org_udf_text4` | string |  |
| `ICB071` | 原自定文字5 | `org_udf_text5` | string |  |
| `ICB072` | 原自定文字6 | `org_udf_text6` | string |  |
| `ICB073` | 原自定数字1 | `org_udf_no1` | float |  |
| `ICB074` | 原自定数字2 | `org_udf_no2` | float |  |
| `ICB075` | 原自定数字3 | `org_udf_no3` | float |  |
| `ICB076` | 原自定数字4 | `org_udf_no4` | float |  |
| `ICB077` | 原自定数字5 | `org_udf_no5` | float |  |
| `ICB078` | 原自定数字6 | `org_udf_no6` | float |  |
| `ICB079` | 变更后自定文字1 | `changed_udf_text1` | string |  |
| `ICB080` | 变更后自定文字2 | `changed_udf_text2` | string |  |
| `ICB081` | 变更后自定文字3 | `changed_udf_text3` | string |  |
| `ICB082` | 变更后自定文字4 | `changed_udf_text4` | string |  |
| `ICB083` | 变更后自定文字5 | `changed_udf_text5` | string |  |
| `ICB084` | 变更后自定文字6 | `changed_udf_text6` | string |  |
| `ICB085` | 变更后自定数字1 | `changed_udf_no1` | float |  |
| `ICB086` | 变更后自定数字2 | `changed_usf_no2` | float |  |
| `ICB087` | 变更后自定数字3 | `changed_udf_no3` | float |  |
| `ICB088` | 变更后自定数字4 | `changed_udf_no4` | float |  |
| `ICB089` | 变更后自定数字5 | `change_udf_no5` | float |  |
| `ICB090` | 变更后自定数字6 | `changed_udf_no6` | float |  |
| `ICB091` | 原二维码 | `org_qrcode` | string |  |
| `ICB092` | 变更后二维码 | `changed_qrcode` | string |  |
| `ICB093` | 原自定文字7 | `org_udf_text7` | string |  |
| `ICB094` | 原自定文字8 | `org_udf_text8` | string |  |
| `ICB095` | 原自定文字9 | `org_udf_text_9` | string |  |
| `ICB096` | 原自定文字10 | `org_udf_text10` | string |  |
| `ICB097` | 原自定文字11 | `org_udf_text11` | string |  |
| `ICB098` | 原自定文字12 | `org_udf_text12` | string |  |
| `ICB099` | 原自定文字13 | `org_udf_text13` | string |  |
| `ICB100` | 原自定文字14 | `org_udf_text14` | string |  |
| `ICB101` | 原自定文字15 | `org_udf_text15` | string |  |
| `ICB102` | 原自定文字16 | `org_udf_text16` | string |  |
| `ICB103` | 变更后自定文字7 | `changed_udf_text7` | string |  |
| `ICB104` | 变更后自定文字8 | `changed_udf_text8` | string |  |
| `ICB105` | 变更后自定文字9 | `changed_udf_text9` | string |  |
| `ICB106` | 变更后自定文字10 | `changed_udf_text10` | string |  |
| `ICB107` | 变更后自定文字11 | `changed_udf_text11` | string |  |
| `ICB108` | 变更后自定文字12 | `changed_udf_text12` | string |  |
| `ICB109` | 变更后自定文字13 | `changed_udf_text13` | string |  |
| `ICB110` | 变更后自定文字14 | `changed_udf_text14` | string |  |
| `ICB111` | 变更后自定文字15 | `changed_udf_text15` | string |  |
| `ICB112` | 变更后自定文字16 | `changed_udf_text16` | string |  |
| `ICB113` | 原自定数字7 | `org_udf_no7` | float |  |
| `ICB114` | 原自定数字8 | `org_udf_no8` | float |  |
| `ICB115` | 原自定数字9 | `org_udf_no9` | float |  |
| `ICB116` | 原自定数字10 | `org_udf_no10` | float |  |
| `ICB117` | 原自定数字11 | `org_udf_no11` | float |  |
| `ICB118` | 原自定数字12 | `org_udf_no12` | float |  |
| `ICB119` | 原自定数字13 | `org_udf_no13` | float |  |
| `ICB120` | 原自定数字14 | `org_udf_no14` | float |  |
| `ICB121` | 原自定数字15 | `org_udf_no15` | float |  |
| `ICB122` | 原自定数字16 | `org_udf_no16` | float |  |
| `ICB123` | 变更后自定数字7 | `changed_udf_no7` | float |  |
| `ICB124` | 变更后自定数字8 | `changed_udf_no8` | float |  |
| `ICB125` | 变更后自定数字9 | `changed_udf_no9` | float |  |
| `ICB126` | 变更后自定数字10 | `changed_udf_no10` | float |  |
| `ICB127` | 变更后自定数字11 | `changed_udf_no11` | float |  |
| `ICB128` | 变更后自定数字12 | `changed_udf_no12` | float |  |
| `ICB129` | 变更后自定数字13 | `changed_udf_no13` | float |  |
| `ICB130` | 变更后自定数字14 | `changed_udf_no14` | float |  |
| `ICB131` | 变更后自定数字15 | `changed_udf_no15` | float |  |
| `ICB132` | 变更后自定数字16 | `changed_udf_no16` | float |  |
| `ICB901` | 录入者编号 | `entry_person_no` | string |  |
| `ICB902` | 录入时间 | `entry_time` | string |  |
| `ICB903` | 更改者编号 | `changer_no` | string |  |
| `ICB904` | 更改时间 | `change_time` | string |  |
| `ICB905` | 更新标记 | `update_flag` | integer |  |
| `ICB960` | 自定文字1 | `udf_text1` | string |  |
| `ICB961` | 自定文字2 | `udf_text2` | string |  |
| `ICB962` | 自定文字3 | `udf_text3` | string |  |
| `ICB963` | 自定文字4 | `udf_text4` | string |  |
| `ICB964` | 自定文字5 | `udf_text5` | string |  |
| `ICB965` | 自定文字6 | `udf_text6` | string |  |
| `ICB966` | 自定文字7 | `udf_text7` | string |  |
| `ICB967` | 自定文字8 | `udf_text8` | string |  |
| `ICB968` | 自定文字9 | `udf_text9` | string |  |
| `ICB969` | 自定文字10 | `udf_text10` | string |  |
| `ICB970` | 自定文字11 | `udf_text11` | string |  |
| `ICB971` | 自定文字12 | `udf_text12` | string |  |
| `ICB972` | 自定文字13 | `udf_text13` | string |  |
| `ICB973` | 自定文字14 | `udf_text14` | string |  |
| `ICB974` | 自定文字15 | `udf_text15` | string |  |
| `ICB975` | 自定文字16 | `udf_text16` | string |  |
| `ICB979` | 二维码 | `qr_code` | string |  |
| `ICB980` | 自定数字1 | `udf_no1` | float |  |
| `ICB981` | 自定数字2 | `udf_no2` | float |  |
| `ICB982` | 自定数字3 | `udf_no3` | float |  |
| `ICB983` | 自定数字4 | `udf_no4` | float |  |
| `ICB984` | 自定数字5 | `udf_no5` | float |  |
| `ICB985` | 自定数字6 | `udf_no6` | float |  |
| `ICB986` | 自定数字7 | `udf_no7` | float |  |
| `ICB987` | 自定数字8 | `udf_no8` | float |  |
| `ICB988` | 自定数字9 | `udf_no9` | float |  |
| `ICB989` | 自定数字10 | `udf_no10` | float |  |
| `ICB990` | 自定数字11 | `udf_no11` | float |  |
| `ICB991` | 自定数字12 | `udf_no12` | float |  |
| `ICB992` | 自定数字13 | `udf_no13` | float |  |
| `ICB993` | 自定数字14 | `udf_no14` | float |  |
| `ICB994` | 自定数字15 | `udf_no15` | float |  |
| `ICB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (DCSICC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `ICC001` | 变更单单号 | `change_docNo` | string |  |
| `ICC002` | 变更版本 | `change_version` | string |  |
| `ICC003` | 订单序号 | `order_seq` | string |  |
| `ICC004` | 层级码 | `hierarchy_code` | string |  |
| `ICC005` | 类别 | `category` | string |  |
| `ICC006` | 品号 | `item_no` | string |  |
| `ICC007` | 选择码 | `selection_code` | string |  |
| `ICC008` | 数量 | `qty` | float |  |
| `ICC009` | 选配原则 | `opt_selection_principle` | string |  |
| `ICC010` | 主件品号 | `main_item_no` | string |  |
| `ICC011` | 主件规格 | `main_component_specification` | string |  |
| `ICC012` | 子件规格 | `subitem_specification` | string |  |
| `ICC013` | 预留字段 | `reserved_field1` | string |  |
| `ICC014` | 预留字段 | `reserved_field2` | string |  |
| `ICC015` | 预留字段 | `reserved_field3` | string |  |
| `ICC016` | 预留字段 | `reserved_field4` | string |  |
| `ICC017` | 预留字段 | `reserved_field5` | float |  |
| `ICC018` | 预留字段 | `reserved_field6` | float |  |
| `ICC020` | 变更单序号 | `change_order_seq` | string |  |
| `ICC901` | 录入者编号 | `entry_person_no` | string |  |
| `ICC902` | 录入时间 | `entry_time` | string |  |
| `ICC903` | 更改者编号 | `changer_no` | string |  |
| `ICC904` | 更改时间 | `change_time` | string |  |
| `ICC905` | 更新标记 | `update_flag` | integer |  |
| `ICC960` | 自定文字1 | `udf_text1` | string |  |
| `ICC961` | 自定文字2 | `udf_text2` | string |  |
| `ICC962` | 自定文字3 | `udf_text3` | string |  |
| `ICC963` | 自定文字4 | `udf_text4` | string |  |
| `ICC964` | 自定文字5 | `udf_text5` | string |  |
| `ICC965` | 自定文字6 | `udf_text6` | string |  |
| `ICC966` | 自定文字7 | `udf_text7` | string |  |
| `ICC967` | 自定文字8 | `udf_text8` | string |  |
| `ICC968` | 自定文字9 | `udf_text9` | string |  |
| `ICC969` | 自定文字10 | `udf_text10` | string |  |
| `ICC970` | 自定文字11 | `udf_text11` | string |  |
| `ICC971` | 自定文字12 | `udf_text12` | string |  |
| `ICC972` | 自定文字13 | `udf_text13` | string |  |
| `ICC973` | 自定文字14 | `udf_text14` | string |  |
| `ICC974` | 自定文字15 | `udf_text15` | string |  |
| `ICC975` | 自定文字16 | `udf_text16` | string |  |
| `ICC980` | 自定数字1 | `udf_no1` | float |  |
| `ICC981` | 自定数字2 | `udf_no2` | float |  |
| `ICC982` | 自定数字3 | `udf_no3` | float |  |
| `ICC983` | 自定数字4 | `udf_no4` | float |  |
| `ICC984` | 自定数字5 | `udf_no5` | float |  |
| `ICC985` | 自定数字6 | `udf_no6` | float |  |
| `ICC986` | 自定数字7 | `udf_no7` | float |  |
| `ICC987` | 自定数字8 | `udf_no8` | float |  |
| `ICC988` | 自定数字9 | `udf_no9` | float |  |
| `ICC989` | 自定数字10 | `udf_no10` | float |  |
| `ICC990` | 自定数字11 | `udf_no11` | float |  |
| `ICC991` | 自定数字12 | `udf_no12` | float |  |
| `ICC992` | 自定数字13 | `udf_no13` | float |  |
| `ICC993` | 自定数字14 | `udf_no14` | float |  |
| `ICC994` | 自定数字15 | `udf_no15` | float |  |
| `ICC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "ICA001": ""
  ,"ICA001": ""
  ,"ICA002": ""
  ,"ICA003": ""
  ,"cdsDetail": [{
    "ICB001": ""
    ,"ICB001": ""
    ,"ICB002": ""
    ,"ICB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"ICA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"change_docNo","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `ICA001` | `change_docNo` | 变更单号 | |
| `ICA002` | `change_version` | 变更版本 | |
| `ICA003` | `change_date` | 变更日期 | |
| `ICA004` | `nature` | 性质 | |
| `ICA005` | `sales_type` | 销售类型 | |
| `ICA006` | `customer` | 客户 | |
| `ICA007` | `request_payment_customer` | 请款客户 | |
| `ICA008` | `salesperson` | 业务员 | |
| `ICA009` | `dept` | 部门 | |
| `ICA010` | `currency` | 币种 | |
| `ICB001` | `change_docNo` | 变更单号 (单身) | |
| `ICB002` | `change_version` | 变更版本 (单身) | |
| `ICB003` | `seq` | 序号 (单身) | |
| `ICB004` | `operation_code` | 操作码 (单身) | |
| `ICB005` | `new_seq` | 新序号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `ICA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `ICA001`
