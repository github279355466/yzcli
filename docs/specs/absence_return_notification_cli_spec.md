# CLI 规格说明书：销假单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `absence.return.notification` |
| **DLL** | `GZSXC19` |
| **服务名称** | `销假单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "absence.return.notification" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "absence.return.notification" \
  --action "getMultiple" \
  --data '{"datakeys":[{"XHA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "absence.return.notification" \
  --action "create" \
  --data '{"XHA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "absence.return.notification" \
  --action "approve" \
  --data '{"datakeys":[{"XHA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `XHA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (GZSXHA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `XHA001` | 单号 | `docNo` | string | 主键 |
| `XHA002` | 申请日期 | `app_date` | string |  |
| `XHA003` | 申请人 | `applicant` | string |  |
| `XHA004` | 所属部门 | `dept` | string |  |
| `XHA005` | 岗位 | `position` | string |  |
| `XHA006` | 年假剩余天数 | `remaining_annual_leave_days` | float |  |
| `XHA007` | 代办人 | `agent` | string |  |
| `XHA008` | 请假时数 | `leave_hours` | float |  |
| `XHA009` | 销假原因 | `leave_cancellation_reason` | string |  |
| `XHA010` | 备注 | `remarks` | string |  |
| `XHA011` | 审核码 | `approve_status` | string |  |
| `XHA012` | 审核人 | `auditor` | string |  |
| `XHA013` | 请假类型 | `leave_type` | string |  |
| `XHA014` | 请假开始时间 | `leave_start_time` | string |  |
| `XHA015` | 请假结束时间 | `leave_end_time` | string |  |
| `XHA016` | 请假单号 | `leave_request_docNo` | string |  |
| `XHA017` | 不同意 | `disagreement` | string |  |
| `XHA018` | 意见 | `opinions` | string |  |
| `XHA019` | 预留字段 | `reserved_field1` | string |  |
| `XHA020` | 预留字段 | `reserved_field2` | string |  |
| `XHA021` | 预留字段 | `reserved_field3` | string |  |
| `XHA022` | 预留字段 | `reserved_field4` | string |  |
| `XHA023` | 预留字段 | `reserved_field5` | float |  |
| `XHA024` | 预留字段 | `reserved_field6` | float |  |
| `XHA901` | 录入者编号 | `entry_person_no` | string |  |
| `XHA902` | 录入时间 | `entry_time` | string |  |
| `XHA903` | 更改者编号 | `changer_no` | string |  |
| `XHA904` | 更改时间 | `change_time` | string |  |
| `XHA905` | 更新标记 | `update_flag` | integer |  |
| `XHA906` | 打印次数 | `print_count` | integer |  |
| `XHA907` | 打印时间 | `print_time` | string |  |
| `XHA908` | 打印人员 | `printer` | string |  |
| `XHA909` | 打印人员姓名 | `printer_name` | string |  |
| `XHA910` | 送审状态 | `submission_status` | string |  |
| `XHA911` | 送审人 | `reviewer` | string |  |
| `XHA912` | 审批人1 | `approver1` | string |  |
| `XHA913` | 审批结果 | `approval_result1` | string |  |
| `XHA914` | 审批意见 | `approval_opinion1` | string |  |
| `XHA915` | 审批人2 | `approver2` | string |  |
| `XHA916` | 审批结果 | `approval_result2` | string |  |
| `XHA917` | 审批意见 | `approval_opinion2` | string |  |
| `XHA918` | 审批人3 | `approver3` | string |  |
| `XHA919` | 审批结果 | `approval_result3` | string |  |
| `XHA920` | 审批意见 | `approval_opinion3` | string |  |
| `XHA921` | 审批人4 | `approver4` | string |  |
| `XHA922` | 审批结果 | `approval_result4` | string |  |
| `XHA923` | 审批意见 | `approval_opinion4` | string |  |
| `XHA924` | 审批人5 | `approver5` | string |  |
| `XHA925` | 审批结果 | `approval_result5` | string |  |
| `XHA926` | 审批意见 | `approval_opinion5` | string |  |
| `XHA927` | 审批人6 | `approver6` | string |  |
| `XHA928` | 审批结果 | `approval_result6` | string |  |
| `XHA929` | 审批意见 | `approval_opinion6` | string |  |
| `XHA930` | 终审人 | `final_approver` | string |  |
| `XHA931` | 审批结果 | `approval_result7` | string |  |
| `XHA932` | 审批意见 | `approval_opinion7` | string |  |
| `XHA933` | 通知人1 | `notifier1` | string |  |
| `XHA934` | 通知人2 | `notifier2` | string |  |
| `XHA935` | 通知人3 | `notifier3` | string |  |
| `XHA950` | 送审时间 | `submission_time_for_review` | string |  |
| `XHA951` | 审批时间1 | `approval_time1` | string |  |
| `XHA952` | 审批时间2 | `approval_time2` | string |  |
| `XHA953` | 审批时间3 | `approval_time3` | string |  |
| `XHA954` | 审批时间4 | `approval_time4` | string |  |
| `XHA955` | 审批时间5 | `approval_time5` | string |  |
| `XHA956` | 审批时间6 | `approval_time6` | string |  |
| `XHA957` | 终审时间 | `final_review_time` | string |  |
| `XHA959` | 审核时间 | `review_time` | string |  |
| `XHA960` | 自定文字1 | `udf_text1` | string |  |
| `XHA961` | 自定文字2 | `udf_text2` | string |  |
| `XHA962` | 自定文字3 | `udf_text3` | string |  |
| `XHA963` | 自定文字4 | `udf_text4` | string |  |
| `XHA964` | 自定文字5 | `udf_text5` | string |  |
| `XHA965` | 自定文字6 | `udf_text6` | string |  |
| `XHA966` | 自定文字7 | `udf_text7` | string |  |
| `XHA967` | 自定文字8 | `udf_text8` | string |  |
| `XHA968` | 自定文字9 | `udf_text9` | string |  |
| `XHA969` | 自定文字10 | `udf_text10` | string |  |
| `XHA970` | 自定文字11 | `udf_text11` | string |  |
| `XHA971` | 自定文字12 | `udf_text12` | string |  |
| `XHA972` | 自定文字13 | `udf_text13` | string |  |
| `XHA973` | 自定文字14 | `udf_text14` | string |  |
| `XHA974` | 自定文字15 | `udf_text15` | string |  |
| `XHA975` | 自定文字16 | `udf_text16` | string |  |
| `XHA980` | 自定数字1 | `udf_no1` | float |  |
| `XHA981` | 自定数字2 | `udf_no2` | float |  |
| `XHA982` | 自定数字3 | `udf_no3` | float |  |
| `XHA983` | 自定数字4 | `udf_no4` | float |  |
| `XHA984` | 自定数字5 | `udf_no5` | float |  |
| `XHA985` | 自定数字6 | `udf_no6` | float |  |
| `XHA986` | 自定数字7 | `udf_no7` | float |  |
| `XHA987` | 自定数字8 | `udf_no8` | float |  |
| `XHA988` | 自定数字9 | `udf_no9` | float |  |
| `XHA989` | 自定数字10 | `udf_no10` | float |  |
| `XHA990` | 自定数字11 | `udf_no11` | float |  |
| `XHA991` | 自定数字12 | `udf_no12` | float |  |
| `XHA992` | 自定数字13 | `udf_no13` | float |  |
| `XHA993` | 自定数字14 | `udf_no14` | float |  |
| `XHA994` | 自定数字15 | `udf_no15` | float |  |
| `XHA995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "XHA001": ""
  ,"XHA002": ""
  ,"XHA003": ""
  ,"XHA004": ""
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"XHA001": "?"}]}
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
| `XHA001` | `docNo` | 单号 | 主键 |
| `XHA002` | `app_date` | 申请日期 | |
| `XHA003` | `applicant` | 申请人 | |
| `XHA004` | `dept` | 所属部门 | |
| `XHA005` | `position` | 岗位 | |
| `XHA006` | `remaining_annual_leave_days` | 年假剩余天数 | |
| `XHA007` | `agent` | 代办人 | |
| `XHA008` | `leave_hours` | 请假时数 | |
| `XHA009` | `leave_cancellation_reason` | 销假原因 | |
| `XHA010` | `remarks` | 备注 | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `XHA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `XHA001`
