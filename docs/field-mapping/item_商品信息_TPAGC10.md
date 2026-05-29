# 商品信息 (item) JSON 节点对照表

## DLL: TPAGC10

### 单头表 (TPADEA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DEA001` | 品号 | `item_no` | string | 主键 |
| `DEA002` | 品名 | `product_name` | string |  |
| `DEA003` | 库存单位 | `inventory_unit` | string |  |
| `DEA004` | 条码编号 | `barcode_no` | string |  |
| `DEA005` | 商品分类 | `product_category` | string |  |
| `DEA006` | 会计分类 | `accounting_classification` | string |  |
| `DEA007` | (预留)计算库存 | `calc_inventory` | string |  |
| `DEA008` | 主要仓库 | `main_warehouse` | string |  |
| `DEA009` | 主要来源 | `main_source` | string |  |
| `DEA010` | 主供应商 | `main_supplier` | string |  |
| `DEA011` | 循环盘点码 | `cycle_counting_code` | string |  |
| `DEA012` | 库位 | `inventory_location` | string |  |
| `DEA013` | 注销 | `cancellation` | string |  |
| `DEA014` | 注销日 | `cancellation_date` | string |  |
| `DEA015` | (预留)上次入库日 | `last_inbound_date` | string |  |
| `DEA016` | (预留)上次出库日 | `last_outbound_date` | string |  |
| `DEA017` | 按需求补货 | `replenishment_as_needed` | string |  |
| `DEA018` | 前置天数 | `lead_time_in_days` | integer |  |
| `DEA019` | 安全存量 | `safety_stock` | float |  |
| `DEA020` | 最低补量 | `minimum_replenishment_qty` | float |  |
| `DEA021` | 补货倍量 | `replenishment_multiple` | float |  |
| `DEA022` | 标准进价 | `standard_purchase_price` | float |  |
| `DEA023` | 最近进价(未税) | `recent_purchase_price_without_tax` | float |  |
| `DEA024` | 零售价 | `retail_price` | float |  |
| `DEA025` | 定价一 | `pricing1` | float |  |
| `DEA026` | 定价二 | `pricing2` | float |  |
| `DEA027` | 定价三 | `pricing_tier3` | float |  |
| `DEA028` | 定价四 | `pricing4` | float |  |
| `DEA029` | 低阶码 | `lowlevel_code` | string |  |
| `DEA030` | 领料码 | `material_requisition_code` | string |  |
| `DEA031` | 商品描述 | `product_descpt` | string |  |
| `DEA032` | 税率 | `tax_rate` | float |  |
| `DEA033` | 保税品 | `tax_paid_goods` | string |  |
| `DEA034` | 预留字段 | `reserved_field1` | string |  |
| `DEA035` | 预留字段 | `reserved_field2` | string |  |
| `DEA036` | 快捷码 | `quick_code` | string |  |
| `DEA037` | 备注 | `remarks` | string |  |
| `DEA038` | 预留字段 | `reserved_field3` | string |  |
| `DEA039` | 预留字段 | `reserved_field4` | float |  |
| `DEA040` | 预留字段 | `reserved_field5` | float |  |
| `DEA041` | 预留字段 | `reserved_field6` | float |  |
| `DEA042` | (预留)领用倍量 | `requisition_multiplier` | float |  |
| `DEA043` | 售价含税 | `selling_price_including_tax` | string |  |
| `DEA044` | 采购单位 | `purchasing_unit` | string |  |
| `DEA045` | 工艺路线编号 | `routing_no` | string |  |
| `DEA046` | 最近进价含税 | `is_recent_purchase_price_including_tax` | string |  |
| `DEA047` | 人工分摊权数 | `labor_allocation_weight` | float |  |
| `DEA048` | 制费分摊权数 | `manufacturing_cost_allocation_weight` | float |  |
| `DEA049` | 进价控制 | `purchase_price_control` | string |  |
| `DEA050` | 单价上限 | `upper_limit_of_unit_price` | float |  |
| `DEA051` | 单价上限含税 | `max_unit_price_including_tax` | string |  |
| `DEA052` | 售价控制 | `sales_price_control` | string |  |
| `DEA053` | 单价下限 | `lower_limit_of_unit_price` | float |  |
| `DEA054` | 指定BOM | `bom` | string |  |
| `DEA055` | 批号管理 | `batch_no_management` | string |  |
| `DEA056` | 成本计价方式 | `cost_pricing_way` | string |  |
| `DEA057` | 规格 | `specification` | string |  |
| `DEA058` | 型号 | `model` | string |  |
| `DEA059` | 商品利润率 | `commodity_profit_margin` | float |  |
| `DEA060` | 标准材料 | `standard_material` | float |  |
| `DEA061` | 标准人工 | `standard_labor` | float |  |
| `DEA062` | 标准制费 | `standard_manufacturing_cost` | float |  |
| `DEA063` | 委外加工费 | `outsourced_processing_fee` | float |  |
| `DEA064` | 商品主保修期_年 | `main_warranty_period_of_product` | integer |  |
| `DEA065` | 商品主保修期_月 | `main_warranty_period_of_goods_month` | integer |  |
| `DEA066` | 商品主保修期_天 | `product_main_warranty_period_days` | integer |  |
| `DEA067` | 商品维修保修期_年 | `commodity_repair_and_warranty_period_years` | integer |  |
| `DEA068` | 商品维修保修期_月 | `product_repair_and_warranty_period_months` | integer |  |
| `DEA069` | 商品维修保修期_天 | `product_repair_and_warranty_period__days` | integer |  |
| `DEA070` | 选配属性一 | `opt_attr1` | string |  |
| `DEA071` | 选配属性二 | `opt_attr2` | string |  |
| `DEA072` | 选配属性三 | `opt_attr3` | string |  |
| `DEA073` | 指定主供应商 | `assigned_main_supplier` | string |  |
| `DEA074` | 存货核算 | `inventory_accounting` | string |  |
| `DEA075` | 最近进价(含税) | `recent_purchase_price_including_tax` | float |  |
| `DEA076` | 生产部门 | `production_dept` | string |  |
| `DEA077` | 免检 | `exemption_from_inspection` | string |  |
| `DEA078` | 销售单位 | `sales_unit` | string |  |
| `DEA079` | 条码格式编号 | `barcode_format_no` | string |  |
| `DEA080` | 税收政策 | `tax_policy` | string |  |
| `DEA081` | 开票品名 | `invoice_item_name` | string |  |
| `DEA082` | 开票规格 | `invoicing_specification` | string |  |
| `DEA083` | 超收管控 | `overreceipt_control` | string |  |
| `DEA084` | 超收率 | `overreceipt_rate` | float |  |
| `DEA901` | 录入者编号 | `entry_person_no` | string |  |
| `DEA902` | 录入时间 | `entry_time` | string |  |
| `DEA903` | 更改者编号 | `changer_no` | string |  |
| `DEA904` | 更改时间 | `change_time` | string |  |
| `DEA905` | 更新标记 | `update_flag` | integer |  |
| `DEA906` | 打印次数 | `print_count` | integer |  |
| `DEA907` | 打印时间 | `print_time` | string |  |
| `DEA908` | 打印人员 | `printer` | string |  |
| `DEA909` | 打印人员姓名 | `printer_name` | string |  |
| `DEA960` | 自定文字1 | `udf_text1` | string |  |
| `DEA961` | 自定文字2 | `udf_text2` | string |  |
| `DEA962` | 自定文字3 | `udf_text3` | string |  |
| `DEA963` | 自定文字4 | `udf_text4` | string |  |
| `DEA964` | 自定文字5 | `udf_text5` | string |  |
| `DEA965` | 自定文字6 | `udf_text6` | string |  |
| `DEA966` | 自定文字7 | `udf_text7` | string |  |
| `DEA967` | 自定文字8 | `udf_text8` | string |  |
| `DEA968` | 自定文字9 | `udf_text9` | string |  |
| `DEA969` | 自定文字10 | `udf_text10` | string |  |
| `DEA970` | 自定文字11 | `udf_text11` | string |  |
| `DEA971` | 自定文字12 | `udf_text12` | string |  |
| `DEA972` | 自定文字13 | `udf_text13` | string |  |
| `DEA973` | 自定文字14 | `udf_text14` | string |  |
| `DEA974` | 自定文字15 | `udf_text15` | string |  |
| `DEA975` | 自定文字16 | `udf_text16` | string |  |
| `DEA979` | 二维码 | `qr_code_on_doc_header` | string |  |
| `DEA980` | 自定数字1 | `udf_no1` | float |  |
| `DEA981` | 自定数字2 | `udf_no2` | float |  |
| `DEA982` | 自定数字3 | `udf_no3` | float |  |
| `DEA983` | 自定数字4 | `udf_no4` | float |  |
| `DEA984` | 自定数字5 | `udf_no5` | float |  |
| `DEA985` | 自定数字6 | `udf_no6` | float |  |
| `DEA986` | 自定数字7 | `udf_no7` | float |  |
| `DEA987` | 自定数字8 | `udf_no8` | float |  |
| `DEA988` | 自定数字9 | `udf_no9` | float |  |
| `DEA989` | 自定数字10 | `udf_no10` | float |  |
| `DEA990` | 自定数字11 | `udf_no11` | float |  |
| `DEA991` | 自定数字12 | `udf_no12` | float |  |
| `DEA992` | 自定数字13 | `udf_no13` | float |  |
| `DEA993` | 自定数字14 | `udf_no14` | float |  |
| `DEA994` | 自定数字15 | `udf_no15` | float |  |
| `DEA995` | 自定数字16 | `udf_no16` | float |  |

