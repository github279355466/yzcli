# CLI 规格说明书：其它入库单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `other.stock.in` |
| **DLL** | `INVKC09` |
| **服务名称** | `其它入库单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.stock.in" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.stock.in" \
  --action "getMultiple" \
  --data '{"datakeys":[{"LHA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.stock.in" \
  --action "create" \
  --data '{"LHA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "other.stock.in" \
  --action "approve" \
  --data '{"datakeys":[{"LHA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `LHA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKLHA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LHA001` | 单号 | `LHA001` | string | 主键 |
| `LHA002` | 性质 | `LHA002` | string |  |
| `LHA003` | 日期 | `LHA003` | string |  |
| `LHA004` | 单据类别 | `LHA004` | string |  |
| `LHA005` | 经办人 | `LHA005` | string |  |
| `LHA006` | 项目 | `LHA006` | string |  |
| `LHA007` | 凭证抛转否 | `LHA007` | string |  |
| `LHA008` | 凭证 | `LHA008` | string |  |
| `LHA009` | 来源 | `LHA009` | string |  |
| `LHA010` | 来源单号 | `LHA010` | string |  |
| `LHA011` | 备注 | `LHA011` | string |  |
| `LHA012` | 审核码 | `LHA012` | string |  |
| `LHA013` | 调整方式 | `LHA013` | string |  |
| `LHA014` | 审核人 | `LHA014` | string |  |
| `LHA015` | 凭证类别 | `LHA015` | string |  |
| `LHA016` | 部门 | `LHA016` | string |  |
| `LHA017` | 日期 | `LHA017` | string |  |
| `LHA018` | 预留字段 | `LHA018` | string |  |
| `LHA019` | 预留字段 | `LHA019` | string |  |
| `LHA020` | 预留字段 | `LHA020` | string |  |
| `LHA021` | 预留字段 | `LHA021` | string |  |
| `LHA022` | 预留字段 | `LHA022` | float |  |
| `LHA023` | 预留字段 | `LHA023` | float |  |
| `LHA024` | 审核时间 | `LHA024` | string |  |
| `LHA025` | 来源序号 | `LHA025` | string |  |
| `LHA026` | 来源子序号 | `LHA026` | string |  |
| `LHA901` | 录入者编号 | `entry_person_no` | string |  |
| `LHA902` | 录入时间 | `entry_time` | string |  |
| `LHA903` | 更改者编号 | `changer_no` | string |  |
| `LHA904` | 更改时间 | `change_time` | string |  |
| `LHA905` | 更新标记 | `update_flag` | integer |  |
| `LHA906` | 打印次数 | `print_count` | integer |  |
| `LHA907` | 打印时间 | `print_time` | string |  |
| `LHA908` | 打印人员 | `printer` | string |  |
| `LHA909` | 打印人员姓名 | `printer_name` | string |  |
| `LHA910` | 送审状态 | `submission_status` | string |  |
| `LHA911` | 送审人 | `reviewer` | string |  |
| `LHA912` | 审批人1 | `approver1` | string |  |
| `LHA913` | 审批结果 | `approval_result1` | string |  |
| `LHA914` | 审批意见 | `approval_opinion1` | string |  |
| `LHA915` | 审批人2 | `approver2` | string |  |
| `LHA916` | 审批结果 | `approval_result2` | string |  |
| `LHA917` | 审批意见 | `approval_opinion2` | string |  |
| `LHA918` | 审批人3 | `approver3` | string |  |
| `LHA919` | 审批结果 | `approval_result3` | string |  |
| `LHA920` | 审批意见 | `approval_opinion3` | string |  |
| `LHA921` | 审批人4 | `approver4` | string |  |
| `LHA922` | 审批结果 | `approval_result4` | string |  |
| `LHA923` | 审批意见 | `approval_opinion4` | string |  |
| `LHA924` | 审批人5 | `approver5` | string |  |
| `LHA925` | 审批结果 | `approval_result5` | string |  |
| `LHA926` | 审批意见 | `approval_opinion5` | string |  |
| `LHA927` | 审批人6 | `approver6` | string |  |
| `LHA928` | 审批结果 | `approval_result6` | string |  |
| `LHA929` | 审批意见 | `approval_opinion6` | string |  |
| `LHA930` | 终审人 | `final_approver` | string |  |
| `LHA931` | 审批结果 | `approval_result7` | string |  |
| `LHA932` | 审批意见 | `approval_opinion7` | string |  |
| `LHA933` | 通知人1 | `notifier1` | string |  |
| `LHA934` | 通知人2 | `notifier2` | string |  |
| `LHA935` | 通知人3 | `notifier3` | string |  |
| `LHA940` | 签核码 | `approval_code` | string |  |
| `LHA941` | 工作流表单单号 | `workflow_form_code` | string |  |
| `LHA942` | 工作路表单编号 | `workflow_form_no` | string |  |
| `LHA960` | 自定文字1 | `udf_text1` | string |  |
| `LHA961` | 自定文字2 | `udf_text2` | string |  |
| `LHA962` | 自定文字3 | `udf_text3` | string |  |
| `LHA963` | 自定文字4 | `udf_text4` | string |  |
| `LHA964` | 自定文字5 | `udf_text5` | string |  |
| `LHA965` | 自定文字6 | `udf_text6` | string |  |
| `LHA966` | 自定文字7 | `udf_text7` | string |  |
| `LHA967` | 自定文字8 | `udf_text8` | string |  |
| `LHA968` | 自定文字9 | `udf_text9` | string |  |
| `LHA969` | 自定文字10 | `udf_text10` | string |  |
| `LHA970` | 自定文字11 | `udf_text11` | string |  |
| `LHA971` | 自定文字12 | `udf_text12` | string |  |
| `LHA972` | 自定文字13 | `udf_text13` | string |  |
| `LHA973` | 自定文字14 | `udf_text14` | string |  |
| `LHA974` | 自定文字15 | `udf_text15` | string |  |
| `LHA975` | 自定文字16 | `udf_text16` | string |  |
| `LHA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `LHA980` | 自定数字1 | `udf_no1` | float |  |
| `LHA981` | 自定数字2 | `udf_no2` | float |  |
| `LHA982` | 自定数字3 | `udf_no3` | float |  |
| `LHA983` | 自定数字4 | `udf_no4` | float |  |
| `LHA984` | 自定数字5 | `udf_no5` | float |  |
| `LHA985` | 自定数字6 | `udf_no6` | float |  |
| `LHA986` | 自定数字7 | `udf_no7` | float |  |
| `LHA987` | 自定数字8 | `udf_no8` | float |  |
| `LHA988` | 自定数字9 | `udf_no9` | float |  |
| `LHA989` | 自定数字10 | `udf_no10` | float |  |
| `LHA990` | 自定数字11 | `udf_no11` | float |  |
| `LHA991` | 自定数字12 | `udf_no12` | float |  |
| `LHA992` | 自定数字13 | `udf_no13` | float |  |
| `LHA993` | 自定数字14 | `udf_no14` | float |  |
| `LHA994` | 自定数字15 | `udf_no15` | float |  |
| `LHA995` | 自定数字16 | `udf_no16` | float |  |
| `LHA950` | 送审时间 | `submission_time_for_review` | string |  |
| `LHA951` | 审批时间1 | `approval_time1` | string |  |
| `LHA952` | 审批时间2 | `approval_time2` | string |  |
| `LHA953` | 审批时间3 | `approval_time3` | string |  |
| `LHA954` | 审批时间4 | `approval_time4` | string |  |
| `LHA955` | 审批时间5 | `approval_time5` | string |  |
| `LHA956` | 审批时间6 | `approval_time6` | string |  |
| `LHA957` | 终审时间 | `final_review_time` | string |  |
| `LHA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKLHB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LHB001` | 单号 | `LHB001` | string |  |
| `LHB002` | 序号 | `LHB002` | string |  |
| `LHB003` | 品号 | `LHB003` | string |  |
| `LHB004` | 品名 | `LHB004` | string |  |
| `LHB005` | 单位 | `LHB005` | string |  |
| `LHB006` | 仓库编号 | `LHB006` | string |  |
| `LHB007` | + | `LHB007` | integer |  |
| `LHB008` | 数量 | `LHB008` | float |  |
| `LHB009` | 单位成本 | `LHB009` | float |  |
| `LHB010` | 成本 | `LHB010` | string |  |
| `LHB011` | 审核码 | `LHB011` | string |  |
| `LHB012` | 日期 | `LHB012` | string |  |
| `LHB013` | 预留字段 | `LHB013` | string |  |
| `LHB014` | 预留字段 | `LHB014` | string |  |
| `LHB015` | 预留字段 | `LHB015` | string |  |
| `LHB016` | 预留字段 | `LHB016` | string |  |
| `LHB017` | 预留字段 | `LHB017` | float |  |
| `LHB018` | 预留字段 | `LHB018` | float |  |
| `LHB019` | 批号 | `LHB019` | string |  |
| `LHB020` | 换算分子 | `LHB020` | float |  |
| `LHB021` | 换算分母 | `LHB021` | float |  |
| `LHB022` | 辅助单位 | `LHB022` | string |  |
| `LHB023` | 辅助数量 | `LHB023` | float |  |
| `LHB024` | 规格 | `LHB024` | string |  |
| `LHB025` | 批号说明 | `LHB025` | string |  |
| `LHB026` | 生产日期 | `LHB026` | string |  |
| `LHB027` | 有效日期 | `LHB027` | string |  |
| `LHB901` | 录入者编号 | `entry_person_no` | string |  |
| `LHB902` | 录入时间 | `entry_time` | string |  |
| `LHB903` | 更改者编号 | `changer_no` | string |  |
| `LHB904` | 更改时间 | `change_time` | string |  |
| `LHB905` | 更新标记 | `update_flag` | integer |  |
| `LHB960` | 自定文字1 | `udf_text1` | string |  |
| `LHB961` | 自定文字2 | `udf_text2` | string |  |
| `LHB962` | 自定文字3 | `udf_text3` | string |  |
| `LHB963` | 自定文字4 | `udf_text4` | string |  |
| `LHB964` | 自定文字5 | `udf_text5` | string |  |
| `LHB965` | 自定文字6 | `udf_text6` | string |  |
| `LHB966` | 自定文字7 | `udf_text7` | string |  |
| `LHB967` | 自定文字8 | `udf_text8` | string |  |
| `LHB968` | 自定文字9 | `udf_text9` | string |  |
| `LHB969` | 自定文字10 | `udf_text10` | string |  |
| `LHB970` | 自定文字11 | `udf_text11` | string |  |
| `LHB971` | 自定文字12 | `udf_text12` | string |  |
| `LHB972` | 自定文字13 | `udf_text13` | string |  |
| `LHB973` | 自定文字14 | `udf_text14` | string |  |
| `LHB974` | 自定文字15 | `udf_text15` | string |  |
| `LHB975` | 自定文字16 | `udf_text16` | string |  |
| `LHB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `LHB980` | 自定数字1 | `udf_no1` | float |  |
| `LHB981` | 自定数字2 | `udf_no2` | float |  |
| `LHB982` | 自定数字3 | `udf_no3` | float |  |
| `LHB983` | 自定数字4 | `udf_no4` | float |  |
| `LHB984` | 自定数字5 | `udf_no5` | float |  |
| `LHB985` | 自定数字6 | `udf_no6` | float |  |
| `LHB986` | 自定数字7 | `udf_no7` | float |  |
| `LHB987` | 自定数字8 | `udf_no8` | float |  |
| `LHB988` | 自定数字9 | `udf_no9` | float |  |
| `LHB989` | 自定数字10 | `udf_no10` | float |  |
| `LHB990` | 自定数字11 | `udf_no11` | float |  |
| `LHB991` | 自定数字12 | `udf_no12` | float |  |
| `LHB992` | 自定数字13 | `udf_no13` | float |  |
| `LHB993` | 自定数字14 | `udf_no14` | float |  |
| `LHB994` | 自定数字15 | `udf_no15` | float |  |
| `LHB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "LHA001": ""
  ,"LHA002": ""
  ,"LHA003": ""
  ,"LHA004": ""
  ,"cdsDetail": [{
    "LHB001": ""
    ,"LHB001": ""
    ,"LHB002": ""
    ,"LHB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"LHA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"LHA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `LHA001` | `LHA001` | 单号 | 主键 |
| `LHA002` | `LHA002` | 性质 | |
| `LHA003` | `LHA003` | 日期 | |
| `LHA004` | `LHA004` | 单据类别 | |
| `LHA005` | `LHA005` | 经办人 | |
| `LHA006` | `LHA006` | 项目 | |
| `LHA007` | `LHA007` | 凭证抛转否 | |
| `LHA008` | `LHA008` | 凭证 | |
| `LHA009` | `LHA009` | 来源 | |
| `LHA010` | `LHA010` | 来源单号 | |
| `LHB001` | `LHB001` | 单号 (单身) | |
| `LHB002` | `LHB002` | 序号 (单身) | |
| `LHB003` | `LHB003` | 品号 (单身) | |
| `LHB004` | `LHB004` | 品名 (单身) | |
| `LHB005` | `LHB005` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `LHA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `LHA001`
