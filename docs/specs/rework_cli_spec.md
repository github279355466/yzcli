# CLI 规格说明书：重工单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `rework` |
| **DLL** | `SGMZC12` |
| **服务名称** | `重工单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "rework" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "rework" \
  --action "getMultiple" \
  --data '{"datakeys":[{"RKA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "rework" \
  --action "create" \
  --data '{"RKA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "rework" \
  --action "approve" \
  --data '{"datakeys":[{"RKA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `RKA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (SGMRKA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RKA001` | 重工单单号 | `RKA001` | string | 主键 |
| `RKA002` | 性质 | `RKA002` | string |  |
| `RKA003` | 开单日期 | `RKA003` | string |  |
| `RKA004` | 经办人 | `RKA004` | string |  |
| `RKA005` | 部门 | `RKA005` | string |  |
| `RKA006` | 预计开工日 | `RKA006` | string |  |
| `RKA007` | 预计完工日 | `RKA007` | string |  |
| `RKA008` | 实际开工日 | `RKA008` | string |  |
| `RKA009` | 实际完工日 | `RKA009` | string |  |
| `RKA010` | 来源工单单号 | `RKA010` | string |  |
| `RKA011` | 主件品号 | `RKA011` | string |  |
| `RKA012` | 预留字段 | `RKA012` | string |  |
| `RKA013` | 预留字段 | `RKA013` | string |  |
| `RKA014` | 生产数量 | `RKA014` | float |  |
| `RKA015` | 已生产量 | `RKA015` | float |  |
| `RKA016` | 完工码 | `RKA016` | string |  |
| `RKA017` | 备注 | `RKA017` | string |  |
| `RKA018` | 审核者编号 | `RKA018` | string |  |
| `RKA019` | 审核者姓名 | `RKA019` | string |  |
| `RKA020` | 审核码 | `RKA020` | string |  |
| `RKA021` | 预留字段 | `RKA021` | string |  |
| `RKA022` | 预留字段 | `RKA022` | string |  |
| `RKA023` | 发放方式 | `RKA023` | string |  |
| `RKA024` | 预留字段 | `RKA024` | string |  |
| `RKA025` | 预留字段 | `RKA025` | string |  |
| `RKA026` | 预留字段 | `RKA026` | string |  |
| `RKA027` | 预留字段 | `RKA027` | float |  |
| `RKA028` | 预留字段 | `RKA028` | float |  |
| `RKA029` | 审核人 | `RKA029` | string |  |
| `RKA030` | 主要材料 | `RKA030` | string |  |
| `RKA031` | 报废数量 | `RKA031` | float |  |
| `RKA032` | 已检数量 | `RKA032` | float |  |
| `RKA033` | 不良品次数 | `RKA033` | float |  |
| `RKA901` | 录入者编号 | `entry_person_no` | string |  |
| `RKA902` | 录入时间 | `entry_time` | string |  |
| `RKA903` | 更改者编号 | `changer_no` | string |  |
| `RKA904` | 更改时间 | `change_time` | string |  |
| `RKA905` | 更新标记 | `update_flag` | integer |  |
| `RKA960` | 自定文字1 | `udf_text1` | string |  |
| `RKA961` | 自定文字2 | `udf_text2` | string |  |
| `RKA962` | 自定文字3 | `udf_text3` | string |  |
| `RKA963` | 自定文字4 | `udf_text4` | string |  |
| `RKA964` | 自定文字5 | `udf_text5` | string |  |
| `RKA965` | 自定文字6 | `udf_text6` | string |  |
| `RKA980` | 自定数字1 | `udf_no1` | float |  |
| `RKA981` | 自定数字2 | `udf_no2` | float |  |
| `RKA982` | 自定数字3 | `udf_no3` | float |  |
| `RKA983` | 自定数字4 | `udf_no4` | float |  |
| `RKA984` | 自定数字5 | `udf_no5` | float |  |
| `RKA985` | 自定数字6 | `udf_no6` | float |  |
| `RKA910` | 送审状态 | `submission_status` | string |  |
| `RKA911` | 送审人 | `reviewer` | string |  |
| `RKA912` | 审批人1 | `approver1` | string |  |
| `RKA913` | 审批结果 | `approval_result1` | string |  |
| `RKA914` | 审批意见 | `approval_opinion1` | string |  |
| `RKA915` | 审批人2 | `approver2` | string |  |
| `RKA916` | 审批结果 | `approval_result2` | string |  |
| `RKA917` | 审批意见 | `approval_opinion2` | string |  |
| `RKA918` | 审批人3 | `approver3` | string |  |
| `RKA919` | 审批结果 | `approval_result3` | string |  |
| `RKA920` | 审批意见 | `approval_opinion3` | string |  |
| `RKA921` | 审批人4 | `approver4` | string |  |
| `RKA922` | 审批结果 | `approval_result4` | string |  |
| `RKA923` | 审批意见 | `approval_opinion4` | string |  |
| `RKA924` | 审批人5 | `approver5` | string |  |
| `RKA925` | 审批结果 | `approval_result5` | string |  |
| `RKA926` | 审批意见 | `approval_opinion5` | string |  |
| `RKA927` | 审批人6 | `approver6` | string |  |
| `RKA928` | 审批结果 | `approval_result6` | string |  |
| `RKA929` | 审批意见 | `approval_opinion6` | string |  |
| `RKA930` | 终审人 | `final_approver` | string |  |
| `RKA931` | 审批结果 | `approval_result7` | string |  |
| `RKA932` | 审批意见 | `approval_opinion7` | string |  |
| `RKA933` | 通知人1 | `notifier1` | string |  |
| `RKA934` | 通知人2 | `notifier2` | string |  |
| `RKA935` | 通知人3 | `notifier3` | string |  |
| `RKA966` | 自定文字7 | `udf_text7` | string |  |
| `RKA967` | 自定文字8 | `udf_text8` | string |  |
| `RKA968` | 自定文字9 | `udf_text9` | string |  |
| `RKA969` | 自定文字10 | `udf_text10` | string |  |
| `RKA970` | 自定文字11 | `udf_text11` | string |  |
| `RKA971` | 自定文字12 | `udf_text12` | string |  |
| `RKA972` | 自定文字13 | `udf_text13` | string |  |
| `RKA973` | 自定文字14 | `udf_text14` | string |  |
| `RKA974` | 自定文字15 | `udf_text15` | string |  |
| `RKA975` | 自定文字16 | `udf_text16` | string |  |
| `RKA986` | 自定数字7 | `udf_no7` | float |  |
| `RKA987` | 自定数字8 | `udf_no8` | float |  |
| `RKA988` | 自定数字9 | `udf_no9` | float |  |
| `RKA989` | 自定数字10 | `udf_no10` | float |  |
| `RKA990` | 自定数字11 | `udf_no11` | float |  |
| `RKA991` | 自定数字12 | `udf_no12` | float |  |
| `RKA992` | 自定数字13 | `udf_no13` | float |  |
| `RKA993` | 自定数字14 | `udf_no14` | float |  |
| `RKA994` | 自定数字15 | `udf_no15` | float |  |
| `RKA995` | 自定数字16 | `udf_no16` | float |  |
| `RKA906` | 打印次数 | `print_count` | integer |  |
| `RKA907` | 打印时间 | `print_time` | string |  |
| `RKA908` | 打印人员 | `printer` | string |  |
| `RKA909` | 打印人员姓名 | `printer_name` | string |  |
| `RKA950` | 送审时间 | `submission_time_for_review` | string |  |
| `RKA951` | 审批时间1 | `approval_time1` | string |  |
| `RKA952` | 审批时间2 | `approval_time2` | string |  |
| `RKA953` | 审批时间3 | `approval_time3` | string |  |
| `RKA954` | 审批时间4 | `approval_time4` | string |  |
| `RKA955` | 审批时间5 | `approval_time5` | string |  |
| `RKA956` | 审批时间6 | `approval_time6` | string |  |
| `RKA957` | 终审时间 | `final_review_time` | string |  |
| `RKA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (SGMRKB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RKB001` | 重工单单号 | `RKB001` | string |  |
| `RKB002` | 序号 | `RKB002` | string |  |
| `RKB003` | 子件品号 | `RKB003` | string |  |
| `RKB004` | 品名(预留) | `RKB004` | string |  |
| `RKB005` | 规格 | `RKB005` | string |  |
| `RKB006` | 单位(预留) | `RKB006` | string |  |
| `RKB007` | 仓库 | `RKB007` | string |  |
| `RKB008` | 预计用量 | `RKB008` | float |  |
| `RKB009` | 已领料量 | `RKB009` | float |  |
| `RKB010` | 入库耗用量 | `RKB010` | float |  |
| `RKB011` | 结束 | `RKB011` | string |  |
| `RKB012` | 备注 | `RKB012` | string |  |
| `RKB013` | 审核码 | `RKB013` | string |  |
| `RKB014` | 预留字段 | `RKB014` | string |  |
| `RKB015` | 预留字段 | `RKB015` | string |  |
| `RKB016` | 预留字段 | `RKB016` | string |  |
| `RKB017` | 预留字段 | `RKB017` | string |  |
| `RKB018` | 预留字段 | `RKB018` | string |  |
| `RKB019` | 预留字段 | `RKB019` | float |  |
| `RKB020` | 预留字段 | `RKB020` | float |  |
| `RKB901` | 录入者编号 | `entry_person_no` | string |  |
| `RKB902` | 录入时间 | `entry_time` | string |  |
| `RKB903` | 更改者编号 | `changer_no` | string |  |
| `RKB904` | 更改时间 | `change_time` | string |  |
| `RKB905` | 更新标记 | `update_flag` | integer |  |
| `RKB960` | 自定文字1 | `udf_text1` | string |  |
| `RKB961` | 自定文字2 | `udf_text2` | string |  |
| `RKB962` | 自定文字3 | `udf_text3` | string |  |
| `RKB963` | 自定文字4 | `udf_text4` | string |  |
| `RKB964` | 自定文字5 | `udf_text5` | string |  |
| `RKB965` | 自定文字6 | `udf_text6` | string |  |
| `RKB980` | 自定数字1 | `udf_no1` | float |  |
| `RKB981` | 自定数字2 | `udf_no2` | float |  |
| `RKB982` | 自定数字3 | `udf_no3` | float |  |
| `RKB983` | 自定数字4 | `udf_no4` | float |  |
| `RKB984` | 自定数字5 | `udf_no5` | float |  |
| `RKB985` | 自定数字6 | `udf_no6` | float |  |
| `RKB966` | 自定文字7 | `udf_text7` | string |  |
| `RKB967` | 自定文字8 | `udf_text8` | string |  |
| `RKB968` | 自定文字9 | `udf_text9` | string |  |
| `RKB969` | 自定文字10 | `udf_text10` | string |  |
| `RKB970` | 自定文字11 | `udf_text11` | string |  |
| `RKB971` | 自定文字12 | `udf_text12` | string |  |
| `RKB972` | 自定文字13 | `udf_text13` | string |  |
| `RKB973` | 自定文字14 | `udf_text14` | string |  |
| `RKB974` | 自定文字15 | `udf_text15` | string |  |
| `RKB975` | 自定文字16 | `udf_text16` | string |  |
| `RKB986` | 自定数字7 | `udf_no7` | float |  |
| `RKB987` | 自定数字8 | `udf_no8` | float |  |
| `RKB988` | 自定数字9 | `udf_no9` | float |  |
| `RKB989` | 自定数字10 | `udf_no10` | float |  |
| `RKB990` | 自定数字11 | `udf_no11` | float |  |
| `RKB991` | 自定数字12 | `udf_no12` | float |  |
| `RKB992` | 自定数字13 | `udf_no13` | float |  |
| `RKB993` | 自定数字14 | `udf_no14` | float |  |
| `RKB994` | 自定数字15 | `udf_no15` | float |  |
| `RKB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (SGMRKC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RKC001` | 单号 | `RKC001` | string |  |
| `RKC002` | 重工单序号 | `RKC002` | string |  |
| `RKC003` | 批号 | `RKC003` | string |  |
| `RKC004` | 已领料量 | `RKC004` | float |  |
| `RKC005` | 已耗用量 | `RKC005` | float |  |
| `RKC006` | 预留字段 | `RKC006` | string |  |
| `RKC007` | 预留字段 | `RKC007` | string |  |
| `RKC008` | 预留字段 | `RKC008` | string |  |
| `RKC009` | 预留字段 | `RKC009` | string |  |
| `RKC010` | 预留字段 | `RKC010` | float |  |
| `RKC011` | 预留字段 | `RKC011` | float |  |
| `RKC901` | 录入者编号 | `entry_person_no` | string |  |
| `RKC902` | 录入时间 | `entry_time` | string |  |
| `RKC903` | 更改者编号 | `changer_no` | string |  |
| `RKC904` | 更改时间 | `change_time` | string |  |
| `RKC905` | 更新标记 | `update_flag` | integer |  |
| `RKC960` | 自定文字1 | `udf_text1` | string |  |
| `RKC961` | 自定文字2 | `udf_text2` | string |  |
| `RKC962` | 自定文字3 | `udf_text3` | string |  |
| `RKC963` | 自定文字4 | `udf_text4` | string |  |
| `RKC964` | 自定文字5 | `udf_text5` | string |  |
| `RKC965` | 自定文字6 | `udf_text6` | string |  |
| `RKC980` | 自定数字1 | `udf_no1` | float |  |
| `RKC981` | 自定数字2 | `udf_no2` | float |  |
| `RKC982` | 自定数字3 | `udf_no3` | float |  |
| `RKC983` | 自定数字4 | `udf_no4` | float |  |
| `RKC984` | 自定数字5 | `udf_no5` | float |  |
| `RKC985` | 自定数字6 | `udf_no6` | float |  |
| `RKC966` | 自定文字7 | `udf_text7` | string |  |
| `RKC967` | 自定文字8 | `udf_text8` | string |  |
| `RKC968` | 自定文字9 | `udf_text9` | string |  |
| `RKC969` | 自定文字10 | `udf_text10` | string |  |
| `RKC970` | 自定文字11 | `udf_text11` | string |  |
| `RKC971` | 自定文字12 | `udf_text12` | string |  |
| `RKC972` | 自定文字13 | `udf_text13` | string |  |
| `RKC973` | 自定文字14 | `udf_text14` | string |  |
| `RKC974` | 自定文字15 | `udf_text15` | string |  |
| `RKC975` | 自定文字16 | `udf_text16` | string |  |
| `RKC986` | 自定数字7 | `udf_no7` | float |  |
| `RKC987` | 自定数字8 | `udf_no8` | float |  |
| `RKC988` | 自定数字9 | `udf_no9` | float |  |
| `RKC989` | 自定数字10 | `udf_no10` | float |  |
| `RKC990` | 自定数字11 | `udf_no11` | float |  |
| `RKC991` | 自定数字12 | `udf_no12` | float |  |
| `RKC992` | 自定数字13 | `udf_no13` | float |  |
| `RKC993` | 自定数字14 | `udf_no14` | float |  |
| `RKC994` | 自定数字15 | `udf_no15` | float |  |
| `RKC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "RKA001": ""
  ,"RKA002": ""
  ,"RKA003": ""
  ,"RKA004": ""
  ,"cdsDetail": [{
    "RKB001": ""
    ,"RKB001": ""
    ,"RKB002": ""
    ,"RKB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"RKA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"RKA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `RKA001` | `RKA001` | 重工单单号 | 主键 |
| `RKA002` | `RKA002` | 性质 | |
| `RKA003` | `RKA003` | 开单日期 | |
| `RKA004` | `RKA004` | 经办人 | |
| `RKA005` | `RKA005` | 部门 | |
| `RKA006` | `RKA006` | 预计开工日 | |
| `RKA007` | `RKA007` | 预计完工日 | |
| `RKA008` | `RKA008` | 实际开工日 | |
| `RKA009` | `RKA009` | 实际完工日 | |
| `RKA010` | `RKA010` | 来源工单单号 | |
| `RKB001` | `RKB001` | 重工单单号 (单身) | |
| `RKB002` | `RKB002` | 序号 (单身) | |
| `RKB003` | `RKB003` | 子件品号 (单身) | |
| `RKB004` | `RKB004` | 品名(预留) (单身) | |
| `RKB005` | `RKB005` | 规格 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `RKA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `RKA001`
