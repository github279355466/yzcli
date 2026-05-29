# CLI 规格说明书：其他应收账款

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `other.receivable` |
| **DLL** | `YSFSC02` |
| **服务名称** | `其他应收账款` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.receivable" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.receivable" \
  --action "getMultiple" \
  --data '{"datakeys":[{"GAA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.receivable" \
  --action "create" \
  --data '{"GAA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.receivable" \
  --action "approve" \
  --data '{"datakeys":[{"GAA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `GAA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (YSFGAA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GAA001` | 单号 | `GAA001` | string | 主键 |
| `GAA002` | 性质 | `GAA002` | string |  |
| `GAA003` | 日期 | `GAA003` | string |  |
| `GAA004` | 请款客户 | `GAA004` | string |  |
| `GAA005` | 业务员 | `GAA005` | string |  |
| `GAA006` | 部门 | `GAA006` | string |  |
| `GAA007` | 币种 | `GAA007` | string |  |
| `GAA008` | 汇率 | `GAA008` | float |  |
| `GAA009` | (预留)预结账日 | `GAA009` | string |  |
| `GAA010` | 预收款日 | `GAA010` | string |  |
| `GAA011` | 专案 | `GAA011` | string |  |
| `GAA012` | 预留字段 | `GAA012` | string |  |
| `GAA013` | 预留(发票种类) | `GAA013` | string |  |
| `GAA014` | 预留(税率) | `GAA014` | float |  |
| `GAA015` | 预留(发票日期) | `GAA015` | string |  |
| `GAA016` | 预留(发票号码) | `GAA016` | string |  |
| `GAA017` | 预留(发票处理) | `GAA017` | string |  |
| `GAA018` | 预留(已开发票金额) | `GAA018` | float |  |
| `GAA019` | 预留(已开发票税额) | `GAA019` | float |  |
| `GAA020` | 金额 | `GAA020` | float |  |
| `GAA021` | 预留(税额) | `GAA021` | float |  |
| `GAA022` | 本币金额 | `GAA022` | float |  |
| `GAA023` | 预留(本币税额) | `GAA023` | float |  |
| `GAA024` | (预留)借方科目 | `GAA024` | string |  |
| `GAA025` | 凭证抛转否 | `GAA025` | string |  |
| `GAA026` | 凭证 | `GAA026` | string |  |
| `GAA027` | 复核编号 | `GAA027` | string |  |
| `GAA028` | 复核姓名 | `GAA028` | string |  |
| `GAA029` | 审核码 | `GAA029` | string |  |
| `GAA030` | 备注 | `GAA030` | string |  |
| `GAA031` | 预留(抛增值税否) | `GAA031` | string |  |
| `GAA032` | 现收 | `GAA032` | string |  |
| `GAA033` | 现收金额 | `GAA033` | float |  |
| `GAA034` | 结算方式 | `GAA034` | string |  |
| `GAA035` | 预留(预兑现日) | `GAA035` | string |  |
| `GAA036` | 票据号码 | `GAA036` | string |  |
| `GAA037` | 收款单号 | `GAA037` | string |  |
| `GAA038` | 发票性质 | `GAA038` | string |  |
| `GAA039` | 预留 | `GAA039` | string |  |
| `GAA040` | 预留字段 | `GAA040` | float |  |
| `GAA041` | 预留字段 | `GAA041` | float |  |
| `GAA042` | 预留 | `GAA042` | string |  |
| `GAA043` | 预留 | `GAA043` | string |  |
| `GAA044` | 审核人 | `GAA044` | string |  |
| `GAA045` | 凭证类别 | `GAA045` | string |  |
| `GAA046` | 结算科目 | `GAA046` | string |  |
| `GAA901` | 录入者编号 | `entry_person_no` | string |  |
| `GAA902` | 录入时间 | `entry_time` | string |  |
| `GAA903` | 更改者编号 | `changer_no` | string |  |
| `GAA904` | 更改时间 | `change_time` | string |  |
| `GAA905` | 更新标记 | `update_flag` | integer |  |
| `GAA960` | 自定文字1 | `udf_text1` | string |  |
| `GAA961` | 自定文字2 | `udf_text2` | string |  |
| `GAA962` | 自定文字3 | `udf_text3` | string |  |
| `GAA963` | 自定文字4 | `udf_text4` | string |  |
| `GAA964` | 自定文字5 | `udf_text5` | string |  |
| `GAA965` | 自定文字6 | `udf_text6` | string |  |
| `GAA980` | 自定数字1 | `udf_no1` | float |  |
| `GAA981` | 自定数字2 | `udf_no2` | float |  |
| `GAA982` | 自定数字3 | `udf_no3` | float |  |
| `GAA983` | 自定数字4 | `udf_no4` | float |  |
| `GAA984` | 自定数字5 | `udf_no5` | float |  |
| `GAA985` | 自定数字6 | `udf_no6` | float |  |
| `GAA966` | 自定文字7 | `udf_text7` | string |  |
| `GAA967` | 自定文字8 | `udf_text8` | string |  |
| `GAA968` | 自定文字9 | `udf_text9` | string |  |
| `GAA969` | 自定文字10 | `udf_text10` | string |  |
| `GAA970` | 自定文字11 | `udf_text11` | string |  |
| `GAA971` | 自定文字12 | `udf_text12` | string |  |
| `GAA972` | 自定文字13 | `udf_text13` | string |  |
| `GAA973` | 自定文字14 | `udf_text14` | string |  |
| `GAA974` | 自定文字15 | `udf_text15` | string |  |
| `GAA975` | 自定文字16 | `udf_text16` | string |  |
| `GAA986` | 自定数字7 | `udf_no7` | float |  |
| `GAA987` | 自定数字8 | `udf_no8` | float |  |
| `GAA988` | 自定数字9 | `udf_no9` | float |  |
| `GAA989` | 自定数字10 | `udf_no10` | float |  |
| `GAA990` | 自定数字11 | `udf_no11` | float |  |
| `GAA991` | 自定数字12 | `udf_no12` | float |  |
| `GAA992` | 自定数字13 | `udf_no13` | float |  |
| `GAA993` | 自定数字14 | `udf_no14` | float |  |
| `GAA994` | 自定数字15 | `udf_no15` | float |  |
| `GAA995` | 自定数字16 | `udf_no16` | float |  |
| `GAA906` | 打印次数 | `print_count` | integer |  |
| `GAA907` | 打印时间 | `print_time` | string |  |
| `GAA908` | 打印人员 | `printer` | string |  |
| `GAA909` | 打印人员姓名 | `printer_name` | string |  |
| `GAA910` | 送审状态 | `submission_status` | string |  |
| `GAA911` | 送审人 | `reviewer` | string |  |
| `GAA912` | 审批人1 | `approver1` | string |  |
| `GAA913` | 审批结果 | `approval_result1` | string |  |
| `GAA914` | 审批意见 | `approval_opinion1` | string |  |
| `GAA915` | 审批人2 | `approver2` | string |  |
| `GAA916` | 审批结果 | `approval_result2` | string |  |
| `GAA917` | 审批意见 | `approval_opinion2` | string |  |
| `GAA918` | 审批人3 | `approver3` | string |  |
| `GAA919` | 审批结果 | `approval_result3` | string |  |
| `GAA920` | 审批意见 | `approval_opinion3` | string |  |
| `GAA921` | 审批人4 | `approver4` | string |  |
| `GAA922` | 审批结果 | `approval_result4` | string |  |
| `GAA923` | 审批意见 | `approval_opinion4` | string |  |
| `GAA924` | 审批人5 | `approver5` | string |  |
| `GAA925` | 审批结果 | `approval_result5` | string |  |
| `GAA926` | 审批意见 | `approval_opinion5` | string |  |
| `GAA927` | 审批人6 | `approver6` | string |  |
| `GAA928` | 审批结果 | `approval_result6` | string |  |
| `GAA929` | 审批意见 | `approval_opinion6` | string |  |
| `GAA930` | 终审人 | `final_approver` | string |  |
| `GAA931` | 审批结果 | `approval_result7` | string |  |
| `GAA932` | 审批意见 | `approval_opinion7` | string |  |
| `GAA933` | 通知人1 | `notifier1` | string |  |
| `GAA934` | 通知人2 | `notifier2` | string |  |
| `GAA935` | 通知人3 | `notifier3` | string |  |
| `GAA950` | 送审时间 | `submission_time_for_review` | string |  |
| `GAA951` | 审批时间1 | `approval_time1` | string |  |
| `GAA952` | 审批时间2 | `approval_time2` | string |  |
| `GAA953` | 审批时间3 | `approval_time3` | string |  |
| `GAA954` | 审批时间4 | `approval_time4` | string |  |
| `GAA955` | 审批时间5 | `approval_time5` | string |  |
| `GAA956` | 审批时间6 | `approval_time6` | string |  |
| `GAA957` | 终审时间 | `final_review_time` | string |  |
| `GAA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (YSFGAB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GAB001` | 单号 | `GAB001` | string |  |
| `GAB002` | 序号 | `GAB002` | string |  |
| `GAB003` | 金额 | `GAB003` | string |  |
| `GAB004` | 本币金额 | `GAB004` | string |  |
| `GAB005` | 贷方科目 | `GAB005` | string |  |
| `GAB006` | 审核码 | `GAB006` | string |  |
| `GAB007` | 日期 | `GAB007` | string |  |
| `GAB008` | 税率 | `GAB008` | float |  |
| `GAB009` | 税额 | `GAB009` | string |  |
| `GAB010` | 本币税额 | `GAB010` | string |  |
| `GAB011` | 货款名称 | `GAB011` | string |  |
| `GAB012` | 来源(预留) | `GAB012` | string |  |
| `GAB013` | 来源单号(预留) | `GAB013` | string |  |
| `GAB014` | 预留 | `GAB014` | string |  |
| `GAB015` | 预留 | `GAB015` | string |  |
| `GAB016` | 预留字段 | `GAB016` | float |  |
| `GAB017` | 预留字段 | `GAB017` | float |  |
| `GAB901` | 录入者编号 | `entry_person_no` | string |  |
| `GAB902` | 录入时间 | `entry_time` | string |  |
| `GAB903` | 更改者编号 | `changer_no` | string |  |
| `GAB904` | 更改时间 | `change_time` | string |  |
| `GAB905` | 更新标记 | `update_flag` | integer |  |
| `GAB960` | 自定文字1 | `udf_text1` | string |  |
| `GAB961` | 自定文字2 | `udf_text2` | string |  |
| `GAB962` | 自定文字3 | `udf_text3` | string |  |
| `GAB963` | 自定文字4 | `udf_text4` | string |  |
| `GAB964` | 自定文字5 | `udf_text5` | string |  |
| `GAB965` | 自定文字6 | `udf_text6` | string |  |
| `GAB980` | 自定数字1 | `udf_no1` | float |  |
| `GAB981` | 自定数字2 | `udf_no2` | float |  |
| `GAB982` | 自定数字3 | `udf_no3` | float |  |
| `GAB983` | 自定数字4 | `udf_no4` | float |  |
| `GAB984` | 自定数字5 | `udf_no5` | float |  |
| `GAB985` | 自定数字6 | `udf_no6` | float |  |
| `GAB966` | 自定文字7 | `udf_text7` | string |  |
| `GAB967` | 自定文字8 | `udf_text8` | string |  |
| `GAB968` | 自定文字9 | `udf_text9` | string |  |
| `GAB969` | 自定文字10 | `udf_text10` | string |  |
| `GAB970` | 自定文字11 | `udf_text11` | string |  |
| `GAB971` | 自定文字12 | `udf_text12` | string |  |
| `GAB972` | 自定文字13 | `udf_text13` | string |  |
| `GAB973` | 自定文字14 | `udf_text14` | string |  |
| `GAB974` | 自定文字15 | `udf_text15` | string |  |
| `GAB975` | 自定文字16 | `udf_text16` | string |  |
| `GAB986` | 自定数字7 | `udf_no7` | float |  |
| `GAB987` | 自定数字8 | `udf_no8` | float |  |
| `GAB988` | 自定数字9 | `udf_no9` | float |  |
| `GAB989` | 自定数字10 | `udf_no10` | float |  |
| `GAB990` | 自定数字11 | `udf_no11` | float |  |
| `GAB991` | 自定数字12 | `udf_no12` | float |  |
| `GAB992` | 自定数字13 | `udf_no13` | float |  |
| `GAB993` | 自定数字14 | `udf_no14` | float |  |
| `GAB994` | 自定数字15 | `udf_no15` | float |  |
| `GAB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "GAA001": ""
  ,"GAA002": ""
  ,"GAA003": ""
  ,"GAA004": ""
  ,"cdsDetail": [{
    "GAB001": ""
    ,"GAB001": ""
    ,"GAB002": ""
    ,"GAB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"GAA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"GAA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `GAA001` | `GAA001` | 单号 | 主键 |
| `GAA002` | `GAA002` | 性质 | |
| `GAA003` | `GAA003` | 日期 | |
| `GAA004` | `GAA004` | 请款客户 | |
| `GAA005` | `GAA005` | 业务员 | |
| `GAA006` | `GAA006` | 部门 | |
| `GAA007` | `GAA007` | 币种 | |
| `GAA008` | `GAA008` | 汇率 | |
| `GAA009` | `GAA009` | (预留)预结账日 | |
| `GAA010` | `GAA010` | 预收款日 | |
| `GAB001` | `GAB001` | 单号 (单身) | |
| `GAB002` | `GAB002` | 序号 (单身) | |
| `GAB003` | `GAB003` | 金额 (单身) | |
| `GAB004` | `GAB004` | 本币金额 (单身) | |
| `GAB005` | `GAB005` | 贷方科目 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `GAA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `GAA001`
