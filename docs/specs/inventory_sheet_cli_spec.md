# CLI 规格说明书：盘点单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `inventory.sheet` |
| **DLL** | `INVKC04` |
| **服务名称** | `盘点单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "inventory.sheet" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "inventory.sheet" \
  --action "getMultiple" \
  --data '{"datakeys":[{"LDA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "inventory.sheet" \
  --action "create" \
  --data '{"LDA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "inventory.sheet" \
  --action "approve" \
  --data '{"datakeys":[{"LDA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `LDA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKLDA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LDA001` | 单号 | `LDA001` | string | 主键 |
| `LDA002` | 性质 | `LDA002` | string |  |
| `LDA003` | 日期 | `LDA003` | string |  |
| `LDA004` | 盘点人 | `LDA004` | string |  |
| `LDA005` | 专案 | `LDA005` | string |  |
| `LDA006` | 调整否 | `LDA006` | string |  |
| `LDA007` | 调整单号 | `LDA007` | string |  |
| `LDA008` | 复核编号 | `LDA008` | string |  |
| `LDA009` | 复核姓名 | `LDA009` | string |  |
| `LDA010` | 备注 | `LDA010` | string |  |
| `LDA011` | 审核码 | `LDA011` | string |  |
| `LDA012` | (预留)日期 | `LDA012` | string |  |
| `LDA013` | (预留)部门 | `LDA013` | string |  |
| `LDA014` | 预留字段 | `LDA014` | string |  |
| `LDA015` | 预留字段 | `LDA015` | string |  |
| `LDA016` | 预留字段 | `LDA016` | string |  |
| `LDA017` | 预留字段 | `LDA017` | string |  |
| `LDA018` | 预留字段 | `LDA018` | float |  |
| `LDA019` | 预留字段 | `LDA019` | float |  |
| `LDA020` | 审核人 | `LDA020` | string |  |
| `LDA901` | 录入者编号 | `entry_person_no` | string |  |
| `LDA902` | 录入时间 | `entry_time` | string |  |
| `LDA903` | 更改者编号 | `changer_no` | string |  |
| `LDA904` | 更改时间 | `change_time` | string |  |
| `LDA905` | 更新标记 | `update_flag` | integer |  |
| `LDA906` | 打印次数 | `print_count` | integer |  |
| `LDA907` | 打印时间 | `print_time` | string |  |
| `LDA908` | 打印人员 | `printer` | string |  |
| `LDA909` | 打印人员姓名 | `printer_name` | string |  |
| `LDA910` | 送审状态 | `submission_status` | string |  |
| `LDA911` | 送审人 | `reviewer` | string |  |
| `LDA912` | 审批人1 | `approver1` | string |  |
| `LDA913` | 审批结果 | `approval_result1` | string |  |
| `LDA914` | 审批意见 | `approval_opinion1` | string |  |
| `LDA915` | 审批人2 | `approver2` | string |  |
| `LDA916` | 审批结果 | `approval_result2` | string |  |
| `LDA917` | 审批意见 | `approval_opinion2` | string |  |
| `LDA918` | 审批人3 | `approver3` | string |  |
| `LDA919` | 审批结果 | `approval_result3` | string |  |
| `LDA920` | 审批意见 | `approval_opinion3` | string |  |
| `LDA921` | 审批人4 | `approver4` | string |  |
| `LDA922` | 审批结果 | `approval_result4` | string |  |
| `LDA923` | 审批意见 | `approval_opinion4` | string |  |
| `LDA924` | 审批人5 | `approver5` | string |  |
| `LDA925` | 审批结果 | `approval_result5` | string |  |
| `LDA926` | 审批意见 | `approval_opinion5` | string |  |
| `LDA927` | 审批人6 | `approver6` | string |  |
| `LDA928` | 审批结果 | `approval_result6` | string |  |
| `LDA929` | 审批意见 | `approval_opinion6` | string |  |
| `LDA930` | 终审人 | `final_approver` | string |  |
| `LDA931` | 审批结果 | `approval_result7` | string |  |
| `LDA932` | 审批意见 | `approval_opinion7` | string |  |
| `LDA933` | 通知人1 | `notifier1` | string |  |
| `LDA934` | 通知人2 | `notifier2` | string |  |
| `LDA935` | 通知人3 | `notifier3` | string |  |
| `LDA960` | 自定文字1 | `udf_text1` | string |  |
| `LDA961` | 自定文字2 | `udf_text2` | string |  |
| `LDA962` | 自定文字3 | `udf_text3` | string |  |
| `LDA963` | 自定文字4 | `udf_text4` | string |  |
| `LDA964` | 自定文字5 | `udf_text5` | string |  |
| `LDA965` | 自定文字6 | `udf_text6` | string |  |
| `LDA966` | 自定文字7 | `udf_text7` | string |  |
| `LDA967` | 自定文字8 | `udf_text8` | string |  |
| `LDA968` | 自定文字9 | `udf_text9` | string |  |
| `LDA969` | 自定文字10 | `udf_text10` | string |  |
| `LDA970` | 自定文字11 | `udf_text11` | string |  |
| `LDA971` | 自定文字12 | `udf_text12` | string |  |
| `LDA972` | 自定文字13 | `udf_text13` | string |  |
| `LDA973` | 自定文字14 | `udf_text14` | string |  |
| `LDA974` | 自定文字15 | `udf_text15` | string |  |
| `LDA975` | 自定文字16 | `udf_text16` | string |  |
| `LDA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `LDA980` | 自定数字1 | `udf_no1` | float |  |
| `LDA981` | 自定数字2 | `udf_no2` | float |  |
| `LDA982` | 自定数字3 | `udf_no3` | float |  |
| `LDA983` | 自定数字4 | `udf_no4` | float |  |
| `LDA984` | 自定数字5 | `udf_no5` | float |  |
| `LDA985` | 自定数字6 | `udf_no6` | float |  |
| `LDA986` | 自定数字7 | `udf_no7` | float |  |
| `LDA987` | 自定数字8 | `udf_no8` | float |  |
| `LDA988` | 自定数字9 | `udf_no9` | float |  |
| `LDA989` | 自定数字10 | `udf_no10` | float |  |
| `LDA990` | 自定数字11 | `udf_no11` | float |  |
| `LDA991` | 自定数字12 | `udf_no12` | float |  |
| `LDA992` | 自定数字13 | `udf_no13` | float |  |
| `LDA993` | 自定数字14 | `udf_no14` | float |  |
| `LDA994` | 自定数字15 | `udf_no15` | float |  |
| `LDA995` | 自定数字16 | `udf_no16` | float |  |
| `LDA950` | 送审时间 | `submission_time_for_review` | string |  |
| `LDA951` | 审批时间1 | `approval_time1` | string |  |
| `LDA952` | 审批时间2 | `approval_time2` | string |  |
| `LDA953` | 审批时间3 | `approval_time3` | string |  |
| `LDA954` | 审批时间4 | `approval_time4` | string |  |
| `LDA955` | 审批时间5 | `approval_time5` | string |  |
| `LDA956` | 审批时间6 | `approval_time6` | string |  |
| `LDA957` | 终审时间 | `final_review_time` | string |  |
| `LDA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKLDB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LDB001` | 单号 | `LDB001` | string |  |
| `LDB002` | 序号 | `LDB002` | string |  |
| `LDB003` | 品号 | `LDB003` | string |  |
| `LDB004` | 品名 | `LDB004` | string |  |
| `LDB005` | 单位 | `LDB005` | string |  |
| `LDB006` | 仓库 | `LDB006` | string |  |
| `LDB007` | 实盘数量 | `LDB007` | float |  |
| `LDB008` | 实际在库量 | `LDB008` | float |  |
| `LDB009` | 备注 | `LDB009` | string |  |
| `LDB010` | (预留)审核码 | `LDB010` | string |  |
| `LDB011` | (预留)日期 | `LDB011` | string |  |
| `LDB012` | 预留字段 | `LDB012` | string |  |
| `LDB013` | 预留字段 | `LDB013` | string |  |
| `LDB014` | 预留字段 | `LDB014` | string |  |
| `LDB015` | 预留字段 | `LDB015` | string |  |
| `LDB016` | 预留字段 | `LDB016` | float |  |
| `LDB017` | 预留字段 | `LDB017` | float |  |
| `LDB018` | 批号 | `LDB018` | string |  |
| `LDB019` | 规格 | `LDB019` | string |  |
| `LDB901` | 录入者编号 | `entry_person_no` | string |  |
| `LDB902` | 录入时间 | `entry_time` | string |  |
| `LDB903` | 更改者编号 | `changer_no` | string |  |
| `LDB904` | 更改时间 | `change_time` | string |  |
| `LDB905` | 更新标记 | `update_flag` | integer |  |
| `LDB960` | 自定文字1 | `udf_text1` | string |  |
| `LDB961` | 自定文字2 | `udf_text2` | string |  |
| `LDB962` | 自定文字3 | `udf_text3` | string |  |
| `LDB963` | 自定文字4 | `udf_text4` | string |  |
| `LDB964` | 自定文字5 | `udf_text5` | string |  |
| `LDB965` | 自定文字6 | `udf_text6` | string |  |
| `LDB966` | 自定文字7 | `udf_text7` | string |  |
| `LDB967` | 自定文字8 | `udf_text8` | string |  |
| `LDB968` | 自定文字9 | `udf_text9` | string |  |
| `LDB969` | 自定文字10 | `udf_text10` | string |  |
| `LDB970` | 自定文字11 | `udf_text11` | string |  |
| `LDB971` | 自定文字12 | `udf_text12` | string |  |
| `LDB972` | 自定文字13 | `udf_text13` | string |  |
| `LDB973` | 自定文字14 | `udf_text14` | string |  |
| `LDB974` | 自定文字15 | `udf_text15` | string |  |
| `LDB975` | 自定文字16 | `udf_text16` | string |  |
| `LDB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `LDB980` | 自定数字1 | `udf_no1` | float |  |
| `LDB981` | 自定数字2 | `udf_no2` | float |  |
| `LDB982` | 自定数字3 | `udf_no3` | float |  |
| `LDB983` | 自定数字4 | `udf_no4` | float |  |
| `LDB984` | 自定数字5 | `udf_no5` | float |  |
| `LDB985` | 自定数字6 | `udf_no6` | float |  |
| `LDB986` | 自定数字7 | `udf_no7` | float |  |
| `LDB987` | 自定数字8 | `udf_no8` | float |  |
| `LDB988` | 自定数字9 | `udf_no9` | float |  |
| `LDB989` | 自定数字10 | `udf_no10` | float |  |
| `LDB990` | 自定数字11 | `udf_no11` | float |  |
| `LDB991` | 自定数字12 | `udf_no12` | float |  |
| `LDB992` | 自定数字13 | `udf_no13` | float |  |
| `LDB993` | 自定数字14 | `udf_no14` | float |  |
| `LDB994` | 自定数字15 | `udf_no15` | float |  |
| `LDB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "LDA001": ""
  ,"LDA002": ""
  ,"LDA003": ""
  ,"LDA004": ""
  ,"cdsDetail": [{
    "LDB001": ""
    ,"LDB001": ""
    ,"LDB002": ""
    ,"LDB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"LDA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"LDA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `LDA001` | `LDA001` | 单号 | 主键 |
| `LDA002` | `LDA002` | 性质 | |
| `LDA003` | `LDA003` | 日期 | |
| `LDA004` | `LDA004` | 盘点人 | |
| `LDA005` | `LDA005` | 专案 | |
| `LDA006` | `LDA006` | 调整否 | |
| `LDA007` | `LDA007` | 调整单号 | |
| `LDA008` | `LDA008` | 复核编号 | |
| `LDA009` | `LDA009` | 复核姓名 | |
| `LDA010` | `LDA010` | 备注 | |
| `LDB001` | `LDB001` | 单号 (单身) | |
| `LDB002` | `LDB002` | 序号 (单身) | |
| `LDB003` | `LDB003` | 品号 (单身) | |
| `LDB004` | `LDB004` | 品名 (单身) | |
| `LDB005` | `LDB005` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `LDA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `LDA001`
