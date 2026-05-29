# CLI 规格说明书：采购变更单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `purchase.change` |
| **DLL** | `PURCC07` |
| **服务名称** | `采购变更单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.change" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.change" \
  --action "getMultiple" \
  --data '{"datakeys":[{"HFA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.change" \
  --action "create" \
  --data '{"HFA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.change" \
  --action "approve" \
  --data '{"datakeys":[{"HFA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `HFA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (DCSHFA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HFA001` | 单号 | `docNo` | string |  |
| `HFA002` | 变更版本 | `change_version` | string |  |
| `HFA003` | 变更日期 | `change_date` | string |  |
| `HFA004` | 供应商 | `supplier` | string |  |
| `HFA005` | 性质 | `nature` | string |  |
| `HFA006` | 采购人 | `purchaser` | string |  |
| `HFA007` | 部门 | `dept` | string |  |
| `HFA008` | 币种 | `currency` | string |  |
| `HFA009` | 汇率 | `exchange_rate` | float |  |
| `HFA010` | 项目编号 | `project_no` | string |  |
| `HFA011` | 送货邮编 | `delivery_postal_code` | string |  |
| `HFA012` | 送货地址 | `delivery_addr` | string |  |
| `HFA013` | 备注 | `remarks` | string |  |
| `HFA014` | 无税金额 | `amt_excluding_tax` | float |  |
| `HFA015` | 本币无税金额 | `amt_in_local_currency_excluding_tax` | float |  |
| `HFA016` | 税额 | `tax_amt` | float |  |
| `HFA017` | 本币币税额 | `local_currency_tax_amt` | float |  |
| `HFA018` | 价税合计 | `sum_price_include_tax` | float |  |
| `HFA019` | 本币价税合计 | `total_price_include_tax_in_local_currency` | float |  |
| `HFA020` | 订金 | `deposit` | float |  |
| `HFA021` | 变更原因 | `reason_for_change` | string |  |
| `HFA022` | 审核码 | `approve_status` | string |  |
| `HFA023` | 审核人 | `auditor` | string |  |
| `HFA024` | 采购日期 | `purchase_date` | string |  |
| `HFA025` | 原性质 | `org_nature` | string |  |
| `HFA026` | 原采购人 | `org_purchaser` | string |  |
| `HFA027` | 原部门 | `org_dept` | string |  |
| `HFA028` | 原币种 | `org_currency` | string |  |
| `HFA029` | 原汇率 | `org_exchange_rate` | float |  |
| `HFA030` | 原项目编号 | `org_project_no` | string |  |
| `HFA031` | 原送货邮编 | `org_delivery_postal_code` | string |  |
| `HFA032` | 原送货地址 | `org_delivery_addr` | string |  |
| `HFA033` | 原备注 | `org_remarks` | string |  |
| `HFA034` | 原无税金额 | `org_taxfree_amt` | float |  |
| `HFA035` | 原本币无税金额 | `org_local_currency_amt_excluding_tax` | float |  |
| `HFA036` | 原税额 | `org_tax_amt` | float |  |
| `HFA037` | 原本币税额 | `org_local_currency_tax_amt` | float |  |
| `HFA038` | 原价税金额 | `org_price_include_tax` | float |  |
| `HFA039` | 原本币价税金额 | `org_local_currency_price_including_tax` | float |  |
| `HFA040` | 原订金 | `org_deposit` | float |  |
| `HFA041` | 订金已开票金额 | `deposit_invoiced_amt` | float |  |
| `HFA042` | 预留字段 | `reserved_field1` | string |  |
| `HFA043` | 预留字段 | `reserved_field2` | string |  |
| `HFA044` | 预留字段 | `reserved_field3` | string |  |
| `HFA045` | 预留字段 | `reserved_field4` | string |  |
| `HFA046` | 预留字段 | `reserved_field5` | float |  |
| `HFA047` | 预留字段 | `reserved_field6` | float |  |
| `HFA048` | 预留字段 | `reserved_field7` | float |  |
| `HFA049` | 原自定文字1 | `org_udf_text1` | string |  |
| `HFA050` | 原自定文字2 | `org_udf_text2` | string |  |
| `HFA051` | 原自定文字3 | `org_udf_text3` | string |  |
| `HFA052` | 原自定文字4 | `org_udf_text4` | string |  |
| `HFA053` | 原自定文字5 | `org_udf_text5` | string |  |
| `HFA054` | 原自定文字6 | `org_udf_text6` | string |  |
| `HFA055` | 原自定数字1 | `org_udf_no1` | float |  |
| `HFA056` | 原自定数字2 | `org_udf_no2` | float |  |
| `HFA057` | 原自定数字3 | `org_udf_no3` | float |  |
| `HFA058` | 原自定数字4 | `org_udf_no4` | float |  |
| `HFA059` | 原自定数字5 | `org_udf_no5` | float |  |
| `HFA060` | 原自定数字6 | `org_udf_no6` | float |  |
| `HFA061` | 变更后自定文字1 | `changed_udf_text1` | string |  |
| `HFA062` | 变更后自定文字2 | `changed_udf_text2` | string |  |
| `HFA063` | 变更后自定文字3 | `changed_udf_text3` | string |  |
| `HFA064` | 变更后自定文字4 | `changed_udf_text4` | string |  |
| `HFA065` | 变更后自定文字5 | `changed_udf_text5` | string |  |
| `HFA066` | 变更后自定文字6 | `changed_udf_text6` | string |  |
| `HFA067` | 变更后自定数字1 | `changed_udf_no1` | float |  |
| `HFA068` | 变更后自定数字2 | `changed_usf_no2` | float |  |
| `HFA069` | 变更后自定数字3 | `changed_udf_no3` | float |  |
| `HFA070` | 变更后自定数字4 | `changed_udf_no4` | float |  |
| `HFA071` | 变更后自定数字5 | `change_udf_no5` | float |  |
| `HFA072` | 变更后自定数字6 | `changed_udf_no6` | float |  |
| `HFA073` | 原单头二维码 | `org_header_qrcode` | string |  |
| `HFA074` | 变更后单头二维码 | `qrcode_of_the_changed_header` | string |  |
| `HFA075` | 原自定文字7 | `org_udf_text7` | string |  |
| `HFA076` | 原自定文字8 | `org_udf_text8` | string |  |
| `HFA077` | 原自定文字9 | `org_udf_text_9` | string |  |
| `HFA078` | 原自定文字10 | `org_udf_text10` | string |  |
| `HFA079` | 原自定文字11 | `org_udf_text11` | string |  |
| `HFA080` | 原自定文字12 | `org_udf_text12` | string |  |
| `HFA081` | 原自定文字13 | `org_udf_text13` | string |  |
| `HFA082` | 原自定文字14 | `org_udf_text14` | string |  |
| `HFA083` | 原自定文字15 | `org_udf_text15` | string |  |
| `HFA084` | 原自定文字16 | `org_udf_text16` | string |  |
| `HFA085` | 变更后自定文字7 | `changed_udf_text7` | string |  |
| `HFA086` | 变更后自定文字8 | `changed_udf_text8` | string |  |
| `HFA087` | 变更后自定文字9 | `changed_udf_text9` | string |  |
| `HFA088` | 变更后自定文字10 | `changed_udf_text10` | string |  |
| `HFA089` | 变更后自定文字11 | `changed_udf_text11` | string |  |
| `HFA090` | 变更后自定文字12 | `changed_udf_text12` | string |  |
| `HFA091` | 变更后自定文字13 | `changed_udf_text13` | string |  |
| `HFA092` | 变更后自定文字14 | `changed_udf_text14` | string |  |
| `HFA093` | 变更后自定文字15 | `changed_udf_text15` | string |  |
| `HFA094` | 变更后自定文字16 | `changed_udf_text16` | string |  |
| `HFA095` | 原自定数字7 | `org_udf_no7` | float |  |
| `HFA096` | 原自定数字8 | `org_udf_no8` | float |  |
| `HFA097` | 原自定数字9 | `org_udf_no9` | float |  |
| `HFA098` | 原自定数字10 | `org_udf_no10` | float |  |
| `HFA099` | 原自定数字11 | `org_udf_no11` | float |  |
| `HFA100` | 原自定数字12 | `org_udf_no12` | float |  |
| `HFA101` | 原自定数字13 | `org_udf_no13` | float |  |
| `HFA102` | 原自定数字14 | `org_udf_no14` | float |  |
| `HFA103` | 原自定数字15 | `org_udf_no15` | float |  |
| `HFA104` | 原自定数字16 | `org_udf_no16` | float |  |
| `HFA105` | 变更后自定数字7 | `changed_udf_no7` | float |  |
| `HFA106` | 变更后自定数字8 | `changed_udf_no8` | float |  |
| `HFA107` | 变更后自定数字9 | `changed_udf_no9` | float |  |
| `HFA108` | 变更后自定数字10 | `changed_udf_no10` | float |  |
| `HFA109` | 变更后自定数字11 | `changed_udf_no11` | float |  |
| `HFA110` | 变更后自定数字12 | `changed_udf_no12` | float |  |
| `HFA111` | 变更后自定数字13 | `changed_udf_no13` | float |  |
| `HFA112` | 变更后自定数字14 | `changed_udf_no14` | float |  |
| `HFA113` | 变更后自定数字15 | `changed_udf_no15` | float |  |
| `HFA114` | 变更后自定数字16 | `changed_udf_no16` | float |  |
| `HFA901` | 录入者编号 | `entry_person_no` | string |  |
| `HFA902` | 录入时间 | `entry_time` | string |  |
| `HFA903` | 更改者编号 | `changer_no` | string |  |
| `HFA904` | 更改时间 | `change_time` | string |  |
| `HFA905` | 更新标记 | `update_flag` | integer |  |
| `HFA906` | 打印次数 | `print_count` | integer |  |
| `HFA907` | 打印时间 | `print_time` | string |  |
| `HFA908` | 打印人员 | `printer` | string |  |
| `HFA909` | 打印人员姓名 | `printer_name` | string |  |
| `HFA910` | 送审状态 | `submission_status` | string |  |
| `HFA911` | 送审人 | `reviewer` | string |  |
| `HFA912` | 审批人1 | `approver1` | string |  |
| `HFA913` | 审批结果 | `approval_result1` | string |  |
| `HFA914` | 审批意见 | `approval_opinion1` | string |  |
| `HFA915` | 审批人2 | `approver2` | string |  |
| `HFA916` | 审批结果 | `approval_result2` | string |  |
| `HFA917` | 审批意见 | `approval_opinion2` | string |  |
| `HFA918` | 审批人3 | `approver3` | string |  |
| `HFA919` | 审批结果 | `approval_result3` | string |  |
| `HFA920` | 审批意见 | `approval_opinion3` | string |  |
| `HFA921` | 审批人4 | `approver4` | string |  |
| `HFA922` | 审批结果 | `approval_result4` | string |  |
| `HFA923` | 审批意见 | `approval_opinion4` | string |  |
| `HFA924` | 审批人5 | `approver5` | string |  |
| `HFA925` | 审批结果 | `approval_result5` | string |  |
| `HFA926` | 审批意见 | `approval_opinion5` | string |  |
| `HFA927` | 审批人6 | `approver6` | string |  |
| `HFA928` | 审批结果 | `approval_result6` | string |  |
| `HFA929` | 审批意见 | `approval_opinion6` | string |  |
| `HFA930` | 终审人 | `final_approver` | string |  |
| `HFA931` | 审批结果 | `approval_result7` | string |  |
| `HFA932` | 审批意见 | `approval_opinion7` | string |  |
| `HFA933` | 通知人1 | `notifier1` | string |  |
| `HFA934` | 通知人2 | `notifier2` | string |  |
| `HFA935` | 通知人3 | `notifier3` | string |  |
| `HFA950` | 送审时间 | `submission_time_for_review` | string |  |
| `HFA951` | 审批时间1 | `approval_time1` | string |  |
| `HFA952` | 审批时间2 | `approval_time2` | string |  |
| `HFA953` | 审批时间3 | `approval_time3` | string |  |
| `HFA954` | 审批时间4 | `approval_time4` | string |  |
| `HFA955` | 审批时间5 | `approval_time5` | string |  |
| `HFA956` | 审批时间6 | `approval_time6` | string |  |
| `HFA957` | 终审时间 | `final_review_time` | string |  |
| `HFA959` | 审核时间 | `review_time` | string |  |
| `HFA960` | 自定文字1 | `udf_text1` | string |  |
| `HFA961` | 自定文字2 | `udf_text2` | string |  |
| `HFA962` | 自定文字3 | `udf_text3` | string |  |
| `HFA963` | 自定文字4 | `udf_text4` | string |  |
| `HFA964` | 自定文字5 | `udf_text5` | string |  |
| `HFA965` | 自定文字6 | `udf_text6` | string |  |
| `HFA966` | 自定文字7 | `udf_text7` | string |  |
| `HFA967` | 自定文字8 | `udf_text8` | string |  |
| `HFA968` | 自定文字9 | `udf_text9` | string |  |
| `HFA969` | 自定文字10 | `udf_text10` | string |  |
| `HFA970` | 自定文字11 | `udf_text11` | string |  |
| `HFA971` | 自定文字12 | `udf_text12` | string |  |
| `HFA972` | 自定文字13 | `udf_text13` | string |  |
| `HFA973` | 自定文字14 | `udf_text14` | string |  |
| `HFA974` | 自定文字15 | `udf_text15` | string |  |
| `HFA975` | 自定文字16 | `udf_text16` | string |  |
| `HFA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `HFA980` | 自定数字1 | `udf_no1` | float |  |
| `HFA981` | 自定数字2 | `udf_no2` | float |  |
| `HFA982` | 自定数字3 | `udf_no3` | float |  |
| `HFA983` | 自定数字4 | `udf_no4` | float |  |
| `HFA984` | 自定数字5 | `udf_no5` | float |  |
| `HFA985` | 自定数字6 | `udf_no6` | float |  |
| `HFA986` | 自定数字7 | `udf_no7` | float |  |
| `HFA987` | 自定数字8 | `udf_no8` | float |  |
| `HFA988` | 自定数字9 | `udf_no9` | float |  |
| `HFA989` | 自定数字10 | `udf_no10` | float |  |
| `HFA990` | 自定数字11 | `udf_no11` | float |  |
| `HFA991` | 自定数字12 | `udf_no12` | float |  |
| `HFA992` | 自定数字13 | `udf_no13` | float |  |
| `HFA993` | 自定数字14 | `udf_no14` | float |  |
| `HFA994` | 自定数字15 | `udf_no15` | float |  |
| `HFA995` | 自定数字16 | `udf_no16` | float |  |

### 3.2 单身表 (DCSHFB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HFB001` | 单号 | `docNo` | string |  |
| `HFB002` | 变更版本 | `change_version` | string |  |
| `HFB003` | 序号 | `seq` | string |  |
| `HFB004` | 操作码 | `operation_code` | string |  |
| `HFB005` | 新序号 | `new_seq` | string |  |
| `HFB006` | 品号 | `item_no` | string |  |
| `HFB007` | 品名 | `product_name` | string |  |
| `HFB008` | 单位 | `unit` | string |  |
| `HFB009` | 数量 | `qty` | float |  |
| `HFB010` | 含税 | `include_tax` | string |  |
| `HFB011` | 单价 | `unit_price` | float |  |
| `HFB012` | 含税单价 | `unit_price_including_tax` | float |  |
| `HFB013` | 税率 | `tax_rate` | float |  |
| `HFB014` | 价税合计 | `sum_price_include_tax` | string |  |
| `HFB015` | 本币价税合计 | `total_price_include_tax_in_local_currency` | string |  |
| `HFB016` | 税额 | `tax_amt` | string |  |
| `HFB017` | 本币税额 | `domestic_currency_tax_amt` | string |  |
| `HFB018` | 无税金额 | `amt_excluding_tax` | string |  |
| `HFB019` | 本币无税金额 | `amt_in_local_currency_excluding_tax` | string |  |
| `HFB020` | 预交货日期 | `predelivery_date` | string |  |
| `HFB021` | 赠品 | `gift` | string |  |
| `HFB022` | 结束 | `end` | string |  |
| `HFB023` | 换算分子 | `conversion_numerator` | float |  |
| `HFB024` | 换算分母 | `conversion_denominator` | float |  |
| `HFB025` | 库存单位 | `inventory_unit` | string |  |
| `HFB026` | 库存单位数量 | `inventory_unit_qty` | float |  |
| `HFB027` | 变更原因 | `reason_for_change` | string |  |
| `HFB028` | 原序号 | `org_seq` | string |  |
| `HFB029` | 原品号 | `org_product_no` | string |  |
| `HFB030` | 原品名 | `org_product_name` | string |  |
| `HFB031` | 原单位 | `org_unit` | string |  |
| `HFB032` | 原数量 | `org_qty` | float |  |
| `HFB033` | 原含税 | `org_price_including_tax` | string |  |
| `HFB034` | 原单价 | `org_unit_price` | float |  |
| `HFB035` | 原含税单价 | `org_unit_price_include_tax` | float |  |
| `HFB036` | 原税率 | `org_tax_rate` | float |  |
| `HFB037` | 原价税金额 | `org_price_include_tax` | string |  |
| `HFB038` | 原本币价税金额 | `org_local_currency_price_including_tax` | string |  |
| `HFB039` | 原税额 | `org_tax_amt` | string |  |
| `HFB040` | 原本币税额 | `org_local_currency_tax_amt` | string |  |
| `HFB041` | 原无税金额 | `org_taxfree_amt` | string |  |
| `HFB042` | 原本币无税金额 | `org_local_currency_amt_excluding_tax` | string |  |
| `HFB043` | 原预交货日期 | `org_estimated_delivery_date` | string |  |
| `HFB044` | 原赠品 | `org_gift` | string |  |
| `HFB045` | 原结束 | `org_end` | string |  |
| `HFB046` | 原换算分子 | `org_conversion_numerator` | float |  |
| `HFB047` | 原换算分母 | `org_conversion_denominator` | float |  |
| `HFB048` | 原库存单位 | `org_inventory_unit` | string |  |
| `HFB049` | 原库存单位数量 | `org_inventory_unit_qty` | float |  |
| `HFB050` | 前置来源 | `prefix_source` | string |  |
| `HFB051` | 前置单据 | `previous_doc` | string |  |
| `HFB052` | 前置序号 | `prefix_seq` | string |  |
| `HFB053` | 底稿单号 | `draft_docNo` | string |  |
| `HFB054` | 底稿序号 | `draft_seq` | string |  |
| `HFB055` | 已交量 | `delivered_qty` | float |  |
| `HFB056` | 已收料量 | `received_material_qty` | float |  |
| `HFB057` | 发放方式 | `distribution_way` | string |  |
| `HFB058` | 预留字段 | `reserved_field1` | string |  |
| `HFB059` | 预留字段 | `reserved_field2` | string |  |
| `HFB060` | 预留字段 | `reserved_field3` | string |  |
| `HFB061` | 预留字段 | `reserved_field4` | string |  |
| `HFB062` | 预留字段 | `reserved_field5` | float |  |
| `HFB063` | 预留字段 | `reserved_field6` | float |  |
| `HFB064` | 规格 | `specification` | string |  |
| `HFB065` | 原规格 | `org_spec` | string |  |
| `HFB066` | 原自定文字1 | `org_udf_text1` | string |  |
| `HFB067` | 原自定文字2 | `org_udf_text2` | string |  |
| `HFB068` | 原自定文字3 | `org_udf_text3` | string |  |
| `HFB069` | 原自定文字4 | `org_udf_text4` | string |  |
| `HFB070` | 原自定文字5 | `org_udf_text5` | string |  |
| `HFB071` | 原自定文字6 | `org_udf_text6` | string |  |
| `HFB072` | 原自定数字1 | `org_udf_no1` | float |  |
| `HFB073` | 原自定数字2 | `org_udf_no2` | float |  |
| `HFB074` | 原自定数字3 | `org_udf_no3` | float |  |
| `HFB075` | 原自定数字4 | `org_udf_no4` | float |  |
| `HFB076` | 原自定数字5 | `org_udf_no5` | float |  |
| `HFB077` | 原自定数字6 | `org_udf_no6` | float |  |
| `HFB078` | 变更后自定文字1 | `changed_udf_text1` | string |  |
| `HFB079` | 变更后自定文字2 | `changed_udf_text2` | string |  |
| `HFB080` | 变更后自定文字3 | `changed_udf_text3` | string |  |
| `HFB081` | 变更后自定文字4 | `changed_udf_text4` | string |  |
| `HFB082` | 变更后自定文字5 | `changed_udf_text5` | string |  |
| `HFB083` | 变更后自定文字6 | `changed_udf_text6` | string |  |
| `HFB084` | 变更后自定数字1 | `changed_udf_no1` | float |  |
| `HFB085` | 变更后自定数字2 | `changed_usf_no2` | float |  |
| `HFB086` | 变更后自定数字3 | `changed_udf_no3` | float |  |
| `HFB087` | 变更后自定数字4 | `changed_udf_no4` | float |  |
| `HFB088` | 变更后自定数字5 | `change_udf_no5` | float |  |
| `HFB089` | 变更后自定数字6 | `changed_udf_no6` | float |  |
| `HFB090` | 原二维码 | `org_qrcode` | string |  |
| `HFB091` | 变更后二维码 | `changed_qrcode` | string |  |
| `HFB092` | 原自定文字7 | `org_udf_text7` | string |  |
| `HFB093` | 原自定文字8 | `org_udf_text8` | string |  |
| `HFB094` | 原自定文字9 | `org_udf_text_9` | string |  |
| `HFB095` | 原自定文字10 | `org_udf_text10` | string |  |
| `HFB096` | 原自定文字11 | `org_udf_text11` | string |  |
| `HFB097` | 原自定文字12 | `org_udf_text12` | string |  |
| `HFB098` | 原自定文字13 | `org_udf_text13` | string |  |
| `HFB099` | 原自定文字14 | `org_udf_text14` | string |  |
| `HFB100` | 原自定文字15 | `org_udf_text15` | string |  |
| `HFB101` | 原自定文字16 | `org_udf_text16` | string |  |
| `HFB102` | 变更后自定文字7 | `changed_udf_text7` | string |  |
| `HFB103` | 变更后自定文字8 | `changed_udf_text8` | string |  |
| `HFB104` | 变更后自定文字9 | `changed_udf_text9` | string |  |
| `HFB105` | 变更后自定文字10 | `changed_udf_text10` | string |  |
| `HFB106` | 变更后自定文字11 | `changed_udf_text11` | string |  |
| `HFB107` | 变更后自定文字12 | `changed_udf_text12` | string |  |
| `HFB108` | 变更后自定文字13 | `changed_udf_text13` | string |  |
| `HFB109` | 变更后自定文字14 | `changed_udf_text14` | string |  |
| `HFB110` | 变更后自定文字15 | `changed_udf_text15` | string |  |
| `HFB111` | 变更后自定文字16 | `changed_udf_text16` | string |  |
| `HFB112` | 原自定数字7 | `org_udf_no7` | float |  |
| `HFB113` | 原自定数字8 | `org_udf_no8` | float |  |
| `HFB114` | 原自定数字9 | `org_udf_no9` | float |  |
| `HFB115` | 原自定数字10 | `org_udf_no10` | float |  |
| `HFB116` | 原自定数字11 | `org_udf_no11` | float |  |
| `HFB117` | 原自定数字12 | `org_udf_no12` | float |  |
| `HFB118` | 原自定数字13 | `org_udf_no13` | float |  |
| `HFB119` | 原自定数字14 | `org_udf_no14` | float |  |
| `HFB120` | 原自定数字15 | `org_udf_no15` | float |  |
| `HFB121` | 原自定数字16 | `org_udf_no16` | float |  |
| `HFB122` | 变更后自定数字7 | `changed_udf_no7` | float |  |
| `HFB123` | 变更后自定数字8 | `changed_udf_no8` | float |  |
| `HFB124` | 变更后自定数字9 | `changed_udf_no9` | float |  |
| `HFB125` | 变更后自定数字10 | `changed_udf_no10` | float |  |
| `HFB126` | 变更后自定数字11 | `changed_udf_no11` | float |  |
| `HFB127` | 变更后自定数字12 | `changed_udf_no12` | float |  |
| `HFB128` | 变更后自定数字13 | `changed_udf_no13` | float |  |
| `HFB129` | 变更后自定数字14 | `changed_udf_no14` | float |  |
| `HFB130` | 变更后自定数字15 | `changed_udf_no15` | float |  |
| `HFB131` | 变更后自定数字16 | `changed_udf_no16` | float |  |
| `HFB901` | 录入者编号 | `entry_person_no` | string |  |
| `HFB902` | 录入时间 | `entry_time` | string |  |
| `HFB903` | 更改者编号 | `changer_no` | string |  |
| `HFB904` | 更改时间 | `change_time` | string |  |
| `HFB905` | 更新标记 | `update_flag` | integer |  |
| `HFB960` | 自定文字1 | `udf_text1` | string |  |
| `HFB961` | 自定文字2 | `udf_text2` | string |  |
| `HFB962` | 自定文字3 | `udf_text3` | string |  |
| `HFB963` | 自定文字4 | `udf_text4` | string |  |
| `HFB964` | 自定文字5 | `udf_text5` | string |  |
| `HFB965` | 自定文字6 | `udf_text6` | string |  |
| `HFB966` | 自定文字7 | `udf_text7` | string |  |
| `HFB967` | 自定文字8 | `udf_text8` | string |  |
| `HFB968` | 自定文字9 | `udf_text9` | string |  |
| `HFB969` | 自定文字10 | `udf_text10` | string |  |
| `HFB970` | 自定文字11 | `udf_text11` | string |  |
| `HFB971` | 自定文字12 | `udf_text12` | string |  |
| `HFB972` | 自定文字13 | `udf_text13` | string |  |
| `HFB973` | 自定文字14 | `udf_text14` | string |  |
| `HFB974` | 自定文字15 | `udf_text15` | string |  |
| `HFB975` | 自定文字16 | `udf_text16` | string |  |
| `HFB979` | 二维码 | `qr_code` | string |  |
| `HFB980` | 自定数字1 | `udf_no1` | float |  |
| `HFB981` | 自定数字2 | `udf_no2` | float |  |
| `HFB982` | 自定数字3 | `udf_no3` | float |  |
| `HFB983` | 自定数字4 | `udf_no4` | float |  |
| `HFB984` | 自定数字5 | `udf_no5` | float |  |
| `HFB985` | 自定数字6 | `udf_no6` | float |  |
| `HFB986` | 自定数字7 | `udf_no7` | float |  |
| `HFB987` | 自定数字8 | `udf_no8` | float |  |
| `HFB988` | 自定数字9 | `udf_no9` | float |  |
| `HFB989` | 自定数字10 | `udf_no10` | float |  |
| `HFB990` | 自定数字11 | `udf_no11` | float |  |
| `HFB991` | 自定数字12 | `udf_no12` | float |  |
| `HFB992` | 自定数字13 | `udf_no13` | float |  |
| `HFB993` | 自定数字14 | `udf_no14` | float |  |
| `HFB994` | 自定数字15 | `udf_no15` | float |  |
| `HFB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "HFA001": ""
  ,"HFA001": ""
  ,"HFA002": ""
  ,"HFA003": ""
  ,"cdsDetail": [{
    "HFB001": ""
    ,"HFB001": ""
    ,"HFB002": ""
    ,"HFB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"HFA001": "?"}]}
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
| `HFA001` | `docNo` | 单号 | |
| `HFA002` | `change_version` | 变更版本 | |
| `HFA003` | `change_date` | 变更日期 | |
| `HFA004` | `supplier` | 供应商 | |
| `HFA005` | `nature` | 性质 | |
| `HFA006` | `purchaser` | 采购人 | |
| `HFA007` | `dept` | 部门 | |
| `HFA008` | `currency` | 币种 | |
| `HFA009` | `exchange_rate` | 汇率 | |
| `HFA010` | `project_no` | 项目编号 | |
| `HFB001` | `docNo` | 单号 (单身) | |
| `HFB002` | `change_version` | 变更版本 (单身) | |
| `HFB003` | `seq` | 序号 (单身) | |
| `HFB004` | `operation_code` | 操作码 (单身) | |
| `HFB005` | `new_seq` | 新序号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `HFA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `HFA001`
