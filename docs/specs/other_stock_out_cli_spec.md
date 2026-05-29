# CLI 规格说明书：其它出库单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `other.stock.out` |
| **DLL** | `INVKC10` |
| **服务名称** | `其它出库单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.stock.out" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.stock.out" \
  --action "getMultiple" \
  --data '{"datakeys":[{"LIA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.stock.out" \
  --action "create" \
  --data '{"LIA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.stock.out" \
  --action "approve" \
  --data '{"datakeys":[{"LIA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `LIA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKLIA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LIA001` | 单号 | `LIA001` | string | 主键 |
| `LIA002` | 性质 | `LIA002` | string |  |
| `LIA003` | 日期 | `LIA003` | string |  |
| `LIA004` | 单据类别 | `LIA004` | string |  |
| `LIA005` | 经办人 | `LIA005` | string |  |
| `LIA006` | 项目 | `LIA006` | string |  |
| `LIA007` | 凭证抛转否 | `LIA007` | string |  |
| `LIA008` | 凭证 | `LIA008` | string |  |
| `LIA009` | 来源 | `LIA009` | string |  |
| `LIA010` | 来源单号 | `LIA010` | string |  |
| `LIA011` | 备注 | `LIA011` | string |  |
| `LIA012` | 审核码 | `LIA012` | string |  |
| `LIA013` | 调整方式 | `LIA013` | string |  |
| `LIA014` | 审核人 | `LIA014` | string |  |
| `LIA015` | 凭证类别 | `LIA015` | string |  |
| `LIA016` | 部门 | `LIA016` | string |  |
| `LIA017` | 日期 | `LIA017` | string |  |
| `LIA018` | 预留字段 | `LIA018` | string |  |
| `LIA019` | 预留字段 | `LIA019` | string |  |
| `LIA020` | 预留字段 | `LIA020` | string |  |
| `LIA021` | 预留字段 | `LIA021` | string |  |
| `LIA022` | 预留字段 | `LIA022` | float |  |
| `LIA023` | 预留字段 | `LIA023` | float |  |
| `LIA024` | 审核时间 | `LIA024` | string |  |
| `LIA025` | 来源序号 | `LIA025` | string |  |
| `LIA026` | 打印次数 | `LIA026` | integer |  |
| `LIA027` | 打印人员 | `LIA027` | string |  |
| `LIA028` | 打印时间 | `LIA028` | string |  |
| `LIA029` | 来源子序号 | `LIA029` | string |  |
| `LIA901` | 录入者编号 | `entry_person_no` | string |  |
| `LIA902` | 录入时间 | `entry_time` | string |  |
| `LIA903` | 更改者编号 | `changer_no` | string |  |
| `LIA904` | 更改时间 | `change_time` | string |  |
| `LIA905` | 更新标记 | `update_flag` | integer |  |
| `LIA906` | 打印次数 | `print_count` | integer |  |
| `LIA907` | 打印时间 | `print_time` | string |  |
| `LIA908` | 打印人员 | `printer` | string |  |
| `LIA909` | 打印人员姓名 | `printer_name` | string |  |
| `LIA910` | 送审状态 | `submission_status` | string |  |
| `LIA911` | 送审人 | `reviewer` | string |  |
| `LIA912` | 审批人1 | `approver1` | string |  |
| `LIA913` | 审批结果 | `approval_result1` | string |  |
| `LIA914` | 审批意见 | `approval_opinion1` | string |  |
| `LIA915` | 审批人2 | `approver2` | string |  |
| `LIA916` | 审批结果 | `approval_result2` | string |  |
| `LIA917` | 审批意见 | `approval_opinion2` | string |  |
| `LIA918` | 审批人3 | `approver3` | string |  |
| `LIA919` | 审批结果 | `approval_result3` | string |  |
| `LIA920` | 审批意见 | `approval_opinion3` | string |  |
| `LIA921` | 审批人4 | `approver4` | string |  |
| `LIA922` | 审批结果 | `approval_result4` | string |  |
| `LIA923` | 审批意见 | `approval_opinion4` | string |  |
| `LIA924` | 审批人5 | `approver5` | string |  |
| `LIA925` | 审批结果 | `approval_result5` | string |  |
| `LIA926` | 审批意见 | `approval_opinion5` | string |  |
| `LIA927` | 审批人6 | `approver6` | string |  |
| `LIA928` | 审批结果 | `approval_result6` | string |  |
| `LIA929` | 审批意见 | `approval_opinion6` | string |  |
| `LIA930` | 终审人 | `final_approver` | string |  |
| `LIA931` | 审批结果 | `approval_result7` | string |  |
| `LIA932` | 审批意见 | `approval_opinion7` | string |  |
| `LIA933` | 通知人1 | `notifier1` | string |  |
| `LIA934` | 通知人2 | `notifier2` | string |  |
| `LIA935` | 通知人3 | `notifier3` | string |  |
| `LIA940` | 签核码 | `approval_code` | string |  |
| `LIA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `LIA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `LIA960` | 自定文字1 | `udf_text1` | string |  |
| `LIA961` | 自定文字2 | `udf_text2` | string |  |
| `LIA962` | 自定文字3 | `udf_text3` | string |  |
| `LIA963` | 自定文字4 | `udf_text4` | string |  |
| `LIA964` | 自定文字5 | `udf_text5` | string |  |
| `LIA965` | 自定文字6 | `udf_text6` | string |  |
| `LIA966` | 自定文字7 | `udf_text7` | string |  |
| `LIA967` | 自定文字8 | `udf_text8` | string |  |
| `LIA968` | 自定文字9 | `udf_text9` | string |  |
| `LIA969` | 自定文字10 | `udf_text10` | string |  |
| `LIA970` | 自定文字11 | `udf_text11` | string |  |
| `LIA971` | 自定文字12 | `udf_text12` | string |  |
| `LIA972` | 自定文字13 | `udf_text13` | string |  |
| `LIA973` | 自定文字14 | `udf_text14` | string |  |
| `LIA974` | 自定文字15 | `udf_text15` | string |  |
| `LIA975` | 自定文字16 | `udf_text16` | string |  |
| `LIA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `LIA980` | 自定数字1 | `udf_no1` | float |  |
| `LIA981` | 自定数字2 | `udf_no2` | float |  |
| `LIA982` | 自定数字3 | `udf_no3` | float |  |
| `LIA983` | 自定数字4 | `udf_no4` | float |  |
| `LIA984` | 自定数字5 | `udf_no5` | float |  |
| `LIA985` | 自定数字6 | `udf_no6` | float |  |
| `LIA986` | 自定数字7 | `udf_no7` | float |  |
| `LIA987` | 自定数字8 | `udf_no8` | float |  |
| `LIA988` | 自定数字9 | `udf_no9` | float |  |
| `LIA989` | 自定数字10 | `udf_no10` | float |  |
| `LIA990` | 自定数字11 | `udf_no11` | float |  |
| `LIA991` | 自定数字12 | `udf_no12` | float |  |
| `LIA992` | 自定数字13 | `udf_no13` | float |  |
| `LIA993` | 自定数字14 | `udf_no14` | float |  |
| `LIA994` | 自定数字15 | `udf_no15` | float |  |
| `LIA995` | 自定数字16 | `udf_no16` | float |  |
| `LIA950` | 送审时间 | `submission_time_for_review` | string |  |
| `LIA951` | 审批时间1 | `approval_time1` | string |  |
| `LIA952` | 审批时间2 | `approval_time2` | string |  |
| `LIA953` | 审批时间3 | `approval_time3` | string |  |
| `LIA954` | 审批时间4 | `approval_time4` | string |  |
| `LIA955` | 审批时间5 | `approval_time5` | string |  |
| `LIA956` | 审批时间6 | `approval_time6` | string |  |
| `LIA957` | 终审时间 | `final_review_time` | string |  |
| `LIA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKLIB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LIB001` | 单号 | `LIB001` | string |  |
| `LIB002` | 序号 | `LIB002` | string |  |
| `LIB003` | 品号 | `LIB003` | string |  |
| `LIB004` | 品名 | `LIB004` | string |  |
| `LIB005` | 单位 | `LIB005` | string |  |
| `LIB006` | 仓库编号 | `LIB006` | string |  |
| `LIB007` | + | `LIB007` | integer |  |
| `LIB008` | 数量 | `LIB008` | float |  |
| `LIB009` | 单位成本 | `LIB009` | float |  |
| `LIB010` | 成本 | `LIB010` | string |  |
| `LIB011` | 审核码 | `LIB011` | string |  |
| `LIB012` | 日期 | `LIB012` | string |  |
| `LIB013` | 预留字段 | `LIB013` | string |  |
| `LIB014` | 预留字段 | `LIB014` | string |  |
| `LIB015` | 预留字段 | `LIB015` | string |  |
| `LIB016` | 预留字段 | `LIB016` | string |  |
| `LIB017` | 预留字段 | `LIB017` | float |  |
| `LIB018` | 预留字段 | `LIB018` | float |  |
| `LIB019` | 批号 | `LIB019` | string |  |
| `LIB020` | 换算分子 | `LIB020` | float |  |
| `LIB021` | 换算分母 | `LIB021` | float |  |
| `LIB022` | 辅助单位 | `LIB022` | string |  |
| `LIB023` | 辅助数量 | `LIB023` | float |  |
| `LIB024` | 规格 | `LIB024` | string |  |
| `LIB025` | 批号说明 | `LIB025` | string |  |
| `LIB026` | 生产日期 | `LIB026` | string |  |
| `LIB027` | 有效日期 | `LIB027` | string |  |
| `LIB901` | 录入者编号 | `entry_person_no` | string |  |
| `LIB902` | 录入时间 | `entry_time` | string |  |
| `LIB903` | 更改者编号 | `changer_no` | string |  |
| `LIB904` | 更改时间 | `change_time` | string |  |
| `LIB905` | 更新标记 | `update_flag` | integer |  |
| `LIB960` | 自定文字1 | `udf_text1` | string |  |
| `LIB961` | 自定文字2 | `udf_text2` | string |  |
| `LIB962` | 自定文字3 | `udf_text3` | string |  |
| `LIB963` | 自定文字4 | `udf_text4` | string |  |
| `LIB964` | 自定文字5 | `udf_text5` | string |  |
| `LIB965` | 自定文字6 | `udf_text6` | string |  |
| `LIB966` | 自定文字7 | `udf_text7` | string |  |
| `LIB967` | 自定文字8 | `udf_text8` | string |  |
| `LIB968` | 自定文字9 | `udf_text9` | string |  |
| `LIB969` | 自定文字10 | `udf_text10` | string |  |
| `LIB970` | 自定文字11 | `udf_text11` | string |  |
| `LIB971` | 自定文字12 | `udf_text12` | string |  |
| `LIB972` | 自定文字13 | `udf_text13` | string |  |
| `LIB973` | 自定文字14 | `udf_text14` | string |  |
| `LIB974` | 自定文字15 | `udf_text15` | string |  |
| `LIB975` | 自定文字16 | `udf_text16` | string |  |
| `LIB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `LIB980` | 自定数字1 | `udf_no1` | float |  |
| `LIB981` | 自定数字2 | `udf_no2` | float |  |
| `LIB982` | 自定数字3 | `udf_no3` | float |  |
| `LIB983` | 自定数字4 | `udf_no4` | float |  |
| `LIB984` | 自定数字5 | `udf_no5` | float |  |
| `LIB985` | 自定数字6 | `udf_no6` | float |  |
| `LIB986` | 自定数字7 | `udf_no7` | float |  |
| `LIB987` | 自定数字8 | `udf_no8` | float |  |
| `LIB988` | 自定数字9 | `udf_no9` | float |  |
| `LIB989` | 自定数字10 | `udf_no10` | float |  |
| `LIB990` | 自定数字11 | `udf_no11` | float |  |
| `LIB991` | 自定数字12 | `udf_no12` | float |  |
| `LIB992` | 自定数字13 | `udf_no13` | float |  |
| `LIB993` | 自定数字14 | `udf_no14` | float |  |
| `LIB994` | 自定数字15 | `udf_no15` | float |  |
| `LIB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "LIA001": ""
  ,"LIA002": ""
  ,"LIA003": ""
  ,"LIA004": ""
  ,"cdsDetail": [{
    "LIB001": ""
    ,"LIB001": ""
    ,"LIB002": ""
    ,"LIB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"LIA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"LIA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `LIA001` | `LIA001` | 单号 | 主键 |
| `LIA002` | `LIA002` | 性质 | |
| `LIA003` | `LIA003` | 日期 | |
| `LIA004` | `LIA004` | 单据类别 | |
| `LIA005` | `LIA005` | 经办人 | |
| `LIA006` | `LIA006` | 项目 | |
| `LIA007` | `LIA007` | 凭证抛转否 | |
| `LIA008` | `LIA008` | 凭证 | |
| `LIA009` | `LIA009` | 来源 | |
| `LIA010` | `LIA010` | 来源单号 | |
| `LIB001` | `LIB001` | 单号 (单身) | |
| `LIB002` | `LIB002` | 序号 (单身) | |
| `LIB003` | `LIB003` | 品号 (单身) | |
| `LIB004` | `LIB004` | 品名 (单身) | |
| `LIB005` | `LIB005` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `LIA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `LIA001`
