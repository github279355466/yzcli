# CLI 规格说明书：产品结构

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `bom` |
| **DLL** | `SGMBC01` |
| **服务名称** | `产品结构` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bom" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bom" \
  --action "getMultiple" \
  --data '{"datakeys":[{"QAA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bom" \
  --action "create" \
  --data '{"QAA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bom" \
  --action "approve" \
  --data '{"datakeys":[{"QAA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `QAA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (SGMQAA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `QAA001` | 主件品号 | `QAA001` | string | 主键 |
| `QAA002` | 预留 | `QAA002` | string |  |
| `QAA003` | 批量 | `QAA003` | float |  |
| `QAA004` | 日期 | `QAA004` | string |  |
| `QAA005` | 备注 | `QAA005` | string |  |
| `QAA006` | 审核码 | `QAA006` | string |  |
| `QAA007` | (预留)日期 | `QAA007` | string |  |
| `QAA008` | (预留)审核者 | `QAA008` | string |  |
| `QAA009` | (预留)审核者姓名 | `QAA009` | string |  |
| `QAA010` | 预留字段 | `QAA010` | integer |  |
| `QAA011` | 预留字段 | `QAA011` | integer |  |
| `QAA012` | 预留字段 | `QAA012` | float |  |
| `QAA013` | 预留字段 | `QAA013` | float |  |
| `QAA014` | 预留字段 | `QAA014` | string |  |
| `QAA015` | 预留字段 | `QAA015` | string |  |
| `QAA016` | 预留字段 | `QAA016` | string |  |
| `QAA017` | 预留字段 | `QAA017` | string |  |
| `QAA018` | 预留字段 | `QAA018` | string |  |
| `QAA019` | 预留字段 | `QAA019` | string |  |
| `QAA020` | 预留字段 | `QAA020` | float |  |
| `QAA021` | 预留字段 | `QAA021` | float |  |
| `QAA901` | 录入者编号 | `entry_person_no` | string |  |
| `QAA902` | 录入时间 | `entry_time` | string |  |
| `QAA903` | 更改者编号 | `changer_no` | string |  |
| `QAA904` | 更改时间 | `change_time` | string |  |
| `QAA905` | 更新标记 | `update_flag` | integer |  |
| `QAA960` | 自定文字1 | `udf_text1` | string |  |
| `QAA961` | 自定文字2 | `udf_text2` | string |  |
| `QAA962` | 自定文字3 | `udf_text3` | string |  |
| `QAA963` | 自定文字4 | `udf_text4` | string |  |
| `QAA964` | 自定文字5 | `udf_text5` | string |  |
| `QAA965` | 自定文字6 | `udf_text6` | string |  |
| `QAA980` | 自定数字1 | `udf_no1` | float |  |
| `QAA981` | 自定数字2 | `udf_no2` | float |  |
| `QAA982` | 自定数字3 | `udf_no3` | float |  |
| `QAA983` | 自定数字4 | `udf_no4` | float |  |
| `QAA984` | 自定数字5 | `udf_no5` | float |  |
| `QAA985` | 自定数字6 | `udf_no6` | float |  |
| `QAA910` | 送审状态 | `submission_status` | string |  |
| `QAA911` | 送审人 | `reviewer` | string |  |
| `QAA912` | 审批人1 | `approver1` | string |  |
| `QAA913` | 审批结果 | `approval_result1` | string |  |
| `QAA914` | 审批意见 | `approval_opinion1` | string |  |
| `QAA915` | 审批人2 | `approver2` | string |  |
| `QAA916` | 审批结果 | `approval_result2` | string |  |
| `QAA917` | 审批意见 | `approval_opinion2` | string |  |
| `QAA918` | 审批人3 | `approver3` | string |  |
| `QAA919` | 审批结果 | `approval_result3` | string |  |
| `QAA920` | 审批意见 | `approval_opinion3` | string |  |
| `QAA921` | 审批人4 | `approver4` | string |  |
| `QAA922` | 审批结果 | `approval_result4` | string |  |
| `QAA923` | 审批意见 | `approval_opinion4` | string |  |
| `QAA924` | 审批人5 | `approver5` | string |  |
| `QAA925` | 审批结果 | `approval_result5` | string |  |
| `QAA926` | 审批意见 | `approval_opinion5` | string |  |
| `QAA927` | 审批人6 | `approver6` | string |  |
| `QAA928` | 审批结果 | `approval_result6` | string |  |
| `QAA929` | 审批意见 | `approval_opinion6` | string |  |
| `QAA930` | 终审人 | `final_approver` | string |  |
| `QAA931` | 审批结果 | `approval_result7` | string |  |
| `QAA932` | 审批意见 | `approval_opinion7` | string |  |
| `QAA933` | 通知人1 | `notifier1` | string |  |
| `QAA934` | 通知人2 | `notifier2` | string |  |
| `QAA935` | 通知人3 | `notifier3` | string |  |
| `QAA966` | 自定文字7 | `udf_text7` | string |  |
| `QAA967` | 自定文字8 | `udf_text8` | string |  |
| `QAA968` | 自定文字9 | `udf_text9` | string |  |
| `QAA969` | 自定文字10 | `udf_text10` | string |  |
| `QAA970` | 自定文字11 | `udf_text11` | string |  |
| `QAA971` | 自定文字12 | `udf_text12` | string |  |
| `QAA972` | 自定文字13 | `udf_text13` | string |  |
| `QAA973` | 自定文字14 | `udf_text14` | string |  |
| `QAA974` | 自定文字15 | `udf_text15` | string |  |
| `QAA975` | 自定文字16 | `udf_text16` | string |  |
| `QAA986` | 自定数字7 | `udf_no7` | float |  |
| `QAA987` | 自定数字8 | `udf_no8` | float |  |
| `QAA988` | 自定数字9 | `udf_no9` | float |  |
| `QAA989` | 自定数字10 | `udf_no10` | float |  |
| `QAA990` | 自定数字11 | `udf_no11` | float |  |
| `QAA991` | 自定数字12 | `udf_no12` | float |  |
| `QAA992` | 自定数字13 | `udf_no13` | float |  |
| `QAA993` | 自定数字14 | `udf_no14` | float |  |
| `QAA994` | 自定数字15 | `udf_no15` | float |  |
| `QAA995` | 自定数字16 | `udf_no16` | float |  |
| `QAA906` | 打印次数 | `print_count` | integer |  |
| `QAA907` | 打印时间 | `print_time` | string |  |
| `QAA908` | 打印人员 | `printer` | string |  |
| `QAA909` | 打印人员姓名 | `printer_name` | string |  |
| `QAA950` | 送审时间 | `submission_time_for_review` | string |  |
| `QAA951` | 审批时间1 | `approval_time1` | string |  |
| `QAA952` | 审批时间2 | `approval_time2` | string |  |
| `QAA953` | 审批时间3 | `approval_time3` | string |  |
| `QAA954` | 审批时间4 | `approval_time4` | string |  |
| `QAA955` | 审批时间5 | `approval_time5` | string |  |
| `QAA956` | 审批时间6 | `approval_time6` | string |  |
| `QAA957` | 终审时间 | `final_review_time` | string |  |
| `QAA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (SGMQAB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `QAB001` | 主件品号 | `QAB001` | string |  |
| `QAB002` | 序号 | `QAB002` | string |  |
| `QAB003` | 子件品号 | `QAB003` | string |  |
| `QAB004` | 预留 | `QAB004` | string |  |
| `QAB005` | 组成量 | `QAB005` | float |  |
| `QAB006` | 底数 | `QAB006` | float |  |
| `QAB007` | 损耗率 | `QAB007` | float |  |
| `QAB008` | 备注 | `QAB008` | string |  |
| `QAB009` | (预留)审核码 | `QAB009` | string |  |
| `QAB010` | (预留)日期 | `QAB010` | string |  |
| `QAB011` | 预留字段 | `QAB011` | string |  |
| `QAB012` | 预留字段 | `QAB012` | string |  |
| `QAB013` | 预留字段 | `QAB013` | string |  |
| `QAB014` | 预留字段 | `QAB014` | string |  |
| `QAB015` | 预留字段 | `QAB015` | string |  |
| `QAB016` | 预留字段 | `QAB016` | string |  |
| `QAB017` | 预留字段 | `QAB017` | string |  |
| `QAB018` | 预留字段 | `QAB018` | string |  |
| `QAB019` | 预留字段 | `QAB019` | float |  |
| `QAB020` | 预留字段 | `QAB020` | float |  |
| `QAB021` | 选配代号 | `QAB021` | string |  |
| `QAB022` | 位号 | `QAB022` | string |  |
| `QAB901` | 录入者编号 | `entry_person_no` | string |  |
| `QAB902` | 录入时间 | `entry_time` | string |  |
| `QAB903` | 更改者编号 | `changer_no` | string |  |
| `QAB904` | 更改时间 | `change_time` | string |  |
| `QAB905` | 更新标记 | `update_flag` | integer |  |
| `QAB960` | 自定文字1 | `udf_text1` | string |  |
| `QAB961` | 自定文字2 | `udf_text2` | string |  |
| `QAB962` | 自定文字3 | `udf_text3` | string |  |
| `QAB963` | 自定文字4 | `udf_text4` | string |  |
| `QAB964` | 自定文字5 | `udf_text5` | string |  |
| `QAB965` | 自定文字6 | `udf_text6` | string |  |
| `QAB980` | 自定数字1 | `udf_no1` | float |  |
| `QAB981` | 自定数字2 | `udf_no2` | float |  |
| `QAB982` | 自定数字3 | `udf_no3` | float |  |
| `QAB983` | 自定数字4 | `udf_no4` | float |  |
| `QAB984` | 自定数字5 | `udf_no5` | float |  |
| `QAB985` | 自定数字6 | `udf_no6` | float |  |
| `QAB966` | 自定文字7 | `udf_text7` | string |  |
| `QAB967` | 自定文字8 | `udf_text8` | string |  |
| `QAB968` | 自定文字9 | `udf_text9` | string |  |
| `QAB969` | 自定文字10 | `udf_text10` | string |  |
| `QAB970` | 自定文字11 | `udf_text11` | string |  |
| `QAB971` | 自定文字12 | `udf_text12` | string |  |
| `QAB972` | 自定文字13 | `udf_text13` | string |  |
| `QAB973` | 自定文字14 | `udf_text14` | string |  |
| `QAB974` | 自定文字15 | `udf_text15` | string |  |
| `QAB975` | 自定文字16 | `udf_text16` | string |  |
| `QAB986` | 自定数字7 | `udf_no7` | float |  |
| `QAB987` | 自定数字8 | `udf_no8` | float |  |
| `QAB988` | 自定数字9 | `udf_no9` | float |  |
| `QAB989` | 自定数字10 | `udf_no10` | float |  |
| `QAB990` | 自定数字11 | `udf_no11` | float |  |
| `QAB991` | 自定数字12 | `udf_no12` | float |  |
| `QAB992` | 自定数字13 | `udf_no13` | float |  |
| `QAB993` | 自定数字14 | `udf_no14` | float |  |
| `QAB994` | 自定数字15 | `udf_no15` | float |  |
| `QAB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (SGMQAC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `QAC001` | 主件品号 | `QAC001` | string | 主键 |
| `QAC002` | 图档 | `QAC002` | string |  |
| `QAC003` | 图档类型 | `QAC003` | string |  |
| `QAC901` | 录入者编号 | `entry_person_no` | string |  |
| `QAC902` | 录入时间 | `entry_time` | string |  |
| `QAC903` | 更改者编号 | `changer_no` | string |  |
| `QAC904` | 更改时间 | `change_time` | string |  |
| `QAC905` | 更新标记 | `update_flag` | integer |  |
| `QAC960` | 自定文字1 | `udf_text1` | string |  |
| `QAC961` | 自定文字2 | `udf_text2` | string |  |
| `QAC962` | 自定文字3 | `udf_text3` | string |  |
| `QAC963` | 自定文字4 | `udf_text4` | string |  |
| `QAC964` | 自定文字5 | `udf_text5` | string |  |
| `QAC965` | 自定文字6 | `udf_text6` | string |  |
| `QAC980` | 自定数字1 | `udf_no1` | float |  |
| `QAC981` | 自定数字2 | `udf_no2` | float |  |
| `QAC982` | 自定数字3 | `udf_no3` | float |  |
| `QAC983` | 自定数字4 | `udf_no4` | float |  |
| `QAC984` | 自定数字5 | `udf_no5` | float |  |
| `QAC985` | 自定数字6 | `udf_no6` | float |  |
| `QAC966` | 自定文字7 | `udf_text7` | string |  |
| `QAC967` | 自定文字8 | `udf_text8` | string |  |
| `QAC968` | 自定文字9 | `udf_text9` | string |  |
| `QAC969` | 自定文字10 | `udf_text10` | string |  |
| `QAC970` | 自定文字11 | `udf_text11` | string |  |
| `QAC971` | 自定文字12 | `udf_text12` | string |  |
| `QAC972` | 自定文字13 | `udf_text13` | string |  |
| `QAC973` | 自定文字14 | `udf_text14` | string |  |
| `QAC974` | 自定文字15 | `udf_text15` | string |  |
| `QAC975` | 自定文字16 | `udf_text16` | string |  |
| `QAC986` | 自定数字7 | `udf_no7` | float |  |
| `QAC987` | 自定数字8 | `udf_no8` | float |  |
| `QAC988` | 自定数字9 | `udf_no9` | float |  |
| `QAC989` | 自定数字10 | `udf_no10` | float |  |
| `QAC990` | 自定数字11 | `udf_no11` | float |  |
| `QAC991` | 自定数字12 | `udf_no12` | float |  |
| `QAC992` | 自定数字13 | `udf_no13` | float |  |
| `QAC993` | 自定数字14 | `udf_no14` | float |  |
| `QAC994` | 自定数字15 | `udf_no15` | float |  |
| `QAC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "QAA001": ""
  ,"QAA002": ""
  ,"QAA003": 1
  ,"QAA004": ""
  ,"cdsDetail": [{
    "QAB001": ""
    ,"QAB001": ""
    ,"QAB002": ""
    ,"QAB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"QAA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"QAA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `QAA001` | `QAA001` | 主件品号 | 主键 |
| `QAA002` | `QAA002` | 预留 | |
| `QAA003` | `QAA003` | 批量 | |
| `QAA004` | `QAA004` | 日期 | |
| `QAA005` | `QAA005` | 备注 | |
| `QAA006` | `QAA006` | 审核码 | |
| `QAA007` | `QAA007` | (预留)日期 | |
| `QAA008` | `QAA008` | (预留)审核者 | |
| `QAA009` | `QAA009` | (预留)审核者姓名 | |
| `QAA010` | `QAA010` | 预留字段 | |
| `QAB001` | `QAB001` | 主件品号 (单身) | |
| `QAB002` | `QAB002` | 序号 (单身) | |
| `QAB003` | `QAB003` | 子件品号 (单身) | |
| `QAB004` | `QAB004` | 预留 (单身) | |
| `QAB005` | `QAB005` | 组成量 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `QAA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `QAA001`
