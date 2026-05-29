# CLI 规格说明书：借款单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `employee.cash.advance.request` |
| **DLL** | `OASXC15` |
| **服务名称** | `借款单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "employee.cash.advance.request" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "employee.cash.advance.request" \
  --action "getMultiple" \
  --data '{"datakeys":[{"WLA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "employee.cash.advance.request" \
  --action "create" \
  --data '{"WLA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "employee.cash.advance.request" \
  --action "approve" \
  --data '{"datakeys":[{"WLA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `WLA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (OASWLA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `WLA001` | 单号 | `WLA001` | string | 主键 |
| `WLA002` | 性质 | `WLA002` | string |  |
| `WLA003` | 申请日期 | `WLA003` | string |  |
| `WLA004` | 借款人 | `WLA004` | string |  |
| `WLA005` | 借款人部门 | `WLA005` | string |  |
| `WLA006` | 代办人 | `WLA006` | string |  |
| `WLA007` | 代办人部门 | `WLA007` | string |  |
| `WLA008` | 币种 | `WLA008` | string |  |
| `WLA009` | 汇率 | `WLA009` | float |  |
| `WLA010` | 项目 | `WLA010` | string |  |
| `WLA011` | 借款金额 | `WLA011` | float |  |
| `WLA012` | 本币借款金额 | `WLA012` | float |  |
| `WLA013` | 用途说明 | `WLA013` | string |  |
| `WLA014` | 备注 | `WLA014` | string |  |
| `WLA015` | 凭证抛转否 | `WLA015` | string |  |
| `WLA016` | 凭证类别 | `WLA016` | string |  |
| `WLA017` | 凭证编号 | `WLA017` | string |  |
| `WLA018` | 审核码 | `WLA018` | string |  |
| `WLA019` | 审核人 | `WLA019` | string |  |
| `WLA020` | 审核时间 | `WLA020` | string |  |
| `WLA021` | 预留字段 | `WLA021` | string |  |
| `WLA022` | 预留字段 | `WLA022` | string |  |
| `WLA023` | 预留字段 | `WLA023` | string |  |
| `WLA024` | 预留字段 | `WLA024` | string |  |
| `WLA025` | 预留字段 | `WLA025` | float |  |
| `WLA026` | 预留字段 | `WLA026` | float |  |
| `WLA027` | 结算方式 | `WLA027` | string |  |
| `WLA028` | 银行账号 | `WLA028` | string |  |
| `WLA029` | 已核销金额 | `WLA029` | float |  |
| `WLA030` | 本币已核销金额 | `WLA030` | float |  |
| `WLA031` | 结束码 | `WLA031` | string |  |
| `WLA032` | 还款凭证抛转否 | `WLA032` | string |  |
| `WLA033` | 还款凭证类别 | `WLA033` | string |  |
| `WLA034` | 还款凭证编号 | `WLA034` | string |  |
| `WLA035` | 还款记账日期 | `WLA035` | string |  |
| `WLA901` | 录入者编号 | `entry_person_no` | string |  |
| `WLA902` | 录入时间 | `entry_time` | string |  |
| `WLA903` | 更改者编号 | `changer_no` | string |  |
| `WLA904` | 更改时间 | `change_time` | string |  |
| `WLA905` | 更新标记 | `update_flag` | integer |  |
| `WLA960` | 自定文字1 | `udf_text1` | string |  |
| `WLA961` | 自定文字2 | `udf_text2` | string |  |
| `WLA962` | 自定文字3 | `udf_text3` | string |  |
| `WLA963` | 自定文字4 | `udf_text4` | string |  |
| `WLA964` | 自定文字5 | `udf_text5` | string |  |
| `WLA965` | 自定文字6 | `udf_text6` | string |  |
| `WLA980` | 自定数字1 | `udf_no1` | float |  |
| `WLA981` | 自定数字2 | `udf_no2` | float |  |
| `WLA982` | 自定数字3 | `udf_no3` | float |  |
| `WLA983` | 自定数字4 | `udf_no4` | float |  |
| `WLA984` | 自定数字5 | `udf_no5` | float |  |
| `WLA985` | 自定数字6 | `udf_no6` | float |  |
| `WLA910` | 送审状态 | `submission_status` | string |  |
| `WLA911` | 送审人 | `reviewer` | string |  |
| `WLA912` | 审批人1 | `approver1` | string |  |
| `WLA913` | 审批结果 | `approval_result1` | string |  |
| `WLA914` | 审批意见 | `approval_opinion1` | string |  |
| `WLA915` | 审批人2 | `approver2` | string |  |
| `WLA916` | 审批结果 | `approval_result2` | string |  |
| `WLA917` | 审批意见 | `approval_opinion2` | string |  |
| `WLA918` | 审批人3 | `approver3` | string |  |
| `WLA919` | 审批结果 | `approval_result3` | string |  |
| `WLA920` | 审批意见 | `approval_opinion3` | string |  |
| `WLA921` | 审批人4 | `approver4` | string |  |
| `WLA922` | 审批结果 | `approval_result4` | string |  |
| `WLA923` | 审批意见 | `approval_opinion4` | string |  |
| `WLA924` | 审批人5 | `approver5` | string |  |
| `WLA925` | 审批结果 | `approval_result5` | string |  |
| `WLA926` | 审批意见 | `approval_opinion5` | string |  |
| `WLA927` | 审批人6 | `approver6` | string |  |
| `WLA928` | 审批结果 | `approval_result6` | string |  |
| `WLA929` | 审批意见 | `approval_opinion6` | string |  |
| `WLA930` | 终审人 | `final_approver` | string |  |
| `WLA931` | 审批结果 | `approval_result7` | string |  |
| `WLA932` | 审批意见 | `approval_opinion7` | string |  |
| `WLA933` | 通知人1 | `notifier1` | string |  |
| `WLA934` | 通知人2 | `notifier2` | string |  |
| `WLA935` | 通知人3 | `notifier3` | string |  |
| `WLA966` | 自定文字7 | `udf_text7` | string |  |
| `WLA967` | 自定文字8 | `udf_text8` | string |  |
| `WLA968` | 自定文字9 | `udf_text9` | string |  |
| `WLA969` | 自定文字10 | `udf_text10` | string |  |
| `WLA970` | 自定文字11 | `udf_text11` | string |  |
| `WLA971` | 自定文字12 | `udf_text12` | string |  |
| `WLA972` | 自定文字13 | `udf_text13` | string |  |
| `WLA973` | 自定文字14 | `udf_text14` | string |  |
| `WLA974` | 自定文字15 | `udf_text15` | string |  |
| `WLA975` | 自定文字16 | `udf_text16` | string |  |
| `WLA986` | 自定数字7 | `udf_no7` | float |  |
| `WLA987` | 自定数字8 | `udf_no8` | float |  |
| `WLA988` | 自定数字9 | `udf_no9` | float |  |
| `WLA989` | 自定数字10 | `udf_no10` | float |  |
| `WLA990` | 自定数字11 | `udf_no11` | float |  |
| `WLA991` | 自定数字12 | `udf_no12` | float |  |
| `WLA992` | 自定数字13 | `udf_no13` | float |  |
| `WLA993` | 自定数字14 | `udf_no14` | float |  |
| `WLA994` | 自定数字15 | `udf_no15` | float |  |
| `WLA995` | 自定数字16 | `udf_no16` | float |  |
| `WLA906` | 打印次数 | `print_count` | integer |  |
| `WLA907` | 打印时间 | `print_time` | string |  |
| `WLA908` | 打印人员 | `printer` | string |  |
| `WLA909` | 打印人员姓名 | `printer_name` | string |  |
| `WLA950` | 送审时间 | `submission_time_for_review` | string |  |
| `WLA951` | 审批时间1 | `approval_time1` | string |  |
| `WLA952` | 审批时间2 | `approval_time2` | string |  |
| `WLA953` | 审批时间3 | `approval_time3` | string |  |
| `WLA954` | 审批时间4 | `approval_time4` | string |  |
| `WLA955` | 审批时间5 | `approval_time5` | string |  |
| `WLA956` | 审批时间6 | `approval_time6` | string |  |
| `WLA957` | 终审时间 | `final_review_time` | string |  |
| `WLA959` | 审核时间 | `review_time` | string |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "WLA001": ""
  ,"WLA002": ""
  ,"WLA003": ""
  ,"WLA004": ""
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"WLA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"WLA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `WLA001` | `WLA001` | 单号 | 主键 |
| `WLA002` | `WLA002` | 性质 | |
| `WLA003` | `WLA003` | 申请日期 | |
| `WLA004` | `WLA004` | 借款人 | |
| `WLA005` | `WLA005` | 借款人部门 | |
| `WLA006` | `WLA006` | 代办人 | |
| `WLA007` | `WLA007` | 代办人部门 | |
| `WLA008` | `WLA008` | 币种 | |
| `WLA009` | `WLA009` | 汇率 | |
| `WLA010` | `WLA010` | 项目 | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `WLA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `WLA001`
