# CLI 规格说明书：验退退回单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `purchase.inspection.return` |
| **DLL** | `QMSCC08` |
| **服务名称** | `验退退回单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.inspection.return" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.inspection.return" \
  --action "getMultiple" \
  --data '{"datakeys":[{"JEA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.inspection.return" \
  --action "create" \
  --data '{"JEA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.inspection.return" \
  --action "approve" \
  --data '{"datakeys":[{"JEA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `JEA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKJEA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JEA001` | 单号 | `JEA001` | string | 主键 |
| `JEA002` | 性质 | `JEA002` | string |  |
| `JEA003` | 日期 | `JEA003` | string |  |
| `JEA004` | 供应商 | `JEA004` | string |  |
| `JEA005` | 经办人 | `JEA005` | string |  |
| `JEA006` | 部门 | `JEA006` | string |  |
| `JEA007` | 专案 | `JEA007` | string |  |
| `JEA008` | 复核编号 | `JEA008` | string |  |
| `JEA009` | 复核姓名 | `JEA009` | string |  |
| `JEA010` | 备注 | `JEA010` | string |  |
| `JEA011` | 审核码 | `JEA011` | string |  |
| `JEA012` | 预留字段 | `JEA012` | string |  |
| `JEA013` | 预留字段 | `JEA013` | string |  |
| `JEA014` | 预留字段 | `JEA014` | string |  |
| `JEA015` | 预留字段 | `JEA015` | string |  |
| `JEA016` | 预留字段 | `JEA016` | string |  |
| `JEA017` | 预留字段 | `JEA017` | float |  |
| `JEA018` | 预留字段 | `JEA018` | float |  |
| `JEA019` | 审核人 | `JEA019` | string |  |
| `JEA901` | 录入者编号 | `entry_person_no` | string |  |
| `JEA902` | 录入时间 | `entry_time` | string |  |
| `JEA903` | 更改者编号 | `changer_no` | string |  |
| `JEA904` | 更改时间 | `change_time` | string |  |
| `JEA905` | 更新标记 | `update_flag` | integer |  |
| `JEA960` | 自定文字1 | `udf_text1` | string |  |
| `JEA961` | 自定文字2 | `udf_text2` | string |  |
| `JEA962` | 自定文字3 | `udf_text3` | string |  |
| `JEA963` | 自定文字4 | `udf_text4` | string |  |
| `JEA964` | 自定文字5 | `udf_text5` | string |  |
| `JEA965` | 自定文字6 | `udf_text6` | string |  |
| `JEA980` | 自定数字1 | `udf_no1` | float |  |
| `JEA981` | 自定数字2 | `udf_no2` | float |  |
| `JEA982` | 自定数字3 | `udf_no3` | float |  |
| `JEA983` | 自定数字4 | `udf_no4` | float |  |
| `JEA984` | 自定数字5 | `udf_no5` | float |  |
| `JEA985` | 自定数字6 | `udf_no6` | float |  |
| `JEA910` | 送审状态 | `submission_status` | string |  |
| `JEA911` | 送审人 | `reviewer` | string |  |
| `JEA912` | 审批人1 | `approver1` | string |  |
| `JEA913` | 审批结果 | `approval_result1` | string |  |
| `JEA914` | 审批意见 | `approval_opinion1` | string |  |
| `JEA915` | 审批人2 | `approver2` | string |  |
| `JEA916` | 审批结果 | `approval_result2` | string |  |
| `JEA917` | 审批意见 | `approval_opinion2` | string |  |
| `JEA918` | 审批人3 | `approver3` | string |  |
| `JEA919` | 审批结果 | `approval_result3` | string |  |
| `JEA920` | 审批意见 | `approval_opinion3` | string |  |
| `JEA921` | 审批人4 | `approver4` | string |  |
| `JEA922` | 审批结果 | `approval_result4` | string |  |
| `JEA923` | 审批意见 | `approval_opinion4` | string |  |
| `JEA924` | 审批人5 | `approver5` | string |  |
| `JEA925` | 审批结果 | `approval_result5` | string |  |
| `JEA926` | 审批意见 | `approval_opinion5` | string |  |
| `JEA927` | 审批人6 | `approver6` | string |  |
| `JEA928` | 审批结果 | `approval_result6` | string |  |
| `JEA929` | 审批意见 | `approval_opinion6` | string |  |
| `JEA930` | 终审人 | `final_approver` | string |  |
| `JEA931` | 审批结果 | `approval_result7` | string |  |
| `JEA932` | 审批意见 | `approval_opinion7` | string |  |
| `JEA933` | 通知人1 | `notifier1` | string |  |
| `JEA934` | 通知人2 | `notifier2` | string |  |
| `JEA935` | 通知人3 | `notifier3` | string |  |
| `JEA966` | 自定文字7 | `udf_text7` | string |  |
| `JEA967` | 自定文字8 | `udf_text8` | string |  |
| `JEA968` | 自定文字9 | `udf_text9` | string |  |
| `JEA969` | 自定文字10 | `udf_text10` | string |  |
| `JEA970` | 自定文字11 | `udf_text11` | string |  |
| `JEA971` | 自定文字12 | `udf_text12` | string |  |
| `JEA972` | 自定文字13 | `udf_text13` | string |  |
| `JEA973` | 自定文字14 | `udf_text14` | string |  |
| `JEA974` | 自定文字15 | `udf_text15` | string |  |
| `JEA975` | 自定文字16 | `udf_text16` | string |  |
| `JEA986` | 自定数字7 | `udf_no7` | float |  |
| `JEA987` | 自定数字8 | `udf_no8` | float |  |
| `JEA988` | 自定数字9 | `udf_no9` | float |  |
| `JEA989` | 自定数字10 | `udf_no10` | float |  |
| `JEA990` | 自定数字11 | `udf_no11` | float |  |
| `JEA991` | 自定数字12 | `udf_no12` | float |  |
| `JEA992` | 自定数字13 | `udf_no13` | float |  |
| `JEA993` | 自定数字14 | `udf_no14` | float |  |
| `JEA994` | 自定数字15 | `udf_no15` | float |  |
| `JEA995` | 自定数字16 | `udf_no16` | float |  |
| `JEA906` | 打印次数 | `print_count` | integer |  |
| `JEA907` | 打印时间 | `print_time` | string |  |
| `JEA908` | 打印人员 | `printer` | string |  |
| `JEA909` | 打印人员姓名 | `printer_name` | string |  |
| `JEA950` | 送审时间 | `submission_time_for_review` | string |  |
| `JEA951` | 审批时间1 | `approval_time1` | string |  |
| `JEA952` | 审批时间2 | `approval_time2` | string |  |
| `JEA953` | 审批时间3 | `approval_time3` | string |  |
| `JEA954` | 审批时间4 | `approval_time4` | string |  |
| `JEA955` | 审批时间5 | `approval_time5` | string |  |
| `JEA956` | 审批时间6 | `approval_time6` | string |  |
| `JEA957` | 终审时间 | `final_review_time` | string |  |
| `JEA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKJEB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JEB001` | 单号 | `JEB001` | string |  |
| `JEB002` | 序号 | `JEB002` | string |  |
| `JEB003` | 品号 | `JEB003` | string |  |
| `JEB004` | 品名 | `JEB004` | string |  |
| `JEB005` | 单位 | `JEB005` | string |  |
| `JEB006` | 数量 | `JEB006` | float |  |
| `JEB007` | 前置来源 | `JEB007` | string |  |
| `JEB008` | 前置单据 | `JEB008` | string |  |
| `JEB009` | 前置序号 | `JEB009` | string |  |
| `JEB010` | 审核码 | `JEB010` | string |  |
| `JEB011` | 预留字段 | `JEB011` | string |  |
| `JEB012` | 预留字段 | `JEB012` | string |  |
| `JEB013` | 预留字段 | `JEB013` | string |  |
| `JEB014` | 预留字段 | `JEB014` | string |  |
| `JEB015` | 预留字段 | `JEB015` | string |  |
| `JEB016` | 预留字段 | `JEB016` | string |  |
| `JEB017` | 预留字段 | `JEB017` | float |  |
| `JEB018` | 预留字段 | `JEB018` | float |  |
| `JEB019` | 换算分子 | `JEB019` | float |  |
| `JEB020` | 换算分母 | `JEB020` | float |  |
| `JEB021` | 辅助单位 | `JEB021` | string |  |
| `JEB022` | 辅助数量 | `JEB022` | float |  |
| `JEB023` | 规格 | `JEB023` | string |  |
| `JEB901` | 录入者编号 | `entry_person_no` | string |  |
| `JEB902` | 录入时间 | `entry_time` | string |  |
| `JEB903` | 更改者编号 | `changer_no` | string |  |
| `JEB904` | 更改时间 | `change_time` | string |  |
| `JEB905` | 更新标记 | `update_flag` | integer |  |
| `JEB960` | 自定文字1 | `udf_text1` | string |  |
| `JEB961` | 自定文字2 | `udf_text2` | string |  |
| `JEB962` | 自定文字3 | `udf_text3` | string |  |
| `JEB963` | 自定文字4 | `udf_text4` | string |  |
| `JEB964` | 自定文字5 | `udf_text5` | string |  |
| `JEB965` | 自定文字6 | `udf_text6` | string |  |
| `JEB980` | 自定数字1 | `udf_no1` | float |  |
| `JEB981` | 自定数字2 | `udf_no2` | float |  |
| `JEB982` | 自定数字3 | `udf_no3` | float |  |
| `JEB983` | 自定数字4 | `udf_no4` | float |  |
| `JEB984` | 自定数字5 | `udf_no5` | float |  |
| `JEB985` | 自定数字6 | `udf_no6` | float |  |
| `JEB966` | 自定文字7 | `udf_text7` | string |  |
| `JEB967` | 自定文字8 | `udf_text8` | string |  |
| `JEB968` | 自定文字9 | `udf_text9` | string |  |
| `JEB969` | 自定文字10 | `udf_text10` | string |  |
| `JEB970` | 自定文字11 | `udf_text11` | string |  |
| `JEB971` | 自定文字12 | `udf_text12` | string |  |
| `JEB972` | 自定文字13 | `udf_text13` | string |  |
| `JEB973` | 自定文字14 | `udf_text14` | string |  |
| `JEB974` | 自定文字15 | `udf_text15` | string |  |
| `JEB975` | 自定文字16 | `udf_text16` | string |  |
| `JEB986` | 自定数字7 | `udf_no7` | float |  |
| `JEB987` | 自定数字8 | `udf_no8` | float |  |
| `JEB988` | 自定数字9 | `udf_no9` | float |  |
| `JEB989` | 自定数字10 | `udf_no10` | float |  |
| `JEB990` | 自定数字11 | `udf_no11` | float |  |
| `JEB991` | 自定数字12 | `udf_no12` | float |  |
| `JEB992` | 自定数字13 | `udf_no13` | float |  |
| `JEB993` | 自定数字14 | `udf_no14` | float |  |
| `JEB994` | 自定数字15 | `udf_no15` | float |  |
| `JEB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "JEA001": ""
  ,"JEA002": ""
  ,"JEA003": ""
  ,"JEA004": ""
  ,"cdsDetail": [{
    "JEB001": ""
    ,"JEB001": ""
    ,"JEB002": ""
    ,"JEB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"JEA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"JEA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `JEA001` | `JEA001` | 单号 | 主键 |
| `JEA002` | `JEA002` | 性质 | |
| `JEA003` | `JEA003` | 日期 | |
| `JEA004` | `JEA004` | 供应商 | |
| `JEA005` | `JEA005` | 经办人 | |
| `JEA006` | `JEA006` | 部门 | |
| `JEA007` | `JEA007` | 专案 | |
| `JEA008` | `JEA008` | 复核编号 | |
| `JEA009` | `JEA009` | 复核姓名 | |
| `JEA010` | `JEA010` | 备注 | |
| `JEB001` | `JEB001` | 单号 (单身) | |
| `JEB002` | `JEB002` | 序号 (单身) | |
| `JEB003` | `JEB003` | 品号 (单身) | |
| `JEB004` | `JEB004` | 品名 (单身) | |
| `JEB005` | `JEB005` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `JEA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `JEA001`
