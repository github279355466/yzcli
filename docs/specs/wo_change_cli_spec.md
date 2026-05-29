# CLI 规格说明书：工单变更单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `wo.change` |
| **DLL** | `SGMZC16` |
| **服务名称** | `工单变更单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "wo.change" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "wo.change" \
  --action "getMultiple" \
  --data '{"datakeys":[{"RMA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "wo.change" \
  --action "create" \
  --data '{"RMA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "wo.change" \
  --action "approve" \
  --data '{"datakeys":[{"RMA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `RMA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (SGMRMA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RMA001` | 变更单单号 | `RMA001` | string |  |
| `RMA002` | 变更版本 | `RMA002` | string |  |
| `RMA003` | 变更日期 | `RMA003` | string |  |
| `RMA004` | 性质 | `RMA004` | string |  |
| `RMA005` | 经办人 | `RMA005` | string |  |
| `RMA006` | 部门 | `RMA006` | string |  |
| `RMA007` | 主件品号 | `RMA007` | string |  |
| `RMA008` | 生产数量 | `RMA008` | float |  |
| `RMA009` | 预计开工日 | `RMA009` | string |  |
| `RMA010` | 预计完工日 | `RMA010` | string |  |
| `RMA011` | 源工单来源 | `RMA011` | string |  |
| `RMA012` | 源工单 | `RMA012` | string |  |
| `RMA013` | 完工码 | `RMA013` | string |  |
| `RMA014` | 备注 | `RMA014` | string |  |
| `RMA015` | 变更原因 | `RMA015` | string |  |
| `RMA016` | 审核码 | `RMA016` | string |  |
| `RMA017` | 审核人 | `RMA017` | string |  |
| `RMA018` | 开单日期 | `RMA018` | string |  |
| `RMA019` | 原性质 | `RMA019` | string |  |
| `RMA020` | 原经办人 | `RMA020` | string |  |
| `RMA021` | 原部门 | `RMA021` | string |  |
| `RMA022` | 原生产数量 | `RMA022` | float |  |
| `RMA023` | 原预计开工日 | `RMA023` | string |  |
| `RMA024` | 原预计完工日 | `RMA024` | string |  |
| `RMA025` | 原源工单来源 | `RMA025` | string |  |
| `RMA026` | 原源工单 | `RMA026` | string |  |
| `RMA027` | 原备注 | `RMA027` | string |  |
| `RMA028` | 原完工码 | `RMA028` | string |  |
| `RMA029` | 实际开工日 | `RMA029` | string |  |
| `RMA030` | 实际完工日 | `RMA030` | string |  |
| `RMA031` | 前置来源 | `RMA031` | string |  |
| `RMA032` | 前置单号 | `RMA032` | string |  |
| `RMA033` | 前置序号 | `RMA033` | string |  |
| `RMA034` | 已生产量 | `RMA034` | float |  |
| `RMA035` | 报废数量 | `RMA035` | float |  |
| `RMA036` | 已检数量 | `RMA036` | float |  |
| `RMA037` | 计划来源 | `RMA037` | string |  |
| `RMA038` | 计划编号 | `RMA038` | string |  |
| `RMA039` | 计划序号 | `RMA039` | string |  |
| `RMA040` | 发放方式 | `RMA040` | string |  |
| `RMA041` | 原自定文字1 | `RMA041` | string |  |
| `RMA042` | 原自定文字2 | `RMA042` | string |  |
| `RMA043` | 原自定文字3 | `RMA043` | string |  |
| `RMA044` | 原自定文字4 | `RMA044` | string |  |
| `RMA045` | 原自定文字5 | `RMA045` | string |  |
| `RMA046` | 原自定文字6 | `RMA046` | string |  |
| `RMA047` | 原自定数字1 | `RMA047` | float |  |
| `RMA048` | 原自定数字2 | `RMA048` | float |  |
| `RMA049` | 原自定数字3 | `RMA049` | float |  |
| `RMA050` | 原自定数字4 | `RMA050` | float |  |
| `RMA051` | 原自定数字5 | `RMA051` | float |  |
| `RMA052` | 原自定数字6 | `RMA052` | float |  |
| `RMA053` | 变更后自定文字1 | `RMA053` | string |  |
| `RMA054` | 变更后自定文字2 | `RMA054` | string |  |
| `RMA055` | 变更后自定文字3 | `RMA055` | string |  |
| `RMA056` | 变更后自定文字4 | `RMA056` | string |  |
| `RMA057` | 变更后自定文字5 | `RMA057` | string |  |
| `RMA058` | 变更后自定文字6 | `RMA058` | string |  |
| `RMA059` | 变更后自定数字1 | `RMA059` | float |  |
| `RMA060` | 变更后自定数字2 | `RMA060` | float |  |
| `RMA061` | 变更后自定数字3 | `RMA061` | float |  |
| `RMA062` | 变更后自定数字4 | `RMA062` | float |  |
| `RMA063` | 变更后自定数字5 | `RMA063` | float |  |
| `RMA064` | 变更后自定数字6 | `RMA064` | float |  |
| `RMA065` | 原二维码 | `RMA065` | string |  |
| `RMA066` | 变更后二维码 | `RMA066` | string |  |
| `RMA067` | 原自定文字7 | `RMA067` | string |  |
| `RMA068` | 原自定文字8 | `RMA068` | string |  |
| `RMA069` | 原自定文字9 | `RMA069` | string |  |
| `RMA070` | 原自定文字10 | `RMA070` | string |  |
| `RMA071` | 原自定文字11 | `RMA071` | string |  |
| `RMA072` | 原自定文字12 | `RMA072` | string |  |
| `RMA073` | 原自定文字13 | `RMA073` | string |  |
| `RMA074` | 原自定文字14 | `RMA074` | string |  |
| `RMA075` | 原自定文字15 | `RMA075` | string |  |
| `RMA076` | 原自定文字16 | `RMA076` | string |  |
| `RMA077` | 变更后自定文字7 | `RMA077` | string |  |
| `RMA078` | 变更后自定文字8 | `RMA078` | string |  |
| `RMA079` | 变更后自定文字9 | `RMA079` | string |  |
| `RMA080` | 变更后自定文字10 | `RMA080` | string |  |
| `RMA081` | 变更后自定文字11 | `RMA081` | string |  |
| `RMA082` | 变更后自定文字12 | `RMA082` | string |  |
| `RMA083` | 变更后自定文字13 | `RMA083` | string |  |
| `RMA084` | 变更后自定文字14 | `RMA084` | string |  |
| `RMA085` | 变更后自定文字15 | `RMA085` | string |  |
| `RMA086` | 变更后自定文字16 | `RMA086` | string |  |
| `RMA087` | 原自定数字7 | `RMA087` | float |  |
| `RMA088` | 原自定数字8 | `RMA088` | float |  |
| `RMA089` | 原自定数字9 | `RMA089` | float |  |
| `RMA090` | 原自定数字10 | `RMA090` | float |  |
| `RMA091` | 原自定数字11 | `RMA091` | float |  |
| `RMA092` | 原自定数字12 | `RMA092` | float |  |
| `RMA093` | 原自定数字13 | `RMA093` | float |  |
| `RMA094` | 原自定数字14 | `RMA094` | float |  |
| `RMA095` | 原自定数字15 | `RMA095` | float |  |
| `RMA096` | 原自定数字16 | `RMA096` | float |  |
| `RMA097` | 变更后自定数字7 | `RMA097` | float |  |
| `RMA098` | 变更后自定数字8 | `RMA098` | float |  |
| `RMA099` | 变更后自定数字9 | `RMA099` | float |  |
| `RMA100` | 变更后自定数字10 | `RMA100` | float |  |
| `RMA101` | 变更后自定数字11 | `RMA101` | float |  |
| `RMA102` | 变更后自定数字12 | `RMA102` | float |  |
| `RMA103` | 变更后自定数字13 | `RMA103` | float |  |
| `RMA104` | 变更后自定数字14 | `RMA104` | float |  |
| `RMA105` | 变更后自定数字15 | `RMA105` | float |  |
| `RMA106` | 变更后自定数字16 | `RMA106` | float |  |
| `RMA901` | 录入者编号 | `entry_person_no` | string |  |
| `RMA902` | 录入时间 | `entry_time` | string |  |
| `RMA903` | 更改者编号 | `changer_no` | string |  |
| `RMA904` | 更改时间 | `change_time` | string |  |
| `RMA905` | 更新标记 | `update_flag` | integer |  |
| `RMA906` | 打印次数 | `print_count` | integer |  |
| `RMA907` | 打印时间 | `print_time` | string |  |
| `RMA908` | 打印人员 | `printer` | string |  |
| `RMA909` | 打印人员姓名 | `printer_name` | string |  |
| `RMA910` | 送审状态 | `submission_status` | string |  |
| `RMA911` | 送审人 | `reviewer` | string |  |
| `RMA912` | 审批人1 | `approver1` | string |  |
| `RMA913` | 审批结果 | `approval_result1` | string |  |
| `RMA914` | 审批意见 | `approval_opinion1` | string |  |
| `RMA915` | 审批人2 | `approver2` | string |  |
| `RMA916` | 审批结果 | `approval_result2` | string |  |
| `RMA917` | 审批意见 | `approval_opinion2` | string |  |
| `RMA918` | 审批人3 | `approver3` | string |  |
| `RMA919` | 审批结果 | `approval_result3` | string |  |
| `RMA920` | 审批意见 | `approval_opinion3` | string |  |
| `RMA921` | 审批人4 | `approver4` | string |  |
| `RMA922` | 审批结果 | `approval_result4` | string |  |
| `RMA923` | 审批意见 | `approval_opinion4` | string |  |
| `RMA924` | 审批人5 | `approver5` | string |  |
| `RMA925` | 审批结果 | `approval_result5` | string |  |
| `RMA926` | 审批意见 | `approval_opinion5` | string |  |
| `RMA927` | 审批人6 | `approver6` | string |  |
| `RMA928` | 审批结果 | `approval_result6` | string |  |
| `RMA929` | 审批意见 | `approval_opinion6` | string |  |
| `RMA930` | 终审人 | `final_approver` | string |  |
| `RMA931` | 审批结果 | `approval_result7` | string |  |
| `RMA932` | 审批意见 | `approval_opinion7` | string |  |
| `RMA933` | 通知人1 | `notifier1` | string |  |
| `RMA934` | 通知人2 | `notifier2` | string |  |
| `RMA935` | 通知人3 | `notifier3` | string |  |
| `RMA960` | 自定文字1 | `udf_text1` | string |  |
| `RMA961` | 自定文字2 | `udf_text2` | string |  |
| `RMA962` | 自定文字3 | `udf_text3` | string |  |
| `RMA963` | 自定文字4 | `udf_text4` | string |  |
| `RMA964` | 自定文字5 | `udf_text5` | string |  |
| `RMA965` | 自定文字6 | `udf_text6` | string |  |
| `RMA966` | 自定文字7 | `udf_text7` | string |  |
| `RMA967` | 自定文字8 | `udf_text8` | string |  |
| `RMA968` | 自定文字9 | `udf_text9` | string |  |
| `RMA969` | 自定文字10 | `udf_text10` | string |  |
| `RMA970` | 自定文字11 | `udf_text11` | string |  |
| `RMA971` | 自定文字12 | `udf_text12` | string |  |
| `RMA972` | 自定文字13 | `udf_text13` | string |  |
| `RMA973` | 自定文字14 | `udf_text14` | string |  |
| `RMA974` | 自定文字15 | `udf_text15` | string |  |
| `RMA975` | 自定文字16 | `udf_text16` | string |  |
| `RMA979` | 二维码 | `qr_code_on_doc_header` | string |  |
| `RMA980` | 自定数字1 | `udf_no1` | float |  |
| `RMA981` | 自定数字2 | `udf_no2` | float |  |
| `RMA982` | 自定数字3 | `udf_no3` | float |  |
| `RMA983` | 自定数字4 | `udf_no4` | float |  |
| `RMA984` | 自定数字5 | `udf_no5` | float |  |
| `RMA985` | 自定数字6 | `udf_no6` | float |  |
| `RMA986` | 自定数字7 | `udf_no7` | float |  |
| `RMA987` | 自定数字8 | `udf_no8` | float |  |
| `RMA988` | 自定数字9 | `udf_no9` | float |  |
| `RMA989` | 自定数字10 | `udf_no10` | float |  |
| `RMA990` | 自定数字11 | `udf_no11` | float |  |
| `RMA991` | 自定数字12 | `udf_no12` | float |  |
| `RMA992` | 自定数字13 | `udf_no13` | float |  |
| `RMA993` | 自定数字14 | `udf_no14` | float |  |
| `RMA994` | 自定数字15 | `udf_no15` | float |  |
| `RMA995` | 自定数字16 | `udf_no16` | float |  |
| `RMA950` | 送审时间 | `submission_time_for_review` | string |  |
| `RMA951` | 审批时间1 | `approval_time1` | string |  |
| `RMA952` | 审批时间2 | `approval_time2` | string |  |
| `RMA953` | 审批时间3 | `approval_time3` | string |  |
| `RMA954` | 审批时间4 | `approval_time4` | string |  |
| `RMA955` | 审批时间5 | `approval_time5` | string |  |
| `RMA956` | 审批时间6 | `approval_time6` | string |  |
| `RMA957` | 终审时间 | `final_review_time` | string |  |
| `RMA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (SGMRMB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RMB001` | 变更单单号 | `RMB001` | string |  |
| `RMB002` | 变更版本 | `RMB002` | string |  |
| `RMB003` | 序号 | `RMB003` | string |  |
| `RMB004` | 操作码 | `RMB004` | string |  |
| `RMB005` | 新序号 | `RMB005` | string |  |
| `RMB006` | 子件品号 | `RMB006` | string |  |
| `RMB007` | 子件品名 | `RMB007` | string |  |
| `RMB008` | 子件单位 | `RMB008` | string |  |
| `RMB009` | 子件规格 | `RMB009` | string |  |
| `RMB010` | 预计用量 | `RMB010` | float |  |
| `RMB011` | 可替代 | `RMB011` | string |  |
| `RMB012` | 结束 | `RMB012` | string |  |
| `RMB013` | 备注 | `RMB013` | string |  |
| `RMB014` | 原序号 | `RMB014` | string |  |
| `RMB015` | 原子件品号 | `RMB015` | string |  |
| `RMB016` | 原子件品名 | `RMB016` | string |  |
| `RMB017` | 原子件单位 | `RMB017` | string |  |
| `RMB018` | 原子件规格 | `RMB018` | string |  |
| `RMB019` | 原预计用量 | `RMB019` | float |  |
| `RMB020` | 原可替代 | `RMB020` | string |  |
| `RMB021` | 原结束 | `RMB021` | string |  |
| `RMB022` | 原备注 | `RMB022` | string |  |
| `RMB023` | 已领料量 | `RMB023` | float |  |
| `RMB024` | 入库耗用量 | `RMB024` | float |  |
| `RMB025` | 被替代量 | `RMB025` | float |  |
| `RMB026` | 原自定文字1 | `RMB026` | string |  |
| `RMB027` | 原自定文字2 | `RMB027` | string |  |
| `RMB028` | 原自定文字3 | `RMB028` | string |  |
| `RMB029` | 原自定文字4 | `RMB029` | string |  |
| `RMB030` | 原自定文字5 | `RMB030` | string |  |
| `RMB031` | 原自定文字6 | `RMB031` | string |  |
| `RMB032` | 原自定数字1 | `RMB032` | float |  |
| `RMB033` | 原自定数字2 | `RMB033` | float |  |
| `RMB034` | 原自定数字3 | `RMB034` | float |  |
| `RMB035` | 原自定数字4 | `RMB035` | float |  |
| `RMB036` | 原自定数字5 | `RMB036` | float |  |
| `RMB037` | 原自定数字6 | `RMB037` | float |  |
| `RMB038` | 变更后自定文字1 | `RMB038` | string |  |
| `RMB039` | 变更后自定文字2 | `RMB039` | string |  |
| `RMB040` | 变更后自定文字3 | `RMB040` | string |  |
| `RMB041` | 变更后自定文字4 | `RMB041` | string |  |
| `RMB042` | 变更后自定文字5 | `RMB042` | string |  |
| `RMB043` | 变更后自定文字6 | `RMB043` | string |  |
| `RMB044` | 变更后自定数字1 | `RMB044` | float |  |
| `RMB045` | 变更后自定数字2 | `RMB045` | float |  |
| `RMB046` | 变更后自定数字3 | `RMB046` | float |  |
| `RMB047` | 变更后自定数字4 | `RMB047` | float |  |
| `RMB048` | 变更后自定数字5 | `RMB048` | float |  |
| `RMB049` | 变更后自定数字6 | `RMB049` | float |  |
| `RMB050` | 原二维码 | `RMB050` | string |  |
| `RMB051` | 变更后二维码 | `RMB051` | string |  |
| `RMB052` | 原自定文字7 | `RMB052` | string |  |
| `RMB053` | 原自定文字8 | `RMB053` | string |  |
| `RMB054` | 原自定文字9 | `RMB054` | string |  |
| `RMB055` | 原自定文字10 | `RMB055` | string |  |
| `RMB056` | 原自定文字11 | `RMB056` | string |  |
| `RMB057` | 原自定文字12 | `RMB057` | string |  |
| `RMB058` | 原自定文字13 | `RMB058` | string |  |
| `RMB059` | 原自定文字14 | `RMB059` | string |  |
| `RMB060` | 原自定文字15 | `RMB060` | string |  |
| `RMB061` | 原自定文字16 | `RMB061` | string |  |
| `RMB062` | 变更后自定文字7 | `RMB062` | string |  |
| `RMB063` | 变更后自定文字8 | `RMB063` | string |  |
| `RMB064` | 变更后自定文字9 | `RMB064` | string |  |
| `RMB065` | 变更后自定文字10 | `RMB065` | string |  |
| `RMB066` | 变更后自定文字11 | `RMB066` | string |  |
| `RMB067` | 变更后自定文字12 | `RMB067` | string |  |
| `RMB068` | 变更后自定文字13 | `RMB068` | string |  |
| `RMB069` | 变更后自定文字14 | `RMB069` | string |  |
| `RMB070` | 变更后自定文字15 | `RMB070` | string |  |
| `RMB071` | 变更后自定文字16 | `RMB071` | string |  |
| `RMB072` | 原自定数字7 | `RMB072` | float |  |
| `RMB073` | 原自定数字8 | `RMB073` | float |  |
| `RMB074` | 原自定数字9 | `RMB074` | float |  |
| `RMB075` | 原自定数字10 | `RMB075` | float |  |
| `RMB076` | 原自定数字11 | `RMB076` | float |  |
| `RMB077` | 原自定数字12 | `RMB077` | float |  |
| `RMB078` | 原自定数字13 | `RMB078` | float |  |
| `RMB079` | 原自定数字14 | `RMB079` | float |  |
| `RMB080` | 原自定数字15 | `RMB080` | float |  |
| `RMB081` | 原自定数字16 | `RMB081` | float |  |
| `RMB082` | 变更后自定数字7 | `RMB082` | float |  |
| `RMB083` | 变更后自定数字8 | `RMB083` | float |  |
| `RMB084` | 变更后自定数字9 | `RMB084` | float |  |
| `RMB085` | 变更后自定数字10 | `RMB085` | float |  |
| `RMB086` | 变更后自定数字11 | `RMB086` | float |  |
| `RMB087` | 变更后自定数字12 | `RMB087` | float |  |
| `RMB088` | 变更后自定数字13 | `RMB088` | float |  |
| `RMB089` | 变更后自定数字14 | `RMB089` | float |  |
| `RMB090` | 变更后自定数字15 | `RMB090` | float |  |
| `RMB091` | 变更后自定数字16 | `RMB091` | float |  |
| `RMB092` | 位号 | `RMB092` | string |  |
| `RMB093` | 原位号 | `RMB093` | string |  |
| `RMB901` | 录入者编号 | `entry_person_no` | string |  |
| `RMB902` | 录入时间 | `entry_time` | string |  |
| `RMB903` | 更改者编号 | `changer_no` | string |  |
| `RMB904` | 更改时间 | `change_time` | string |  |
| `RMB905` | 更新标记 | `update_flag` | integer |  |
| `RMB960` | 自定文字1 | `udf_text1` | string |  |
| `RMB961` | 自定文字2 | `udf_text2` | string |  |
| `RMB962` | 自定文字3 | `udf_text3` | string |  |
| `RMB963` | 自定文字4 | `udf_text4` | string |  |
| `RMB964` | 自定文字5 | `udf_text5` | string |  |
| `RMB965` | 自定文字6 | `udf_text6` | string |  |
| `RMB966` | 自定文字7 | `udf_text7` | string |  |
| `RMB967` | 自定文字8 | `udf_text8` | string |  |
| `RMB968` | 自定文字9 | `udf_text9` | string |  |
| `RMB969` | 自定文字10 | `udf_text10` | string |  |
| `RMB970` | 自定文字11 | `udf_text11` | string |  |
| `RMB971` | 自定文字12 | `udf_text12` | string |  |
| `RMB972` | 自定文字13 | `udf_text13` | string |  |
| `RMB973` | 自定文字14 | `udf_text14` | string |  |
| `RMB974` | 自定文字15 | `udf_text15` | string |  |
| `RMB975` | 自定文字16 | `udf_text16` | string |  |
| `RMB979` | 二维码 | `qr_code_on_doc_header` | string |  |
| `RMB980` | 自定数字1 | `udf_no1` | float |  |
| `RMB981` | 自定数字2 | `udf_no2` | float |  |
| `RMB982` | 自定数字3 | `udf_no3` | float |  |
| `RMB983` | 自定数字4 | `udf_no4` | float |  |
| `RMB984` | 自定数字5 | `udf_no5` | float |  |
| `RMB985` | 自定数字6 | `udf_no6` | float |  |
| `RMB986` | 自定数字7 | `udf_no7` | float |  |
| `RMB987` | 自定数字8 | `udf_no8` | float |  |
| `RMB988` | 自定数字9 | `udf_no9` | float |  |
| `RMB989` | 自定数字10 | `udf_no10` | float |  |
| `RMB990` | 自定数字11 | `udf_no11` | float |  |
| `RMB991` | 自定数字12 | `udf_no12` | float |  |
| `RMB992` | 自定数字13 | `udf_no13` | float |  |
| `RMB993` | 自定数字14 | `udf_no14` | float |  |
| `RMB994` | 自定数字15 | `udf_no15` | float |  |
| `RMB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "RMA001": ""
  ,"RMA001": ""
  ,"RMA002": ""
  ,"RMA003": ""
  ,"cdsDetail": [{
    "RMB001": ""
    ,"RMB001": ""
    ,"RMB002": ""
    ,"RMB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"RMA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"RMA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `RMA001` | `RMA001` | 变更单单号 | |
| `RMA002` | `RMA002` | 变更版本 | |
| `RMA003` | `RMA003` | 变更日期 | |
| `RMA004` | `RMA004` | 性质 | |
| `RMA005` | `RMA005` | 经办人 | |
| `RMA006` | `RMA006` | 部门 | |
| `RMA007` | `RMA007` | 主件品号 | |
| `RMA008` | `RMA008` | 生产数量 | |
| `RMA009` | `RMA009` | 预计开工日 | |
| `RMA010` | `RMA010` | 预计完工日 | |
| `RMB001` | `RMB001` | 变更单单号 (单身) | |
| `RMB002` | `RMB002` | 变更版本 (单身) | |
| `RMB003` | `RMB003` | 序号 (单身) | |
| `RMB004` | `RMB004` | 操作码 (单身) | |
| `RMB005` | `RMB005` | 新序号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `RMA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `RMA001`
