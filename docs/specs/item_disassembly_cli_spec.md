# CLI 规格说明书：商品拆解单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `item.disassembly` |
| **DLL** | `INVKC08` |
| **服务名称** | `商品拆解单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.disassembly" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.disassembly" \
  --action "getMultiple" \
  --data '{"datakeys":[{"LGA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.disassembly" \
  --action "create" \
  --data '{"LGA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.disassembly" \
  --action "approve" \
  --data '{"datakeys":[{"LGA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `LGA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKLGA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LGA001` | 单号 | `LGA001` | string | 主键 |
| `LGA002` | 性质 | `LGA002` | string |  |
| `LGA003` | 日期 | `LGA003` | string |  |
| `LGA004` | 组合品号 | `LGA004` | string |  |
| `LGA005` | 仓库 | `LGA005` | string |  |
| `LGA006` | 拆解数量 | `LGA006` | float |  |
| `LGA007` | 单位成本 | `LGA007` | float |  |
| `LGA008` | 成本 | `LGA008` | float |  |
| `LGA009` | (预留) | `LGA009` | string |  |
| `LGA010` | (预留) | `LGA010` | string |  |
| `LGA011` | (预留) | `LGA011` | string |  |
| `LGA012` | 复核编号 | `LGA012` | string |  |
| `LGA013` | 复核姓名 | `LGA013` | string |  |
| `LGA014` | 审核码 | `LGA014` | string |  |
| `LGA015` | 备注 | `LGA015` | string |  |
| `LGA016` | 经办人 | `LGA016` | string |  |
| `LGA017` | (预留)部门 | `LGA017` | string |  |
| `LGA018` | 预留 | `LGA018` | string |  |
| `LGA019` | 预留 | `LGA019` | string |  |
| `LGA020` | (预留)日期 | `LGA020` | string |  |
| `LGA021` | 预留字段 | `LGA021` | string |  |
| `LGA022` | 预留字段 | `LGA022` | string |  |
| `LGA023` | 预留字段 | `LGA023` | string |  |
| `LGA024` | 预留字段 | `LGA024` | string |  |
| `LGA025` | 预留字段 | `LGA025` | string |  |
| `LGA026` | 预留字段 | `LGA026` | float |  |
| `LGA027` | 预留字段 | `LGA027` | float |  |
| `LGA028` | 预留(品名) | `LGA028` | string |  |
| `LGA029` | 审核人 | `LGA029` | string |  |
| `LGA030` | 批号 | `LGA030` | string |  |
| `LGA031` | 审核时间 | `LGA031` | string |  |
| `LGA032` | 规格 | `LGA032` | string |  |
| `LGA901` | 录入者编号 | `entry_person_no` | string |  |
| `LGA902` | 录入时间 | `entry_time` | string |  |
| `LGA903` | 更改者编号 | `changer_no` | string |  |
| `LGA904` | 更改时间 | `change_time` | string |  |
| `LGA905` | 更新标记 | `update_flag` | integer |  |
| `LGA960` | 自定文字1 | `udf_text1` | string |  |
| `LGA961` | 自定文字2 | `udf_text2` | string |  |
| `LGA962` | 自定文字3 | `udf_text3` | string |  |
| `LGA963` | 自定文字4 | `udf_text4` | string |  |
| `LGA964` | 自定文字5 | `udf_text5` | string |  |
| `LGA965` | 自定文字6 | `udf_text6` | string |  |
| `LGA980` | 自定数字1 | `udf_no1` | float |  |
| `LGA981` | 自定数字2 | `udf_no2` | float |  |
| `LGA982` | 自定数字3 | `udf_no3` | float |  |
| `LGA983` | 自定数字4 | `udf_no4` | float |  |
| `LGA984` | 自定数字5 | `udf_no5` | float |  |
| `LGA985` | 自定数字6 | `udf_no6` | float |  |
| `LGA910` | 送审状态 | `submission_status` | string |  |
| `LGA911` | 送审人 | `reviewer` | string |  |
| `LGA912` | 审批人1 | `approver1` | string |  |
| `LGA913` | 审批结果 | `approval_result1` | string |  |
| `LGA914` | 审批意见 | `approval_opinion1` | string |  |
| `LGA915` | 审批人2 | `approver2` | string |  |
| `LGA916` | 审批结果 | `approval_result2` | string |  |
| `LGA917` | 审批意见 | `approval_opinion2` | string |  |
| `LGA918` | 审批人3 | `approver3` | string |  |
| `LGA919` | 审批结果 | `approval_result3` | string |  |
| `LGA920` | 审批意见 | `approval_opinion3` | string |  |
| `LGA921` | 审批人4 | `approver4` | string |  |
| `LGA922` | 审批结果 | `approval_result4` | string |  |
| `LGA923` | 审批意见 | `approval_opinion4` | string |  |
| `LGA924` | 审批人5 | `approver5` | string |  |
| `LGA925` | 审批结果 | `approval_result5` | string |  |
| `LGA926` | 审批意见 | `approval_opinion5` | string |  |
| `LGA927` | 审批人6 | `approver6` | string |  |
| `LGA928` | 审批结果 | `approval_result6` | string |  |
| `LGA929` | 审批意见 | `approval_opinion6` | string |  |
| `LGA930` | 终审人 | `final_approver` | string |  |
| `LGA931` | 审批结果 | `approval_result7` | string |  |
| `LGA932` | 审批意见 | `approval_opinion7` | string |  |
| `LGA933` | 通知人1 | `notifier1` | string |  |
| `LGA934` | 通知人2 | `notifier2` | string |  |
| `LGA935` | 通知人3 | `notifier3` | string |  |
| `LGA966` | 自定文字7 | `udf_text7` | string |  |
| `LGA967` | 自定文字8 | `udf_text8` | string |  |
| `LGA968` | 自定文字9 | `udf_text9` | string |  |
| `LGA969` | 自定文字10 | `udf_text10` | string |  |
| `LGA970` | 自定文字11 | `udf_text11` | string |  |
| `LGA971` | 自定文字12 | `udf_text12` | string |  |
| `LGA972` | 自定文字13 | `udf_text13` | string |  |
| `LGA973` | 自定文字14 | `udf_text14` | string |  |
| `LGA974` | 自定文字15 | `udf_text15` | string |  |
| `LGA975` | 自定文字16 | `udf_text16` | string |  |
| `LGA986` | 自定数字7 | `udf_no7` | float |  |
| `LGA987` | 自定数字8 | `udf_no8` | float |  |
| `LGA988` | 自定数字9 | `udf_no9` | float |  |
| `LGA989` | 自定数字10 | `udf_no10` | float |  |
| `LGA990` | 自定数字11 | `udf_no11` | float |  |
| `LGA991` | 自定数字12 | `udf_no12` | float |  |
| `LGA992` | 自定数字13 | `udf_no13` | float |  |
| `LGA993` | 自定数字14 | `udf_no14` | float |  |
| `LGA994` | 自定数字15 | `udf_no15` | float |  |
| `LGA995` | 自定数字16 | `udf_no16` | float |  |
| `LGA906` | 打印次数 | `print_count` | integer |  |
| `LGA907` | 打印时间 | `print_time` | string |  |
| `LGA908` | 打印人员 | `printer` | string |  |
| `LGA909` | 打印人员姓名 | `printer_name` | string |  |
| `LGA950` | 送审时间 | `submission_time_for_review` | string |  |
| `LGA951` | 审批时间1 | `approval_time1` | string |  |
| `LGA952` | 审批时间2 | `approval_time2` | string |  |
| `LGA953` | 审批时间3 | `approval_time3` | string |  |
| `LGA954` | 审批时间4 | `approval_time4` | string |  |
| `LGA955` | 审批时间5 | `approval_time5` | string |  |
| `LGA956` | 审批时间6 | `approval_time6` | string |  |
| `LGA957` | 终审时间 | `final_review_time` | string |  |
| `LGA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKLGB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LGB001` | 单号 | `LGB001` | string |  |
| `LGB002` | 序号 | `LGB002` | string |  |
| `LGB003` | 子件品号 | `LGB003` | string |  |
| `LGB004` | 仓库 | `LGB004` | string |  |
| `LGB005` | 拆解量 | `LGB005` | float |  |
| `LGB006` | 单位成本 | `LGB006` | float |  |
| `LGB007` | 成本 | `LGB007` | string |  |
| `LGB008` | 审核码 | `LGB008` | string |  |
| `LGB009` | 预留 | `LGB009` | string |  |
| `LGB010` | 预留 | `LGB010` | string |  |
| `LGB011` | (预留)日期 | `LGB011` | string |  |
| `LGB012` | 预留字段 | `LGB012` | string |  |
| `LGB013` | 预留字段 | `LGB013` | string |  |
| `LGB014` | 预留字段 | `LGB014` | string |  |
| `LGB015` | 预留字段 | `LGB015` | string |  |
| `LGB016` | 预留字段 | `LGB016` | string |  |
| `LGB017` | 预留字段 | `LGB017` | string |  |
| `LGB018` | 预留字段 | `LGB018` | string |  |
| `LGB019` | 预留字段 | `LGB019` | float |  |
| `LGB020` | 预留字段 | `LGB020` | float |  |
| `LGB021` | 预留(品名) | `LGB021` | string |  |
| `LGB022` | 批号 | `LGB022` | string |  |
| `LGB023` | 规格 | `LGB023` | string |  |
| `LGB024` | 批号说明 | `LGB024` | string |  |
| `LGB025` | 生产日期 | `LGB025` | string |  |
| `LGB026` | 有效日期 | `LGB026` | string |  |
| `LGB901` | 录入者编号 | `entry_person_no` | string |  |
| `LGB902` | 录入时间 | `entry_time` | string |  |
| `LGB903` | 更改者编号 | `changer_no` | string |  |
| `LGB904` | 更改时间 | `change_time` | string |  |
| `LGB905` | 更新标记 | `update_flag` | integer |  |
| `LGB960` | 自定文字1 | `udf_text1` | string |  |
| `LGB961` | 自定文字2 | `udf_text2` | string |  |
| `LGB962` | 自定文字3 | `udf_text3` | string |  |
| `LGB963` | 自定文字4 | `udf_text4` | string |  |
| `LGB964` | 自定文字5 | `udf_text5` | string |  |
| `LGB965` | 自定文字6 | `udf_text6` | string |  |
| `LGB980` | 自定数字1 | `udf_no1` | float |  |
| `LGB981` | 自定数字2 | `udf_no2` | float |  |
| `LGB982` | 自定数字3 | `udf_no3` | float |  |
| `LGB983` | 自定数字4 | `udf_no4` | float |  |
| `LGB984` | 自定数字5 | `udf_no5` | float |  |
| `LGB985` | 自定数字6 | `udf_no6` | float |  |
| `LGB966` | 自定文字7 | `udf_text7` | string |  |
| `LGB967` | 自定文字8 | `udf_text8` | string |  |
| `LGB968` | 自定文字9 | `udf_text9` | string |  |
| `LGB969` | 自定文字10 | `udf_text10` | string |  |
| `LGB970` | 自定文字11 | `udf_text11` | string |  |
| `LGB971` | 自定文字12 | `udf_text12` | string |  |
| `LGB972` | 自定文字13 | `udf_text13` | string |  |
| `LGB973` | 自定文字14 | `udf_text14` | string |  |
| `LGB974` | 自定文字15 | `udf_text15` | string |  |
| `LGB975` | 自定文字16 | `udf_text16` | string |  |
| `LGB986` | 自定数字7 | `udf_no7` | float |  |
| `LGB987` | 自定数字8 | `udf_no8` | float |  |
| `LGB988` | 自定数字9 | `udf_no9` | float |  |
| `LGB989` | 自定数字10 | `udf_no10` | float |  |
| `LGB990` | 自定数字11 | `udf_no11` | float |  |
| `LGB991` | 自定数字12 | `udf_no12` | float |  |
| `LGB992` | 自定数字13 | `udf_no13` | float |  |
| `LGB993` | 自定数字14 | `udf_no14` | float |  |
| `LGB994` | 自定数字15 | `udf_no15` | float |  |
| `LGB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "LGA001": ""
  ,"LGA002": ""
  ,"LGA003": ""
  ,"LGA004": ""
  ,"cdsDetail": [{
    "LGB001": ""
    ,"LGB001": ""
    ,"LGB002": ""
    ,"LGB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"LGA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"LGA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `LGA001` | `LGA001` | 单号 | 主键 |
| `LGA002` | `LGA002` | 性质 | |
| `LGA003` | `LGA003` | 日期 | |
| `LGA004` | `LGA004` | 组合品号 | |
| `LGA005` | `LGA005` | 仓库 | |
| `LGA006` | `LGA006` | 拆解数量 | |
| `LGA007` | `LGA007` | 单位成本 | |
| `LGA008` | `LGA008` | 成本 | |
| `LGA009` | `LGA009` | (预留) | |
| `LGA010` | `LGA010` | (预留) | |
| `LGB001` | `LGB001` | 单号 (单身) | |
| `LGB002` | `LGB002` | 序号 (单身) | |
| `LGB003` | `LGB003` | 子件品号 (单身) | |
| `LGB004` | `LGB004` | 仓库 (单身) | |
| `LGB005` | `LGB005` | 拆解量 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `LGA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `LGA001`
