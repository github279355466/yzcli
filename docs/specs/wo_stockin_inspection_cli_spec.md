# CLI 规格说明书：生产入库检验单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `wo.stockin.inspection` |
| **DLL** | `QMSCC03` |
| **服务名称** | `生产入库检验单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "wo.stockin.inspection" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "wo.stockin.inspection" \
  --action "getMultiple" \
  --data '{"datakeys":[{"MAA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "wo.stockin.inspection" \
  --action "create" \
  --data '{"MAA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "wo.stockin.inspection" \
  --action "approve" \
  --data '{"datakeys":[{"MAA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `MAA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (QMSMAA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MAA001` | 单号 | `MAA001` | string | 主键 |
| `MAA002` | 性质 | `MAA002` | string |  |
| `MAA003` | 日期 | `MAA003` | string |  |
| `MAA004` | 检验人 | `MAA004` | string |  |
| `MAA005` | 部门 | `MAA005` | string |  |
| `MAA006` | 项目 | `MAA006` | string |  |
| `MAA007` | 审核码 | `MAA007` | string |  |
| `MAA008` | 审核人 | `MAA008` | string |  |
| `MAA009` | 审核时间 | `MAA009` | string |  |
| `MAA010` | 备注 | `MAA010` | string |  |
| `MAA011` | 预留字段 | `MAA011` | string |  |
| `MAA012` | 预留字段 | `MAA012` | string |  |
| `MAA013` | 预留字段 | `MAA013` | string |  |
| `MAA014` | 预留字段 | `MAA014` | string |  |
| `MAA015` | 预留字段 | `MAA015` | float |  |
| `MAA016` | 预留字段 | `MAA016` | float |  |
| `MAA017` | log_id | `log_id` | string |  |
| `MAA018` | req_id | `req_id` | string |  |
| `MAA019` | 设备云报工生成不良品标记 | `MAA019` | string |  |
| `MAA901` | 录入者编号 | `entry_person_no` | string |  |
| `MAA902` | 录入时间 | `entry_time` | string |  |
| `MAA903` | 更改者编号 | `changer_no` | string |  |
| `MAA904` | 更改时间 | `change_time` | string |  |
| `MAA905` | 更新标记 | `update_flag` | integer |  |
| `MAA906` | 打印次数 | `print_count` | integer |  |
| `MAA907` | 打印时间 | `print_time` | string |  |
| `MAA908` | 打印人员 | `printer` | string |  |
| `MAA909` | 打印人员姓名 | `printer_name` | string |  |
| `MAA910` | 送审状态 | `submission_status` | string |  |
| `MAA911` | 送审人 | `reviewer` | string |  |
| `MAA912` | 审批人1 | `approver1` | string |  |
| `MAA913` | 审批结果 | `approval_result1` | string |  |
| `MAA914` | 审批意见 | `approval_opinion1` | string |  |
| `MAA915` | 审批人2 | `approver2` | string |  |
| `MAA916` | 审批结果 | `approval_result2` | string |  |
| `MAA917` | 审批意见 | `approval_opinion2` | string |  |
| `MAA918` | 审批人3 | `approver3` | string |  |
| `MAA919` | 审批结果 | `approval_result3` | string |  |
| `MAA920` | 审批意见 | `approval_opinion3` | string |  |
| `MAA921` | 审批人4 | `approver4` | string |  |
| `MAA922` | 审批结果 | `approval_result4` | string |  |
| `MAA923` | 审批意见 | `approval_opinion4` | string |  |
| `MAA924` | 审批人5 | `approver5` | string |  |
| `MAA925` | 审批结果 | `approval_result5` | string |  |
| `MAA926` | 审批意见 | `approval_opinion5` | string |  |
| `MAA927` | 审批人6 | `approver6` | string |  |
| `MAA928` | 审批结果 | `approval_result6` | string |  |
| `MAA929` | 审批意见 | `approval_opinion6` | string |  |
| `MAA930` | 终审人 | `final_approver` | string |  |
| `MAA931` | 审批结果 | `approval_result7` | string |  |
| `MAA932` | 审批意见 | `approval_opinion7` | string |  |
| `MAA933` | 通知人1 | `notifier1` | string |  |
| `MAA934` | 通知人2 | `notifier2` | string |  |
| `MAA935` | 通知人3 | `notifier3` | string |  |
| `MAA960` | 自定文字1 | `udf_text1` | string |  |
| `MAA961` | 自定文字2 | `udf_text2` | string |  |
| `MAA962` | 自定文字3 | `udf_text3` | string |  |
| `MAA963` | 自定文字4 | `udf_text4` | string |  |
| `MAA964` | 自定文字5 | `udf_text5` | string |  |
| `MAA965` | 自定文字6 | `udf_text6` | string |  |
| `MAA966` | 自定文字7 | `udf_text7` | string |  |
| `MAA967` | 自定文字8 | `udf_text8` | string |  |
| `MAA968` | 自定文字9 | `udf_text9` | string |  |
| `MAA969` | 自定文字10 | `udf_text10` | string |  |
| `MAA970` | 自定文字11 | `udf_text11` | string |  |
| `MAA971` | 自定文字12 | `udf_text12` | string |  |
| `MAA972` | 自定文字13 | `udf_text13` | string |  |
| `MAA973` | 自定文字14 | `udf_text14` | string |  |
| `MAA974` | 自定文字15 | `udf_text15` | string |  |
| `MAA975` | 自定文字16 | `udf_text16` | string |  |
| `MAA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `MAA980` | 自定数字1 | `udf_no1` | float |  |
| `MAA981` | 自定数字2 | `udf_no2` | float |  |
| `MAA982` | 自定数字3 | `udf_no3` | float |  |
| `MAA983` | 自定数字4 | `udf_no4` | float |  |
| `MAA984` | 自定数字5 | `udf_no5` | float |  |
| `MAA985` | 自定数字6 | `udf_no6` | float |  |
| `MAA986` | 自定数字7 | `udf_no7` | float |  |
| `MAA987` | 自定数字8 | `udf_no8` | float |  |
| `MAA988` | 自定数字9 | `udf_no9` | float |  |
| `MAA989` | 自定数字10 | `udf_no10` | float |  |
| `MAA990` | 自定数字11 | `udf_no11` | float |  |
| `MAA991` | 自定数字12 | `udf_no12` | float |  |
| `MAA992` | 自定数字13 | `udf_no13` | float |  |
| `MAA993` | 自定数字14 | `udf_no14` | float |  |
| `MAA994` | 自定数字15 | `udf_no15` | float |  |
| `MAA995` | 自定数字16 | `udf_no16` | float |  |
| `MAA950` | 送审时间 | `submission_time_for_review` | string |  |
| `MAA951` | 审批时间1 | `approval_time1` | string |  |
| `MAA952` | 审批时间2 | `approval_time2` | string |  |
| `MAA953` | 审批时间3 | `approval_time3` | string |  |
| `MAA954` | 审批时间4 | `approval_time4` | string |  |
| `MAA955` | 审批时间5 | `approval_time5` | string |  |
| `MAA956` | 审批时间6 | `approval_time6` | string |  |
| `MAA957` | 终审时间 | `final_review_time` | string |  |
| `MAA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (QMSMAB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MAB001` | 单号 | `MAB001` | string |  |
| `MAB002` | 序号 | `MAB002` | string |  |
| `MAB003` | 检验类型 | `MAB003` | string |  |
| `MAB004` | 检验说明 | `MAB004` | string |  |
| `MAB005` | 来源 | `MAB005` | string |  |
| `MAB006` | 单号 | `MAB006` | string |  |
| `MAB007` | 品号 | `MAB007` | string |  |
| `MAB008` | 品名 | `MAB008` | string |  |
| `MAB009` | 规格 | `MAB009` | string |  |
| `MAB010` | 预留字段 | `MAB010` | string |  |
| `MAB011` | 单位 | `MAB011` | string |  |
| `MAB012` | 检验数量 | `MAB012` | float |  |
| `MAB013` | 合格数量 | `MAB013` | float |  |
| `MAB014` | 待重工数量 | `MAB014` | float |  |
| `MAB015` | 报废数量 | `MAB015` | float |  |
| `MAB016` | 已入库量 | `MAB016` | float |  |
| `MAB017` | 已报废量 | `MAB017` | float |  |
| `MAB018` | 备注 | `MAB018` | string |  |
| `MAB019` | 审核码 | `MAB019` | string |  |
| `MAB020` | 预留字段 | `MAB020` | string |  |
| `MAB021` | 预留字段 | `MAB021` | string |  |
| `MAB022` | 预留字段 | `MAB022` | string |  |
| `MAB023` | 预留字段 | `MAB023` | string |  |
| `MAB024` | 预留字段 | `MAB024` | float |  |
| `MAB025` | 预留字段 | `MAB025` | float |  |
| `MAB026` | 已入库待重工量 | `MAB026` | float |  |
| `MAB027` | 不良品量 | `MAB027` | float |  |
| `MAB028` | 报废耗用统计量 | `MAB028` | float |  |
| `MAB029` | 工艺入库单序号 | `MAB029` | string |  |
| `MAB030` | 工艺入库单单号 | `MAB030` | string |  |
| `MAB031` | 工艺报废量 | `MAB031` | float |  |
| `MAB901` | 录入者编号 | `entry_person_no` | string |  |
| `MAB902` | 录入时间 | `entry_time` | string |  |
| `MAB903` | 更改者编号 | `changer_no` | string |  |
| `MAB904` | 更改时间 | `change_time` | string |  |
| `MAB905` | 更新标记 | `update_flag` | integer |  |
| `MAB960` | 自定文字1 | `udf_text1` | string |  |
| `MAB961` | 自定文字2 | `udf_text2` | string |  |
| `MAB962` | 自定文字3 | `udf_text3` | string |  |
| `MAB963` | 自定文字4 | `udf_text4` | string |  |
| `MAB964` | 自定文字5 | `udf_text5` | string |  |
| `MAB965` | 自定文字6 | `udf_text6` | string |  |
| `MAB966` | 自定文字7 | `udf_text7` | string |  |
| `MAB967` | 自定文字8 | `udf_text8` | string |  |
| `MAB968` | 自定文字9 | `udf_text9` | string |  |
| `MAB969` | 自定文字10 | `udf_text10` | string |  |
| `MAB970` | 自定文字11 | `udf_text11` | string |  |
| `MAB971` | 自定文字12 | `udf_text12` | string |  |
| `MAB972` | 自定文字13 | `udf_text13` | string |  |
| `MAB973` | 自定文字14 | `udf_text14` | string |  |
| `MAB974` | 自定文字15 | `udf_text15` | string |  |
| `MAB975` | 自定文字16 | `udf_text16` | string |  |
| `MAB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `MAB980` | 自定数字1 | `udf_no1` | float |  |
| `MAB981` | 自定数字2 | `udf_no2` | float |  |
| `MAB982` | 自定数字3 | `udf_no3` | float |  |
| `MAB983` | 自定数字4 | `udf_no4` | float |  |
| `MAB984` | 自定数字5 | `udf_no5` | float |  |
| `MAB985` | 自定数字6 | `udf_no6` | float |  |
| `MAB986` | 自定数字7 | `udf_no7` | float |  |
| `MAB987` | 自定数字8 | `udf_no8` | float |  |
| `MAB988` | 自定数字9 | `udf_no9` | float |  |
| `MAB989` | 自定数字10 | `udf_no10` | float |  |
| `MAB990` | 自定数字11 | `udf_no11` | float |  |
| `MAB991` | 自定数字12 | `udf_no12` | float |  |
| `MAB992` | 自定数字13 | `udf_no13` | float |  |
| `MAB993` | 自定数字14 | `udf_no14` | float |  |
| `MAB994` | 自定数字15 | `udf_no15` | float |  |
| `MAB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "MAA001": ""
  ,"MAA002": ""
  ,"MAA003": ""
  ,"MAA004": ""
  ,"cdsDetail": [{
    "MAB001": ""
    ,"MAB001": ""
    ,"MAB002": ""
    ,"MAB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"MAA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"MAA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `MAA001` | `MAA001` | 单号 | 主键 |
| `MAA002` | `MAA002` | 性质 | |
| `MAA003` | `MAA003` | 日期 | |
| `MAA004` | `MAA004` | 检验人 | |
| `MAA005` | `MAA005` | 部门 | |
| `MAA006` | `MAA006` | 项目 | |
| `MAA007` | `MAA007` | 审核码 | |
| `MAA008` | `MAA008` | 审核人 | |
| `MAA009` | `MAA009` | 审核时间 | |
| `MAA010` | `MAA010` | 备注 | |
| `MAB001` | `MAB001` | 单号 (单身) | |
| `MAB002` | `MAB002` | 序号 (单身) | |
| `MAB003` | `MAB003` | 检验类型 (单身) | |
| `MAB004` | `MAB004` | 检验说明 (单身) | |
| `MAB005` | `MAB005` | 来源 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `MAA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `MAA001`
