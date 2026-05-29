# CLI 规格说明书：付款单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `payable.doc` |
| **DLL** | `YSFFC03` |
| **服务名称** | `付款单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "payable.doc" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "payable.doc" \
  --action "getMultiple" \
  --data '{"datakeys":[{"GQA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "payable.doc" \
  --action "create" \
  --data '{"GQA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "payable.doc" \
  --action "approve" \
  --data '{"datakeys":[{"GQA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `GQA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (YSFGQA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GQA001` | 单号 | `GQA001` | string | 主键 |
| `GQA002` | 性质 | `GQA002` | string |  |
| `GQA003` | 日期 | `GQA003` | string |  |
| `GQA004` | 供应商 | `GQA004` | string |  |
| `GQA005` | 付款人 | `GQA005` | string |  |
| `GQA006` | 部门 | `GQA006` | string |  |
| `GQA007` | 币种 | `GQA007` | string |  |
| `GQA008` | 汇率 | `GQA008` | float |  |
| `GQA009` | 付款金额 | `GQA009` | float |  |
| `GQA010` | 应付冲账 | `GQA010` | float |  |
| `GQA011` | 预付冲账 | `GQA011` | float |  |
| `GQA012` | 累入预付 | `GQA012` | float |  |
| `GQA013` | 本币付款 | `GQA013` | float |  |
| `GQA014` | 本币冲账 | `GQA014` | float |  |
| `GQA015` | 本币预付冲账 | `GQA015` | float |  |
| `GQA016` | 本币累入预付 | `GQA016` | float |  |
| `GQA017` | 汇差 | `GQA017` | float |  |
| `GQA018` | 凭证抛转否 | `GQA018` | string |  |
| `GQA019` | 凭证 | `GQA019` | string |  |
| `GQA020` | 复核编号 | `GQA020` | string |  |
| `GQA021` | 复核姓名 | `GQA021` | string |  |
| `GQA022` | 审核码 | `GQA022` | string |  |
| `GQA023` | 专案 | `GQA023` | string |  |
| `GQA024` | 备注 | `GQA024` | string |  |
| `GQA025` | 来源 | `GQA025` | string |  |
| `GQA026` | 来源单号 | `GQA026` | string |  |
| `GQA027` | 购买票据否 | `GQA027` | string |  |
| `GQA028` | 日期 | `GQA028` | string |  |
| `GQA029` | 折让金额 | `GQA029` | float |  |
| `GQA030` | 本币折让 | `GQA030` | float |  |
| `GQA031` | 预留字段 | `GQA031` | string |  |
| `GQA032` | 预留字段 | `GQA032` | string |  |
| `GQA033` | 预留字段 | `GQA033` | string |  |
| `GQA034` | 预留字段 | `GQA034` | string |  |
| `GQA035` | 预留字段 | `GQA035` | float |  |
| `GQA036` | 预留字段 | `GQA036` | float |  |
| `GQA037` | 审核人 | `GQA037` | string |  |
| `GQA038` | 凭证类别 | `GQA038` | string |  |
| `GQA039` | 付款类型 | `GQA039` | string |  |
| `GQA040` | 按数量冲账 | `GQA040` | string |  |
| `GQA041` | 结算方式 | `GQA041` | string |  |
| `GQA042` | 票据号码 | `GQA042` | string |  |
| `GQA043` | 银行账号 | `GQA043` | string |  |
| `GQA044` | 票据日期 | `GQA044` | string |  |
| `GQA045` | 到期日 | `GQA045` | string |  |
| `GQA046` | 付款科目 | `GQA046` | string |  |
| `GQA047` | 折扣科目 | `GQA047` | string |  |
| `GQA048` | 升级标志 | `GQA048` | string |  |
| `GQA049` | 异币种核销 | `GQA049` | string |  |
| `GQA050` | 采购单号 | `GQA050` | string |  |
| `GQA051` | 收款方开户银行 | `GQA051` | string |  |
| `GQA052` | 收款方银行账号 | `GQA052` | string |  |
| `GQA053` | 收款方账号户名 | `GQA053` | string |  |
| `GQA054` | 收款方开户行联行号 | `GQA054` | string |  |
| `GQA055` | 收款方银行行名 | `GQA055` | string |  |
| `GQA056` | 收款方开户行名称 | `GQA056` | string |  |
| `GQA057` | 收款方开户行省份 | `GQA057` | string |  |
| `GQA058` | 收款方开户行城市 | `GQA058` | string |  |
| `GQA059` | 交易类型 | `GQA059` | string |  |
| `GQA060` | 城市类型 | `GQA060` | string |  |
| `GQA061` | 加急 | `GQA061` | string |  |
| `GQA062` | 摘要 | `GQA062` | string |  |
| `GQA063` | 交易状态 | `GQA063` | string |  |
| `GQA064` | 失败原因 | `GQA064` | string |  |
| `GQA065` | 银行流水号 | `GQA065` | string |  |
| `GQA066` | 单据来源 | `GQA066` | string |  |
| `GQA067` | 签约类型 | `GQA067` | string |  |
| `GQA068` | 协议编号 | `GQA068` | string |  |
| `GQA069` | 付款银行行号 | `GQA069` | string |  |
| `GQA070` | 发起付款时间 | `GQA070` | string |  |
| `GQA071` | 付款回传时间 | `GQA071` | string |  |
| `GQA072` | 申请者编号 | `GQA072` | string |  |
| `GQA073` | 记账日期 | `GQA073` | string |  |
| `GQA901` | 录入者编号 | `entry_person_no` | string |  |
| `GQA902` | 录入时间 | `entry_time` | string |  |
| `GQA903` | 更改者编号 | `changer_no` | string |  |
| `GQA904` | 更改时间 | `change_time` | string |  |
| `GQA905` | 更新标记 | `update_flag` | integer |  |
| `GQA906` | 打印次数 | `print_count` | integer |  |
| `GQA907` | 打印时间 | `print_time` | string |  |
| `GQA908` | 打印人员 | `printer` | string |  |
| `GQA909` | 打印人员姓名 | `printer_name` | string |  |
| `GQA910` | 送审状态 | `submission_status` | string |  |
| `GQA911` | 送审人 | `reviewer` | string |  |
| `GQA912` | 审批人1 | `approver1` | string |  |
| `GQA913` | 审批结果 | `approval_result1` | string |  |
| `GQA914` | 审批意见 | `approval_opinion1` | string |  |
| `GQA915` | 审批人2 | `approver2` | string |  |
| `GQA916` | 审批结果 | `approval_result2` | string |  |
| `GQA917` | 审批意见 | `approval_opinion2` | string |  |
| `GQA918` | 审批人3 | `approver3` | string |  |
| `GQA919` | 审批结果 | `approval_result3` | string |  |
| `GQA920` | 审批意见 | `approval_opinion3` | string |  |
| `GQA921` | 审批人4 | `approver4` | string |  |
| `GQA922` | 审批结果 | `approval_result4` | string |  |
| `GQA923` | 审批意见 | `approval_opinion4` | string |  |
| `GQA924` | 审批人5 | `approver5` | string |  |
| `GQA925` | 审批结果 | `approval_result5` | string |  |
| `GQA926` | 审批意见 | `approval_opinion5` | string |  |
| `GQA927` | 审批人6 | `approver6` | string |  |
| `GQA928` | 审批结果 | `approval_result6` | string |  |
| `GQA929` | 审批意见 | `approval_opinion6` | string |  |
| `GQA930` | 终审人 | `final_approver` | string |  |
| `GQA931` | 审批结果 | `approval_result7` | string |  |
| `GQA932` | 审批意见 | `approval_opinion7` | string |  |
| `GQA933` | 通知人1 | `notifier1` | string |  |
| `GQA934` | 通知人2 | `notifier2` | string |  |
| `GQA935` | 通知人3 | `notifier3` | string |  |
| `GQA960` | 自定文字1 | `udf_text1` | string |  |
| `GQA961` | 自定文字2 | `udf_text2` | string |  |
| `GQA962` | 自定文字3 | `udf_text3` | string |  |
| `GQA963` | 自定文字4 | `udf_text4` | string |  |
| `GQA964` | 自定文字5 | `udf_text5` | string |  |
| `GQA965` | 自定文字6 | `udf_text6` | string |  |
| `GQA966` | 自定文字7 | `udf_text7` | string |  |
| `GQA967` | 自定文字8 | `udf_text8` | string |  |
| `GQA968` | 自定文字9 | `udf_text9` | string |  |
| `GQA969` | 自定文字10 | `udf_text10` | string |  |
| `GQA970` | 自定文字11 | `udf_text11` | string |  |
| `GQA971` | 自定文字12 | `udf_text12` | string |  |
| `GQA972` | 自定文字13 | `udf_text13` | string |  |
| `GQA973` | 自定文字14 | `udf_text14` | string |  |
| `GQA974` | 自定文字15 | `udf_text15` | string |  |
| `GQA975` | 自定文字16 | `udf_text16` | string |  |
| `GQA980` | 自定数字1 | `udf_no1` | float |  |
| `GQA981` | 自定数字2 | `udf_no2` | float |  |
| `GQA982` | 自定数字3 | `udf_no3` | float |  |
| `GQA983` | 自定数字4 | `udf_no4` | float |  |
| `GQA984` | 自定数字5 | `udf_no5` | float |  |
| `GQA985` | 自定数字6 | `udf_no6` | float |  |
| `GQA986` | 自定数字7 | `udf_no7` | float |  |
| `GQA987` | 自定数字8 | `udf_no8` | float |  |
| `GQA988` | 自定数字9 | `udf_no9` | float |  |
| `GQA989` | 自定数字10 | `udf_no10` | float |  |
| `GQA990` | 自定数字11 | `udf_no11` | float |  |
| `GQA991` | 自定数字12 | `udf_no12` | float |  |
| `GQA992` | 自定数字13 | `udf_no13` | float |  |
| `GQA993` | 自定数字14 | `udf_no14` | float |  |
| `GQA994` | 自定数字15 | `udf_no15` | float |  |
| `GQA995` | 自定数字16 | `udf_no16` | float |  |
| `GQA950` | 送审时间 | `submission_time_for_review` | string |  |
| `GQA951` | 审批时间1 | `approval_time1` | string |  |
| `GQA952` | 审批时间2 | `approval_time2` | string |  |
| `GQA953` | 审批时间3 | `approval_time3` | string |  |
| `GQA954` | 审批时间4 | `approval_time4` | string |  |
| `GQA955` | 审批时间5 | `approval_time5` | string |  |
| `GQA956` | 审批时间6 | `approval_time6` | string |  |
| `GQA957` | 终审时间 | `final_review_time` | string |  |
| `GQA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (YSFGQB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GQB001` | 单号 | `GQB001` | string |  |
| `GQB002` | 序号 | `GQB002` | string |  |
| `GQB003` | 结算方式 | `GQB003` | string |  |
| `GQB004` | 金额 | `GQB004` | float |  |
| `GQB005` | 本币金额 | `GQB005` | float |  |
| `GQB006` | 票据号码 | `GQB006` | string |  |
| `GQB007` | 预留字段 | `GQB007` | string |  |
| `GQB008` | 付款账号 | `GQB008` | string |  |
| `GQB009` | 到期日 | `GQB009` | string |  |
| `GQB010` | 预兑日 | `GQB010` | string |  |
| `GQB011` | 审核码 | `GQB011` | string |  |
| `GQB012` | 会计科目 | `GQB012` | string |  |
| `GQB013` | 出票日 | `GQB013` | string |  |
| `GQB014` | 预留字段 | `GQB014` | string |  |
| `GQB015` | 预留字段 | `GQB015` | string |  |
| `GQB016` | 预留字段 | `GQB016` | string |  |
| `GQB017` | 预留字段 | `GQB017` | string |  |
| `GQB018` | 预留字段 | `GQB018` | float |  |
| `GQB019` | 预留字段 | `GQB019` | float |  |
| `GQB020` | 预留(删除码) | `GQB020` | string |  |
| `GQB901` | 录入者编号 | `entry_person_no` | string |  |
| `GQB902` | 录入时间 | `entry_time` | string |  |
| `GQB903` | 更改者编号 | `changer_no` | string |  |
| `GQB904` | 更改时间 | `change_time` | string |  |
| `GQB905` | 更新标记 | `update_flag` | integer |  |
| `GQB960` | 自定文字1 | `udf_text1` | string |  |
| `GQB961` | 自定文字2 | `udf_text2` | string |  |
| `GQB962` | 自定文字3 | `udf_text3` | string |  |
| `GQB963` | 自定文字4 | `udf_text4` | string |  |
| `GQB964` | 自定文字5 | `udf_text5` | string |  |
| `GQB965` | 自定文字6 | `udf_text6` | string |  |
| `GQB980` | 自定数字1 | `udf_no1` | float |  |
| `GQB981` | 自定数字2 | `udf_no2` | float |  |
| `GQB982` | 自定数字3 | `udf_no3` | float |  |
| `GQB983` | 自定数字4 | `udf_no4` | float |  |
| `GQB984` | 自定数字5 | `udf_no5` | float |  |
| `GQB985` | 自定数字6 | `udf_no6` | float |  |
| `GQB966` | 自定文字7 | `udf_text7` | string |  |
| `GQB967` | 自定文字8 | `udf_text8` | string |  |
| `GQB968` | 自定文字9 | `udf_text9` | string |  |
| `GQB969` | 自定文字10 | `udf_text10` | string |  |
| `GQB970` | 自定文字11 | `udf_text11` | string |  |
| `GQB971` | 自定文字12 | `udf_text12` | string |  |
| `GQB972` | 自定文字13 | `udf_text13` | string |  |
| `GQB973` | 自定文字14 | `udf_text14` | string |  |
| `GQB974` | 自定文字15 | `udf_text15` | string |  |
| `GQB975` | 自定文字16 | `udf_text16` | string |  |
| `GQB986` | 自定数字7 | `udf_no7` | float |  |
| `GQB987` | 自定数字8 | `udf_no8` | float |  |
| `GQB988` | 自定数字9 | `udf_no9` | float |  |
| `GQB989` | 自定数字10 | `udf_no10` | float |  |
| `GQB990` | 自定数字11 | `udf_no11` | float |  |
| `GQB991` | 自定数字12 | `udf_no12` | float |  |
| `GQB992` | 自定数字13 | `udf_no13` | float |  |
| `GQB993` | 自定数字14 | `udf_no14` | float |  |
| `GQB994` | 自定数字15 | `udf_no15` | float |  |
| `GQB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (YSFGQC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GQC001` | 付款单号 | `GQC001` | string |  |
| `GQC002` | 序号 | `GQC002` | string |  |
| `GQC003` | 付款日期 | `GQC003` | string |  |
| `GQC004` | 来源 | `GQC004` | string |  |
| `GQC005` | 来源单号 | `GQC005` | string |  |
| `GQC006` | 来源日期 | `GQC006` | string |  |
| `GQC007` | 应付金额 | `GQC007` | float |  |
| `GQC008` | 总本次冲账 | `GQC008` | float |  |
| `GQC009` | 预留 | `GQC009` | float |  |
| `GQC010` | 汇率 | `GQC010` | float |  |
| `GQC011` | 本币应付 | `GQC011` | float |  |
| `GQC012` | 总本币冲账 | `GQC012` | float |  |
| `GQC013` | 预留 | `GQC013` | float |  |
| `GQC014` | 币种 | `GQC014` | string |  |
| `GQC015` | 供应商 | `GQC015` | string |  |
| `GQC016` | 部门 | `GQC016` | string |  |
| `GQC017` | 经办人 | `GQC017` | string |  |
| `GQC018` | 专案 | `GQC018` | string |  |
| `GQC019` | 审核码 | `GQC019` | string |  |
| `GQC020` | 预结账日 | `GQC020` | string |  |
| `GQC021` | 预付款日 | `GQC021` | string |  |
| `GQC022` | 折让金额 | `GQC022` | float |  |
| `GQC023` | 本币折让 | `GQC023` | float |  |
| `GQC024` | 本次冲账 | `GQC024` | float |  |
| `GQC025` | 本币冲账 | `GQC025` | float |  |
| `GQC026` | 预留字段 | `GQC026` | string |  |
| `GQC027` | 预留字段 | `GQC027` | string |  |
| `GQC028` | 预留字段 | `GQC028` | string |  |
| `GQC029` | 预留字段 | `GQC029` | string |  |
| `GQC030` | 预留字段 | `GQC030` | float |  |
| `GQC031` | 预留字段 | `GQC031` | float |  |
| `GQC032` | 预留(删除码) | `GQC032` | string |  |
| `GQC033` | 预留 | `GQC033` | string |  |
| `GQC034` | 预留 | `GQC034` | string |  |
| `GQC035` | 预留 | `GQC035` | string |  |
| `GQC036` | 品号 | `GQC036` | string |  |
| `GQC037` | 品名 | `GQC037` | string |  |
| `GQC038` | 单位 | `GQC038` | string |  |
| `GQC039` | 数量 | `GQC039` | float |  |
| `GQC040` | 单价 | `GQC040` | float |  |
| `GQC041` | 金额 | `GQC041` | string |  |
| `GQC042` | 税额 | `GQC042` | string |  |
| `GQC043` | 价税合计 | `GQC043` | string |  |
| `GQC044` | 未冲账数量 | `GQC044` | float |  |
| `GQC045` | 本次冲账数量 | `GQC045` | float |  |
| `GQC046` | 来源序号 | `GQC046` | string |  |
| `GQC047` | 含税 | `GQC047` | string |  |
| `GQC048` | 含税单价 | `GQC048` | float |  |
| `GQC049` | 规格 | `GQC049` | string |  |
| `GQC901` | 录入者编号 | `entry_person_no` | string |  |
| `GQC902` | 录入时间 | `entry_time` | string |  |
| `GQC903` | 更改者编号 | `changer_no` | string |  |
| `GQC904` | 更改时间 | `change_time` | string |  |
| `GQC905` | 更新标记 | `update_flag` | integer |  |
| `GQC960` | 自定文字1 | `udf_text1` | string |  |
| `GQC961` | 自定文字2 | `udf_text2` | string |  |
| `GQC962` | 自定文字3 | `udf_text3` | string |  |
| `GQC963` | 自定文字4 | `udf_text4` | string |  |
| `GQC964` | 自定文字5 | `udf_text5` | string |  |
| `GQC965` | 自定文字6 | `udf_text6` | string |  |
| `GQC980` | 自定数字1 | `udf_no1` | float |  |
| `GQC981` | 自定数字2 | `udf_no2` | float |  |
| `GQC982` | 自定数字3 | `udf_no3` | float |  |
| `GQC983` | 自定数字4 | `udf_no4` | float |  |
| `GQC984` | 自定数字5 | `udf_no5` | float |  |
| `GQC985` | 自定数字6 | `udf_no6` | float |  |
| `GQC966` | 自定文字7 | `udf_text7` | string |  |
| `GQC967` | 自定文字8 | `udf_text8` | string |  |
| `GQC968` | 自定文字9 | `udf_text9` | string |  |
| `GQC969` | 自定文字10 | `udf_text10` | string |  |
| `GQC970` | 自定文字11 | `udf_text11` | string |  |
| `GQC971` | 自定文字12 | `udf_text12` | string |  |
| `GQC972` | 自定文字13 | `udf_text13` | string |  |
| `GQC973` | 自定文字14 | `udf_text14` | string |  |
| `GQC974` | 自定文字15 | `udf_text15` | string |  |
| `GQC975` | 自定文字16 | `udf_text16` | string |  |
| `GQC986` | 自定数字7 | `udf_no7` | float |  |
| `GQC987` | 自定数字8 | `udf_no8` | float |  |
| `GQC988` | 自定数字9 | `udf_no9` | float |  |
| `GQC989` | 自定数字10 | `udf_no10` | float |  |
| `GQC990` | 自定数字11 | `udf_no11` | float |  |
| `GQC991` | 自定数字12 | `udf_no12` | float |  |
| `GQC992` | 自定数字13 | `udf_no13` | float |  |
| `GQC993` | 自定数字14 | `udf_no14` | float |  |
| `GQC994` | 自定数字15 | `udf_no15` | float |  |
| `GQC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "GQA001": ""
  ,"GQA002": ""
  ,"GQA003": ""
  ,"GQA004": ""
  ,"cdsDetail": [{
    "GQB001": ""
    ,"GQB001": ""
    ,"GQB002": ""
    ,"GQB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"GQA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"GQA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `GQA001` | `GQA001` | 单号 | 主键 |
| `GQA002` | `GQA002` | 性质 | |
| `GQA003` | `GQA003` | 日期 | |
| `GQA004` | `GQA004` | 供应商 | |
| `GQA005` | `GQA005` | 付款人 | |
| `GQA006` | `GQA006` | 部门 | |
| `GQA007` | `GQA007` | 币种 | |
| `GQA008` | `GQA008` | 汇率 | |
| `GQA009` | `GQA009` | 付款金额 | |
| `GQA010` | `GQA010` | 应付冲账 | |
| `GQB001` | `GQB001` | 单号 (单身) | |
| `GQB002` | `GQB002` | 序号 (单身) | |
| `GQB003` | `GQB003` | 结算方式 (单身) | |
| `GQB004` | `GQB004` | 金额 (单身) | |
| `GQB005` | `GQB005` | 本币金额 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `GQA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `GQA001`
