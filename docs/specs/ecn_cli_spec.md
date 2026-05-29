# CLI 规格说明书：产品结构变更单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `ecn` |
| **DLL** | `SGMBC03` |
| **服务名称** | `产品结构变更单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "ecn" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "ecn" \
  --action "getMultiple" \
  --data '{"datakeys":[{"QOA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "ecn" \
  --action "create" \
  --data '{"QOA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "ecn" \
  --action "approve" \
  --data '{"datakeys":[{"QOA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `QOA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (SGMQOA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `QOA001` | 主件品号 | `QOA001` | string |  |
| `QOA002` | 变更版本 | `QOA002` | string |  |
| `QOA003` | 变更日期 | `QOA003` | string |  |
| `QOA004` | 批量 | `QOA004` | float |  |
| `QOA005` | 审核码 | `QOA005` | string |  |
| `QOA006` | 备注 | `QOA006` | string |  |
| `QOA007` | 审核者 | `QOA007` | string |  |
| `QOA008` | 变更原因 | `QOA008` | string |  |
| `QOA009` | 原批量 | `QOA009` | float |  |
| `QOA010` | 原备注 | `QOA010` | string |  |
| `QOA960` | 自定文字1 | `udf_text1` | string |  |
| `QOA961` | 自定文字2 | `udf_text2` | string |  |
| `QOA962` | 自定文字3 | `udf_text3` | string |  |
| `QOA963` | 自定文字4 | `udf_text4` | string |  |
| `QOA964` | 自定文字5 | `udf_text5` | string |  |
| `QOA965` | 自定文字6 | `udf_text6` | string |  |
| `QOA980` | 自定数字1 | `udf_no1` | float |  |
| `QOA981` | 自定数字2 | `udf_no2` | float |  |
| `QOA982` | 自定数字3 | `udf_no3` | float |  |
| `QOA983` | 自定数字4 | `udf_no4` | float |  |
| `QOA984` | 自定数字5 | `udf_no5` | float |  |
| `QOA985` | 自定数字6 | `udf_no6` | float |  |
| `QOA901` | 录入者编号 | `entry_person_no` | string |  |
| `QOA902` | 录入时间 | `entry_time` | string |  |
| `QOA903` | 更改者编号 | `changer_no` | string |  |
| `QOA904` | 更改时间 | `change_time` | string |  |
| `QOA905` | 更新标记 | `update_flag` | integer |  |
| `QOA910` | 送审状态 | `submission_status` | string |  |
| `QOA911` | 送审人 | `reviewer` | string |  |
| `QOA912` | 审批人1 | `approver1` | string |  |
| `QOA913` | 审批结果 | `approval_result1` | string |  |
| `QOA914` | 审批意见 | `approval_opinion1` | string |  |
| `QOA915` | 审批人2 | `approver2` | string |  |
| `QOA916` | 审批结果 | `approval_result2` | string |  |
| `QOA917` | 审批意见 | `approval_opinion2` | string |  |
| `QOA918` | 审批人3 | `approver3` | string |  |
| `QOA919` | 审批结果 | `approval_result3` | string |  |
| `QOA920` | 审批意见 | `approval_opinion3` | string |  |
| `QOA921` | 审批人4 | `approver4` | string |  |
| `QOA922` | 审批结果 | `approval_result4` | string |  |
| `QOA923` | 审批意见 | `approval_opinion4` | string |  |
| `QOA924` | 审批人5 | `approver5` | string |  |
| `QOA925` | 审批结果 | `approval_result5` | string |  |
| `QOA926` | 审批意见 | `approval_opinion5` | string |  |
| `QOA927` | 审批人6 | `approver6` | string |  |
| `QOA928` | 审批结果 | `approval_result6` | string |  |
| `QOA929` | 审批意见 | `approval_opinion6` | string |  |
| `QOA930` | 终审人 | `final_approver` | string |  |
| `QOA931` | 审批结果 | `approval_result7` | string |  |
| `QOA932` | 审批意见 | `approval_opinion7` | string |  |
| `QOA933` | 通知人1 | `notifier1` | string |  |
| `QOA934` | 通知人2 | `notifier2` | string |  |
| `QOA935` | 通知人3 | `notifier3` | string |  |
| `QOA966` | 自定文字7 | `udf_text7` | string |  |
| `QOA967` | 自定文字8 | `udf_text8` | string |  |
| `QOA968` | 自定文字9 | `udf_text9` | string |  |
| `QOA969` | 自定文字10 | `udf_text10` | string |  |
| `QOA970` | 自定文字11 | `udf_text11` | string |  |
| `QOA971` | 自定文字12 | `udf_text12` | string |  |
| `QOA972` | 自定文字13 | `udf_text13` | string |  |
| `QOA973` | 自定文字14 | `udf_text14` | string |  |
| `QOA974` | 自定文字15 | `udf_text15` | string |  |
| `QOA975` | 自定文字16 | `udf_text16` | string |  |
| `QOA986` | 自定数字7 | `udf_no7` | float |  |
| `QOA987` | 自定数字8 | `udf_no8` | float |  |
| `QOA988` | 自定数字9 | `udf_no9` | float |  |
| `QOA989` | 自定数字10 | `udf_no10` | float |  |
| `QOA990` | 自定数字11 | `udf_no11` | float |  |
| `QOA991` | 自定数字12 | `udf_no12` | float |  |
| `QOA992` | 自定数字13 | `udf_no13` | float |  |
| `QOA993` | 自定数字14 | `udf_no14` | float |  |
| `QOA994` | 自定数字15 | `udf_no15` | float |  |
| `QOA995` | 自定数字16 | `udf_no16` | float |  |
| `QOA906` | 打印次数 | `print_count` | integer |  |
| `QOA907` | 打印时间 | `print_time` | string |  |
| `QOA908` | 打印人员 | `printer` | string |  |
| `QOA909` | 打印人员姓名 | `printer_name` | string |  |
| `QOA011` | 原自定文字1 | `QOA011` | string |  |
| `QOA012` | 原自定文字2 | `QOA012` | string |  |
| `QOA013` | 原自定文字3 | `QOA013` | string |  |
| `QOA014` | 原自定文字4 | `QOA014` | string |  |
| `QOA015` | 原自定文字5 | `QOA015` | string |  |
| `QOA016` | 原自定文字6 | `QOA016` | string |  |
| `QOA017` | 原自定文字7 | `QOA017` | string |  |
| `QOA018` | 原自定文字8 | `QOA018` | string |  |
| `QOA019` | 原自定文字9 | `QOA019` | string |  |
| `QOA020` | 原自定文字10 | `QOA020` | string |  |
| `QOA051` | 原自定文字11 | `QOA051` | string |  |
| `QOA052` | 原自定文字12 | `QOA052` | string |  |
| `QOA053` | 原自定文字13 | `QOA053` | string |  |
| `QOA054` | 原自定文字14 | `QOA054` | string |  |
| `QOA055` | 原自定文字15 | `QOA055` | string |  |
| `QOA056` | 原自定文字16 | `QOA056` | string |  |
| `QOA021` | 变更后自定文字1 | `QOA021` | string |  |
| `QOA022` | 变更后自定文字2 | `QOA022` | string |  |
| `QOA023` | 变更后自定文字3 | `QOA023` | string |  |
| `QOA024` | 变更后自定文字4 | `QOA024` | string |  |
| `QOA025` | 变更后自定文字5 | `QOA025` | string |  |
| `QOA026` | 变更后自定文字6 | `QOA026` | string |  |
| `QOA027` | 变更后自定文字7 | `QOA027` | string |  |
| `QOA028` | 变更后自定文字8 | `QOA028` | string |  |
| `QOA029` | 变更后自定文字9 | `QOA029` | string |  |
| `QOA030` | 变更后自定文字10 | `QOA030` | string |  |
| `QOA061` | 变更后自定文字11 | `QOA061` | string |  |
| `QOA062` | 变更后自定文字12 | `QOA062` | string |  |
| `QOA063` | 变更后自定文字13 | `QOA063` | string |  |
| `QOA064` | 变更后自定文字14 | `QOA064` | string |  |
| `QOA065` | 变更后自定文字15 | `QOA065` | string |  |
| `QOA066` | 变更后自定文字16 | `QOA066` | string |  |
| `QOA031` | 原自定数字1 | `QOA031` | float |  |
| `QOA032` | 原自定数字2 | `QOA032` | float |  |
| `QOA033` | 原自定数字3 | `QOA033` | float |  |
| `QOA034` | 原自定数字4 | `QOA034` | float |  |
| `QOA035` | 原自定数字5 | `QOA035` | float |  |
| `QOA036` | 原自定数字6 | `QOA036` | float |  |
| `QOA037` | 原自定数字7 | `QOA037` | float |  |
| `QOA038` | 原自定数字8 | `QOA038` | float |  |
| `QOA039` | 原自定数字9 | `QOA039` | float |  |
| `QOA040` | 原自定数字10 | `QOA040` | float |  |
| `QOA071` | 原自定数字11 | `QOA071` | float |  |
| `QOA072` | 原自定数字12 | `QOA072` | float |  |
| `QOA073` | 原自定数字13 | `QOA073` | float |  |
| `QOA074` | 原自定数字14 | `QOA074` | float |  |
| `QOA075` | 原自定数字15 | `QOA075` | float |  |
| `QOA076` | 原自定数字16 | `QOA076` | float |  |
| `QOA041` | 变更后自定数字1 | `QOA041` | float |  |
| `QOA042` | 变更后自定数字2 | `QOA042` | float |  |
| `QOA043` | 变更后自定数字3 | `QOA043` | float |  |
| `QOA044` | 变更后自定数字4 | `QOA044` | float |  |
| `QOA045` | 变更后自定数字5 | `QOA045` | float |  |
| `QOA046` | 变更后自定数字6 | `QOA046` | float |  |
| `QOA047` | 变更后自定数字7 | `QOA047` | float |  |
| `QOA048` | 变更后自定数字8 | `QOA048` | float |  |
| `QOA049` | 变更后自定数字9 | `QOA049` | float |  |
| `QOA050` | 变更后自定数字10 | `QOA050` | float |  |
| `QOA081` | 变更后自定数字11 | `QOA081` | float |  |
| `QOA082` | 变更后自定数字12 | `QOA082` | float |  |
| `QOA083` | 变更后自定数字13 | `QOA083` | float |  |
| `QOA084` | 变更后自定数字14 | `QOA084` | float |  |
| `QOA085` | 变更后自定数字15 | `QOA085` | float |  |
| `QOA086` | 变更后自定数字16 | `QOA086` | float |  |
| `QOA950` | 送审时间 | `submission_time_for_review` | string |  |
| `QOA951` | 审批时间1 | `approval_time1` | string |  |
| `QOA952` | 审批时间2 | `approval_time2` | string |  |
| `QOA953` | 审批时间3 | `approval_time3` | string |  |
| `QOA954` | 审批时间4 | `approval_time4` | string |  |
| `QOA955` | 审批时间5 | `approval_time5` | string |  |
| `QOA956` | 审批时间6 | `approval_time6` | string |  |
| `QOA957` | 终审时间 | `final_review_time` | string |  |
| `QOA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (SGMQOB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `QOB001` | 主件品号 | `QOB001` | string |  |
| `QOB002` | 变更版本 | `QOB002` | string |  |
| `QOB003` | 序号 | `QOB003` | string |  |
| `QOB004` | 操作码 | `QOB004` | string |  |
| `QOB005` | 新序号 | `QOB005` | string |  |
| `QOB006` | 子件品号 | `QOB006` | string |  |
| `QOB007` | 组成量 | `QOB007` | float |  |
| `QOB008` | 底数 | `QOB008` | float |  |
| `QOB009` | 损耗率 | `QOB009` | float |  |
| `QOB010` | 备注 | `QOB010` | string |  |
| `QOB011` | 选配代号 | `QOB011` | string |  |
| `QOB012` | 变更原因 | `QOB012` | string |  |
| `QOB013` | 审核码 | `QOB013` | string |  |
| `QOB014` | 原子件品号 | `QOB014` | string |  |
| `QOB015` | 原组成量 | `QOB015` | float |  |
| `QOB016` | 原底数 | `QOB016` | float |  |
| `QOB017` | 原损耗率 | `QOB017` | float |  |
| `QOB018` | 原备注 | `QOB018` | string |  |
| `QOB019` | 原选配代号 | `QOB019` | string |  |
| `QOB020` | 原序号 | `QOB020` | string |  |
| `QOB960` | 自定文字1 | `udf_text1` | string |  |
| `QOB961` | 自定文字2 | `udf_text2` | string |  |
| `QOB962` | 自定文字3 | `udf_text3` | string |  |
| `QOB963` | 自定文字4 | `udf_text4` | string |  |
| `QOB964` | 自定文字5 | `udf_text5` | string |  |
| `QOB965` | 自定文字6 | `udf_text6` | string |  |
| `QOB980` | 自定数字1 | `udf_no1` | float |  |
| `QOB981` | 自定数字2 | `udf_no2` | float |  |
| `QOB982` | 自定数字3 | `udf_no3` | float |  |
| `QOB983` | 自定数字4 | `udf_no4` | float |  |
| `QOB984` | 自定数字5 | `udf_no5` | float |  |
| `QOB985` | 自定数字6 | `udf_no6` | float |  |
| `QOB901` | 录入者编号 | `entry_person_no` | string |  |
| `QOB902` | 录入时间 | `entry_time` | string |  |
| `QOB903` | 更改者编号 | `changer_no` | string |  |
| `QOB904` | 更改时间 | `change_time` | string |  |
| `QOB905` | 更新标记 | `update_flag` | integer |  |
| `QOB966` | 自定文字7 | `udf_text7` | string |  |
| `QOB967` | 自定文字8 | `udf_text8` | string |  |
| `QOB968` | 自定文字9 | `udf_text9` | string |  |
| `QOB969` | 自定文字10 | `udf_text10` | string |  |
| `QOB970` | 自定文字11 | `udf_text11` | string |  |
| `QOB971` | 自定文字12 | `udf_text12` | string |  |
| `QOB972` | 自定文字13 | `udf_text13` | string |  |
| `QOB973` | 自定文字14 | `udf_text14` | string |  |
| `QOB974` | 自定文字15 | `udf_text15` | string |  |
| `QOB975` | 自定文字16 | `udf_text16` | string |  |
| `QOB986` | 自定数字7 | `udf_no7` | float |  |
| `QOB987` | 自定数字8 | `udf_no8` | float |  |
| `QOB988` | 自定数字9 | `udf_no9` | float |  |
| `QOB989` | 自定数字10 | `udf_no10` | float |  |
| `QOB990` | 自定数字11 | `udf_no11` | float |  |
| `QOB991` | 自定数字12 | `udf_no12` | float |  |
| `QOB992` | 自定数字13 | `udf_no13` | float |  |
| `QOB993` | 自定数字14 | `udf_no14` | float |  |
| `QOB994` | 自定数字15 | `udf_no15` | float |  |
| `QOB995` | 自定数字16 | `udf_no16` | float |  |
| `QOB031` | 原自定文字1 | `QOB031` | string |  |
| `QOB032` | 原自定文字2 | `QOB032` | string |  |
| `QOB033` | 原自定文字3 | `QOB033` | string |  |
| `QOB034` | 原自定文字4 | `QOB034` | string |  |
| `QOB035` | 原自定文字5 | `QOB035` | string |  |
| `QOB036` | 原自定文字6 | `QOB036` | string |  |
| `QOB037` | 原自定文字7 | `QOB037` | string |  |
| `QOB038` | 原自定文字8 | `QOB038` | string |  |
| `QOB039` | 原自定文字9 | `QOB039` | string |  |
| `QOB040` | 原自定文字10 | `QOB040` | string |  |
| `QOB081` | 原自定文字11 | `QOB081` | string |  |
| `QOB082` | 原自定文字12 | `QOB082` | string |  |
| `QOB083` | 原自定文字13 | `QOB083` | string |  |
| `QOB084` | 原自定文字14 | `QOB084` | string |  |
| `QOB085` | 原自定文字15 | `QOB085` | string |  |
| `QOB086` | 原自定文字16 | `QOB086` | string |  |
| `QOB041` | 变更后自定文字1 | `QOB041` | string |  |
| `QOB042` | 变更后自定文字2 | `QOB042` | string |  |
| `QOB043` | 变更后自定文字3 | `QOB043` | string |  |
| `QOB044` | 变更后自定文字4 | `QOB044` | string |  |
| `QOB045` | 变更后自定文字5 | `QOB045` | string |  |
| `QOB046` | 变更后自定文字6 | `QOB046` | string |  |
| `QOB047` | 变更后自定文字7 | `QOB047` | string |  |
| `QOB048` | 变更后自定文字8 | `QOB048` | string |  |
| `QOB049` | 变更后自定文字9 | `QOB049` | string |  |
| `QOB050` | 变更后自定文字10 | `QOB050` | string |  |
| `QOB091` | 变更后自定文字11 | `QOB091` | string |  |
| `QOB092` | 变更后自定文字12 | `QOB092` | string |  |
| `QOB093` | 变更后自定文字13 | `QOB093` | string |  |
| `QOB094` | 变更后自定文字14 | `QOB094` | string |  |
| `QOB095` | 变更后自定文字15 | `QOB095` | string |  |
| `QOB096` | 变更后自定文字16 | `QOB096` | string |  |
| `QOB051` | 原自定数字1 | `QOB051` | float |  |
| `QOB052` | 原自定数字2 | `QOB052` | float |  |
| `QOB053` | 原自定数字3 | `QOB053` | float |  |
| `QOB054` | 原自定数字4 | `QOB054` | float |  |
| `QOB055` | 原自定数字5 | `QOB055` | float |  |
| `QOB056` | 原自定数字6 | `QOB056` | float |  |
| `QOB057` | 原自定数字7 | `QOB057` | float |  |
| `QOB058` | 原自定数字8 | `QOB058` | float |  |
| `QOB059` | 原自定数字9 | `QOB059` | float |  |
| `QOB060` | 原自定数字10 | `QOB060` | float |  |
| `QOB101` | 原自定数字11 | `QOB101` | float |  |
| `QOB102` | 原自定数字12 | `QOB102` | float |  |
| `QOB103` | 原自定数字13 | `QOB103` | float |  |
| `QOB104` | 原自定数字14 | `QOB104` | float |  |
| `QOB105` | 原自定数字15 | `QOB105` | float |  |
| `QOB106` | 原自定数字16 | `QOB106` | float |  |
| `QOB061` | 变更后自定数字1 | `QOB061` | float |  |
| `QOB062` | 变更后自定数字2 | `QOB062` | float |  |
| `QOB063` | 变更后自定数字3 | `QOB063` | float |  |
| `QOB064` | 变更后自定数字4 | `QOB064` | float |  |
| `QOB065` | 变更后自定数字5 | `QOB065` | float |  |
| `QOB066` | 变更后自定数字6 | `QOB066` | float |  |
| `QOB067` | 变更后自定数字7 | `QOB067` | float |  |
| `QOB068` | 变更后自定数字8 | `QOB068` | float |  |
| `QOB069` | 变更后自定数字9 | `QOB069` | float |  |
| `QOB070` | 变更后自定数字10 | `QOB070` | float |  |
| `QOB111` | 变更后自定数字11 | `QOB111` | float |  |
| `QOB112` | 变更后自定数字12 | `QOB112` | float |  |
| `QOB113` | 变更后自定数字13 | `QOB113` | float |  |
| `QOB114` | 变更后自定数字14 | `QOB114` | float |  |
| `QOB115` | 变更后自定数字15 | `QOB115` | float |  |
| `QOB116` | 变更后自定数字16 | `QOB116` | float |  |
| `QOB122` | 位号 | `QOB122` | string |  |
| `QOB123` | 原位号 | `QOB123` | string |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "QOA001": ""
  ,"QOA001": ""
  ,"QOA002": ""
  ,"QOA003": ""
  ,"cdsDetail": [{
    "QOB001": ""
    ,"QOB001": ""
    ,"QOB002": ""
    ,"QOB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"QOA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"QOA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `QOA001` | `QOA001` | 主件品号 | |
| `QOA002` | `QOA002` | 变更版本 | |
| `QOA003` | `QOA003` | 变更日期 | |
| `QOA004` | `QOA004` | 批量 | |
| `QOA005` | `QOA005` | 审核码 | |
| `QOA006` | `QOA006` | 备注 | |
| `QOA007` | `QOA007` | 审核者 | |
| `QOA008` | `QOA008` | 变更原因 | |
| `QOA009` | `QOA009` | 原批量 | |
| `QOA010` | `QOA010` | 原备注 | |
| `QOB001` | `QOB001` | 主件品号 (单身) | |
| `QOB002` | `QOB002` | 变更版本 (单身) | |
| `QOB003` | `QOB003` | 序号 (单身) | |
| `QOB004` | `QOB004` | 操作码 (单身) | |
| `QOB005` | `QOB005` | 新序号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `QOA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `QOA001`
