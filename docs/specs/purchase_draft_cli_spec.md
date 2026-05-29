# CLI 规格说明书：采购底稿单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `purchase.draft` |
| **DLL** | `PURCC03` |
| **服务名称** | `采购底稿单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.draft" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.draft" \
  --action "getMultiple" \
  --data '{"datakeys":[{"HCA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.draft" \
  --action "create" \
  --data '{"HCA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.draft" \
  --action "approve" \
  --data '{"datakeys":[{"HCA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `HCA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (DCSHCA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HCA001` | 单号 | `docNo` | string | 主键 |
| `HCA002` | 性质 | `nature` | string |  |
| `HCA003` | 日期 | `date` | string |  |
| `HCA004` | 采购人 | `purchaser` | string |  |
| `HCA005` | 部门 | `dept` | string |  |
| `HCA006` | 专案 | `project` | string |  |
| `HCA007` | 送货邮编 | `delivery_postal_code` | string |  |
| `HCA008` | 送货地址 | `delivery_addr` | string |  |
| `HCA009` | 备注 | `remarks` | string |  |
| `HCA010` | 复核 | `review` | string |  |
| `HCA011` | 复核姓名 | `review_name` | string |  |
| `HCA012` | 金额合计 | `total_amt` | float |  |
| `HCA013` | 预留字段 | `reserved_field1` | float |  |
| `HCA014` | 审核码 | `approve_status` | string |  |
| `HCA015` | 运费 | `freight` | float |  |
| `HCA016` | 折让 | `allowance` | float |  |
| `HCA017` | 预留字段 | `reserved_field2` | string |  |
| `HCA018` | 预留字段 | `reserved_field3` | string |  |
| `HCA019` | 预留字段 | `reserved_field4` | string |  |
| `HCA020` | 预留字段 | `reserved_field5` | string |  |
| `HCA021` | 预留字段 | `reserved_field6` | float |  |
| `HCA022` | 预留字段 | `reserved_field7` | float |  |
| `HCA023` | 预留字段 | `reserved_field8` | string |  |
| `HCA024` | 审核人 | `auditor` | string |  |
| `HCA901` | 录入者编号 | `entry_person_no` | string |  |
| `HCA902` | 录入时间 | `entry_time` | string |  |
| `HCA903` | 更改者编号 | `changer_no` | string |  |
| `HCA904` | 更改时间 | `change_time` | string |  |
| `HCA905` | 更新标记 | `update_flag` | integer |  |
| `HCA906` | 打印次数 | `print_count` | integer |  |
| `HCA907` | 打印时间 | `print_time` | string |  |
| `HCA908` | 打印人员 | `printer` | string |  |
| `HCA909` | 打印人员姓名 | `printer_name` | string |  |
| `HCA910` | 送审状态 | `submission_status` | string |  |
| `HCA911` | 送审人 | `reviewer` | string |  |
| `HCA912` | 审批人1 | `approver1` | string |  |
| `HCA913` | 审批结果 | `approval_result1` | string |  |
| `HCA914` | 审批意见 | `approval_opinion1` | string |  |
| `HCA915` | 审批人2 | `approver2` | string |  |
| `HCA916` | 审批结果 | `approval_result2` | string |  |
| `HCA917` | 审批意见 | `approval_opinion2` | string |  |
| `HCA918` | 审批人3 | `approver3` | string |  |
| `HCA919` | 审批结果 | `approval_result3` | string |  |
| `HCA920` | 审批意见 | `approval_opinion3` | string |  |
| `HCA921` | 审批人4 | `approver4` | string |  |
| `HCA922` | 审批结果 | `approval_result4` | string |  |
| `HCA923` | 审批意见 | `approval_opinion4` | string |  |
| `HCA924` | 审批人5 | `approver5` | string |  |
| `HCA925` | 审批结果 | `approval_result5` | string |  |
| `HCA926` | 审批意见 | `approval_opinion5` | string |  |
| `HCA927` | 审批人6 | `approver6` | string |  |
| `HCA928` | 审批结果 | `approval_result6` | string |  |
| `HCA929` | 审批意见 | `approval_opinion6` | string |  |
| `HCA930` | 终审人 | `final_approver` | string |  |
| `HCA931` | 审批结果 | `approval_result7` | string |  |
| `HCA932` | 审批意见 | `approval_opinion7` | string |  |
| `HCA933` | 通知人1 | `notifier1` | string |  |
| `HCA934` | 通知人2 | `notifier2` | string |  |
| `HCA935` | 通知人3 | `notifier3` | string |  |
| `HCA940` | 签核码 | `approval_code` | string |  |
| `HCA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `HCA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `HCA950` | 送审时间 | `submission_time_for_review` | string |  |
| `HCA951` | 审批时间1 | `approval_time1` | string |  |
| `HCA952` | 审批时间2 | `approval_time2` | string |  |
| `HCA953` | 审批时间3 | `approval_time3` | string |  |
| `HCA954` | 审批时间4 | `approval_time4` | string |  |
| `HCA955` | 审批时间5 | `approval_time5` | string |  |
| `HCA956` | 审批时间6 | `approval_time6` | string |  |
| `HCA957` | 终审时间 | `final_review_time` | string |  |
| `HCA959` | 审核时间 | `review_time` | string |  |
| `HCA960` | 自定文字1 | `udf_text1` | string |  |
| `HCA961` | 自定文字2 | `udf_text2` | string |  |
| `HCA962` | 自定文字3 | `udf_text3` | string |  |
| `HCA963` | 自定文字4 | `udf_text4` | string |  |
| `HCA964` | 自定文字5 | `udf_text5` | string |  |
| `HCA965` | 自定文字6 | `udf_text6` | string |  |
| `HCA966` | 自定文字7 | `udf_text7` | string |  |
| `HCA967` | 自定文字8 | `udf_text8` | string |  |
| `HCA968` | 自定文字9 | `udf_text9` | string |  |
| `HCA969` | 自定文字10 | `udf_text10` | string |  |
| `HCA970` | 自定文字11 | `udf_text11` | string |  |
| `HCA971` | 自定文字12 | `udf_text12` | string |  |
| `HCA972` | 自定文字13 | `udf_text13` | string |  |
| `HCA973` | 自定文字14 | `udf_text14` | string |  |
| `HCA974` | 自定文字15 | `udf_text15` | string |  |
| `HCA975` | 自定文字16 | `udf_text16` | string |  |
| `HCA980` | 自定数字1 | `udf_no1` | float |  |
| `HCA981` | 自定数字2 | `udf_no2` | float |  |
| `HCA982` | 自定数字3 | `udf_no3` | float |  |
| `HCA983` | 自定数字4 | `udf_no4` | float |  |
| `HCA984` | 自定数字5 | `udf_no5` | float |  |
| `HCA985` | 自定数字6 | `udf_no6` | float |  |
| `HCA986` | 自定数字7 | `udf_no7` | float |  |
| `HCA987` | 自定数字8 | `udf_no8` | float |  |
| `HCA988` | 自定数字9 | `udf_no9` | float |  |
| `HCA989` | 自定数字10 | `udf_no10` | float |  |
| `HCA990` | 自定数字11 | `udf_no11` | float |  |
| `HCA991` | 自定数字12 | `udf_no12` | float |  |
| `HCA992` | 自定数字13 | `udf_no13` | float |  |
| `HCA993` | 自定数字14 | `udf_no14` | float |  |
| `HCA994` | 自定数字15 | `udf_no15` | float |  |
| `HCA995` | 自定数字16 | `udf_no16` | float |  |

### 3.2 单身表 (DCSHCB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HCB001` | 单号 | `docNo` | string |  |
| `HCB002` | 序号 | `seq` | string |  |
| `HCB003` | 品号 | `item_no` | string |  |
| `HCB004` | 品名 | `product_name` | string |  |
| `HCB005` | 单位 | `unit` | string |  |
| `HCB006` | 数量 | `qty` | float |  |
| `HCB007` | 单价 | `unit_price` | float |  |
| `HCB008` | 金额 | `amt` | string |  |
| `HCB009` | 预留字段 | `reserved_field1` | string |  |
| `HCB010` | 预交货日期 | `predelivery_date` | string |  |
| `HCB011` | 赠品 | `gift` | string |  |
| `HCB012` | 供应商 | `supplier` | string |  |
| `HCB013` | 币种 | `currency` | string |  |
| `HCB014` | 预留字段 | `reserved_field2` | string |  |
| `HCB015` | 采购状况 | `purchase_status` | string |  |
| `HCB016` | 前置来源 | `prefix_source` | string |  |
| `HCB017` | 前置单据 | `previous_doc` | string |  |
| `HCB018` | 前置序号 | `prefix_seq` | string |  |
| `HCB019` | 展组合品 | `exhibition_combined_product` | string |  |
| `HCB020` | 审核码 | `approve_status` | string |  |
| `HCB021` | 预留字段 | `reserved_field3` | float |  |
| `HCB022` | 预留字段 | `reserved_field4` | string |  |
| `HCB023` | 预留字段 | `reserved_field5` | string |  |
| `HCB024` | 发放方式 | `distribution_way` | string |  |
| `HCB025` | 预留字段 | `reserved_field6` | string |  |
| `HCB026` | 预留字段 | `reserved_field7` | string |  |
| `HCB027` | 预留字段 | `reserved_field8` | string |  |
| `HCB028` | 子件需求量 | `subcomponent_demand_qty` | float |  |
| `HCB029` | 预留字段 | `reserved_field9` | float |  |
| `HCB030` | 预留字段 | `reserved_field10` | string |  |
| `HCB031` | 含税 | `include_tax` | string |  |
| `HCB032` | 税率 | `tax_rate` | float |  |
| `HCB033` | 含税单价 | `unit_price_including_tax` | float |  |
| `HCB034` | 税额 | `tax_amt` | string |  |
| `HCB035` | 价税合计 | `sum_price_include_tax` | string |  |
| `HCB036` | 采购单位 | `purchasing_unit` | string |  |
| `HCB037` | 采购数量 | `purchase_qty` | float |  |
| `HCB038` | 换算分子 | `conversion_numerator` | float |  |
| `HCB039` | 换算分母 | `conversion_denominator` | float |  |
| `HCB040` | 规格 | `specification` | string |  |
| `HCB041` | 已交辅助量 | `submitted_auxiliary_qty` | float |  |
| `HCB042` | 结束码 | `ending_code` | string |  |
| `HCB043` | 指定结束原因 | `specified_end_reason` | string |  |
| `HCB901` | 录入者编号 | `entry_person_no` | string |  |
| `HCB902` | 录入时间 | `entry_time` | string |  |
| `HCB903` | 更改者编号 | `changer_no` | string |  |
| `HCB904` | 更改时间 | `change_time` | string |  |
| `HCB905` | 更新标记 | `update_flag` | integer |  |
| `HCB960` | 自定文字1 | `udf_text1` | string |  |
| `HCB961` | 自定文字2 | `udf_text2` | string |  |
| `HCB962` | 自定文字3 | `udf_text3` | string |  |
| `HCB963` | 自定文字4 | `udf_text4` | string |  |
| `HCB964` | 自定文字5 | `udf_text5` | string |  |
| `HCB965` | 自定文字6 | `udf_text6` | string |  |
| `HCB966` | 自定文字7 | `udf_text7` | string |  |
| `HCB967` | 自定文字8 | `udf_text8` | string |  |
| `HCB968` | 自定文字9 | `udf_text9` | string |  |
| `HCB969` | 自定文字10 | `udf_text10` | string |  |
| `HCB970` | 自定文字11 | `udf_text11` | string |  |
| `HCB971` | 自定文字12 | `udf_text12` | string |  |
| `HCB972` | 自定文字13 | `udf_text13` | string |  |
| `HCB973` | 自定文字14 | `udf_text14` | string |  |
| `HCB974` | 自定文字15 | `udf_text15` | string |  |
| `HCB975` | 自定文字16 | `udf_text16` | string |  |
| `HCB980` | 自定数字1 | `udf_no1` | float |  |
| `HCB981` | 自定数字2 | `udf_no2` | float |  |
| `HCB982` | 自定数字3 | `udf_no3` | float |  |
| `HCB983` | 自定数字4 | `udf_no4` | float |  |
| `HCB984` | 自定数字5 | `udf_no5` | float |  |
| `HCB985` | 自定数字6 | `udf_no6` | float |  |
| `HCB986` | 自定数字7 | `udf_no7` | float |  |
| `HCB987` | 自定数字8 | `udf_no8` | float |  |
| `HCB988` | 自定数字9 | `udf_no9` | float |  |
| `HCB989` | 自定数字10 | `udf_no10` | float |  |
| `HCB990` | 自定数字11 | `udf_no11` | float |  |
| `HCB991` | 自定数字12 | `udf_no12` | float |  |
| `HCB992` | 自定数字13 | `udf_no13` | float |  |
| `HCB993` | 自定数字14 | `udf_no14` | float |  |
| `HCB994` | 自定数字15 | `udf_no15` | float |  |
| `HCB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (DCSHCC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HCC001` | 底稿单号 | `draft_docNo` | string |  |
| `HCC002` | 底稿序号 | `draft_seq` | string |  |
| `HCC003` | 前置来源 | `prefix_source` | string |  |
| `HCC004` | 前置单据 | `previous_doc` | string |  |
| `HCC005` | 前置序号 | `prefix_seq` | string |  |
| `HCC006` | 品号 | `item_no` | string |  |
| `HCC007` | 品名 | `product_name` | string |  |
| `HCC008` | 直接底稿量 | `direct_draft_qty` | float |  |
| `HCC009` | 预留字段 | `reserved_field1` | string |  |
| `HCC010` | 预留字段 | `reserved_field2` | string |  |
| `HCC011` | 预留字段 | `reserved_field3` | string |  |
| `HCC012` | 预留字段 | `reserved_field4` | string |  |
| `HCC013` | 预留字段 | `reserved_field5` | float |  |
| `HCC014` | 预留字段 | `reserved_field6` | float |  |
| `HCC901` | 录入者编号 | `entry_person_no` | string |  |
| `HCC902` | 录入者时间 | `entry_time_by_recorder` | string |  |
| `HCC903` | 更改者编号 | `changer_no` | string |  |
| `HCC904` | 更改时间 | `change_time` | string |  |
| `HCC905` | 更新标记 | `update_flag` | integer |  |
| `HCC960` | 自定义文字1 | `udf_text1` | string |  |
| `HCC961` | 自定义文字2 | `udf_text2` | string |  |
| `HCC962` | 自定义文字3 | `udf_text3` | string |  |
| `HCC963` | 自定义文字4 | `udf_text4` | string |  |
| `HCC964` | 自定义文字5 | `udf_text5` | string |  |
| `HCC965` | 自定义文字6 | `udf_text6` | string |  |
| `HCC966` | 自定文字7 | `udf_text7` | string |  |
| `HCC967` | 自定文字8 | `udf_text8` | string |  |
| `HCC968` | 自定文字9 | `udf_text9` | string |  |
| `HCC969` | 自定文字10 | `udf_text10` | string |  |
| `HCC970` | 自定文字11 | `udf_text11` | string |  |
| `HCC971` | 自定文字12 | `udf_text12` | string |  |
| `HCC972` | 自定文字13 | `udf_text13` | string |  |
| `HCC973` | 自定文字14 | `udf_text14` | string |  |
| `HCC974` | 自定文字15 | `udf_text15` | string |  |
| `HCC975` | 自定文字16 | `udf_text16` | string |  |
| `HCC980` | 自定义数字1 | `udf_no1` | float |  |
| `HCC981` | 自定义数字2 | `udf_no2` | float |  |
| `HCC982` | 自定义数字3 | `udf_no3` | float |  |
| `HCC983` | 自定义数字4 | `udf_no4` | float |  |
| `HCC984` | 自定义数字5 | `udf_no5` | float |  |
| `HCC985` | 自定义数字6 | `udf_no6` | float |  |
| `HCC986` | 自定数字7 | `udf_no7` | float |  |
| `HCC987` | 自定数字8 | `udf_no8` | float |  |
| `HCC988` | 自定数字9 | `udf_no9` | float |  |
| `HCC989` | 自定数字10 | `udf_no10` | float |  |
| `HCC990` | 自定数字11 | `udf_no11` | float |  |
| `HCC991` | 自定数字12 | `udf_no12` | float |  |
| `HCC992` | 自定数字13 | `udf_no13` | float |  |
| `HCC993` | 自定数字14 | `udf_no14` | float |  |
| `HCC994` | 自定数字15 | `udf_no15` | float |  |
| `HCC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "HCA001": ""
  ,"HCA002": ""
  ,"HCA003": ""
  ,"HCA004": ""
  ,"cdsDetail": [{
    "HCB001": ""
    ,"HCB001": ""
    ,"HCB002": ""
    ,"HCB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"HCA001": "?"}]}
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
| `HCA001` | `docNo` | 单号 | 主键 |
| `HCA002` | `nature` | 性质 | |
| `HCA003` | `date` | 日期 | |
| `HCA004` | `purchaser` | 采购人 | |
| `HCA005` | `dept` | 部门 | |
| `HCA006` | `project` | 专案 | |
| `HCA007` | `delivery_postal_code` | 送货邮编 | |
| `HCA008` | `delivery_addr` | 送货地址 | |
| `HCA009` | `remarks` | 备注 | |
| `HCA010` | `review` | 复核 | |
| `HCB001` | `docNo` | 单号 (单身) | |
| `HCB002` | `seq` | 序号 (单身) | |
| `HCB003` | `item_no` | 品号 (单身) | |
| `HCB004` | `product_name` | 品名 (单身) | |
| `HCB005` | `unit` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `HCA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `HCA001`
