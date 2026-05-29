# CLI 规格说明书：销售发票

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `sales.invoice` |
| **DLL** | `YSFSC05` |
| **服务名称** | `销售发票` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.invoice" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.invoice" \
  --action "getMultiple" \
  --data '{"datakeys":[{"GGA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.invoice" \
  --action "create" \
  --data '{"GGA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sales.invoice" \
  --action "approve" \
  --data '{"datakeys":[{"GGA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `GGA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (YSFGGA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GGA001` | 发票号码 | `GGA001` | string | 主键 |
| `GGA002` | 发票性质 | `GGA002` | string |  |
| `GGA003` | 发票种类 | `GGA003` | string |  |
| `GGA004` | 发票来源 | `GGA004` | string |  |
| `GGA005` | 单据日期 | `GGA005` | string |  |
| `GGA006` | 客户 | `GGA006` | string |  |
| `GGA007` | 部门 | `GGA007` | string |  |
| `GGA008` | 业务员 | `GGA008` | string |  |
| `GGA009` | 币种 | `GGA009` | string |  |
| `GGA010` | 汇率 | `GGA010` | float |  |
| `GGA011` | 税率 | `GGA011` | float |  |
| `GGA012` | 专案 | `GGA012` | string |  |
| `GGA013` | 预收款日 | `GGA013` | string |  |
| `GGA014` | 备注 | `GGA014` | string |  |
| `GGA015` | 凭证抛砖否 | `GGA015` | string |  |
| `GGA016` | 凭证编号 | `GGA016` | string |  |
| `GGA017` | 性质 | `GGA017` | string |  |
| `GGA018` | 发票处理 | `GGA018` | string |  |
| `GGA019` | 无税金额 | `GGA019` | float |  |
| `GGA020` | 税额 | `GGA020` | float |  |
| `GGA021` | 本币无税金额 | `GGA021` | float |  |
| `GGA022` | 本币税额 | `GGA022` | float |  |
| `GGA023` | 购买票据否 | `GGA023` | string |  |
| `GGA024` | 现收 | `GGA024` | string |  |
| `GGA025` | 现收金额 | `GGA025` | float |  |
| `GGA026` | 结算方式 | `GGA026` | string |  |
| `GGA027` | 票据号码 | `GGA027` | string |  |
| `GGA028` | 收款单号 | `GGA028` | string |  |
| `GGA029` | 制单人 | `GGA029` | string |  |
| `GGA030` | 审核人 | `GGA030` | string |  |
| `GGA031` | 预留 | `GGA031` | string |  |
| `GGA032` | 审核码 | `GGA032` | string |  |
| `GGA033` | 预留(复核编号) | `GGA033` | string |  |
| `GGA034` | 预留(复核姓名) | `GGA034` | string |  |
| `GGA035` | 红冲发票单号 | `GGA035` | string |  |
| `GGA036` | 预留 | `GGA036` | string |  |
| `GGA037` | 预留 | `GGA037` | string |  |
| `GGA038` | 预留 | `GGA038` | string |  |
| `GGA039` | 预留 | `GGA039` | float |  |
| `GGA040` | 预留 | `GGA040` | float |  |
| `GGA041` | 销售类型 | `GGA041` | string |  |
| `GGA042` | 发出商品凭证抛转否 | `GGA042` | string |  |
| `GGA043` | 发出商品凭证编号 | `GGA043` | string |  |
| `GGA044` | 凭证类别 | `GGA044` | string |  |
| `GGA045` | 发出商品凭证类别 | `GGA045` | string |  |
| `GGA046` | 核销方式 | `GGA046` | string |  |
| `GGA047` | 开票状态 | `GGA047` | string |  |
| `GGA048` | 金税发票代码 | `GGA048` | string |  |
| `GGA049` | 金税发票号码 | `GGA049` | string |  |
| `GGA050` | 金税发票日期 | `GGA050` | string |  |
| `GGA051` | 拆分标签 | `GGA051` | string |  |
| `GGA052` | 电子发票 | `GGA052` | string |  |
| `GGA053` | 税盘信息 | `GGA053` | string |  |
| `GGA054` | 发票打印 | `GGA054` | string |  |
| `GGA055` | 发票清单打印 | `GGA055` | string |  |
| `GGA056` | 是否打印清单 | `GGA056` | string |  |
| `GGA057` | 发票URL地址 | `url` | string |  |
| `GGA058` | 红字专票信息表编号 | `GGA058` | string |  |
| `GGA059` | 正票发票号码 | `GGA059` | string |  |
| `GGA060` | 正票发票代码 | `GGA060` | string |  |
| `GGA061` | 开票结果 | `GGA061` | string |  |
| `GGA062` | 错误原因 | `GGA062` | string |  |
| `GGA063` | 打印结果 | `GGA063` | string |  |
| `GGA064` | 打印报错原因 | `GGA064` | string |  |
| `GGA065` | 红冲原因 | `GGA065` | string |  |
| `GGA066` | 电子发票批量下载状态码 | `GGA066` | string |  |
| `GGA901` | 录入者编号 | `entry_person_no` | string |  |
| `GGA902` | 录入时间 | `entry_time` | string |  |
| `GGA903` | 更改者编号 | `changer_no` | string |  |
| `GGA904` | 更改时间 | `change_time` | string |  |
| `GGA905` | 更新标记 | `update_flag` | integer |  |
| `GGA960` | 自定文字1 | `udf_text1` | string |  |
| `GGA961` | 自定文字2 | `udf_text2` | string |  |
| `GGA962` | 自定文字3 | `udf_text3` | string |  |
| `GGA963` | 自定文字4 | `udf_text4` | string |  |
| `GGA964` | 自定文字5 | `udf_text5` | string |  |
| `GGA965` | 自定文字6 | `udf_text6` | string |  |
| `GGA980` | 自定数字1 | `udf_no1` | float |  |
| `GGA981` | 自定数字2 | `udf_no2` | float |  |
| `GGA982` | 自定数字3 | `udf_no3` | float |  |
| `GGA983` | 自定数字4 | `udf_no4` | float |  |
| `GGA984` | 自定数字5 | `udf_no5` | float |  |
| `GGA985` | 自定数字6 | `udf_no6` | float |  |
| `GGA910` | 送审状态 | `submission_status` | string |  |
| `GGA911` | 送审人 | `reviewer` | string |  |
| `GGA912` | 审批人1 | `approver1` | string |  |
| `GGA913` | 审批结果 | `approval_result1` | string |  |
| `GGA914` | 审批意见 | `approval_opinion1` | string |  |
| `GGA915` | 审批人2 | `approver2` | string |  |
| `GGA916` | 审批结果 | `approval_result2` | string |  |
| `GGA917` | 审批意见 | `approval_opinion2` | string |  |
| `GGA918` | 审批人3 | `approver3` | string |  |
| `GGA919` | 审批结果 | `approval_result3` | string |  |
| `GGA920` | 审批意见 | `approval_opinion3` | string |  |
| `GGA921` | 审批人4 | `approver4` | string |  |
| `GGA922` | 审批结果 | `approval_result4` | string |  |
| `GGA923` | 审批意见 | `approval_opinion4` | string |  |
| `GGA924` | 审批人5 | `approver5` | string |  |
| `GGA925` | 审批结果 | `approval_result5` | string |  |
| `GGA926` | 审批意见 | `approval_opinion5` | string |  |
| `GGA927` | 审批人6 | `approver6` | string |  |
| `GGA928` | 审批结果 | `approval_result6` | string |  |
| `GGA929` | 审批意见 | `approval_opinion6` | string |  |
| `GGA930` | 终审人 | `final_approver` | string |  |
| `GGA931` | 审批结果 | `approval_result7` | string |  |
| `GGA932` | 审批意见 | `approval_opinion7` | string |  |
| `GGA933` | 通知人1 | `notifier1` | string |  |
| `GGA934` | 通知人2 | `notifier2` | string |  |
| `GGA935` | 通知人3 | `notifier3` | string |  |
| `GGA966` | 自定文字7 | `udf_text7` | string |  |
| `GGA967` | 自定文字8 | `udf_text8` | string |  |
| `GGA968` | 自定文字9 | `udf_text9` | string |  |
| `GGA969` | 自定文字10 | `udf_text10` | string |  |
| `GGA970` | 自定文字11 | `udf_text11` | string |  |
| `GGA971` | 自定文字12 | `udf_text12` | string |  |
| `GGA972` | 自定文字13 | `udf_text13` | string |  |
| `GGA973` | 自定文字14 | `udf_text14` | string |  |
| `GGA974` | 自定文字15 | `udf_text15` | string |  |
| `GGA975` | 自定文字16 | `udf_text16` | string |  |
| `GGA986` | 自定数字7 | `udf_no7` | float |  |
| `GGA987` | 自定数字8 | `udf_no8` | float |  |
| `GGA988` | 自定数字9 | `udf_no9` | float |  |
| `GGA989` | 自定数字10 | `udf_no10` | float |  |
| `GGA990` | 自定数字11 | `udf_no11` | float |  |
| `GGA991` | 自定数字12 | `udf_no12` | float |  |
| `GGA992` | 自定数字13 | `udf_no13` | float |  |
| `GGA993` | 自定数字14 | `udf_no14` | float |  |
| `GGA994` | 自定数字15 | `udf_no15` | float |  |
| `GGA995` | 自定数字16 | `udf_no16` | float |  |
| `GGA906` | 打印次数 | `print_count` | integer |  |
| `GGA907` | 打印时间 | `print_time` | string |  |
| `GGA908` | 打印人员 | `printer` | string |  |
| `GGA909` | 打印人员姓名 | `printer_name` | string |  |
| `GGA950` | 送审时间 | `submission_time_for_review` | string |  |
| `GGA951` | 审批时间1 | `approval_time1` | string |  |
| `GGA952` | 审批时间2 | `approval_time2` | string |  |
| `GGA953` | 审批时间3 | `approval_time3` | string |  |
| `GGA954` | 审批时间4 | `approval_time4` | string |  |
| `GGA955` | 审批时间5 | `approval_time5` | string |  |
| `GGA956` | 审批时间6 | `approval_time6` | string |  |
| `GGA957` | 终审时间 | `final_review_time` | string |  |
| `GGA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (YSFGGB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GGB001` | 发票号码 | `GGB001` | string |  |
| `GGB002` | 序号 | `GGB002` | string |  |
| `GGB003` | 来源 | `GGB003` | string |  |
| `GGB004` | 来源单号 | `GGB004` | string |  |
| `GGB005` | 来源序号 | `GGB005` | string |  |
| `GGB006` | 品号 | `GGB006` | string |  |
| `GGB007` | 品名 | `GGB007` | string |  |
| `GGB008` | 单位 | `GGB008` | string |  |
| `GGB009` | 仓库 | `GGB009` | string |  |
| `GGB010` | 数量 | `GGB010` | float |  |
| `GGB011` | 单价 | `GGB011` | float |  |
| `GGB012` | 折扣率 | `GGB012` | float |  |
| `GGB013` | 原币无税金额 | `GGB013` | string |  |
| `GGB014` | 原币税额 | `GGB014` | string |  |
| `GGB015` | 本币无税金额 | `GGB015` | string |  |
| `GGB016` | 本币税额 | `GGB016` | string |  |
| `GGB017` | 销货冲销金额 | `GGB017` | string |  |
| `GGB018` | 审核码 | `GGB018` | string |  |
| `GGB019` | 预留 | `GGB019` | string |  |
| `GGB020` | 预留 | `GGB020` | string |  |
| `GGB021` | 销货冲销价税合计预留 | `GGB021` | float |  |
| `GGB022` | 预留 | `GGB022` | float |  |
| `GGB023` | 含税单价 | `GGB023` | float |  |
| `GGB024` | 原币价税合计 | `GGB024` | string |  |
| `GGB025` | 本币价税合计 | `GGB025` | string |  |
| `GGB026` | 单价类型 | `GGB026` | string |  |
| `GGB027` | 已冲账数量 | `GGB027` | float |  |
| `GGB028` | 已冲账金额 | `GGB028` | string |  |
| `GGB029` | 本币已冲账金额 | `GGB029` | string |  |
| `GGB030` | 税率 | `GGB030` | float |  |
| `GGB031` | 规格 | `GGB031` | string |  |
| `GGB032` | 来源子序号 | `GGB032` | string |  |
| `GGB901` | 录入者编号 | `entry_person_no` | string |  |
| `GGB902` | 录入时间 | `entry_time` | string |  |
| `GGB903` | 更改者编号 | `changer_no` | string |  |
| `GGB904` | 更改时间 | `change_time` | string |  |
| `GGB905` | 更新标记 | `update_flag` | integer |  |
| `GGB960` | 自定文字1 | `udf_text1` | string |  |
| `GGB961` | 自定文字2 | `udf_text2` | string |  |
| `GGB962` | 自定文字3 | `udf_text3` | string |  |
| `GGB963` | 自定文字4 | `udf_text4` | string |  |
| `GGB964` | 自定文字5 | `udf_text5` | string |  |
| `GGB965` | 自定文字6 | `udf_text6` | string |  |
| `GGB980` | 自定数字1 | `udf_no1` | float |  |
| `GGB981` | 自定数字2 | `udf_no2` | float |  |
| `GGB982` | 自定数字3 | `udf_no3` | float |  |
| `GGB983` | 自定数字4 | `udf_no4` | float |  |
| `GGB984` | 自定数字5 | `udf_no5` | float |  |
| `GGB985` | 自定数字6 | `udf_no6` | float |  |
| `GGB966` | 自定文字7 | `udf_text7` | string |  |
| `GGB967` | 自定文字8 | `udf_text8` | string |  |
| `GGB968` | 自定文字9 | `udf_text9` | string |  |
| `GGB969` | 自定文字10 | `udf_text10` | string |  |
| `GGB970` | 自定文字11 | `udf_text11` | string |  |
| `GGB971` | 自定文字12 | `udf_text12` | string |  |
| `GGB972` | 自定文字13 | `udf_text13` | string |  |
| `GGB973` | 自定文字14 | `udf_text14` | string |  |
| `GGB974` | 自定文字15 | `udf_text15` | string |  |
| `GGB975` | 自定文字16 | `udf_text16` | string |  |
| `GGB986` | 自定数字7 | `udf_no7` | float |  |
| `GGB987` | 自定数字8 | `udf_no8` | float |  |
| `GGB988` | 自定数字9 | `udf_no9` | float |  |
| `GGB989` | 自定数字10 | `udf_no10` | float |  |
| `GGB990` | 自定数字11 | `udf_no11` | float |  |
| `GGB991` | 自定数字12 | `udf_no12` | float |  |
| `GGB992` | 自定数字13 | `udf_no13` | float |  |
| `GGB993` | 自定数字14 | `udf_no14` | float |  |
| `GGB994` | 自定数字15 | `udf_no15` | float |  |
| `GGB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (YSFGGC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GGC001` | 发票号码 | `GGC001` | string |  |
| `GGC002` | 序号 | `GGC002` | string |  |
| `GGC003` | 来源 | `GGC003` | string |  |
| `GGC004` | 来源单号 | `GGC004` | string |  |
| `GGC005` | 来源序号 | `GGC005` | string |  |
| `GGC006` | 品号(预留) | `GGC006` | string |  |
| `GGC007` | 品名(预留) | `GGC007` | string |  |
| `GGC008` | 单位(预留) | `GGC008` | string |  |
| `GGC009` | 仓库(预留) | `GGC009` | string |  |
| `GGC010` | 数量(预留) | `GGC010` | float |  |
| `GGC011` | 单价(预留) | `GGC011` | float |  |
| `GGC012` | 折扣率(预留) | `GGC012` | float |  |
| `GGC013` | 本次冲销金额 | `GGC013` | string |  |
| `GGC014` | 原币税额 | `GGC014` | string |  |
| `GGC015` | 本币本次冲销金额 | `GGC015` | string |  |
| `GGC016` | 本币税额 | `GGC016` | string |  |
| `GGC017` | 未冲销订单发票 | `GGC017` | string |  |
| `GGC018` | 审核码 | `GGC018` | string |  |
| `GGC019` | 订单单号 | `GGC019` | string |  |
| `GGC020` | 预留 | `GGC020` | string |  |
| `GGC021` | 预留 | `GGC021` | float |  |
| `GGC022` | 预留 | `GGC022` | float |  |
| `GGC023` | 税率 | `GGC023` | float |  |
| `GGC024` | 规格 | `GGC024` | string |  |
| `GGC025` | 未冲销订金价税合计 | `GGC025` | string |  |
| `GGC901` | 录入者编号 | `entry_person_no` | string |  |
| `GGC902` | 录入时间 | `entry_time` | string |  |
| `GGC903` | 更改者编号 | `changer_no` | string |  |
| `GGC904` | 更改时间 | `change_time` | string |  |
| `GGC905` | 更新标记 | `update_flag` | integer |  |
| `GGC960` | 自定文字1 | `udf_text1` | string |  |
| `GGC961` | 自定文字2 | `udf_text2` | string |  |
| `GGC962` | 自定文字3 | `udf_text3` | string |  |
| `GGC963` | 自定文字4 | `udf_text4` | string |  |
| `GGC964` | 自定文字5 | `udf_text5` | string |  |
| `GGC965` | 自定文字6 | `udf_text6` | string |  |
| `GGC966` | 自定文字7 | `udf_text7` | string |  |
| `GGC967` | 自定文字8 | `udf_text8` | string |  |
| `GGC968` | 自定文字9 | `udf_text9` | string |  |
| `GGC969` | 自定文字10 | `udf_text10` | string |  |
| `GGC970` | 自定文字11 | `udf_text11` | string |  |
| `GGC971` | 自定文字12 | `udf_text12` | string |  |
| `GGC972` | 自定文字13 | `udf_text13` | string |  |
| `GGC973` | 自定文字14 | `udf_text14` | string |  |
| `GGC974` | 自定文字15 | `udf_text15` | string |  |
| `GGC975` | 自定文字16 | `udf_text16` | string |  |
| `GGC980` | 自定数字1 | `udf_no1` | float |  |
| `GGC981` | 自定数字2 | `udf_no2` | float |  |
| `GGC982` | 自定数字3 | `udf_no3` | float |  |
| `GGC983` | 自定数字4 | `udf_no4` | float |  |
| `GGC984` | 自定数字5 | `udf_no5` | float |  |
| `GGC985` | 自定数字6 | `udf_no6` | float |  |
| `GGC986` | 自定数字7 | `udf_no7` | float |  |
| `GGC987` | 自定数字8 | `udf_no8` | float |  |
| `GGC988` | 自定数字9 | `udf_no9` | float |  |
| `GGC989` | 自定数字10 | `udf_no10` | float |  |
| `GGC990` | 自定数字11 | `udf_no11` | float |  |
| `GGC991` | 自定数字12 | `udf_no12` | float |  |
| `GGC992` | 自定数字13 | `udf_no13` | float |  |
| `GGC993` | 自定数字14 | `udf_no14` | float |  |
| `GGC994` | 自定数字15 | `udf_no15` | float |  |
| `GGC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "GGA001": ""
  ,"GGA002": ""
  ,"GGA003": ""
  ,"GGA004": ""
  ,"cdsDetail": [{
    "GGB001": ""
    ,"GGB001": ""
    ,"GGB002": ""
    ,"GGB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"GGA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"GGA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `GGA001` | `GGA001` | 发票号码 | 主键 |
| `GGA002` | `GGA002` | 发票性质 | |
| `GGA003` | `GGA003` | 发票种类 | |
| `GGA004` | `GGA004` | 发票来源 | |
| `GGA005` | `GGA005` | 单据日期 | |
| `GGA006` | `GGA006` | 客户 | |
| `GGA007` | `GGA007` | 部门 | |
| `GGA008` | `GGA008` | 业务员 | |
| `GGA009` | `GGA009` | 币种 | |
| `GGA010` | `GGA010` | 汇率 | |
| `GGB001` | `GGB001` | 发票号码 (单身) | |
| `GGB002` | `GGB002` | 序号 (单身) | |
| `GGB003` | `GGB003` | 来源 (单身) | |
| `GGB004` | `GGB004` | 来源单号 (单身) | |
| `GGB005` | `GGB005` | 来源序号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `GGA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `GGA001`
