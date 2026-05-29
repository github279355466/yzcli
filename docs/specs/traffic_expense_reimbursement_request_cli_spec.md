# CLI 规格说明书：交通费报销单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `traffic.expense.reimbursement.request` |
| **DLL** | `OASXC01` |
| **服务名称** | `交通费报销单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "traffic.expense.reimbursement.request" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "traffic.expense.reimbursement.request" \
  --action "getMultiple" \
  --data '{"datakeys":[{"WAA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "traffic.expense.reimbursement.request" \
  --action "create" \
  --data '{"WAA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "traffic.expense.reimbursement.request" \
  --action "approve" \
  --data '{"datakeys":[{"WAA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `WAA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (OASWAA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `WAA001` | 单号 | `WAA001` | string | 主键 |
| `WAA002` | 性质 | `WAA002` | string |  |
| `WAA003` | 申请日期 | `WAA003` | string |  |
| `WAA004` | 申请人 | `WAA004` | string |  |
| `WAA005` | 申请人部门 | `WAA005` | string |  |
| `WAA006` | 代办人 | `WAA006` | string |  |
| `WAA007` | 代办人部门 | `WAA007` | string |  |
| `WAA008` | 币种 | `WAA008` | string |  |
| `WAA009` | 汇率 | `WAA009` | float |  |
| `WAA010` | 项目 | `WAA010` | string |  |
| `WAA011` | 报销总金额 | `WAA011` | float |  |
| `WAA012` | 本币报销总金额 | `WAA012` | float |  |
| `WAA013` | 记账日期 | `WAA013` | string |  |
| `WAA014` | 用途说明 | `WAA014` | string |  |
| `WAA015` | 备注 | `WAA015` | string |  |
| `WAA016` | 凭证抛转否 | `WAA016` | string |  |
| `WAA017` | 凭证类别 | `WAA017` | string |  |
| `WAA018` | 凭证编号 | `WAA018` | string |  |
| `WAA019` | 审核码 | `WAA019` | string |  |
| `WAA020` | 审核人 | `WAA020` | string |  |
| `WAA021` | 审核时间 | `WAA021` | string |  |
| `WAA022` | 预留字段 | `WAA022` | string |  |
| `WAA023` | 预留字段 | `WAA023` | string |  |
| `WAA024` | 预留字段 | `WAA024` | string |  |
| `WAA025` | 预留字段 | `WAA025` | string |  |
| `WAA026` | 预留字段 | `WAA026` | float |  |
| `WAA027` | 预留字段 | `WAA027` | float |  |
| `WAA028` | 结算方式 | `WAA028` | string |  |
| `WAA029` | 银行账号 | `WAA029` | string |  |
| `WAA030` | 费用分摊 | `WAA030` | string |  |
| `WAA901` | 录入者编号 | `entry_person_no` | string |  |
| `WAA902` | 录入时间 | `entry_time` | string |  |
| `WAA903` | 更改者编号 | `changer_no` | string |  |
| `WAA904` | 更改时间 | `change_time` | string |  |
| `WAA905` | 更新标记 | `update_flag` | integer |  |
| `WAA960` | 自定文字1 | `udf_text1` | string |  |
| `WAA961` | 自定文字2 | `udf_text2` | string |  |
| `WAA962` | 自定文字3 | `udf_text3` | string |  |
| `WAA963` | 自定文字4 | `udf_text4` | string |  |
| `WAA964` | 自定文字5 | `udf_text5` | string |  |
| `WAA965` | 自定文字6 | `udf_text6` | string |  |
| `WAA980` | 自定数字1 | `udf_no1` | float |  |
| `WAA981` | 自定数字2 | `udf_no2` | float |  |
| `WAA982` | 自定数字3 | `udf_no3` | float |  |
| `WAA983` | 自定数字4 | `udf_no4` | float |  |
| `WAA984` | 自定数字5 | `udf_no5` | float |  |
| `WAA985` | 自定数字6 | `udf_no6` | float |  |
| `WAA910` | 送审状态 | `submission_status` | string |  |
| `WAA911` | 送审人 | `reviewer` | string |  |
| `WAA912` | 审批人1 | `approver1` | string |  |
| `WAA913` | 审批结果 | `approval_result1` | string |  |
| `WAA914` | 审批意见 | `approval_opinion1` | string |  |
| `WAA915` | 审批人2 | `approver2` | string |  |
| `WAA916` | 审批结果 | `approval_result2` | string |  |
| `WAA917` | 审批意见 | `approval_opinion2` | string |  |
| `WAA918` | 审批人3 | `approver3` | string |  |
| `WAA919` | 审批结果 | `approval_result3` | string |  |
| `WAA920` | 审批意见 | `approval_opinion3` | string |  |
| `WAA921` | 审批人4 | `approver4` | string |  |
| `WAA922` | 审批结果 | `approval_result4` | string |  |
| `WAA923` | 审批意见 | `approval_opinion4` | string |  |
| `WAA924` | 审批人5 | `approver5` | string |  |
| `WAA925` | 审批结果 | `approval_result5` | string |  |
| `WAA926` | 审批意见 | `approval_opinion5` | string |  |
| `WAA927` | 审批人6 | `approver6` | string |  |
| `WAA928` | 审批结果 | `approval_result6` | string |  |
| `WAA929` | 审批意见 | `approval_opinion6` | string |  |
| `WAA930` | 终审人 | `final_approver` | string |  |
| `WAA931` | 审批结果 | `approval_result7` | string |  |
| `WAA932` | 审批意见 | `approval_opinion7` | string |  |
| `WAA933` | 通知人1 | `notifier1` | string |  |
| `WAA934` | 通知人2 | `notifier2` | string |  |
| `WAA935` | 通知人3 | `notifier3` | string |  |
| `WAA936` | 加签人 | `WAA936` | string |  |
| `WAA937` | 审批结果 | `WAA937` | string |  |
| `WAA938` | 审批意见 | `WAA938` | string |  |
| `WAA966` | 自定文字7 | `udf_text7` | string |  |
| `WAA967` | 自定文字8 | `udf_text8` | string |  |
| `WAA968` | 自定文字9 | `udf_text9` | string |  |
| `WAA969` | 自定文字10 | `udf_text10` | string |  |
| `WAA970` | 自定文字11 | `udf_text11` | string |  |
| `WAA971` | 自定文字12 | `udf_text12` | string |  |
| `WAA972` | 自定文字13 | `udf_text13` | string |  |
| `WAA973` | 自定文字14 | `udf_text14` | string |  |
| `WAA974` | 自定文字15 | `udf_text15` | string |  |
| `WAA975` | 自定文字16 | `udf_text16` | string |  |
| `WAA986` | 自定数字7 | `udf_no7` | float |  |
| `WAA987` | 自定数字8 | `udf_no8` | float |  |
| `WAA988` | 自定数字9 | `udf_no9` | float |  |
| `WAA989` | 自定数字10 | `udf_no10` | float |  |
| `WAA990` | 自定数字11 | `udf_no11` | float |  |
| `WAA991` | 自定数字12 | `udf_no12` | float |  |
| `WAA992` | 自定数字13 | `udf_no13` | float |  |
| `WAA993` | 自定数字14 | `udf_no14` | float |  |
| `WAA994` | 自定数字15 | `udf_no15` | float |  |
| `WAA995` | 自定数字16 | `udf_no16` | float |  |
| `WAA906` | 打印次数 | `print_count` | integer |  |
| `WAA907` | 打印时间 | `print_time` | string |  |
| `WAA908` | 打印人员 | `printer` | string |  |
| `WAA909` | 打印人员姓名 | `printer_name` | string |  |
| `WAA950` | 送审时间 | `submission_time_for_review` | string |  |
| `WAA951` | 审批时间1 | `approval_time1` | string |  |
| `WAA952` | 审批时间2 | `approval_time2` | string |  |
| `WAA953` | 审批时间3 | `approval_time3` | string |  |
| `WAA954` | 审批时间4 | `approval_time4` | string |  |
| `WAA955` | 审批时间5 | `approval_time5` | string |  |
| `WAA956` | 审批时间6 | `approval_time6` | string |  |
| `WAA957` | 终审时间 | `final_review_time` | string |  |
| `WAA958` | 加签时间 | `WAA958` | string |  |
| `WAA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (OASWAB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `WAB001` | 单号 | `WAB001` | string |  |
| `WAB002` | 序号 | `WAB002` | string |  |
| `WAB003` | 乘车人 | `WAB003` | string |  |
| `WAB004` | 乘车日期 | `WAB004` | string |  |
| `WAB005` | 精确时间 | `WAB005` | string |  |
| `WAB006` | 乘车事由 | `WAB006` | string |  |
| `WAB007` | 报销金额 | `WAB007` | float |  |
| `WAB008` | 本币报销金额 | `WAB008` | float |  |
| `WAB009` | 乘车起止点 | `WAB009` | string |  |
| `WAB010` | 备注 | `WAB010` | string |  |
| `WAB011` | 审核码 | `WAB011` | string |  |
| `WAB012` | 预留字段 | `WAB012` | string |  |
| `WAB013` | 预留字段 | `WAB013` | string |  |
| `WAB014` | 预留字段 | `WAB014` | string |  |
| `WAB015` | 预留字段 | `WAB015` | string |  |
| `WAB016` | 预留字段 | `WAB016` | float |  |
| `WAB017` | 预留字段 | `WAB017` | float |  |
| `WAB901` | 录入者编号 | `entry_person_no` | string |  |
| `WAB902` | 录入时间 | `entry_time` | string |  |
| `WAB903` | 更改者编号 | `changer_no` | string |  |
| `WAB904` | 更改时间 | `change_time` | string |  |
| `WAB905` | 更新标记 | `update_flag` | integer |  |
| `WAB960` | 自定文字1 | `udf_text1` | string |  |
| `WAB961` | 自定文字2 | `udf_text2` | string |  |
| `WAB962` | 自定文字3 | `udf_text3` | string |  |
| `WAB963` | 自定文字4 | `udf_text4` | string |  |
| `WAB964` | 自定文字5 | `udf_text5` | string |  |
| `WAB965` | 自定文字6 | `udf_text6` | string |  |
| `WAB980` | 自定数字1 | `udf_no1` | float |  |
| `WAB981` | 自定数字2 | `udf_no2` | float |  |
| `WAB982` | 自定数字3 | `udf_no3` | float |  |
| `WAB983` | 自定数字4 | `udf_no4` | float |  |
| `WAB984` | 自定数字5 | `udf_no5` | float |  |
| `WAB985` | 自定数字6 | `udf_no6` | float |  |
| `WAB966` | 自定文字7 | `udf_text7` | string |  |
| `WAB967` | 自定文字8 | `udf_text8` | string |  |
| `WAB968` | 自定文字9 | `udf_text9` | string |  |
| `WAB969` | 自定文字10 | `udf_text10` | string |  |
| `WAB970` | 自定文字11 | `udf_text11` | string |  |
| `WAB971` | 自定文字12 | `udf_text12` | string |  |
| `WAB972` | 自定文字13 | `udf_text13` | string |  |
| `WAB973` | 自定文字14 | `udf_text14` | string |  |
| `WAB974` | 自定文字15 | `udf_text15` | string |  |
| `WAB975` | 自定文字16 | `udf_text16` | string |  |
| `WAB986` | 自定数字7 | `udf_no7` | float |  |
| `WAB987` | 自定数字8 | `udf_no8` | float |  |
| `WAB988` | 自定数字9 | `udf_no9` | float |  |
| `WAB989` | 自定数字10 | `udf_no10` | float |  |
| `WAB990` | 自定数字11 | `udf_no11` | float |  |
| `WAB991` | 自定数字12 | `udf_no12` | float |  |
| `WAB992` | 自定数字13 | `udf_no13` | float |  |
| `WAB993` | 自定数字14 | `udf_no14` | float |  |
| `WAB994` | 自定数字15 | `udf_no15` | float |  |
| `WAB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (OASWAC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `WAC001` | 单号 | `WAC001` | string |  |
| `WAC002` | 序号 | `WAC002` | string |  |
| `WAC003` | 分摊类型 | `WAC003` | string |  |
| `WAC004` | 订单单号 | `WAC004` | string |  |
| `WAC005` | 客户编号 | `WAC005` | string |  |
| `WAC006` | 业务员编号 | `WAC006` | string |  |
| `WAC007` | 分摊金额 | `WAC007` | string |  |
| `WAC008` | 预留字段 | `WAC008` | string |  |
| `WAC009` | 预留字段 | `WAC009` | string |  |
| `WAC010` | 预留字段 | `WAC010` | string |  |
| `WAC011` | 预留字段 | `WAC011` | string |  |
| `WAC012` | 预留字段 | `WAC012` | float |  |
| `WAC013` | 预留字段 | `WAC013` | float |  |
| `WAC960` | 自定文字1 | `udf_text1` | string |  |
| `WAC961` | 自定文字2 | `udf_text2` | string |  |
| `WAC962` | 自定文字3 | `udf_text3` | string |  |
| `WAC963` | 自定文字4 | `udf_text4` | string |  |
| `WAC964` | 自定文字5 | `udf_text5` | string |  |
| `WAC965` | 自定文字6 | `udf_text6` | string |  |
| `WAC980` | 自定数字1 | `udf_no1` | float |  |
| `WAC981` | 自定数字2 | `udf_no2` | float |  |
| `WAC982` | 自定数字3 | `udf_no3` | float |  |
| `WAC983` | 自定数字4 | `udf_no4` | float |  |
| `WAC984` | 自定数字5 | `udf_no5` | float |  |
| `WAC985` | 自定数字6 | `udf_no6` | float |  |
| `WAC901` | 录入者编号 | `entry_person_no` | string |  |
| `WAC902` | 录入时间 | `entry_time` | string |  |
| `WAC903` | 更改者编号 | `changer_no` | string |  |
| `WAC904` | 更改时间 | `change_time` | string |  |
| `WAC905` | 更新标记 | `update_flag` | integer |  |
| `WAC966` | 自定文字7 | `udf_text7` | string |  |
| `WAC967` | 自定文字8 | `udf_text8` | string |  |
| `WAC968` | 自定文字9 | `udf_text9` | string |  |
| `WAC969` | 自定文字10 | `udf_text10` | string |  |
| `WAC970` | 自定文字11 | `udf_text11` | string |  |
| `WAC971` | 自定文字12 | `udf_text12` | string |  |
| `WAC972` | 自定文字13 | `udf_text13` | string |  |
| `WAC973` | 自定文字14 | `udf_text14` | string |  |
| `WAC974` | 自定文字15 | `udf_text15` | string |  |
| `WAC975` | 自定文字16 | `udf_text16` | string |  |
| `WAC986` | 自定数字7 | `udf_no7` | float |  |
| `WAC987` | 自定数字8 | `udf_no8` | float |  |
| `WAC988` | 自定数字9 | `udf_no9` | float |  |
| `WAC989` | 自定数字10 | `udf_no10` | float |  |
| `WAC990` | 自定数字11 | `udf_no11` | float |  |
| `WAC991` | 自定数字12 | `udf_no12` | float |  |
| `WAC992` | 自定数字13 | `udf_no13` | float |  |
| `WAC993` | 自定数字14 | `udf_no14` | float |  |
| `WAC994` | 自定数字15 | `udf_no15` | float |  |
| `WAC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "WAA001": ""
  ,"WAA002": ""
  ,"WAA003": ""
  ,"WAA004": ""
  ,"cdsDetail": [{
    "WAB001": ""
    ,"WAB001": ""
    ,"WAB002": ""
    ,"WAB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"WAA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"WAA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `WAA001` | `WAA001` | 单号 | 主键 |
| `WAA002` | `WAA002` | 性质 | |
| `WAA003` | `WAA003` | 申请日期 | |
| `WAA004` | `WAA004` | 申请人 | |
| `WAA005` | `WAA005` | 申请人部门 | |
| `WAA006` | `WAA006` | 代办人 | |
| `WAA007` | `WAA007` | 代办人部门 | |
| `WAA008` | `WAA008` | 币种 | |
| `WAA009` | `WAA009` | 汇率 | |
| `WAA010` | `WAA010` | 项目 | |
| `WAB001` | `WAB001` | 单号 (单身) | |
| `WAB002` | `WAB002` | 序号 (单身) | |
| `WAB003` | `WAB003` | 乘车人 (单身) | |
| `WAB004` | `WAB004` | 乘车日期 (单身) | |
| `WAB005` | `WAB005` | 精确时间 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `WAA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `WAA001`