### 单身表 (TPADEB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DEB001` | 品号 | `DEB001` | string | 主键 |
| `DEB002` | 图档 | `DEB002` | string |  |
| `DEB003` | 图档类型 | `DEB003` | string |  |
| `DEB901` | 录入者编号 | `entry_person_no` | string |  |
| `DEB902` | 录入时间 | `entry_time` | string |  |
| `DEB903` | 更改者编号 | `changer_no` | string |  |
| `DEB904` | 更改时间 | `change_time` | string |  |
| `DEB905` | 更新标记 | `update_flag` | integer |  |

### 扩展表 (TPADEC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DEC001` | 品号 | `DEC001` | string |  |
| `DEC002` | 换算单位 | `DEC002` | string |  |
| `DEC003` | 换算分子 | `DEC003` | float |  |
| `DEC004` | 换算分母 | `DEC004` | float |  |
| `DEC005` | 预留字段 | `DEC005` | float |  |
| `DEC006` | 预留字段 | `DEC006` | string |  |
| `DEC007` | 是否固定比率 | `DEC007` | string |  |
| `DEC901` | 录入者编号 | `entry_person_no` | string |  |
| `DEC902` | 录入时间 | `entry_time` | string |  |
| `DEC903` | 更改者编号 | `changer_no` | string |  |
| `DEC904` | 更改时间 | `change_time` | string |  |
| `DEC905` | 更新标记 | `update_flag` | integer |  |
