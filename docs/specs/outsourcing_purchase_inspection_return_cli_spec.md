# CLI 规格说明书：委外验退退回单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `outsourcing.purchase.inspection.return` |
| **DLL** | `QMSCC06` |
| **服务名称** | `委外验退退回单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.inspection.return" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.inspection.return" \
  --action "getMultiple" \
  --data '{"datakeys":[{"MDA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.inspection.return" \
  --action "create" \
  --data '{"MDA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.inspection.return" \
  --action "approve" \
  --data '{"datakeys":[{"MDA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `MDA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (QMSMDA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MDA001` | 单号 | `MDA001` | string | 主键 |
| `MDA002` | 性质 | `MDA002` | string |  |
| `MDA003` | 日期 | `MDA003` | string |  |
| `MDA004` | 供应商 | `MDA004` | string |  |
| `MDA005` | 经办人 | `MDA005` | string |  |
| `MDA006` | 部门 | `MDA006` | string |  |
| `MDA007` | 项目 | `MDA007` | string |  |
| `MDA008` | 审核码 | `MDA008` | string |  |
| `MDA009` | 审核人 | `MDA009` | string |  |
| `MDA010` | 审核时间 | `MDA010` | string |  |
| `MDA011` | 备注 | `MDA011` | string |  |
| `MDA012` | 预留字段 | `MDA012` | string |  |
| `MDA013` | 预留字段 | `MDA013` | string |  |
| `MDA014` | 预留字段 | `MDA014` | string |  |
| `MDA015` | 预留字段 | `MDA015` | string |  |
| `MDA016` | 预留字段 | `MDA016` | float |  |
| `MDA017` | 预留字段 | `MDA017` | float |  |
| `MDA960` | 自定文字1 | `udf_text1` | string |  |
| `MDA961` | 自定文字2 | `udf_text2` | string |  |
| `MDA962` | 自定文字3 | `udf_text3` | string |  |
| `MDA963` | 自定文字4 | `udf_text4` | string |  |
| `MDA964` | 自定文字5 | `udf_text5` | string |  |
| `MDA965` | 自定文字6 | `udf_text6` | string |  |
| `MDA980` | 自定数字1 | `udf_no1` | float |  |
| `MDA981` | 自定数字2 | `udf_no2` | float |  |
| `MDA982` | 自定数字3 | `udf_no3` | float |  |
| `MDA983` | 自定数字4 | `udf_no4` | float |  |
| `MDA984` | 自定数字5 | `udf_no5` | float |  |
| `MDA985` | 自定数字6 | `udf_no6` | float |  |
| `MDA901` | 录入者编号 | `entry_person_no` | string |  |
| `MDA902` | 录入时间 | `entry_time` | string |  |
| `MDA903` | 更改者编号 | `changer_no` | string |  |
| `MDA904` | 更改时间 | `change_time` | string |  |
| `MDA905` | 更新标记 | `update_flag` | integer |  |
| `MDA910` | 送审状态 | `submission_status` | string |  |
| `MDA911` | 送审人 | `reviewer` | string |  |
| `MDA912` | 审批人1 | `approver1` | string |  |
| `MDA913` | 审批结果 | `approval_result1` | string |  |
| `MDA914` | 审批意见 | `approval_opinion1` | string |  |
| `MDA915` | 审批人2 | `approver2` | string |  |
| `MDA916` | 审批结果 | `approval_result2` | string |  |
| `MDA917` | 审批意见 | `approval_opinion2` | string |  |
| `MDA918` | 审批人3 | `approver3` | string |  |
| `MDA919` | 审批结果 | `approval_result3` | string |  |
| `MDA920` | 审批意见 | `approval_opinion3` | string |  |
| `MDA921` | 审批人4 | `approver4` | string |  |
| `MDA922` | 审批结果 | `approval_result4` | string |  |
| `MDA923` | 审批意见 | `approval_opinion4` | string |  |
| `MDA924` | 审批人5 | `approver5` | string |  |
| `MDA925` | 审批结果 | `approval_result5` | string |  |
| `MDA926` | 审批意见 | `approval_opinion5` | string |  |
| `MDA927` | 审批人6 | `approver6` | string |  |
| `MDA928` | 审批结果 | `approval_result6` | string |  |
| `MDA929` | 审批意见 | `approval_opinion6` | string |  |
| `MDA930` | 终审人 | `final_approver` | string |  |
| `MDA931` | 审批结果 | `approval_result7` | string |  |
| `MDA932` | 审批意见 | `approval_opinion7` | string |  |
| `MDA933` | 通知人1 | `notifier1` | string |  |
| `MDA934` | 通知人2 | `notifier2` | string |  |
| `MDA935` | 通知人3 | `notifier3` | string |  |
| `MDA966` | 自定文字7 | `udf_text7` | string |  |
| `MDA967` | 自定文字8 | `udf_text8` | string |  |
| `MDA968` | 自定文字9 | `udf_text9` | string |  |
| `MDA969` | 自定文字10 | `udf_text10` | string |  |
| `MDA970` | 自定文字11 | `udf_text11` | string |  |
| `MDA971` | 自定文字12 | `udf_text12` | string |  |
| `MDA972` | 自定文字13 | `udf_text13` | string |  |
| `MDA973` | 自定文字14 | `udf_text14` | string |  |
| `MDA974` | 自定文字15 | `udf_text15` | string |  |
| `MDA975` | 自定文字16 | `udf_text16` | string |  |
| `MDA986` | 自定数字7 | `udf_no7` | float |  |
| `MDA987` | 自定数字8 | `udf_no8` | float |  |
| `MDA988` | 自定数字9 | `udf_no9` | float |  |
| `MDA989` | 自定数字10 | `udf_no10` | float |  |
| `MDA990` | 自定数字11 | `udf_no11` | float |  |
| `MDA991` | 自定数字12 | `udf_no12` | float |  |
| `MDA992` | 自定数字13 | `udf_no13` | float |  |
| `MDA993` | 自定数字14 | `udf_no14` | float |  |
| `MDA994` | 自定数字15 | `udf_no15` | float |  |
| `MDA995` | 自定数字16 | `udf_no16` | float |  |
| `MDA906` | 打印次数 | `print_count` | integer |  |
| `MDA907` | 打印时间 | `print_time` | string |  |
| `MDA908` | 打印人员 | `printer` | string |  |
| `MDA909` | 打印人员姓名 | `printer_name` | string |  |
| `MDA950` | 送审时间 | `submission_time_for_review` | string |  |
| `MDA951` | 审批时间1 | `approval_time1` | string |  |
| `MDA952` | 审批时间2 | `approval_time2` | string |  |
| `MDA953` | 审批时间3 | `approval_time3` | string |  |
| `MDA954` | 审批时间4 | `approval_time4` | string |  |
| `MDA955` | 审批时间5 | `approval_time5` | string |  |
| `MDA956` | 审批时间6 | `approval_time6` | string |  |
| `MDA957` | 终审时间 | `final_review_time` | string |  |
| `MDA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (QMSMDB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MDB001` | 单号 | `MDB001` | string |  |
| `MDB002` | 序号 | `MDB002` | string |  |
| `MDB003` | 品号 | `MDB003` | string |  |
| `MDB004` | 品名 | `MDB004` | string |  |
| `MDB005` | 规格 | `MDB005` | string |  |
| `MDB006` | 单位 | `MDB006` | string |  |
| `MDB007` | 数量 | `MDB007` | float |  |
| `MDB008` | 前置来源 | `MDB008` | string |  |
| `MDB009` | 前置单号 | `MDB009` | string |  |
| `MDB010` | 前置序号 | `MDB010` | string |  |
| `MDB011` | 审核码 | `MDB011` | string |  |
| `MDB012` | 预留字段 | `MDB012` | string |  |
| `MDB013` | 预留字段 | `MDB013` | string |  |
| `MDB014` | 预留字段 | `MDB014` | string |  |
| `MDB015` | 预留字段 | `MDB015` | string |  |
| `MDB016` | 预留字段 | `MDB016` | float |  |
| `MDB017` | 预留字段 | `MDB017` | float |  |
| `MDB018` | 换算分子 | `MDB018` | float |  |
| `MDB019` | 换算分母 | `MDB019` | float |  |
| `MDB020` | 库存单位 | `MDB020` | string |  |
| `MDB021` | 库存单位数量 | `MDB021` | float |  |
| `MDB960` | 自定文字1 | `udf_text1` | string |  |
| `MDB961` | 自定文字2 | `udf_text2` | string |  |
| `MDB962` | 自定文字3 | `udf_text3` | string |  |
| `MDB963` | 自定文字4 | `udf_text4` | string |  |
| `MDB964` | 自定文字5 | `udf_text5` | string |  |
| `MDB965` | 自定文字6 | `udf_text6` | string |  |
| `MDB980` | 自定数字1 | `udf_no1` | float |  |
| `MDB981` | 自定数字2 | `udf_no2` | float |  |
| `MDB982` | 自定数字3 | `udf_no3` | float |  |
| `MDB983` | 自定数字4 | `udf_no4` | float |  |
| `MDB984` | 自定数字5 | `udf_no5` | float |  |
| `MDB985` | 自定数字6 | `udf_no6` | float |  |
| `MDB901` | 录入者编号 | `entry_person_no` | string |  |
| `MDB902` | 录入时间 | `entry_time` | string |  |
| `MDB903` | 更改者编号 | `changer_no` | string |  |
| `MDB904` | 更改时间 | `change_time` | string |  |
| `MDB905` | 更新标记 | `update_flag` | integer |  |
| `MDB966` | 自定文字7 | `udf_text7` | string |  |
| `MDB967` | 自定文字8 | `udf_text8` | string |  |
| `MDB968` | 自定文字9 | `udf_text9` | string |  |
| `MDB969` | 自定文字10 | `udf_text10` | string |  |
| `MDB970` | 自定文字11 | `udf_text11` | string |  |
| `MDB971` | 自定文字12 | `udf_text12` | string |  |
| `MDB972` | 自定文字13 | `udf_text13` | string |  |
| `MDB973` | 自定文字14 | `udf_text14` | string |  |
| `MDB974` | 自定文字15 | `udf_text15` | string |  |
| `MDB975` | 自定文字16 | `udf_text16` | string |  |
| `MDB986` | 自定数字7 | `udf_no7` | float |  |
| `MDB987` | 自定数字8 | `udf_no8` | float |  |
| `MDB988` | 自定数字9 | `udf_no9` | float |  |
| `MDB989` | 自定数字10 | `udf_no10` | float |  |
| `MDB990` | 自定数字11 | `udf_no11` | float |  |
| `MDB991` | 自定数字12 | `udf_no12` | float |  |
| `MDB992` | 自定数字13 | `udf_no13` | float |  |
| `MDB993` | 自定数字14 | `udf_no14` | float |  |
| `MDB994` | 自定数字15 | `udf_no15` | float |  |
| `MDB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "MDA001": ""
  ,"MDA002": ""
  ,"MDA003": ""
  ,"MDA004": ""
  ,"cdsDetail": [{
    "MDB001": ""
    ,"MDB001": ""
    ,"MDB002": ""
    ,"MDB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"MDA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"MDA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `MDA001` | `MDA001` | 单号 | 主键 |
| `MDA002` | `MDA002` | 性质 | |
| `MDA003` | `MDA003` | 日期 | |
| `MDA004` | `MDA004` | 供应商 | |
| `MDA005` | `MDA005` | 经办人 | |
| `MDA006` | `MDA006` | 部门 | |
| `MDA007` | `MDA007` | 项目 | |
| `MDA008` | `MDA008` | 审核码 | |
| `MDA009` | `MDA009` | 审核人 | |
| `MDA010` | `MDA010` | 审核时间 | |
| `MDB001` | `MDB001` | 单号 (单身) | |
| `MDB002` | `MDB002` | 序号 (单身) | |
| `MDB003` | `MDB003` | 品号 (单身) | |
| `MDB004` | `MDB004` | 品名 (单身) | |
| `MDB005` | `MDB005` | 规格 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `MDA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `MDA001`
