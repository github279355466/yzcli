# CLI 规格说明书：核价单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `approve.price` |
| **DLL** | `PURCC05` |
| **服务名称** | `核价单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "approve.price" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "approve.price" \
  --action "getMultiple" \
  --data '{"datakeys":[{"HEA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "approve.price" \
  --action "create" \
  --data '{"HEA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "approve.price" \
  --action "approve" \
  --data '{"datakeys":[{"HEA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `HEA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (DCSHEA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HEA001` | 单号 | `docNo` | string | 主键 |
| `HEA002` | 性质 | `nature` | string |  |
| `HEA003` | 日期 | `date` | string |  |
| `HEA004` | 品号 | `item_no` | string |  |
| `HEA005` | 品名 | `product_name` | string |  |
| `HEA006` | 审核码 | `approve_status` | string |  |
| `HEA007` | 备注 | `remarks` | string |  |
| `HEA008` | 审核人 | `auditor` | string |  |
| `HEA009` | 主供应商 | `main_supplier` | string |  |
| `HEA010` | 原主供应商 | `org_main_supplier` | string |  |
| `HEA011` | 最低单价 | `minimum_unit_price` | float |  |
| `HEA012` | 最低供应商 | `lowest_supplier` | string |  |
| `HEA013` | 单位 | `unit` | string |  |
| `HEA014` | 预留字段 | `reserved_field1` | string |  |
| `HEA015` | 预留字段 | `reserved_field2` | string |  |
| `HEA016` | 预留字段 | `reserved_field3` | string |  |
| `HEA017` | 预留字段 | `reserved_field4` | string |  |
| `HEA018` | 预留字段 | `reserved_field5` | float |  |
| `HEA019` | 预留字段 | `reserved_field6` | float |  |
| `HEA024` | 规格 | `specification` | string |  |
| `HEA901` | 录入者编号 | `entry_person_no` | string |  |
| `HEA902` | 录入时间 | `entry_time` | string |  |
| `HEA903` | 更改者编号 | `changer_no` | string |  |
| `HEA904` | 更改时间 | `change_time` | string |  |
| `HEA905` | 更新标记 | `update_flag` | integer |  |
| `HEA906` | 打印次数 | `print_count` | integer |  |
| `HEA907` | 打印时间 | `print_time` | string |  |
| `HEA908` | 打印人员 | `printer` | string |  |
| `HEA909` | 打印人员姓名 | `printer_name` | string |  |
| `HEA910` | 送审状态 | `submission_status` | string |  |
| `HEA911` | 送审人 | `reviewer` | string |  |
| `HEA912` | 审批人1 | `approver1` | string |  |
| `HEA913` | 审批结果 | `approval_result1` | string |  |
| `HEA914` | 审批意见 | `approval_opinion1` | string |  |
| `HEA915` | 审批人2 | `approver2` | string |  |
| `HEA916` | 审批结果 | `approval_result2` | string |  |
| `HEA917` | 审批意见 | `approval_opinion2` | string |  |
| `HEA918` | 审批人3 | `approver3` | string |  |
| `HEA919` | 审批结果 | `approval_result3` | string |  |
| `HEA920` | 审批意见 | `approval_opinion3` | string |  |
| `HEA921` | 审批人4 | `approver4` | string |  |
| `HEA922` | 审批结果 | `approval_result4` | string |  |
| `HEA923` | 审批意见 | `approval_opinion4` | string |  |
| `HEA924` | 审批人5 | `approver5` | string |  |
| `HEA925` | 审批结果 | `approval_result5` | string |  |
| `HEA926` | 审批意见 | `approval_opinion5` | string |  |
| `HEA927` | 审批人6 | `approver6` | string |  |
| `HEA928` | 审批结果 | `approval_result6` | string |  |
| `HEA929` | 审批意见 | `approval_opinion6` | string |  |
| `HEA930` | 终审人 | `final_approver` | string |  |
| `HEA931` | 审批结果 | `approval_result7` | string |  |
| `HEA932` | 审批意见 | `approval_opinion7` | string |  |
| `HEA933` | 通知人1 | `notifier1` | string |  |
| `HEA934` | 通知人2 | `notifier2` | string |  |
| `HEA935` | 通知人3 | `notifier3` | string |  |
| `HEA940` | 签核码 | `approval_code` | string |  |
| `HEA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `HEA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `HEA950` | 送审时间 | `submission_time_for_review` | string |  |
| `HEA951` | 审批时间1 | `approval_time1` | string |  |
| `HEA952` | 审批时间2 | `approval_time2` | string |  |
| `HEA953` | 审批时间3 | `approval_time3` | string |  |
| `HEA954` | 审批时间4 | `approval_time4` | string |  |
| `HEA955` | 审批时间5 | `approval_time5` | string |  |
| `HEA956` | 审批时间6 | `approval_time6` | string |  |
| `HEA957` | 终审时间 | `final_review_time` | string |  |
| `HEA959` | 审核时间 | `review_time` | string |  |
| `HEA960` | 自定文字1 | `udf_text1` | string |  |
| `HEA961` | 自定文字2 | `udf_text2` | string |  |
| `HEA962` | 自定文字3 | `udf_text3` | string |  |
| `HEA963` | 自定文字4 | `udf_text4` | string |  |
| `HEA964` | 自定文字5 | `udf_text5` | string |  |
| `HEA965` | 自定文字6 | `udf_text6` | string |  |
| `HEA966` | 自定文字7 | `udf_text7` | string |  |
| `HEA967` | 自定文字8 | `udf_text8` | string |  |
| `HEA968` | 自定文字9 | `udf_text9` | string |  |
| `HEA969` | 自定文字10 | `udf_text10` | string |  |
| `HEA970` | 自定文字11 | `udf_text11` | string |  |
| `HEA971` | 自定文字12 | `udf_text12` | string |  |
| `HEA972` | 自定文字13 | `udf_text13` | string |  |
| `HEA973` | 自定文字14 | `udf_text14` | string |  |
| `HEA974` | 自定文字15 | `udf_text15` | string |  |
| `HEA975` | 自定文字16 | `udf_text16` | string |  |
| `HEA980` | 自定数字1 | `udf_no1` | float |  |
| `HEA981` | 自定数字2 | `udf_no2` | float |  |
| `HEA982` | 自定数字3 | `udf_no3` | float |  |
| `HEA983` | 自定数字4 | `udf_no4` | float |  |
| `HEA984` | 自定数字5 | `udf_no5` | float |  |
| `HEA985` | 自定数字6 | `udf_no6` | float |  |
| `HEA986` | 自定数字7 | `udf_no7` | float |  |
| `HEA987` | 自定数字8 | `udf_no8` | float |  |
| `HEA988` | 自定数字9 | `udf_no9` | float |  |
| `HEA989` | 自定数字10 | `udf_no10` | float |  |
| `HEA990` | 自定数字11 | `udf_no11` | float |  |
| `HEA991` | 自定数字12 | `udf_no12` | float |  |
| `HEA992` | 自定数字13 | `udf_no13` | float |  |
| `HEA993` | 自定数字14 | `udf_no14` | float |  |
| `HEA994` | 自定数字15 | `udf_no15` | float |  |
| `HEA995` | 自定数字16 | `udf_no16` | float |  |

### 3.2 单身表 (DCSHEB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HEB001` | 单号 | `docNo` | string |  |
| `HEB002` | 单身序号 | `detail_seq` | string |  |
| `HEB003` | 供应商编号 | `supplier_no` | string |  |
| `HEB004` | 供应商简称 | `supplier_abbreviation` | string |  |
| `HEB005` | 币种 | `currency` | string |  |
| `HEB006` | 单价 | `unit_price` | float |  |
| `HEB007` | 审核码 | `approve_status` | string |  |
| `HEB008` | 选定码 | `selected_code` | string |  |
| `HEB009` | 含税单价 | `unit_price_including_tax` | float |  |
| `HEB010` | 含税 | `include_tax` | string |  |
| `HEB011` | 备注 | `remarks` | string |  |
| `HEB012` | 本币未税单价 | `local_currency_unit_price_excluding_tax` | float |  |
| `HEB013` | 汇率 | `exchange_rate` | float |  |
| `HEB014` | 税率 | `tax_rate` | float |  |
| `HEB015` | 预留字段 | `reserved_field1` | string |  |
| `HEB016` | 预留字段 | `reserved_field2` | string |  |
| `HEB017` | 预留字段 | `reserved_field3` | string |  |
| `HEB018` | 预留字段 | `reserved_field4` | string |  |
| `HEB019` | 预留字段 | `reserved_field5` | float |  |
| `HEB020` | 预留字段 | `reserved_field6` | float |  |
| `HEB021` | 序号 | `seq` | string |  |
| `HEB901` | 录入者编号 | `entry_person_no` | string |  |
| `HEB902` | 录入时间 | `entry_time` | string |  |
| `HEB903` | 更改者编号 | `changer_no` | string |  |
| `HEB904` | 更改时间 | `change_time` | string |  |
| `HEB905` | 更新标记 | `update_flag` | integer |  |
| `HEB960` | 自定文字1 | `udf_text1` | string |  |
| `HEB961` | 自定文字2 | `udf_text2` | string |  |
| `HEB962` | 自定文字3 | `udf_text3` | string |  |
| `HEB963` | 自定文字4 | `udf_text4` | string |  |
| `HEB964` | 自定文字5 | `udf_text5` | string |  |
| `HEB965` | 自定文字6 | `udf_text6` | string |  |
| `HEB966` | 自定文字7 | `udf_text7` | string |  |
| `HEB967` | 自定文字8 | `udf_text8` | string |  |
| `HEB968` | 自定文字9 | `udf_text9` | string |  |
| `HEB969` | 自定文字10 | `udf_text10` | string |  |
| `HEB970` | 自定文字11 | `udf_text11` | string |  |
| `HEB971` | 自定文字12 | `udf_text12` | string |  |
| `HEB972` | 自定文字13 | `udf_text13` | string |  |
| `HEB973` | 自定文字14 | `udf_text14` | string |  |
| `HEB974` | 自定文字15 | `udf_text15` | string |  |
| `HEB975` | 自定文字16 | `udf_text16` | string |  |
| `HEB980` | 自定数字1 | `udf_no1` | float |  |
| `HEB981` | 自定数字2 | `udf_no2` | float |  |
| `HEB982` | 自定数字3 | `udf_no3` | float |  |
| `HEB983` | 自定数字4 | `udf_no4` | float |  |
| `HEB984` | 自定数字5 | `udf_no5` | float |  |
| `HEB985` | 自定数字6 | `udf_no6` | float |  |
| `HEB986` | 自定数字7 | `udf_no7` | float |  |
| `HEB987` | 自定数字8 | `udf_no8` | float |  |
| `HEB988` | 自定数字9 | `udf_no9` | float |  |
| `HEB989` | 自定数字10 | `udf_no10` | float |  |
| `HEB990` | 自定数字11 | `udf_no11` | float |  |
| `HEB991` | 自定数字12 | `udf_no12` | float |  |
| `HEB992` | 自定数字13 | `udf_no13` | float |  |
| `HEB993` | 自定数字14 | `udf_no14` | float |  |
| `HEB994` | 自定数字15 | `udf_no15` | float |  |
| `HEB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (DCSHEC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HEC001` | 单号 | `docNo` | string |  |
| `HEC002` | 序号 | `seq` | string |  |
| `HEC003` | 品号 | `item_no` | string |  |
| `HEC004` | 品名 | `product_name` | string |  |
| `HEC005` | 规格 | `specification` | string |  |
| `HEC006` | 主供应商 | `main_supplier` | string |  |
| `HEC007` | 原主供应商 | `org_main_supplier` | string |  |
| `HEC008` | 最低单价 | `minimum_unit_price` | float |  |
| `HEC009` | 最低供应商 | `lowest_supplier` | string |  |
| `HEC010` | 单位 | `unit` | string |  |
| `HEC011` | 备注 | `remarks` | string |  |
| `HEC012` | 预留字段 | `reserved_field1` | string |  |
| `HEC013` | 预留字段 | `reserved_field2` | string |  |
| `HEC014` | 预留字段 | `reserved_field3` | string |  |
| `HEC015` | 预留字段 | `reserved_field4` | string |  |
| `HEC016` | 预留字段 | `reserved_field5` | float |  |
| `HEC017` | 预留字段 | `reserved_field6` | float |  |
| `HEC901` | 录入者编号 | `entry_person_no` | string |  |
| `HEC902` | 录入时间 | `entry_time` | string |  |
| `HEC903` | 更改者编号 | `changer_no` | string |  |
| `HEC904` | 更改时间 | `change_time` | string |  |
| `HEC905` | 更新标记 | `update_flag` | integer |  |
| `HEC960` | 自定文字1 | `udf_text1` | string |  |
| `HEC961` | 自定文字2 | `udf_text2` | string |  |
| `HEC962` | 自定文字3 | `udf_text3` | string |  |
| `HEC963` | 自定文字4 | `udf_text4` | string |  |
| `HEC964` | 自定文字5 | `udf_text5` | string |  |
| `HEC965` | 自定文字6 | `udf_text6` | string |  |
| `HEC966` | 自定文字7 | `udf_text7` | string |  |
| `HEC967` | 自定文字8 | `udf_text8` | string |  |
| `HEC968` | 自定文字9 | `udf_text9` | string |  |
| `HEC969` | 自定文字10 | `udf_text10` | string |  |
| `HEC970` | 自定文字11 | `udf_text11` | string |  |
| `HEC971` | 自定文字12 | `udf_text12` | string |  |
| `HEC972` | 自定文字13 | `udf_text13` | string |  |
| `HEC973` | 自定文字14 | `udf_text14` | string |  |
| `HEC974` | 自定文字15 | `udf_text15` | string |  |
| `HEC975` | 自定文字16 | `udf_text16` | string |  |
| `HEC980` | 自定数字1 | `udf_no1` | float |  |
| `HEC981` | 自定数字2 | `udf_no2` | float |  |
| `HEC982` | 自定数字3 | `udf_no3` | float |  |
| `HEC983` | 自定数字4 | `udf_no4` | float |  |
| `HEC984` | 自定数字5 | `udf_no5` | float |  |
| `HEC985` | 自定数字6 | `udf_no6` | float |  |
| `HEC986` | 自定数字7 | `udf_no7` | float |  |
| `HEC987` | 自定数字8 | `udf_no8` | float |  |
| `HEC988` | 自定数字9 | `udf_no9` | float |  |
| `HEC989` | 自定数字10 | `udf_no10` | float |  |
| `HEC990` | 自定数字11 | `udf_no11` | float |  |
| `HEC991` | 自定数字12 | `udf_no12` | float |  |
| `HEC992` | 自定数字13 | `udf_no13` | float |  |
| `HEC993` | 自定数字14 | `udf_no14` | float |  |
| `HEC994` | 自定数字15 | `udf_no15` | float |  |
| `HEC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "HEA001": ""
  ,"HEA002": ""
  ,"HEA003": ""
  ,"HEA004": ""
  ,"cdsDetail": [{
    "HEB001": ""
    ,"HEB001": ""
    ,"HEB002": ""
    ,"HEB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"HEA001": "?"}]}
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
| `HEA001` | `docNo` | 单号 | 主键 |
| `HEA002` | `nature` | 性质 | |
| `HEA003` | `date` | 日期 | |
| `HEA004` | `item_no` | 品号 | |
| `HEA005` | `product_name` | 品名 | |
| `HEA006` | `approve_status` | 审核码 | |
| `HEA007` | `remarks` | 备注 | |
| `HEA008` | `auditor` | 审核人 | |
| `HEA009` | `main_supplier` | 主供应商 | |
| `HEA010` | `org_main_supplier` | 原主供应商 | |
| `HEB001` | `docNo` | 单号 (单身) | |
| `HEB002` | `detail_seq` | 单身序号 (单身) | |
| `HEB003` | `supplier_no` | 供应商编号 (单身) | |
| `HEB004` | `supplier_abbreviation` | 供应商简称 (单身) | |
| `HEB005` | `currency` | 币种 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `HEA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `HEA001`
