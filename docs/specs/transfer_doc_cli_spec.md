# CLI 规格说明书：移转单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `transfer.doc` |
| **DLL** | `GYSYC03` |
| **服务名称** | `移转单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "transfer.doc" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "transfer.doc" \
  --action "getMultiple" \
  --data '{"datakeys":[{"RDA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "transfer.doc" \
  --action "create" \
  --data '{"RDA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "transfer.doc" \
  --action "approve" \
  --data '{"datakeys":[{"RDA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `RDA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (SGMRDA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RDA001` | 移转类型 | `RDA001` | string |  |
| `RDA002` | 移转单号 | `RDA002` | string |  |
| `RDA003` | 单据日期 | `RDA003` | string |  |
| `RDA004` | 性质 | `RDA004` | string |  |
| `RDA005` | 移出类别 | `RDA005` | string |  |
| `RDA006` | 移出地 | `RDA006` | string |  |
| `RDA007` | 移出地名称 | `RDA007` | string |  |
| `RDA008` | 移入类别 | `RDA008` | string |  |
| `RDA009` | 移入地 | `RDA009` | string |  |
| `RDA010` | 移入地名称 | `RDA010` | string |  |
| `RDA011` | 经办人 | `RDA011` | string |  |
| `RDA012` | 备注 | `RDA012` | string |  |
| `RDA013` | 审核码 | `RDA013` | string |  |
| `RDA014` | 审核人 | `RDA014` | string |  |
| `RDA015` | 部门 | `RDA015` | string |  |
| `RDA016` | 预留字段 | `RDA016` | string |  |
| `RDA017` | 预留字段 | `RDA017` | string |  |
| `RDA018` | 预留字段 | `RDA018` | string |  |
| `RDA019` | 预留字段 | `RDA019` | string |  |
| `RDA020` | 预留字段 | `RDA020` | float |  |
| `RDA021` | 预留字段 | `RDA021` | float |  |
| `RDA022` | 直接产生发票信息 | `RDA022` | string |  |
| `RDA023` | 发票种类 | `RDA023` | string |  |
| `RDA024` | 发票号码 | `RDA024` | string |  |
| `RDA901` | 录入者编号 | `entry_person_no` | string |  |
| `RDA902` | 录入时间 | `entry_time` | string |  |
| `RDA903` | 更改者编号 | `changer_no` | string |  |
| `RDA904` | 更改时间 | `change_time` | string |  |
| `RDA905` | 更新标记 | `update_flag` | integer |  |
| `RDA906` | 打印次数 | `print_count` | integer |  |
| `RDA907` | 打印时间 | `print_time` | string |  |
| `RDA908` | 打印人员 | `printer` | string |  |
| `RDA909` | 打印人员姓名 | `printer_name` | string |  |
| `RDA910` | 送审状态 | `submission_status` | string |  |
| `RDA911` | 送审人 | `reviewer` | string |  |
| `RDA912` | 审批人1 | `approver1` | string |  |
| `RDA913` | 审批结果 | `approval_result1` | string |  |
| `RDA914` | 审批意见 | `approval_opinion1` | string |  |
| `RDA915` | 审批人2 | `approver2` | string |  |
| `RDA916` | 审批结果 | `approval_result2` | string |  |
| `RDA917` | 审批意见 | `approval_opinion2` | string |  |
| `RDA918` | 审批人3 | `approver3` | string |  |
| `RDA919` | 审批结果 | `approval_result3` | string |  |
| `RDA920` | 审批意见 | `approval_opinion3` | string |  |
| `RDA921` | 审批人4 | `approver4` | string |  |
| `RDA922` | 审批结果 | `approval_result4` | string |  |
| `RDA923` | 审批意见 | `approval_opinion4` | string |  |
| `RDA924` | 审批人5 | `approver5` | string |  |
| `RDA925` | 审批结果 | `approval_result5` | string |  |
| `RDA926` | 审批意见 | `approval_opinion5` | string |  |
| `RDA927` | 审批人6 | `approver6` | string |  |
| `RDA928` | 审批结果 | `approval_result6` | string |  |
| `RDA929` | 审批意见 | `approval_opinion6` | string |  |
| `RDA930` | 终审人 | `final_approver` | string |  |
| `RDA931` | 审批结果 | `approval_result7` | string |  |
| `RDA932` | 审批意见 | `approval_opinion7` | string |  |
| `RDA933` | 通知人1 | `notifier1` | string |  |
| `RDA934` | 通知人2 | `notifier2` | string |  |
| `RDA935` | 通知人3 | `notifier3` | string |  |
| `RDA960` | 自定文字1 | `udf_text1` | string |  |
| `RDA961` | 自定文字2 | `udf_text2` | string |  |
| `RDA962` | 自定文字3 | `udf_text3` | string |  |
| `RDA963` | 自定文字4 | `udf_text4` | string |  |
| `RDA964` | 自定文字5 | `udf_text5` | string |  |
| `RDA965` | 自定文字6 | `udf_text6` | string |  |
| `RDA966` | 自定文字7 | `udf_text7` | string |  |
| `RDA967` | 自定文字8 | `udf_text8` | string |  |
| `RDA968` | 自定文字9 | `udf_text9` | string |  |
| `RDA969` | 自定文字10 | `udf_text10` | string |  |
| `RDA970` | 自定文字11 | `udf_text11` | string |  |
| `RDA971` | 自定文字12 | `udf_text12` | string |  |
| `RDA972` | 自定文字13 | `udf_text13` | string |  |
| `RDA973` | 自定文字14 | `udf_text14` | string |  |
| `RDA974` | 自定文字15 | `udf_text15` | string |  |
| `RDA975` | 自定文字16 | `udf_text16` | string |  |
| `RDA979` | 二维码 | `qr_code_on_doc_header` | string |  |
| `RDA980` | 自定数字1 | `udf_no1` | float |  |
| `RDA981` | 自定数字2 | `udf_no2` | float |  |
| `RDA982` | 自定数字3 | `udf_no3` | float |  |
| `RDA983` | 自定数字4 | `udf_no4` | float |  |
| `RDA984` | 自定数字5 | `udf_no5` | float |  |
| `RDA985` | 自定数字6 | `udf_no6` | float |  |
| `RDA986` | 自定数字7 | `udf_no7` | float |  |
| `RDA987` | 自定数字8 | `udf_no8` | float |  |
| `RDA988` | 自定数字9 | `udf_no9` | float |  |
| `RDA989` | 自定数字10 | `udf_no10` | float |  |
| `RDA990` | 自定数字11 | `udf_no11` | float |  |
| `RDA991` | 自定数字12 | `udf_no12` | float |  |
| `RDA992` | 自定数字13 | `udf_no13` | float |  |
| `RDA993` | 自定数字14 | `udf_no14` | float |  |
| `RDA994` | 自定数字15 | `udf_no15` | float |  |
| `RDA995` | 自定数字16 | `udf_no16` | float |  |
| `RDA950` | 送审时间 | `submission_time_for_review` | string |  |
| `RDA951` | 审批时间1 | `approval_time1` | string |  |
| `RDA952` | 审批时间2 | `approval_time2` | string |  |
| `RDA953` | 审批时间3 | `approval_time3` | string |  |
| `RDA954` | 审批时间4 | `approval_time4` | string |  |
| `RDA955` | 审批时间5 | `approval_time5` | string |  |
| `RDA956` | 审批时间6 | `approval_time6` | string |  |
| `RDA957` | 终审时间 | `final_review_time` | string |  |
| `RDA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (SGMRDB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RDB001` | 移转类型 | `RDB001` | string |  |
| `RDB002` | 移转单号 | `RDB002` | string |  |
| `RDB003` | 序号 | `RDB003` | string |  |
| `RDB004` | 工单单号 | `RDB004` | string |  |
| `RDB005` | 产品品号 | `RDB005` | string |  |
| `RDB006` | 移出工序 | `RDB006` | string |  |
| `RDB007` | 移出工艺 | `RDB007` | string |  |
| `RDB008` | 移入工序 | `RDB008` | string |  |
| `RDB009` | 移入工艺 | `RDB009` | string |  |
| `RDB010` | 移转类型 | `RDB010` | string |  |
| `RDB011` | 移转数量 | `RDB011` | float |  |
| `RDB012` | 备注 | `RDB012` | string |  |
| `RDB013` | 审核码 | `RDB013` | string |  |
| `RDB014` | 来源 | `RDB014` | string |  |
| `RDB015` | 来源单号 | `RDB015` | string |  |
| `RDB016` | 预留字段 | `RDB016` | string |  |
| `RDB017` | 预留字段 | `RDB017` | string |  |
| `RDB018` | 预留字段 | `RDB018` | string |  |
| `RDB019` | 预留字段 | `RDB019` | string |  |
| `RDB020` | 预留字段 | `RDB020` | float |  |
| `RDB021` | 预留字段 | `RDB021` | float |  |
| `RDB022` | 报废数量 | `RDB022` | float |  |
| `RDB023` | 生产入库单号 | `RDB023` | string |  |
| `RDB024` | 来源类别 | `RDB024` | string |  |
| `RDB025` | 移转报废量 | `RDB025` | float |  |
| `RDB026` | 已入库报废量 | `RDB026` | float |  |
| `RDB027` | 入库检验单号 | `RDB027` | string |  |
| `RDB028` | 规格 | `RDB028` | string |  |
| `RDB029` | 设备号 | `RDB029` | string |  |
| `RDB030` | 已开票数量 | `RDB030` | float |  |
| `RDB901` | 录入者编号 | `entry_person_no` | string |  |
| `RDB902` | 录入时间 | `entry_time` | string |  |
| `RDB903` | 更改者编号 | `changer_no` | string |  |
| `RDB904` | 更改时间 | `change_time` | string |  |
| `RDB905` | 更新标记 | `update_flag` | integer |  |
| `RDB960` | 自定文字1 | `udf_text1` | string |  |
| `RDB961` | 自定文字2 | `udf_text2` | string |  |
| `RDB962` | 自定文字3 | `udf_text3` | string |  |
| `RDB963` | 自定文字4 | `udf_text4` | string |  |
| `RDB964` | 自定文字5 | `udf_text5` | string |  |
| `RDB965` | 自定文字6 | `udf_text6` | string |  |
| `RDB966` | 自定文字7 | `udf_text7` | string |  |
| `RDB967` | 自定文字8 | `udf_text8` | string |  |
| `RDB968` | 自定文字9 | `udf_text9` | string |  |
| `RDB969` | 自定文字10 | `udf_text10` | string |  |
| `RDB970` | 自定文字11 | `udf_text11` | string |  |
| `RDB971` | 自定文字12 | `udf_text12` | string |  |
| `RDB972` | 自定文字13 | `udf_text13` | string |  |
| `RDB973` | 自定文字14 | `udf_text14` | string |  |
| `RDB974` | 自定文字15 | `udf_text15` | string |  |
| `RDB975` | 自定文字16 | `udf_text16` | string |  |
| `RDB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `RDB980` | 自定数字1 | `udf_no1` | float |  |
| `RDB981` | 自定数字2 | `udf_no2` | float |  |
| `RDB982` | 自定数字3 | `udf_no3` | float |  |
| `RDB983` | 自定数字4 | `udf_no4` | float |  |
| `RDB984` | 自定数字5 | `udf_no5` | float |  |
| `RDB985` | 自定数字6 | `udf_no6` | float |  |
| `RDB986` | 自定数字7 | `udf_no7` | float |  |
| `RDB987` | 自定数字8 | `udf_no8` | float |  |
| `RDB988` | 自定数字9 | `udf_no9` | float |  |
| `RDB989` | 自定数字10 | `udf_no10` | float |  |
| `RDB990` | 自定数字11 | `udf_no11` | float |  |
| `RDB991` | 自定数字12 | `udf_no12` | float |  |
| `RDB992` | 自定数字13 | `udf_no13` | float |  |
| `RDB993` | 自定数字14 | `udf_no14` | float |  |
| `RDB994` | 自定数字15 | `udf_no15` | float |  |
| `RDB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "RDA001": ""
  ,"RDA001": ""
  ,"RDA002": ""
  ,"RDA003": ""
  ,"cdsDetail": [{
    "RDB001": ""
    ,"RDB001": ""
    ,"RDB002": ""
    ,"RDB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"RDA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"RDA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `RDA001` | `RDA001` | 移转类型 | |
| `RDA002` | `RDA002` | 移转单号 | |
| `RDA003` | `RDA003` | 单据日期 | |
| `RDA004` | `RDA004` | 性质 | |
| `RDA005` | `RDA005` | 移出类别 | |
| `RDA006` | `RDA006` | 移出地 | |
| `RDA007` | `RDA007` | 移出地名称 | |
| `RDA008` | `RDA008` | 移入类别 | |
| `RDA009` | `RDA009` | 移入地 | |
| `RDA010` | `RDA010` | 移入地名称 | |
| `RDB001` | `RDB001` | 移转类型 (单身) | |
| `RDB002` | `RDB002` | 移转单号 (单身) | |
| `RDB003` | `RDB003` | 序号 (单身) | |
| `RDB004` | `RDB004` | 工单单号 (单身) | |
| `RDB005` | `RDB005` | 产品品号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `RDA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `RDA001`
