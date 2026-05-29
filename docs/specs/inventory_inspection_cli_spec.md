# CLI 规格说明书：库存检验单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `inventory.inspection` |
| **DLL** | `QMSCC07` |
| **服务名称** | `库存检验单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "inventory.inspection" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "inventory.inspection" \
  --action "getMultiple" \
  --data '{"datakeys":[{"MEA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "inventory.inspection" \
  --action "create" \
  --data '{"MEA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "inventory.inspection" \
  --action "approve" \
  --data '{"datakeys":[{"MEA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `MEA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (QMSMEA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MEA001` | 单号 | `MEA001` | string | 主键 |
| `MEA002` | 性质 | `MEA002` | string |  |
| `MEA003` | 日期 | `MEA003` | string |  |
| `MEA004` | 经办人 | `MEA004` | string |  |
| `MEA005` | 部门 | `MEA005` | string |  |
| `MEA006` | 项目 | `MEA006` | string |  |
| `MEA007` | 备注 | `MEA007` | string |  |
| `MEA008` | 审核码 | `MEA008` | string |  |
| `MEA009` | 审核人 | `MEA009` | string |  |
| `MEA010` | 审核时间 | `MEA010` | string |  |
| `MEA011` | 预留字段 | `MEA011` | string |  |
| `MEA012` | 预留字段 | `MEA012` | string |  |
| `MEA013` | 预留字段 | `MEA013` | string |  |
| `MEA014` | 预留字段 | `MEA014` | string |  |
| `MEA015` | 预留字段 | `MEA015` | float |  |
| `MEA016` | 预留字段 | `MEA016` | float |  |
| `MEA960` | 自定文字1 | `udf_text1` | string |  |
| `MEA961` | 自定文字2 | `udf_text2` | string |  |
| `MEA962` | 自定文字3 | `udf_text3` | string |  |
| `MEA963` | 自定文字4 | `udf_text4` | string |  |
| `MEA964` | 自定文字5 | `udf_text5` | string |  |
| `MEA965` | 自定文字6 | `udf_text6` | string |  |
| `MEA980` | 自定数字1 | `udf_no1` | float |  |
| `MEA981` | 自定数字2 | `udf_no2` | float |  |
| `MEA982` | 自定数字3 | `udf_no3` | float |  |
| `MEA983` | 自定数字4 | `udf_no4` | float |  |
| `MEA984` | 自定数字5 | `udf_no5` | float |  |
| `MEA985` | 自定数字6 | `udf_no6` | float |  |
| `MEA901` | 录入者编号 | `entry_person_no` | string |  |
| `MEA902` | 录入时间 | `entry_time` | string |  |
| `MEA903` | 更改者编号 | `changer_no` | string |  |
| `MEA904` | 更改时间 | `change_time` | string |  |
| `MEA905` | 更新标记 | `update_flag` | integer |  |
| `MEA910` | 送审状态 | `submission_status` | string |  |
| `MEA911` | 送审人 | `reviewer` | string |  |
| `MEA912` | 审批人1 | `approver1` | string |  |
| `MEA913` | 审批结果 | `approval_result1` | string |  |
| `MEA914` | 审批意见 | `approval_opinion1` | string |  |
| `MEA915` | 审批人2 | `approver2` | string |  |
| `MEA916` | 审批结果 | `approval_result2` | string |  |
| `MEA917` | 审批意见 | `approval_opinion2` | string |  |
| `MEA918` | 审批人3 | `approver3` | string |  |
| `MEA919` | 审批结果 | `approval_result3` | string |  |
| `MEA920` | 审批意见 | `approval_opinion3` | string |  |
| `MEA921` | 审批人4 | `approver4` | string |  |
| `MEA922` | 审批结果 | `approval_result4` | string |  |
| `MEA923` | 审批意见 | `approval_opinion4` | string |  |
| `MEA924` | 审批人5 | `approver5` | string |  |
| `MEA925` | 审批结果 | `approval_result5` | string |  |
| `MEA926` | 审批意见 | `approval_opinion5` | string |  |
| `MEA927` | 审批人6 | `approver6` | string |  |
| `MEA928` | 审批结果 | `approval_result6` | string |  |
| `MEA929` | 审批意见 | `approval_opinion6` | string |  |
| `MEA930` | 终审人 | `final_approver` | string |  |
| `MEA931` | 审批结果 | `approval_result7` | string |  |
| `MEA932` | 审批意见 | `approval_opinion7` | string |  |
| `MEA933` | 通知人1 | `notifier1` | string |  |
| `MEA934` | 通知人2 | `notifier2` | string |  |
| `MEA935` | 通知人3 | `notifier3` | string |  |
| `MEA966` | 自定文字7 | `udf_text7` | string |  |
| `MEA967` | 自定文字8 | `udf_text8` | string |  |
| `MEA968` | 自定文字9 | `udf_text9` | string |  |
| `MEA969` | 自定文字10 | `udf_text10` | string |  |
| `MEA970` | 自定文字11 | `udf_text11` | string |  |
| `MEA971` | 自定文字12 | `udf_text12` | string |  |
| `MEA972` | 自定文字13 | `udf_text13` | string |  |
| `MEA973` | 自定文字14 | `udf_text14` | string |  |
| `MEA974` | 自定文字15 | `udf_text15` | string |  |
| `MEA975` | 自定文字16 | `udf_text16` | string |  |
| `MEA986` | 自定数字7 | `udf_no7` | float |  |
| `MEA987` | 自定数字8 | `udf_no8` | float |  |
| `MEA988` | 自定数字9 | `udf_no9` | float |  |
| `MEA989` | 自定数字10 | `udf_no10` | float |  |
| `MEA990` | 自定数字11 | `udf_no11` | float |  |
| `MEA991` | 自定数字12 | `udf_no12` | float |  |
| `MEA992` | 自定数字13 | `udf_no13` | float |  |
| `MEA993` | 自定数字14 | `udf_no14` | float |  |
| `MEA994` | 自定数字15 | `udf_no15` | float |  |
| `MEA995` | 自定数字16 | `udf_no16` | float |  |
| `MEA906` | 打印次数 | `print_count` | integer |  |
| `MEA907` | 打印时间 | `print_time` | string |  |
| `MEA908` | 打印人员 | `printer` | string |  |
| `MEA909` | 打印人员姓名 | `printer_name` | string |  |
| `MEA950` | 送审时间 | `submission_time_for_review` | string |  |
| `MEA951` | 审批时间1 | `approval_time1` | string |  |
| `MEA952` | 审批时间2 | `approval_time2` | string |  |
| `MEA953` | 审批时间3 | `approval_time3` | string |  |
| `MEA954` | 审批时间4 | `approval_time4` | string |  |
| `MEA955` | 审批时间5 | `approval_time5` | string |  |
| `MEA956` | 审批时间6 | `approval_time6` | string |  |
| `MEA957` | 终审时间 | `final_review_time` | string |  |
| `MEA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (QMSMEB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MEB001` | 单号 | `MEB001` | string |  |
| `MEB002` | 序号 | `MEB002` | string |  |
| `MEB003` | 检验类型 | `MEB003` | string |  |
| `MEB004` | 检验说明 | `MEB004` | string |  |
| `MEB005` | 仓库 | `MEB005` | string |  |
| `MEB006` | 品号 | `MEB006` | string |  |
| `MEB007` | 品名 | `MEB007` | string |  |
| `MEB008` | 规格 | `MEB008` | string |  |
| `MEB009` | 批号 | `MEB009` | string |  |
| `MEB010` | 检验数量 | `MEB010` | float |  |
| `MEB011` | 合格数量 | `MEB011` | float |  |
| `MEB012` | 报废数量 | `MEB012` | float |  |
| `MEB013` | 已报废量 | `MEB013` | float |  |
| `MEB014` | 备注 | `MEB014` | string |  |
| `MEB015` | 审核码 | `MEB015` | string |  |
| `MEB016` | 库存单位 | `MEB016` | string |  |
| `MEB017` | 预留字段 | `MEB017` | string |  |
| `MEB018` | 预留字段 | `MEB018` | string |  |
| `MEB019` | 预留字段 | `MEB019` | string |  |
| `MEB020` | 预留字段 | `MEB020` | string |  |
| `MEB021` | 预留字段 | `MEB021` | float |  |
| `MEB022` | 预留字段 | `MEB022` | float |  |
| `MEB960` | 自定文字1 | `udf_text1` | string |  |
| `MEB961` | 自定文字2 | `udf_text2` | string |  |
| `MEB962` | 自定文字3 | `udf_text3` | string |  |
| `MEB963` | 自定文字4 | `udf_text4` | string |  |
| `MEB964` | 自定文字5 | `udf_text5` | string |  |
| `MEB965` | 自定文字6 | `udf_text6` | string |  |
| `MEB980` | 自定数字1 | `udf_no1` | float |  |
| `MEB981` | 自定数字2 | `udf_no2` | float |  |
| `MEB982` | 自定数字3 | `udf_no3` | float |  |
| `MEB983` | 自定数字4 | `udf_no4` | float |  |
| `MEB984` | 自定数字5 | `udf_no5` | float |  |
| `MEB985` | 自定数字6 | `udf_no6` | float |  |
| `MEB901` | 录入者编号 | `entry_person_no` | string |  |
| `MEB902` | 录入时间 | `entry_time` | string |  |
| `MEB903` | 更改者编号 | `changer_no` | string |  |
| `MEB904` | 更改时间 | `change_time` | string |  |
| `MEB905` | 更新标记 | `update_flag` | integer |  |
| `MEB966` | 自定文字7 | `udf_text7` | string |  |
| `MEB967` | 自定文字8 | `udf_text8` | string |  |
| `MEB968` | 自定文字9 | `udf_text9` | string |  |
| `MEB969` | 自定文字10 | `udf_text10` | string |  |
| `MEB970` | 自定文字11 | `udf_text11` | string |  |
| `MEB971` | 自定文字12 | `udf_text12` | string |  |
| `MEB972` | 自定文字13 | `udf_text13` | string |  |
| `MEB973` | 自定文字14 | `udf_text14` | string |  |
| `MEB974` | 自定文字15 | `udf_text15` | string |  |
| `MEB975` | 自定文字16 | `udf_text16` | string |  |
| `MEB986` | 自定数字7 | `udf_no7` | float |  |
| `MEB987` | 自定数字8 | `udf_no8` | float |  |
| `MEB988` | 自定数字9 | `udf_no9` | float |  |
| `MEB989` | 自定数字10 | `udf_no10` | float |  |
| `MEB990` | 自定数字11 | `udf_no11` | float |  |
| `MEB991` | 自定数字12 | `udf_no12` | float |  |
| `MEB992` | 自定数字13 | `udf_no13` | float |  |
| `MEB993` | 自定数字14 | `udf_no14` | float |  |
| `MEB994` | 自定数字15 | `udf_no15` | float |  |
| `MEB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "MEA001": ""
  ,"MEA002": ""
  ,"MEA003": ""
  ,"MEA004": ""
  ,"cdsDetail": [{
    "MEB001": ""
    ,"MEB001": ""
    ,"MEB002": ""
    ,"MEB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"MEA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"MEA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `MEA001` | `MEA001` | 单号 | 主键 |
| `MEA002` | `MEA002` | 性质 | |
| `MEA003` | `MEA003` | 日期 | |
| `MEA004` | `MEA004` | 经办人 | |
| `MEA005` | `MEA005` | 部门 | |
| `MEA006` | `MEA006` | 项目 | |
| `MEA007` | `MEA007` | 备注 | |
| `MEA008` | `MEA008` | 审核码 | |
| `MEA009` | `MEA009` | 审核人 | |
| `MEA010` | `MEA010` | 审核时间 | |
| `MEB001` | `MEB001` | 单号 (单身) | |
| `MEB002` | `MEB002` | 序号 (单身) | |
| `MEB003` | `MEB003` | 检验类型 (单身) | |
| `MEB004` | `MEB004` | 检验说明 (单身) | |
| `MEB005` | `MEB005` | 仓库 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `MEA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `MEA001`
