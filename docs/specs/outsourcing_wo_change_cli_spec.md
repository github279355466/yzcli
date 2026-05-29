# CLI 规格说明书：委外变更单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `outsourcing.wo.change` |
| **DLL** | `SGMZC17` |
| **服务名称** | `委外变更单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.wo.change" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.wo.change" \
  --action "getMultiple" \
  --data '{"datakeys":[{"RNA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.wo.change" \
  --action "create" \
  --data '{"RNA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.wo.change" \
  --action "approve" \
  --data '{"datakeys":[{"RNA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `RNA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (SGMRNA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RNA001` | 变更单单号 | `RNA001` | string |  |
| `RNA002` | 版本 | `RNA002` | string |  |
| `RNA003` | 变更日期 | `RNA003` | string |  |
| `RNA004` | 性质 | `RNA004` | string |  |
| `RNA005` | 经办人 | `RNA005` | string |  |
| `RNA006` | 部门 | `RNA006` | string |  |
| `RNA007` | 供应商 | `RNA007` | string |  |
| `RNA008` | 主件品号 | `RNA008` | string |  |
| `RNA009` | 委外数量 | `RNA009` | float |  |
| `RNA010` | 含税 | `RNA010` | string |  |
| `RNA011` | 税率 | `RNA011` | float |  |
| `RNA012` | 委外含税单价 | `RNA012` | float |  |
| `RNA013` | 委外单价 | `RNA013` | float |  |
| `RNA014` | 金额 | `RNA014` | float |  |
| `RNA015` | 本币金额 | `RNA015` | float |  |
| `RNA016` | 税额 | `RNA016` | float |  |
| `RNA017` | 本币税额 | `RNA017` | float |  |
| `RNA018` | 价税合计 | `RNA018` | float |  |
| `RNA019` | 本币价税合计 | `RNA019` | float |  |
| `RNA020` | 币种 | `RNA020` | string |  |
| `RNA021` | 汇率 | `RNA021` | float |  |
| `RNA022` | 源工单来源 | `RNA022` | string |  |
| `RNA023` | 源工单单号 | `RNA023` | string |  |
| `RNA024` | 预计开工日 | `RNA024` | string |  |
| `RNA025` | 预计完工日 | `RNA025` | string |  |
| `RNA026` | 完工码 | `RNA026` | string |  |
| `RNA027` | 备注 | `RNA027` | string |  |
| `RNA028` | 变更原因 | `RNA028` | string |  |
| `RNA029` | 审核码 | `RNA029` | string |  |
| `RNA030` | 审核人 | `RNA030` | string |  |
| `RNA031` | 开单日期 | `RNA031` | string |  |
| `RNA032` | 原性质 | `RNA032` | string |  |
| `RNA033` | 原经办人 | `RNA033` | string |  |
| `RNA034` | 原部门 | `RNA034` | string |  |
| `RNA035` | 原委外数量 | `RNA035` | float |  |
| `RNA036` | 原含税 | `RNA036` | string |  |
| `RNA037` | 原税率 | `RNA037` | float |  |
| `RNA038` | 原委外含税单价 | `RNA038` | float |  |
| `RNA039` | 原委外单价 | `RNA039` | float |  |
| `RNA040` | 原金额 | `RNA040` | float |  |
| `RNA041` | 原本币金额 | `RNA041` | float |  |
| `RNA042` | 原税额 | `RNA042` | float |  |
| `RNA043` | 原本币税额 | `RNA043` | float |  |
| `RNA044` | 原价税合计 | `RNA044` | float |  |
| `RNA045` | 原本币价税合计 | `RNA045` | float |  |
| `RNA046` | 原币种 | `RNA046` | string |  |
| `RNA047` | 原汇率 | `RNA047` | float |  |
| `RNA048` | 原源工单来源 | `RNA048` | string |  |
| `RNA049` | 原源工单号 | `RNA049` | string |  |
| `RNA050` | 原预计开工日 | `RNA050` | string |  |
| `RNA051` | 原预计完工日 | `RNA051` | string |  |
| `RNA052` | 原完工码 | `RNA052` | string |  |
| `RNA053` | 原备注 | `RNA053` | string |  |
| `RNA054` | 实际开工日 | `RNA054` | string |  |
| `RNA055` | 实际完工日 | `RNA055` | string |  |
| `RNA056` | 前置来源 | `RNA056` | string |  |
| `RNA057` | 前置单号 | `RNA057` | string |  |
| `RNA058` | 前置序号 | `RNA058` | string |  |
| `RNA059` | 计划来源 | `RNA059` | string |  |
| `RNA060` | 计划编号 | `RNA060` | string |  |
| `RNA061` | 计划序号 | `RNA061` | string |  |
| `RNA062` | 报废数量 | `RNA062` | float |  |
| `RNA063` | 已收料量 | `RNA063` | float |  |
| `RNA064` | 已完工量 | `RNA064` | float |  |
| `RNA065` | 发放方式 | `RNA065` | string |  |
| `RNA066` | 预留字段 | `RNA066` | string |  |
| `RNA067` | 预留字段 | `RNA067` | string |  |
| `RNA068` | 预留字段 | `RNA068` | string |  |
| `RNA069` | 预留字段 | `RNA069` | string |  |
| `RNA070` | 预留字段 | `RNA070` | string |  |
| `RNA071` | 预留字段 | `RNA071` | string |  |
| `RNA072` | 预留字段 | `RNA072` | float |  |
| `RNA073` | 预留字段 | `RNA073` | float |  |
| `RNA074` | 委外单位 | `RNA074` | string |  |
| `RNA075` | 换算分子 | `RNA075` | float |  |
| `RNA076` | 换算分母 | `RNA076` | float |  |
| `RNA077` | 库存单位 | `RNA077` | string |  |
| `RNA078` | 库存单位数量 | `RNA078` | float |  |
| `RNA079` | 原委外单位 | `RNA079` | string |  |
| `RNA080` | 原换算分子 | `RNA080` | float |  |
| `RNA081` | 原换算分母 | `RNA081` | float |  |
| `RNA082` | 原库存单位 | `RNA082` | string |  |
| `RNA083` | 原库存单位数量 | `RNA083` | float |  |
| `RNA084` | 原自定文字1 | `RNA084` | string |  |
| `RNA085` | 原自定文字2 | `RNA085` | string |  |
| `RNA086` | 原自定文字3 | `RNA086` | string |  |
| `RNA087` | 原自定文字4 | `RNA087` | string |  |
| `RNA088` | 原自定文字5 | `RNA088` | string |  |
| `RNA089` | 原自定文字6 | `RNA089` | string |  |
| `RNA090` | 原自定数字1 | `RNA090` | float |  |
| `RNA091` | 原自定数字2 | `RNA091` | float |  |
| `RNA092` | 原自定数字3 | `RNA092` | float |  |
| `RNA093` | 原自定数字4 | `RNA093` | float |  |
| `RNA094` | 原自定数字5 | `RNA094` | float |  |
| `RNA095` | 原自定数字6 | `RNA095` | float |  |
| `RNA096` | 变更后自定文字1 | `RNA096` | string |  |
| `RNA097` | 变更后自定文字2 | `RNA097` | string |  |
| `RNA098` | 变更后自定文字3 | `RNA098` | string |  |
| `RNA099` | 变更后自定文字4 | `RNA099` | string |  |
| `RNA100` | 变更后自定文字5 | `RNA100` | string |  |
| `RNA101` | 变更后自定文字6 | `RNA101` | string |  |
| `RNA102` | 变更后自定数字1 | `RNA102` | float |  |
| `RNA103` | 变更后自定数字2 | `RNA103` | float |  |
| `RNA104` | 变更后自定数字3 | `RNA104` | float |  |
| `RNA105` | 变更后自定数字4 | `RNA105` | float |  |
| `RNA106` | 变更后自定数字5 | `RNA106` | float |  |
| `RNA107` | 变更后自定数字6 | `RNA107` | float |  |
| `RNA108` | 原二维码 | `RNA108` | string |  |
| `RNA109` | 变更后二维码 | `RNA109` | string |  |
| `RNA110` | 原自定文字7 | `RNA110` | string |  |
| `RNA111` | 原自定文字8 | `RNA111` | string |  |
| `RNA112` | 原自定文字9 | `RNA112` | string |  |
| `RNA113` | 原自定文字10 | `RNA113` | string |  |
| `RNA114` | 原自定文字11 | `RNA114` | string |  |
| `RNA115` | 原自定文字12 | `RNA115` | string |  |
| `RNA116` | 原自定文字13 | `RNA116` | string |  |
| `RNA117` | 原自定文字14 | `RNA117` | string |  |
| `RNA118` | 原自定文字15 | `RNA118` | string |  |
| `RNA119` | 原自定文字16 | `RNA119` | string |  |
| `RNA120` | 变更后自定文字7 | `RNA120` | string |  |
| `RNA121` | 变更后自定文字8 | `RNA121` | string |  |
| `RNA122` | 变更后自定文字9 | `RNA122` | string |  |
| `RNA123` | 变更后自定文字10 | `RNA123` | string |  |
| `RNA124` | 变更后自定文字11 | `RNA124` | string |  |
| `RNA125` | 变更后自定文字12 | `RNA125` | string |  |
| `RNA126` | 变更后自定文字13 | `RNA126` | string |  |
| `RNA127` | 变更后自定文字14 | `RNA127` | string |  |
| `RNA128` | 变更后自定文字15 | `RNA128` | string |  |
| `RNA129` | 变更后自定文字16 | `RNA129` | string |  |
| `RNA130` | 原自定数字7 | `RNA130` | float |  |
| `RNA131` | 原自定数字8 | `RNA131` | float |  |
| `RNA132` | 原自定数字9 | `RNA132` | float |  |
| `RNA133` | 原自定数字10 | `RNA133` | float |  |
| `RNA134` | 原自定数字11 | `RNA134` | float |  |
| `RNA135` | 原自定数字12 | `RNA135` | float |  |
| `RNA136` | 原自定数字13 | `RNA136` | float |  |
| `RNA137` | 原自定数字14 | `RNA137` | float |  |
| `RNA138` | 原自定数字15 | `RNA138` | float |  |
| `RNA139` | 原自定数字16 | `RNA139` | float |  |
| `RNA140` | 变更后自定数字7 | `RNA140` | float |  |
| `RNA141` | 变更后自定数字8 | `RNA141` | float |  |
| `RNA142` | 变更后自定数字9 | `RNA142` | float |  |
| `RNA143` | 变更后自定数字10 | `RNA143` | float |  |
| `RNA144` | 变更后自定数字11 | `RNA144` | float |  |
| `RNA145` | 变更后自定数字12 | `RNA145` | float |  |
| `RNA146` | 变更后自定数字13 | `RNA146` | float |  |
| `RNA147` | 变更后自定数字14 | `RNA147` | float |  |
| `RNA148` | 变更后自定数字15 | `RNA148` | float |  |
| `RNA149` | 变更后自定数字16 | `RNA149` | float |  |
| `RNA901` | 录入者编号 | `entry_person_no` | string |  |
| `RNA902` | 录入时间 | `entry_time` | string |  |
| `RNA903` | 更改者编号 | `changer_no` | string |  |
| `RNA904` | 更改时间 | `change_time` | string |  |
| `RNA905` | 更新标记 | `update_flag` | integer |  |
| `RNA906` | 打印次数 | `print_count` | integer |  |
| `RNA907` | 打印时间 | `print_time` | string |  |
| `RNA908` | 打印人员 | `printer` | string |  |
| `RNA909` | 打印人员姓名 | `printer_name` | string |  |
| `RNA910` | 送审状态 | `submission_status` | string |  |
| `RNA911` | 送审人 | `reviewer` | string |  |
| `RNA912` | 审批人1 | `approver1` | string |  |
| `RNA913` | 审批结果 | `approval_result1` | string |  |
| `RNA914` | 审批意见 | `approval_opinion1` | string |  |
| `RNA915` | 审批人2 | `approver2` | string |  |
| `RNA916` | 审批结果 | `approval_result2` | string |  |
| `RNA917` | 审批意见 | `approval_opinion2` | string |  |
| `RNA918` | 审批人3 | `approver3` | string |  |
| `RNA919` | 审批结果 | `approval_result3` | string |  |
| `RNA920` | 审批意见 | `approval_opinion3` | string |  |
| `RNA921` | 审批人4 | `approver4` | string |  |
| `RNA922` | 审批结果 | `approval_result4` | string |  |
| `RNA923` | 审批意见 | `approval_opinion4` | string |  |
| `RNA924` | 审批人5 | `approver5` | string |  |
| `RNA925` | 审批结果 | `approval_result5` | string |  |
| `RNA926` | 审批意见 | `approval_opinion5` | string |  |
| `RNA927` | 审批人6 | `approver6` | string |  |
| `RNA928` | 审批结果 | `approval_result6` | string |  |
| `RNA929` | 审批意见 | `approval_opinion6` | string |  |
| `RNA930` | 终审人 | `final_approver` | string |  |
| `RNA931` | 审批结果 | `approval_result7` | string |  |
| `RNA932` | 审批意见 | `approval_opinion7` | string |  |
| `RNA933` | 通知人1 | `notifier1` | string |  |
| `RNA934` | 通知人2 | `notifier2` | string |  |
| `RNA935` | 通知人3 | `notifier3` | string |  |
| `RNA960` | 自定文字1 | `udf_text1` | string |  |
| `RNA961` | 自定文字2 | `udf_text2` | string |  |
| `RNA962` | 自定文字3 | `udf_text3` | string |  |
| `RNA963` | 自定文字4 | `udf_text4` | string |  |
| `RNA964` | 自定文字5 | `udf_text5` | string |  |
| `RNA965` | 自定文字6 | `udf_text6` | string |  |
| `RNA966` | 自定文字7 | `udf_text7` | string |  |
| `RNA967` | 自定文字8 | `udf_text8` | string |  |
| `RNA968` | 自定文字9 | `udf_text9` | string |  |
| `RNA969` | 自定文字10 | `udf_text10` | string |  |
| `RNA970` | 自定文字11 | `udf_text11` | string |  |
| `RNA971` | 自定文字12 | `udf_text12` | string |  |
| `RNA972` | 自定文字13 | `udf_text13` | string |  |
| `RNA973` | 自定文字14 | `udf_text14` | string |  |
| `RNA974` | 自定文字15 | `udf_text15` | string |  |
| `RNA975` | 自定文字16 | `udf_text16` | string |  |
| `RNA979` | 二维码 | `qr_code_on_doc_header` | string |  |
| `RNA980` | 自定数字1 | `udf_no1` | float |  |
| `RNA981` | 自定数字2 | `udf_no2` | float |  |
| `RNA982` | 自定数字3 | `udf_no3` | float |  |
| `RNA983` | 自定数字4 | `udf_no4` | float |  |
| `RNA984` | 自定数字5 | `udf_no5` | float |  |
| `RNA985` | 自定数字6 | `udf_no6` | float |  |
| `RNA986` | 自定数字7 | `udf_no7` | float |  |
| `RNA987` | 自定数字8 | `udf_no8` | float |  |
| `RNA988` | 自定数字9 | `udf_no9` | float |  |
| `RNA989` | 自定数字10 | `udf_no10` | float |  |
| `RNA990` | 自定数字11 | `udf_no11` | float |  |
| `RNA991` | 自定数字12 | `udf_no12` | float |  |
| `RNA992` | 自定数字13 | `udf_no13` | float |  |
| `RNA993` | 自定数字14 | `udf_no14` | float |  |
| `RNA994` | 自定数字15 | `udf_no15` | float |  |
| `RNA995` | 自定数字16 | `udf_no16` | float |  |
| `RNA950` | 送审时间 | `submission_time_for_review` | string |  |
| `RNA951` | 审批时间1 | `approval_time1` | string |  |
| `RNA952` | 审批时间2 | `approval_time2` | string |  |
| `RNA953` | 审批时间3 | `approval_time3` | string |  |
| `RNA954` | 审批时间4 | `approval_time4` | string |  |
| `RNA955` | 审批时间5 | `approval_time5` | string |  |
| `RNA956` | 审批时间6 | `approval_time6` | string |  |
| `RNA957` | 终审时间 | `final_review_time` | string |  |
| `RNA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (SGMRNB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RNB001` | 变更单单号 | `RNB001` | string |  |
| `RNB002` | 变更版本 | `RNB002` | string |  |
| `RNB003` | 序号 | `RNB003` | string |  |
| `RNB004` | 操作码 | `RNB004` | string |  |
| `RNB005` | 新序号 | `RNB005` | string |  |
| `RNB006` | 子件品号 | `RNB006` | string |  |
| `RNB007` | 子件品名 | `RNB007` | string |  |
| `RNB008` | 子件单位 | `RNB008` | string |  |
| `RNB009` | 子件规格 | `RNB009` | string |  |
| `RNB010` | 预计用量 | `RNB010` | float |  |
| `RNB011` | 可替代 | `RNB011` | string |  |
| `RNB012` | 结束 | `RNB012` | string |  |
| `RNB013` | 备注 | `RNB013` | string |  |
| `RNB014` | 原序号 | `RNB014` | string |  |
| `RNB015` | 原子件品号 | `RNB015` | string |  |
| `RNB016` | 原子件品名 | `RNB016` | string |  |
| `RNB017` | 原子件单位 | `RNB017` | string |  |
| `RNB018` | 原子件规格 | `RNB018` | string |  |
| `RNB019` | 原预计用量 | `RNB019` | float |  |
| `RNB020` | 原可替代 | `RNB020` | string |  |
| `RNB021` | 原结束 | `RNB021` | string |  |
| `RNB022` | 原备注 | `RNB022` | string |  |
| `RNB023` | 已送料量 | `RNB023` | float |  |
| `RNB024` | 耗用量 | `RNB024` | float |  |
| `RNB025` | 被替代量 | `RNB025` | float |  |
| `RNB026` | 原自定文字1 | `RNB026` | string |  |
| `RNB027` | 原自定文字2 | `RNB027` | string |  |
| `RNB028` | 原自定文字3 | `RNB028` | string |  |
| `RNB029` | 原自定文字4 | `RNB029` | string |  |
| `RNB030` | 原自定文字5 | `RNB030` | string |  |
| `RNB031` | 原自定文字6 | `RNB031` | string |  |
| `RNB032` | 原自定数字1 | `RNB032` | float |  |
| `RNB033` | 原自定数字2 | `RNB033` | float |  |
| `RNB034` | 原自定数字3 | `RNB034` | float |  |
| `RNB035` | 原自定数字4 | `RNB035` | float |  |
| `RNB036` | 原自定数字5 | `RNB036` | float |  |
| `RNB037` | 原自定数字6 | `RNB037` | float |  |
| `RNB038` | 变更后自定文字1 | `RNB038` | string |  |
| `RNB039` | 变更后自定文字2 | `RNB039` | string |  |
| `RNB040` | 变更后自定文字3 | `RNB040` | string |  |
| `RNB041` | 变更后自定文字4 | `RNB041` | string |  |
| `RNB042` | 变更后自定文字5 | `RNB042` | string |  |
| `RNB043` | 变更后自定文字6 | `RNB043` | string |  |
| `RNB044` | 变更后自定数字1 | `RNB044` | float |  |
| `RNB045` | 变更后自定数字2 | `RNB045` | float |  |
| `RNB046` | 变更后自定数字3 | `RNB046` | float |  |
| `RNB047` | 变更后自定数字4 | `RNB047` | float |  |
| `RNB048` | 变更后自定数字5 | `RNB048` | float |  |
| `RNB049` | 变更后自定数字6 | `RNB049` | float |  |
| `RNB050` | 原二维码 | `RNB050` | string |  |
| `RNB051` | 变更后二维码 | `RNB051` | string |  |
| `RNB052` | 原自定文字7 | `RNB052` | string |  |
| `RNB053` | 原自定文字8 | `RNB053` | string |  |
| `RNB054` | 原自定文字9 | `RNB054` | string |  |
| `RNB055` | 原自定文字10 | `RNB055` | string |  |
| `RNB056` | 原自定文字11 | `RNB056` | string |  |
| `RNB057` | 原自定文字12 | `RNB057` | string |  |
| `RNB058` | 原自定文字13 | `RNB058` | string |  |
| `RNB059` | 原自定文字14 | `RNB059` | string |  |
| `RNB060` | 原自定文字15 | `RNB060` | string |  |
| `RNB061` | 原自定文字16 | `RNB061` | string |  |
| `RNB062` | 变更后自定文字7 | `RNB062` | string |  |
| `RNB063` | 变更后自定文字8 | `RNB063` | string |  |
| `RNB064` | 变更后自定文字9 | `RNB064` | string |  |
| `RNB065` | 变更后自定文字10 | `RNB065` | string |  |
| `RNB066` | 变更后自定文字11 | `RNB066` | string |  |
| `RNB067` | 变更后自定文字12 | `RNB067` | string |  |
| `RNB068` | 变更后自定文字13 | `RNB068` | string |  |
| `RNB069` | 变更后自定文字14 | `RNB069` | string |  |
| `RNB070` | 变更后自定文字15 | `RNB070` | string |  |
| `RNB071` | 变更后自定文字16 | `RNB071` | string |  |
| `RNB072` | 原自定数字7 | `RNB072` | float |  |
| `RNB073` | 原自定数字8 | `RNB073` | float |  |
| `RNB074` | 原自定数字9 | `RNB074` | float |  |
| `RNB075` | 原自定数字10 | `RNB075` | float |  |
| `RNB076` | 原自定数字11 | `RNB076` | float |  |
| `RNB077` | 原自定数字12 | `RNB077` | float |  |
| `RNB078` | 原自定数字13 | `RNB078` | float |  |
| `RNB079` | 原自定数字14 | `RNB079` | float |  |
| `RNB080` | 原自定数字15 | `RNB080` | float |  |
| `RNB081` | 原自定数字16 | `RNB081` | float |  |
| `RNB082` | 变更后自定数字7 | `RNB082` | float |  |
| `RNB083` | 变更后自定数字8 | `RNB083` | float |  |
| `RNB084` | 变更后自定数字9 | `RNB084` | float |  |
| `RNB085` | 变更后自定数字10 | `RNB085` | float |  |
| `RNB086` | 变更后自定数字11 | `RNB086` | float |  |
| `RNB087` | 变更后自定数字12 | `RNB087` | float |  |
| `RNB088` | 变更后自定数字13 | `RNB088` | float |  |
| `RNB089` | 变更后自定数字14 | `RNB089` | float |  |
| `RNB090` | 变更后自定数字15 | `RNB090` | float |  |
| `RNB091` | 变更后自定数字16 | `RNB091` | float |  |
| `RNB092` | 位号 | `RNB092` | string |  |
| `RNB093` | 原位号 | `RNB093` | string |  |
| `RNB901` | 录入者编号 | `entry_person_no` | string |  |
| `RNB902` | 录入时间 | `entry_time` | string |  |
| `RNB903` | 更改者编号 | `changer_no` | string |  |
| `RNB904` | 更改时间 | `change_time` | string |  |
| `RNB905` | 更新标记 | `update_flag` | integer |  |
| `RNB960` | 自定文字1 | `udf_text1` | string |  |
| `RNB961` | 自定文字2 | `udf_text2` | string |  |
| `RNB962` | 自定文字3 | `udf_text3` | string |  |
| `RNB963` | 自定文字4 | `udf_text4` | string |  |
| `RNB964` | 自定文字5 | `udf_text5` | string |  |
| `RNB965` | 自定文字6 | `udf_text6` | string |  |
| `RNB966` | 自定文字7 | `udf_text7` | string |  |
| `RNB967` | 自定文字8 | `udf_text8` | string |  |
| `RNB968` | 自定文字9 | `udf_text9` | string |  |
| `RNB969` | 自定文字10 | `udf_text10` | string |  |
| `RNB970` | 自定文字11 | `udf_text11` | string |  |
| `RNB971` | 自定文字12 | `udf_text12` | string |  |
| `RNB972` | 自定文字13 | `udf_text13` | string |  |
| `RNB973` | 自定文字14 | `udf_text14` | string |  |
| `RNB974` | 自定文字15 | `udf_text15` | string |  |
| `RNB975` | 自定文字16 | `udf_text16` | string |  |
| `RNB979` | 二维码 | `qr_code_on_doc_header` | string |  |
| `RNB980` | 自定数字1 | `udf_no1` | float |  |
| `RNB981` | 自定数字2 | `udf_no2` | float |  |
| `RNB982` | 自定数字3 | `udf_no3` | float |  |
| `RNB983` | 自定数字4 | `udf_no4` | float |  |
| `RNB984` | 自定数字5 | `udf_no5` | float |  |
| `RNB985` | 自定数字6 | `udf_no6` | float |  |
| `RNB986` | 自定数字7 | `udf_no7` | float |  |
| `RNB987` | 自定数字8 | `udf_no8` | float |  |
| `RNB988` | 自定数字9 | `udf_no9` | float |  |
| `RNB989` | 自定数字10 | `udf_no10` | float |  |
| `RNB990` | 自定数字11 | `udf_no11` | float |  |
| `RNB991` | 自定数字12 | `udf_no12` | float |  |
| `RNB992` | 自定数字13 | `udf_no13` | float |  |
| `RNB993` | 自定数字14 | `udf_no14` | float |  |
| `RNB994` | 自定数字15 | `udf_no15` | float |  |
| `RNB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "RNA001": ""
  ,"RNA001": ""
  ,"RNA002": ""
  ,"RNA003": ""
  ,"cdsDetail": [{
    "RNB001": ""
    ,"RNB001": ""
    ,"RNB002": ""
    ,"RNB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"RNA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"RNA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `RNA001` | `RNA001` | 变更单单号 | |
| `RNA002` | `RNA002` | 版本 | |
| `RNA003` | `RNA003` | 变更日期 | |
| `RNA004` | `RNA004` | 性质 | |
| `RNA005` | `RNA005` | 经办人 | |
| `RNA006` | `RNA006` | 部门 | |
| `RNA007` | `RNA007` | 供应商 | |
| `RNA008` | `RNA008` | 主件品号 | |
| `RNA009` | `RNA009` | 委外数量 | |
| `RNA010` | `RNA010` | 含税 | |
| `RNB001` | `RNB001` | 变更单单号 (单身) | |
| `RNB002` | `RNB002` | 变更版本 (单身) | |
| `RNB003` | `RNB003` | 序号 (单身) | |
| `RNB004` | `RNB004` | 操作码 (单身) | |
| `RNB005` | `RNB005` | 新序号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `RNA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `RNA001`
