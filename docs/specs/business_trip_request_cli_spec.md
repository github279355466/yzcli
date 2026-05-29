# CLI 规格说明书：出差申请单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `business.trip.request` |
| **DLL** | `GZSXC21` |
| **服务名称** | `出差申请单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "business.trip.request" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "business.trip.request" \
  --action "getMultiple" \
  --data '{"datakeys":[{"XJA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "business.trip.request" \
  --action "create" \
  --data '{"XJA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "business.trip.request" \
  --action "approve" \
  --data '{"datakeys":[{"XJA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `XJA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (GZSXJA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `XJA001` | 单号 | `docNo` | string | 主键 |
| `XJA002` | 日期 | `date` | string |  |
| `XJA003` | 申请人 | `applicant` | string |  |
| `XJA004` | 所属部门 | `dept` | string |  |
| `XJA005` | 岗位 | `position` | string |  |
| `XJA006` | 出差开始日期 | `business_trip_start_date` | string |  |
| `XJA007` | 代办人 | `agent` | string |  |
| `XJA008` | 出差天数 | `business_trip_days` | float |  |
| `XJA009` | 出差内容 | `business_trip_content` | string |  |
| `XJA010` | 备注 | `remarks` | string |  |
| `XJA011` | 审核码 | `approve_status` | string |  |
| `XJA012` | 审核人 | `auditor` | string |  |
| `XJA013` | 出差结束日期 | `end_date_of_business_trip` | string |  |
| `XJA014` | 出差地点 | `business_trip_location` | string |  |
| `XJA015` | 不同意 | `disagreement` | string |  |
| `XJA016` | 意见 | `opinions` | string |  |
| `XJA017` | 预留字段 | `reserved_field1` | string |  |
| `XJA018` | 预留字段 | `reserved_field2` | string |  |
| `XJA019` | 预留字段 | `reserved_field3` | string |  |
| `XJA020` | 预留字段 | `reserved_field4` | string |  |
| `XJA021` | 预留字段 | `reserved_field5` | float |  |
| `XJA022` | 预留字段 | `reserved_field6` | float |  |
| `XJA901` | 录入者编号 | `entry_person_no` | string |  |
| `XJA902` | 录入时间 | `entry_time` | string |  |
| `XJA903` | 更改者编号 | `changer_no` | string |  |
| `XJA904` | 更改时间 | `change_time` | string |  |
| `XJA905` | 更新标记 | `update_flag` | integer |  |
| `XJA906` | 打印次数 | `print_count` | integer |  |
| `XJA907` | 打印时间 | `print_time` | string |  |
| `XJA908` | 打印人员 | `printer` | string |  |
| `XJA909` | 打印人员姓名 | `printer_name` | string |  |
| `XJA910` | 送审状态 | `submission_status` | string |  |
| `XJA911` | 送审人 | `reviewer` | string |  |
| `XJA912` | 审批人1 | `approver1` | string |  |
| `XJA913` | 审批结果 | `approval_result1` | string |  |
| `XJA914` | 审批意见 | `approval_opinion1` | string |  |
| `XJA915` | 审批人2 | `approver2` | string |  |
| `XJA916` | 审批结果 | `approval_result2` | string |  |
| `XJA917` | 审批意见 | `approval_opinion2` | string |  |
| `XJA918` | 审批人3 | `approver3` | string |  |
| `XJA919` | 审批结果 | `approval_result3` | string |  |
| `XJA920` | 审批意见 | `approval_opinion3` | string |  |
| `XJA921` | 审批人4 | `approver4` | string |  |
| `XJA922` | 审批结果 | `approval_result4` | string |  |
| `XJA923` | 审批意见 | `approval_opinion4` | string |  |
| `XJA924` | 审批人5 | `approver5` | string |  |
| `XJA925` | 审批结果 | `approval_result5` | string |  |
| `XJA926` | 审批意见 | `approval_opinion5` | string |  |
| `XJA927` | 审批人6 | `approver6` | string |  |
| `XJA928` | 审批结果 | `approval_result6` | string |  |
| `XJA929` | 审批意见 | `approval_opinion6` | string |  |
| `XJA930` | 终审人 | `final_approver` | string |  |
| `XJA931` | 审批结果 | `approval_result7` | string |  |
| `XJA932` | 审批意见 | `approval_opinion7` | string |  |
| `XJA933` | 通知人1 | `notifier1` | string |  |
| `XJA934` | 通知人2 | `notifier2` | string |  |
| `XJA935` | 通知人3 | `notifier3` | string |  |
| `XJA950` | 送审时间 | `submission_time_for_review` | string |  |
| `XJA951` | 审批时间1 | `approval_time1` | string |  |
| `XJA952` | 审批时间2 | `approval_time2` | string |  |
| `XJA953` | 审批时间3 | `approval_time3` | string |  |
| `XJA954` | 审批时间4 | `approval_time4` | string |  |
| `XJA955` | 审批时间5 | `approval_time5` | string |  |
| `XJA956` | 审批时间6 | `approval_time6` | string |  |
| `XJA957` | 终审时间 | `final_review_time` | string |  |
| `XJA959` | 审核时间 | `review_time` | string |  |
| `XJA960` | 自定文字1 | `udf_text1` | string |  |
| `XJA961` | 自定文字2 | `udf_text2` | string |  |
| `XJA962` | 自定文字3 | `udf_text3` | string |  |
| `XJA963` | 自定文字4 | `udf_text4` | string |  |
| `XJA964` | 自定文字5 | `udf_text5` | string |  |
| `XJA965` | 自定文字6 | `udf_text6` | string |  |
| `XJA966` | 自定文字7 | `udf_text7` | string |  |
| `XJA967` | 自定文字8 | `udf_text8` | string |  |
| `XJA968` | 自定文字9 | `udf_text9` | string |  |
| `XJA969` | 自定文字10 | `udf_text10` | string |  |
| `XJA970` | 自定文字11 | `udf_text11` | string |  |
| `XJA971` | 自定文字12 | `udf_text12` | string |  |
| `XJA972` | 自定文字13 | `udf_text13` | string |  |
| `XJA973` | 自定文字14 | `udf_text14` | string |  |
| `XJA974` | 自定文字15 | `udf_text15` | string |  |
| `XJA975` | 自定文字16 | `udf_text16` | string |  |
| `XJA980` | 自定数字1 | `udf_no1` | float |  |
| `XJA981` | 自定数字2 | `udf_no2` | float |  |
| `XJA982` | 自定数字3 | `udf_no3` | float |  |
| `XJA983` | 自定数字4 | `udf_no4` | float |  |
| `XJA984` | 自定数字5 | `udf_no5` | float |  |
| `XJA985` | 自定数字6 | `udf_no6` | float |  |
| `XJA986` | 自定数字7 | `udf_no7` | float |  |
| `XJA987` | 自定数字8 | `udf_no8` | float |  |
| `XJA988` | 自定数字9 | `udf_no9` | float |  |
| `XJA989` | 自定数字10 | `udf_no10` | float |  |
| `XJA990` | 自定数字11 | `udf_no11` | float |  |
| `XJA991` | 自定数字12 | `udf_no12` | float |  |
| `XJA992` | 自定数字13 | `udf_no13` | float |  |
| `XJA993` | 自定数字14 | `udf_no14` | float |  |
| `XJA994` | 自定数字15 | `udf_no15` | float |  |
| `XJA995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "XJA001": ""
  ,"XJA002": ""
  ,"XJA003": ""
  ,"XJA004": ""
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"XJA001": "?"}]}
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
| `XJA001` | `docNo` | 单号 | 主键 |
| `XJA002` | `date` | 日期 | |
| `XJA003` | `applicant` | 申请人 | |
| `XJA004` | `dept` | 所属部门 | |
| `XJA005` | `position` | 岗位 | |
| `XJA006` | `business_trip_start_date` | 出差开始日期 | |
| `XJA007` | `agent` | 代办人 | |
| `XJA008` | `business_trip_days` | 出差天数 | |
| `XJA009` | `business_trip_content` | 出差内容 | |
| `XJA010` | `remarks` | 备注 | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `XJA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `XJA001`
