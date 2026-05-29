# 订单 (sales.order) JSON 节点对照表

## DLL: COPDC02

### 单头表 (DCSIBA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `IBA001` | 单号 | `docNo` | string | 主键 |
| `IBA002` | 性质 | `nature` | string | 必填 |
| `IBA003` | 日期 | `date` | string |  |
| `IBA004` | 客户 | `cust` | string |  |
| `IBA005` | 业务员 | `saleser` | string |  |
| `IBA006` | 部门 | `dept` | string | 必填 |
| `IBA007` | 币种 | `currency` | string | 必填 |
| `IBA008` | 汇率 | `exchange_rate` | float | 必填 |
| `IBA009` | 专案 | `project` | string | 必填 |
| `IBA010` | 送货邮编 | `delivery_postal_code` | string | 必填 |
| `IBA011` | 送货地址 | `delivery_addr` | string | 必填 |
| `IBA012` | 备注 | `remark` | string |  |
| `IBA013` | 复核编号 | `review_no` | string | 必填 |
| `IBA014` | 复核姓名 | `review_name` | string | 必填 |
| `IBA015` | 发票种类 | `invoice_type` | string | 必填 |
| `IBA016` | 税率 | `tax_rate` | float | 必填 |
| `IBA017` | 无税金额 | `amt_excluding_tax` | float | 必填 |
| `IBA018` | 税额 | `tax_amt` | float | 必填 |
| `IBA019` | 本币无税金额 | `amt_in_local_currency_excluding_tax` | float | 必填 |
| `IBA020` | 本币税额 | `domestic_currency_tax_amt` | float | 必填 |
| `IBA021` | 客户单号 | `customer_docNo` | string |  |
| `IBA022` | 审核码 | `approve_status` | string | 必填 |
| `IBA023` | 预留字段 | `reserved_field1` | string | 必填 |
| `IBA024` | 预留字段 | `reserved_field2` | string | 必填 |
| `IBA025` | 订金 | `deposit` | float | 必填 |
| `IBA026` | 订金已开票金额 | `deposit_invoiced_amt` | float |  |
| `IBA027` | 预留字段 | `reserved_field3` | string | 必填 |
| `IBA028` | 预留字段 | `reserved_field4` | string | 必填 |
| `IBA029` | 预留字段 | `reserved_field5` | string | 必填 |
| `IBA030` | 预留字段 | `reserved_field6` | string | 必填 |
| `IBA031` | 预留字段 | `reserved_field7` | string | 必填 |
| `IBA032` | 预留字段 | `reserved_field8` | string | 必填 |
| `IBA033` | 请款客户 | `request_payment_customer` | string | 必填 |
| `IBA034` | 预留字段 | `reserved_field9` | string | 必填 |
| `IBA035` | 预留字段 | `reserved_field10` | string | 必填 |
| `IBA036` | 预留字段 | `reserved_field11` | string | 必填 |
| `IBA037` | 运费 | `freight` | float | 必填 |
| `IBA038` | 折让 | `allowance` | float | 必填 |
| `IBA039` | 预留字段 | `reserved_field12` | string | 必填 |
| `IBA040` | 预留字段 | `reserved_field13` | string | 必填 |
| `IBA041` | 预留字段 | `reserved_field14` | string | 必填 |
| `IBA042` | 预留字段 | `reserved_field15` | string | 必填 |
| `IBA043` | 预留字段 | `reserved_field16` | float | 必填 |
| `IBA044` | 预留字段 | `reserved_field17` | float | 必填 |
| `IBA045` | 审核人 | `auditor` | string |  |
| `IBA046` | 价税合计 | `sum_price_include_tax` | float |  |
| `IBA047` | 本币价税合计 | `total_price_include_tax_in_local_currency` | float |  |
| `IBA048` | 易隆单号 | `yilong_docNo` | string | 必填 |
| `IBA049` | 易隆次单号 | `yilong_subDocNo` | string | 必填 |
| `IBA050` | 订金总额 | `total_deposit_amt` | float |  |
| `IBA051` | 本币订金总额 | `sum_local_currency_deposit_amt` | float |  |
| `IBA052` | 订金已收金额 | `deposit_received_amt` | float |  |
| `IBA053` | 本币订金已收金额 | `local_currency_deposit_received_amt` | float |  |
| `IBA054` | 销售类型 | `sales_type` | string |  |
| `IBA055` | 订金已开票价税合计 | `deposit_invoiced_amt_including_tax` | float |  |
| `IBA056` | 变更版本 | `change_version` | string |  |
| `IBA057` | 变更日期 | `change_date` | string |  |
| `IBA058` | 变更原因 | `reason_for_change` | string |  |
| `IBA059` | 订金已收价税合计 | `sum_deposit_received_include_tax` | float |  |
| `IBA060` | 结账方式描述 | `descpt_of_settlement_way` | string |  |
| `IBA061` | 收款方式描述 | `payment_way_descpt` | string |  |
| `IBA062` | 票期方式描述 | `description_of_bill_date_method` | string |  |
| `IBA063` | 打印次数 | `print_count1` | integer | 必填 |
| `IBA064` | 打印人员 | `printer1` | string | 必填 |
| `IBA065` | 打印时间 | `print_time1` | string | 必填 |
| `IBA901` | 录入者编号 | `entry_person_no` | string |  |
| `IBA902` | 录入时间 | `entry_time` | string |  |
| `IBA903` | 更改者编号 | `changer_no` | string |  |
| `IBA904` | 更改时间 | `change_time` | string |  |
| `IBA905` | 更新标记 | `update_flag` | integer |  |
| `IBA906` | 打印次数 | `print_count2` | integer |  |
| `IBA907` | 打印时间 | `print_time2` | string |  |
| `IBA908` | 打印人员 | `printer2` | string |  |
| `IBA909` | 打印人员姓名 | `printer_name` | string |  |
| `IBA910` | 送审状态 | `submission_status` | string |  |
| `IBA911` | 送审人 | `reviewer` | string |  |
| `IBA912` | 审批人1 | `approver1` | string |  |
| `IBA913` | 审批结果 | `approval_result1` | string |  |
| `IBA914` | 审批意见 | `approval_opinion1` | string |  |
| `IBA915` | 审批人2 | `approver2` | string |  |
| `IBA916` | 审批结果 | `approval_result2` | string |  |
| `IBA917` | 审批意见 | `approval_opinion2` | string |  |
| `IBA918` | 审批人3 | `approver3` | string |  |
| `IBA919` | 审批结果 | `approval_result3` | string |  |
| `IBA920` | 审批意见 | `approval_opinion3` | string |  |
| `IBA921` | 审批人4 | `approver4` | string |  |
| `IBA922` | 审批结果 | `approval_result4` | string |  |
| `IBA923` | 审批意见 | `approval_opinion4` | string |  |
| `IBA924` | 审批人5 | `approver5` | string |  |
| `IBA925` | 审批结果 | `approval_result5` | string |  |
| `IBA926` | 审批意见 | `approval_opinion5` | string |  |
| `IBA927` | 审批人6 | `approver6` | string |  |
| `IBA928` | 审批结果 | `approval_result6` | string |  |
| `IBA929` | 审批意见 | `approval_opinion6` | string |  |
| `IBA930` | 终审人 | `final_approver` | string |  |
| `IBA931` | 审批结果 | `approval_result7` | string |  |
| `IBA932` | 审批意见 | `approval_opinion7` | string |  |
| `IBA933` | 通知人1 | `notifier1` | string |  |
| `IBA934` | 通知人2 | `notifier2` | string |  |
| `IBA935` | 通知人3 | `notifier3` | string |  |
| `IBA940` | 签核码 | `approval_code` | string |  |
| `IBA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `IBA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `IBA950` | 送审时间 | `submission_time_for_review` | string |  |
| `IBA951` | 审批时间1 | `approval_time1` | string |  |
| `IBA952` | 审批时间2 | `approval_time2` | string |  |
| `IBA953` | 审批时间3 | `approval_time3` | string |  |
| `IBA954` | 审批时间4 | `approval_time4` | string |  |
| `IBA955` | 审批时间5 | `approval_time5` | string |  |
| `IBA956` | 审批时间6 | `approval_time6` | string |  |
| `IBA957` | 终审时间 | `final_review_time` | string |  |
| `IBA959` | 审核时间 | `review_time` | string |  |
| `IBA960` | 自定文字1 | `udf_text1` | string |  |
| `IBA961` | 自定文字2 | `udf_text2` | string |  |
| `IBA962` | 自定文字3 | `udf_text3` | string |  |
| `IBA963` | 自定文字4 | `udf_text4` | string |  |
| `IBA964` | 自定文字5 | `udf_text5` | string |  |
| `IBA965` | 自定文字6 | `udf_text6` | string |  |
| `IBA966` | 自定文字7 | `udf_text7` | string |  |
| `IBA967` | 自定文字8 | `udf_text8` | string |  |
| `IBA968` | 自定文字9 | `udf_text9` | string |  |
| `IBA969` | 自定文字10 | `udf_text10` | string |  |
| `IBA970` | 自定文字11 | `udf_text11` | string |  |
| `IBA971` | 自定文字12 | `udf_text12` | string |  |
| `IBA972` | 自定文字13 | `udf_text13` | string |  |
| `IBA973` | 自定文字14 | `udf_text14` | string |  |
| `IBA974` | 自定文字15 | `udf_text15` | string |  |
| `IBA975` | 自定文字16 | `udf_text16` | string |  |
| `IBA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `IBA980` | 自定数字1 | `udf_no1` | float |  |
| `IBA981` | 自定数字2 | `udf_no2` | float |  |
| `IBA982` | 自定数字3 | `udf_no3` | float |  |
| `IBA983` | 自定数字4 | `udf_no4` | float |  |
| `IBA984` | 自定数字5 | `udf_no5` | float |  |
| `IBA985` | 自定数字6 | `udf_no6` | float |  |
| `IBA986` | 自定数字7 | `udf_no7` | float |  |
| `IBA987` | 自定数字8 | `udf_no8` | float |  |
| `IBA988` | 自定数字9 | `udf_no9` | float |  |
| `IBA989` | 自定数字10 | `udf_no10` | float |  |
| `IBA990` | 自定数字11 | `udf_no11` | float |  |
| `IBA991` | 自定数字12 | `udf_no12` | float |  |
| `IBA992` | 自定数字13 | `udf_no13` | float |  |
| `IBA993` | 自定数字14 | `udf_no14` | float |  |
| `IBA994` | 自定数字15 | `udf_no15` | float |  |
| `IBA995` | 自定数字16 | `udf_no16` | float |  |

### 单身表 (DCSIBB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `IBB001` | 单号 | `docNo` | string |  |
| `IBB002` | 序号 | `seq` | string |  |
| `IBB003` | 品号 | `item_no` | string |  |
| `IBB004` | 品名 | `product_name` | string |  |
| `IBB005` | 单位 | `unit` | string |  |
| `IBB006` | 数量 | `qty` | float |  |
| `IBB007` | 定价 | `pricing` | float |  |
| `IBB008` | 折扣率 | `discount_rate` | float |  |
| `IBB009` | 单价 | `unit_price` | float |  |
| `IBB010` | 金额 | `amt` | string |  |
| `IBB011` | 本币金额 | `local_currency_amt` | string |  |
| `IBB012` | 赠品 | `gift` | string |  |
| `IBB013` | 预交货日期 | `predelivery_date` | string |  |
| `IBB014` | 已交量 | `delivered_qty` | float |  |
| `IBB015` | 结束 | `end` | string |  |
| `IBB016` | 前置来源 | `prefix_source` | string |  |
| `IBB017` | 前置单号 | `previous_docNo` | string |  |
| `IBB018` | 前置序号 | `prefix_seq` | string |  |
| `IBB019` | 采买状况 | `purchasing_status` | string |  |
| `IBB020` | 预留字段 | `reserved_field1` | float |  |
| `IBB021` | 原币税额 | `org_currency_tax_amt` | string |  |
| `IBB022` | 本币税额 | `domestic_currency_tax_amt` | string |  |
| `IBB023` | 审核码 | `approve_status` | string |  |
| `IBB024` | 预留字段 | `reserved_field2` | string |  |
| `IBB025` | 预留字段 | `reserved_field3` | string |  |
| `IBB026` | 预留字段 | `reserved_field4` | string |  |
| `IBB027` | 预留字段 | `reserved_field5` | string |  |
| `IBB028` | 预留字段 | `reserved_field6` | string |  |
| `IBB029` | 预留字段 | `reserved_field7` | float |  |
| `IBB030` | 预留字段 | `reserved_field8` | float |  |
| `IBB031` | 含税单价 | `unit_price_including_tax` | float |  |
| `IBB032` | 价税合计 | `sum_price_include_tax` | string |  |
| `IBB033` | 本币价税合计 | `total_price_include_tax_in_local_currency` | string |  |
| `IBB034` | 单价类型 | `unit_price_type` | string |  |
| `IBB035` | 易隆行ID号 | `ylh_id_no` | string |  |
| `IBB036` | 换算分子 | `conversion_numerator` | float |  |
| `IBB037` | 换算分母 | `conversion_denominator` | float |  |
| `IBB038` | 辅助单位 | `auxiliary_unit` | string |  |
| `IBB039` | 辅助数量 | `auxiliary_qty` | float |  |
| `IBB040` | 税率 | `tax_rate` | float |  |
| `IBB041` | 规格 | `specification` | string |  |
| `IBB042` | 工单数量 | `work_order_qty` | float |  |
| `IBB043` | 委外数量 | `subcontract_qty` | float |  |
| `IBB044` | 生产计划量 | `production_plan_qty` | float |  |
| `IBB045` | MRP量 | `mrp` | float |  |
| `IBB046` | 采购底稿量 | `purchasing_draft_qty` | float |  |
| `IBB047` | 指定结束原因 | `specified_end_reason` | string |  |
| `IBB048` | 被赠序号 | `gift_seq` | string |  |
| `IBB049` | 客户品号 | `customer_item_no` | string |  |
| `IBB050` | 客户品名 | `customer_product_name` | string |  |
| `IBB901` | 录入者编号 | `entry_person_no` | string |  |
| `IBB902` | 录入时间 | `entry_time` | string |  |
| `IBB903` | 更改者编号 | `changer_no` | string |  |
| `IBB904` | 更改时间 | `change_time` | string |  |
| `IBB905` | 更新标记 | `update_flag` | integer |  |
| `IBB960` | 自定文字1 | `udf_text1` | string |  |
| `IBB961` | 自定文字2 | `udf_text2` | string |  |
| `IBB962` | 自定文字3 | `udf_text3` | string |  |
| `IBB963` | 自定文字4 | `udf_text4` | string |  |
| `IBB964` | 自定文字5 | `udf_text5` | string |  |
| `IBB965` | 自定文字6 | `udf_text6` | string |  |
| `IBB966` | 自定文字7 | `udf_text7` | string |  |
| `IBB967` | 自定文字8 | `udf_text8` | string |  |
| `IBB968` | 自定文字9 | `udf_text9` | string |  |
| `IBB969` | 自定文字10 | `udf_text10` | string |  |
| `IBB970` | 自定文字11 | `udf_text11` | string |  |
| `IBB971` | 自定文字12 | `udf_text12` | string |  |
| `IBB972` | 自定文字13 | `udf_text13` | string |  |
| `IBB973` | 自定文字14 | `udf_text14` | string |  |
| `IBB974` | 自定文字15 | `udf_text15` | string |  |
| `IBB975` | 自定文字16 | `udf_text16` | string |  |
| `IBB979` | 单身二维码 | `detail_qrcode` | string |  |
| `IBB980` | 自定数字1 | `udf_no1` | float |  |
| `IBB981` | 自定数字2 | `udf_no2` | float |  |
| `IBB982` | 自定数字3 | `udf_no3` | float |  |
| `IBB983` | 自定数字4 | `udf_no4` | float |  |
| `IBB984` | 自定数字5 | `udf_no5` | float |  |
| `IBB985` | 自定数字6 | `udf_no6` | float |  |
| `IBB986` | 自定数字7 | `udf_no7` | float |  |
| `IBB987` | 自定数字8 | `udf_no8` | float |  |
| `IBB988` | 自定数字9 | `udf_no9` | float |  |
| `IBB989` | 自定数字10 | `udf_no10` | float |  |
| `IBB990` | 自定数字11 | `udf_no11` | float |  |
| `IBB991` | 自定数字12 | `udf_no12` | float |  |
| `IBB992` | 自定数字13 | `udf_no13` | float |  |
| `IBB993` | 自定数字14 | `udf_no14` | float |  |
| `IBB994` | 自定数字15 | `udf_no15` | float |  |
| `IBB995` | 自定数字16 | `udf_no16` | float |  |
| `IBB051` | 客户规格 | `IBB051` | string |  |

### 扩展表 (DCSIBC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `IBC001` | 订单单号 | `order_docNo` | string |  |
| `IBC002` | 订单序号 | `order_seq` | string |  |
| `IBC003` | 层级码 | `hierarchy_code` | string |  |
| `IBC004` | 品号 | `item_no` | string |  |
| `IBC005` | 选择码 | `selection_code` | string |  |
| `IBC006` | 数量 | `qty` | float |  |
| `IBC007` | 选配原则 | `opt_selection_principle` | string |  |
| `IBC008` | 主件品号 | `main_item_no` | string |  |
| `IBC009` | 预留字段 | `reserved_field1` | string |  |
| `IBC010` | 预留字段 | `reserved_field2` | string |  |
| `IBC011` | 预留字段 | `reserved_field3` | string |  |
| `IBC012` | 预留字段 | `reserved_field4` | string |  |
| `IBC013` | 预留字段 | `reserved_field5` | float |  |
| `IBC014` | 预留字段 | `reserved_field6` | float |  |
| `IBC015` | 子件规格 | `subitem_specification` | string |  |
| `IBC016` | 主件规格 | `main_component_specification` | string |  |
| `IBC901` | 录入者编号 | `entry_person_no` | string |  |
| `IBC902` | 录入时间 | `entry_time` | string |  |
| `IBC903` | 更改者编号 | `changer_no` | string |  |
| `IBC904` | 更改时间 | `change_time` | string |  |
| `IBC905` | 更新标记 | `update_flag` | integer |  |
| `IBC960` | 自定文字1 | `udf_text1` | string |  |
| `IBC961` | 自定文字2 | `udf_text2` | string |  |
| `IBC962` | 自定文字3 | `udf_text3` | string |  |
| `IBC963` | 自定文字4 | `udf_text4` | string |  |
| `IBC964` | 自定文字5 | `udf_text5` | string |  |
| `IBC965` | 自定文字6 | `udf_text6` | string |  |
| `IBC966` | 自定文字7 | `udf_text7` | string |  |
| `IBC967` | 自定文字8 | `udf_text8` | string |  |
| `IBC968` | 自定文字9 | `udf_text9` | string |  |
| `IBC969` | 自定文字10 | `udf_text10` | string |  |
| `IBC970` | 自定文字11 | `udf_text11` | string |  |
| `IBC971` | 自定文字12 | `udf_text12` | string |  |
| `IBC972` | 自定文字13 | `udf_text13` | string |  |
| `IBC973` | 自定文字14 | `udf_text14` | string |  |
| `IBC974` | 自定文字15 | `udf_text15` | string |  |
| `IBC975` | 自定文字16 | `udf_text16` | string |  |
| `IBC980` | 自定数字1 | `udf_no1` | float |  |
| `IBC981` | 自定数字2 | `udf_no2` | float |  |
| `IBC982` | 自定数字3 | `udf_no3` | float |  |
| `IBC983` | 自定数字4 | `udf_no4` | float |  |
| `IBC984` | 自定数字5 | `udf_no5` | float |  |
| `IBC985` | 自定数字6 | `udf_no6` | float |  |
| `IBC986` | 自定数字7 | `udf_no7` | float |  |
| `IBC987` | 自定数字8 | `udf_no8` | float |  |
| `IBC988` | 自定数字9 | `udf_no9` | float |  |
| `IBC989` | 自定数字10 | `udf_no10` | float |  |
| `IBC990` | 自定数字11 | `udf_no11` | float |  |
| `IBC991` | 自定数字12 | `udf_no12` | float |  |
| `IBC992` | 自定数字13 | `udf_no13` | float |  |
| `IBC993` | 自定数字14 | `udf_no14` | float |  |
| `IBC994` | 自定数字15 | `udf_no15` | float |  |
| `IBC995` | 自定数字16 | `udf_no16` | float |  |
