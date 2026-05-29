# CLI 规格说明书：差旅费报销单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `travel.expense.reimbursement.request` |
| **DLL** | `OASXC02` |
| **服务名称** | `差旅费报销单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "travel.expense.reimbursement.request" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "travel.expense.reimbursement.request" \
  --action "getMultiple" \
  --data '{"datakeys":[{"WBA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "travel.expense.reimbursement.request" \
  --action "create" \
  --data '{"WBA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "travel.expense.reimbursement.request" \
  --action "approve" \
  --data '{"datakeys":[{"WBA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `WBA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (OASWBA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `WBA001` | 单号 | `WBA001` | string | 主键 |
| `WBA002` | 性质 | `WBA002` | string |  |
| `WBA003` | 申请日期 | `WBA003` | string |  |
| `WBA004` | 报销人 | `WBA004` | string |  |
| `WBA005` | 报销人部门 | `WBA005` | string |  |
| `WBA006` | 代办人 | `WBA006` | string |  |
| `WBA007` | 代办人部门 | `WBA007` | string |  |
| `WBA008` | 币种 | `WBA008` | string |  |
| `WBA009` | 汇率 | `WBA009` | float |  |
| `WBA010` | 项目 | `WBA010` | string |  |
| `WBA011` | 报销总金额 | `WBA011` | float |  |
| `WBA012` | 本币报销总金额 | `WBA012` | float |  |
| `WBA013` | 出差起始日 | `WBA013` | string |  |
| `WBA014` | 出差截止日 | `WBA014` | string |  |
| `WBA015` | 补助金额 | `WBA015` | float |  |
| `WBA016` | 本币补助金额 | `WBA016` | float |  |
| `WBA017` | 记账日期 | `WBA017` | string |  |
| `WBA018` | 用途说明 | `WBA018` | string |  |
| `WBA019` | 备注 | `WBA019` | string |  |
| `WBA020` | 凭证抛转否 | `WBA020` | string |  |
| `WBA021` | 凭证类别 | `WBA021` | string |  |
| `WBA022` | 凭证编号 | `WBA022` | string |  |
| `WBA023` | 审核码 | `WBA023` | string |  |
| `WBA024` | 审核人 | `WBA024` | string |  |
| `WBA025` | 审核时间 | `WBA025` | string |  |
| `WBA026` | 预留字段 | `WBA026` | string |  |
| `WBA027` | 预留字段 | `WBA027` | string |  |
| `WBA028` | 预留字段 | `WBA028` | string |  |
| `WBA029` | 预留字段 | `WBA029` | string |  |
| `WBA030` | 预留字段 | `WBA030` | float |  |
| `WBA031` | 预留字段 | `WBA031` | float |  |
| `WBA032` | 结算方式 | `WBA032` | string |  |
| `WBA033` | 银行账号 | `WBA033` | string |  |
| `WBA034` | 已冲金额 | `WBA034` | float |  |
| `WBA035` | 本币已冲金额 | `WBA035` | float |  |
| `WBA036` | 费用分摊 | `WBA036` | string |  |
| `WBA901` | 录入者编号 | `entry_person_no` | string |  |
| `WBA902` | 录入时间 | `entry_time` | string |  |
| `WBA903` | 更改者编号 | `changer_no` | string |  |
| `WBA904` | 更改时间 | `change_time` | string |  |
| `WBA905` | 更新标记 | `update_flag` | integer |  |
| `WBA960` | 自定文字1 | `udf_text1` | string |  |
| `WBA961` | 自定文字2 | `udf_text2` | string |  |
| `WBA962` | 自定文字3 | `udf_text3` | string |  |
| `WBA963` | 自定文字4 | `udf_text4` | string |  |
| `WBA964` | 自定文字5 | `udf_text5` | string |  |
| `WBA965` | 自定文字6 | `udf_text6` | string |  |
| `WBA980` | 自定数字1 | `udf_no1` | float |  |
| `WBA981` | 自定数字2 | `udf_no2` | float |  |
| `WBA982` | 自定数字3 | `udf_no3` | float |  |
| `WBA983` | 自定数字4 | `udf_no4` | float |  |
| `WBA984` | 自定数字5 | `udf_no5` | float |  |
| `WBA985` | 自定数字6 | `udf_no6` | float |  |
| `WBA910` | 送审状态 | `submission_status` | string |  |
| `WBA911` | 送审人 | `reviewer` | string |  |
| `WBA912` | 审批人1 | `approver1` | string |  |
| `WBA913` | 审批结果 | `approval_result1` | string |  |
| `WBA914` | 审批意见 | `approval_opinion1` | string |  |
| `WBA915` | 审批人2 | `approver2` | string |  |
| `WBA916` | 审批结果 | `approval_result2` | string |  |
| `WBA917` | 审批意见 | `approval_opinion2` | string |  |
| `WBA918` | 审批人3 | `approver3` | string |  |
| `WBA919` | 审批结果 | `approval_result3` | string |  |
| `WBA920` | 审批意见 | `approval_opinion3` | string |  |
| `WBA921` | 审批人4 | `approver4` | string |  |
| `WBA922` | 审批结果 | `approval_result4` | string |  |
| `WBA923` | 审批意见 | `approval_opinion4` | string |  |
| `WBA924` | 审批人5 | `approver5` | string |  |
| `WBA925` | 审批结果 | `approval_result5` | string |  |
| `WBA926` | 审批意见 | `approval_opinion5` | string |  |
| `WBA927` | 审批人6 | `approver6` | string |  |
| `WBA928` | 审批结果 | `approval_result6` | string |  |
| `WBA929` | 审批意见 | `approval_opinion6` | string |  |
| `WBA930` | 终审人 | `final_approver` | string |  |
| `WBA931` | 审批结果 | `approval_result7` | string |  |
| `WBA932` | 审批意见 | `approval_opinion7` | string |  |
| `WBA933` | 通知人1 | `notifier1` | string |  |
| `WBA934` | 通知人2 | `notifier2` | string |  |
| `WBA935` | 通知人3 | `notifier3` | string |  |
| `WBA936` | 加签人 | `WBA936` | string |  |
| `WBA937` | 审批结果 | `WBA937` | string |  |
| `WBA938` | 审批意见 | `WBA938` | string |  |
| `WBA966` | 自定文字7 | `udf_text7` | string |  |
| `WBA967` | 自定文字8 | `udf_text8` | string |  |
| `WBA968` | 自定文字9 | `udf_text9` | string |  |
| `WBA969` | 自定文字10 | `udf_text10` | string |  |
| `WBA970` | 自定文字11 | `udf_text11` | string |  |
| `WBA971` | 自定文字12 | `udf_text12` | string |  |
| `WBA972` | 自定文字13 | `udf_text13` | string |  |
| `WBA973` | 自定文字14 | `udf_text14` | string |  |
| `WBA974` | 自定文字15 | `udf_text15` | string |  |
| `WBA975` | 自定文字16 | `udf_text16` | string |  |
| `WBA986` | 自定数字7 | `udf_no7` | float |  |
| `WBA987` | 自定数字8 | `udf_no8` | float |  |
| `WBA988` | 自定数字9 | `udf_no9` | float |  |
| `WBA989` | 自定数字10 | `udf_no10` | float |  |
| `WBA990` | 自定数字11 | `udf_no11` | float |  |
| `WBA991` | 自定数字12 | `udf_no12` | float |  |
| `WBA992` | 自定数字13 | `udf_no13` | float |  |
| `WBA993` | 自定数字14 | `udf_no14` | float |  |
| `WBA994` | 自定数字15 | `udf_no15` | float |  |
| `WBA995` | 自定数字16 | `udf_no16` | float |  |
| `WBA906` | 打印次数 | `print_count` | integer |  |
| `WBA907` | 打印时间 | `print_time` | string |  |
| `WBA908` | 打印人员 | `printer` | string |  |
| `WBA909` | 打印人员姓名 | `printer_name` | string |  |
| `WBA950` | 送审时间 | `submission_time_for_review` | string |  |
| `WBA951` | 审批时间1 | `approval_time1` | string |  |
| `WBA952` | 审批时间2 | `approval_time2` | string |  |
| `WBA953` | 审批时间3 | `approval_time3` | string |  |
| `WBA954` | 审批时间4 | `approval_time4` | string |  |
| `WBA955` | 审批时间5 | `approval_time5` | string |  |
| `WBA956` | 审批时间6 | `approval_time6` | string |  |
| `WBA957` | 终审时间 | `final_review_time` | string |  |
| `WBA958` | 加签时间 | `WBA958` | string |  |
| `WBA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (OASWBB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `WBB001` | 单号 | `WBB001` | string |  |
| `WBB002` | 序号 | `WBB002` | string |  |
| `WBB003` | 始发地 | `WBB003` | string |  |
| `WBB004` | 目的地 | `WBB004` | string |  |
| `WBB005` | 日期 | `WBB005` | string |  |
| `WBB006` | 飞机票费 | `WBB006` | float |  |
| `WBB007` | 本币飞机票费 | `WBB007` | float |  |
| `WBB008` | 火车票费 | `WBB008` | float |  |
| `WBB009` | 本币火车票费 | `WBB009` | float |  |
| `WBB010` | 住宿费 | `WBB010` | float |  |
| `WBB011` | 本币住宿费 | `WBB011` | float |  |
| `WBB012` | 交通费 | `WBB012` | float |  |
| `WBB013` | 本币交通费 | `WBB013` | float |  |
| `WBB014` | 其他费用 | `WBB014` | float |  |
| `WBB015` | 本币其他费用 | `WBB015` | float |  |
| `WBB016` | 备注 | `WBB016` | string |  |
| `WBB017` | 审核码 | `WBB017` | string |  |
| `WBB018` | 预留字段 | `WBB018` | string |  |
| `WBB019` | 预留字段 | `WBB019` | string |  |
| `WBB020` | 预留字段 | `WBB020` | string |  |
| `WBB021` | 预留字段 | `WBB021` | string |  |
| `WBB022` | 预留字段 | `WBB022` | float |  |
| `WBB023` | 预留字段 | `WBB023` | float |  |
| `WBB901` | 录入者编号 | `entry_person_no` | string |  |
| `WBB902` | 录入时间 | `entry_time` | string |  |
| `WBB903` | 更改者编号 | `changer_no` | string |  |
| `WBB904` | 更改时间 | `change_time` | string |  |
| `WBB905` | 更新标记 | `update_flag` | integer |  |
| `WBB960` | 自定文字1 | `udf_text1` | string |  |
| `WBB961` | 自定文字2 | `udf_text2` | string |  |
| `WBB962` | 自定文字3 | `udf_text3` | string |  |
| `WBB963` | 自定文字4 | `udf_text4` | string |  |
| `WBB964` | 自定文字5 | `udf_text5` | string |  |
| `WBB965` | 自定文字6 | `udf_text6` | string |  |
| `WBB980` | 自定数字1 | `udf_no1` | float |  |
| `WBB981` | 自定数字2 | `udf_no2` | float |  |
| `WBB982` | 自定数字3 | `udf_no3` | float |  |
| `WBB983` | 自定数字4 | `udf_no4` | float |  |
| `WBB984` | 自定数字5 | `udf_no5` | float |  |
| `WBB985` | 自定数字6 | `udf_no6` | float |  |
| `WBB966` | 自定文字7 | `udf_text7` | string |  |
| `WBB967` | 自定文字8 | `udf_text8` | string |  |
| `WBB968` | 自定文字9 | `udf_text9` | string |  |
| `WBB969` | 自定文字10 | `udf_text10` | string |  |
| `WBB970` | 自定文字11 | `udf_text11` | string |  |
| `WBB971` | 自定文字12 | `udf_text12` | string |  |
| `WBB972` | 自定文字13 | `udf_text13` | string |  |
| `WBB973` | 自定文字14 | `udf_text14` | string |  |
| `WBB974` | 自定文字15 | `udf_text15` | string |  |
| `WBB975` | 自定文字16 | `udf_text16` | string |  |
| `WBB986` | 自定数字7 | `udf_no7` | float |  |
| `WBB987` | 自定数字8 | `udf_no8` | float |  |
| `WBB988` | 自定数字9 | `udf_no9` | float |  |
| `WBB989` | 自定数字10 | `udf_no10` | float |  |
| `WBB990` | 自定数字11 | `udf_no11` | float |  |
| `WBB991` | 自定数字12 | `udf_no12` | float |  |
| `WBB992` | 自定数字13 | `udf_no13` | float |  |
| `WBB993` | 自定数字14 | `udf_no14` | float |  |
| `WBB994` | 自定数字15 | `udf_no15` | float |  |
| `WBB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (OASWBC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `WBC001` | 单号 | `WBC001` | string |  |
| `WBC002` | 序号 | `WBC002` | string |  |
| `WBC003` | 借款单号 | `WBC003` | string |  |
| `WBC004` | 借款日期 | `WBC004` | string |  |
| `WBC005` | 借款人 | `WBC005` | string |  |
| `WBC006` | 借款金额 | `WBC006` | float |  |
| `WBC007` | 未核销金额 | `WBC007` | float |  |
| `WBC008` | 本次核销金额 | `WBC008` | float |  |
| `WBC009` | 本币本次核销金额 | `WBC009` | float |  |
| `WBC010` | 备注 | `WBC010` | string |  |
| `WBC011` | 审核码 | `WBC011` | string |  |
| `WBC901` | 录入者编号 | `entry_person_no` | string |  |
| `WBC902` | 录入时间 | `entry_time` | string |  |
| `WBC903` | 更改者编号 | `changer_no` | string |  |
| `WBC904` | 更改时间 | `change_time` | string |  |
| `WBC905` | 更新标记 | `update_flag` | integer |  |
| `WBC960` | 自定文字1 | `udf_text1` | string |  |
| `WBC961` | 自定文字2 | `udf_text2` | string |  |
| `WBC962` | 自定文字3 | `udf_text3` | string |  |
| `WBC963` | 自定文字4 | `udf_text4` | string |  |
| `WBC964` | 自定文字5 | `udf_text5` | string |  |
| `WBC965` | 自定文字6 | `udf_text6` | string |  |
| `WBC980` | 自定数字1 | `udf_no1` | float |  |
| `WBC981` | 自定数字2 | `udf_no2` | float |  |
| `WBC982` | 自定数字3 | `udf_no3` | float |  |
| `WBC983` | 自定数字4 | `udf_no4` | float |  |
| `WBC984` | 自定数字5 | `udf_no5` | float |  |
| `WBC985` | 自定数字6 | `udf_no6` | float |  |
| `WBC966` | 自定文字7 | `udf_text7` | string |  |
| `WBC967` | 自定文字8 | `udf_text8` | string |  |
| `WBC968` | 自定文字9 | `udf_text9` | string |  |
| `WBC969` | 自定文字10 | `udf_text10` | string |  |
| `WBC970` | 自定文字11 | `udf_text11` | string |  |
| `WBC971` | 自定文字12 | `udf_text12` | string |  |
| `WBC972` | 自定文字13 | `udf_text13` | string |  |
| `WBC973` | 自定文字14 | `udf_text14` | string |  |
| `WBC974` | 自定文字15 | `udf_text15` | string |  |
| `WBC975` | 自定文字16 | `udf_text16` | string |  |
| `WBC986` | 自定数字7 | `udf_no7` | float |  |
| `WBC987` | 自定数字8 | `udf_no8` | float |  |
| `WBC988` | 自定数字9 | `udf_no9` | float |  |
| `WBC989` | 自定数字10 | `udf_no10` | float |  |
| `WBC990` | 自定数字11 | `udf_no11` | float |  |
| `WBC991` | 自定数字12 | `udf_no12` | float |  |
| `WBC992` | 自定数字13 | `udf_no13` | float |  |
| `WBC993` | 自定数字14 | `udf_no14` | float |  |
| `WBC994` | 自定数字15 | `udf_no15` | float |  |
| `WBC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "WBA001": ""
  ,"WBA002": ""
  ,"WBA003": ""
  ,"WBA004": ""
  ,"cdsDetail": [{
    "WBB001": ""
    ,"WBB001": ""
    ,"WBB002": ""
    ,"WBB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"WBA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"WBA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `WBA001` | `WBA001` | 单号 | 主键 |
| `WBA002` | `WBA002` | 性质 | |
| `WBA003` | `WBA003` | 申请日期 | |
| `WBA004` | `WBA004` | 报销人 | |
| `WBA005` | `WBA005` | 报销人部门 | |
| `WBA006` | `WBA006` | 代办人 | |
| `WBA007` | `WBA007` | 代办人部门 | |
| `WBA008` | `WBA008` | 币种 | |
| `WBA009` | `WBA009` | 汇率 | |
| `WBA010` | `WBA010` | 项目 | |
| `WBB001` | `WBB001` | 单号 (单身) | |
| `WBB002` | `WBB002` | 序号 (单身) | |
| `WBB003` | `WBB003` | 始发地 (单身) | |
| `WBB004` | `WBB004` | 目的地 (单身) | |
| `WBB005` | `WBB005` | 日期 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `WBA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `WBA001`
