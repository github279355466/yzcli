# CLI 规格说明书：委外检验单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `outsourcing.purchase.arrival.inspection` |
| **DLL** | `QMSCC05` |
| **服务名称** | `委外检验单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.arrival.inspection" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.arrival.inspection" \
  --action "getMultiple" \
  --data '{"datakeys":[{"MCA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.arrival.inspection" \
  --action "create" \
  --data '{"MCA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.arrival.inspection" \
  --action "approve" \
  --data '{"datakeys":[{"MCA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `MCA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (QMSMCA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MCA001` | 单号 | `MCA001` | string | 主键 |
| `MCA002` | 性质 | `MCA002` | string |  |
| `MCA003` | 日期 | `MCA003` | string |  |
| `MCA004` | 供应商 | `MCA004` | string |  |
| `MCA005` | 经办人 | `MCA005` | string |  |
| `MCA006` | 部门 | `MCA006` | string |  |
| `MCA007` | 项目 | `MCA007` | string |  |
| `MCA008` | 审核码 | `MCA008` | string |  |
| `MCA009` | 审核人 | `MCA009` | string |  |
| `MCA010` | 审核时间 | `MCA010` | string |  |
| `MCA011` | 备注 | `MCA011` | string |  |
| `MCA012` | 预留字段 | `MCA012` | string |  |
| `MCA013` | 预留字段 | `MCA013` | string |  |
| `MCA014` | 预留字段 | `MCA014` | string |  |
| `MCA015` | 预留字段 | `MCA015` | string |  |
| `MCA016` | 预留字段 | `MCA016` | float |  |
| `MCA017` | 预留字段 | `MCA017` | float |  |
| `MCA901` | 录入者编号 | `entry_person_no` | string |  |
| `MCA902` | 录入时间 | `entry_time` | string |  |
| `MCA903` | 更改者编号 | `changer_no` | string |  |
| `MCA904` | 更改时间 | `change_time` | string |  |
| `MCA905` | 更新标记 | `update_flag` | integer |  |
| `MCA906` | 打印次数 | `print_count` | integer |  |
| `MCA907` | 打印时间 | `print_time` | string |  |
| `MCA908` | 打印人员 | `printer` | string |  |
| `MCA909` | 打印人员姓名 | `printer_name` | string |  |
| `MCA910` | 送审状态 | `submission_status` | string |  |
| `MCA911` | 送审人 | `reviewer` | string |  |
| `MCA912` | 审批人1 | `approver1` | string |  |
| `MCA913` | 审批结果 | `approval_result1` | string |  |
| `MCA914` | 审批意见 | `approval_opinion1` | string |  |
| `MCA915` | 审批人2 | `approver2` | string |  |
| `MCA916` | 审批结果 | `approval_result2` | string |  |
| `MCA917` | 审批意见 | `approval_opinion2` | string |  |
| `MCA918` | 审批人3 | `approver3` | string |  |
| `MCA919` | 审批结果 | `approval_result3` | string |  |
| `MCA920` | 审批意见 | `approval_opinion3` | string |  |
| `MCA921` | 审批人4 | `approver4` | string |  |
| `MCA922` | 审批结果 | `approval_result4` | string |  |
| `MCA923` | 审批意见 | `approval_opinion4` | string |  |
| `MCA924` | 审批人5 | `approver5` | string |  |
| `MCA925` | 审批结果 | `approval_result5` | string |  |
| `MCA926` | 审批意见 | `approval_opinion5` | string |  |
| `MCA927` | 审批人6 | `approver6` | string |  |
| `MCA928` | 审批结果 | `approval_result6` | string |  |
| `MCA929` | 审批意见 | `approval_opinion6` | string |  |
| `MCA930` | 终审人 | `final_approver` | string |  |
| `MCA931` | 审批结果 | `approval_result7` | string |  |
| `MCA932` | 审批意见 | `approval_opinion7` | string |  |
| `MCA933` | 通知人1 | `notifier1` | string |  |
| `MCA934` | 通知人2 | `notifier2` | string |  |
| `MCA935` | 通知人3 | `notifier3` | string |  |
| `MCA960` | 自定文字1 | `udf_text1` | string |  |
| `MCA961` | 自定文字2 | `udf_text2` | string |  |
| `MCA962` | 自定文字3 | `udf_text3` | string |  |
| `MCA963` | 自定文字4 | `udf_text4` | string |  |
| `MCA964` | 自定文字5 | `udf_text5` | string |  |
| `MCA965` | 自定文字6 | `udf_text6` | string |  |
| `MCA966` | 自定文字7 | `udf_text7` | string |  |
| `MCA967` | 自定文字8 | `udf_text8` | string |  |
| `MCA968` | 自定文字9 | `udf_text9` | string |  |
| `MCA969` | 自定文字10 | `udf_text10` | string |  |
| `MCA970` | 自定文字11 | `udf_text11` | string |  |
| `MCA971` | 自定文字12 | `udf_text12` | string |  |
| `MCA972` | 自定文字13 | `udf_text13` | string |  |
| `MCA973` | 自定文字14 | `udf_text14` | string |  |
| `MCA974` | 自定文字15 | `udf_text15` | string |  |
| `MCA975` | 自定文字16 | `udf_text16` | string |  |
| `MCA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `MCA980` | 自定数字1 | `udf_no1` | float |  |
| `MCA981` | 自定数字2 | `udf_no2` | float |  |
| `MCA982` | 自定数字3 | `udf_no3` | float |  |
| `MCA983` | 自定数字4 | `udf_no4` | float |  |
| `MCA984` | 自定数字5 | `udf_no5` | float |  |
| `MCA985` | 自定数字6 | `udf_no6` | float |  |
| `MCA986` | 自定数字7 | `udf_no7` | float |  |
| `MCA987` | 自定数字8 | `udf_no8` | float |  |
| `MCA988` | 自定数字9 | `udf_no9` | float |  |
| `MCA989` | 自定数字10 | `udf_no10` | float |  |
| `MCA990` | 自定数字11 | `udf_no11` | float |  |
| `MCA991` | 自定数字12 | `udf_no12` | float |  |
| `MCA992` | 自定数字13 | `udf_no13` | float |  |
| `MCA993` | 自定数字14 | `udf_no14` | float |  |
| `MCA994` | 自定数字15 | `udf_no15` | float |  |
| `MCA995` | 自定数字16 | `udf_no16` | float |  |
| `MCA950` | 送审时间 | `submission_time_for_review` | string |  |
| `MCA951` | 审批时间1 | `approval_time1` | string |  |
| `MCA952` | 审批时间2 | `approval_time2` | string |  |
| `MCA953` | 审批时间3 | `approval_time3` | string |  |
| `MCA954` | 审批时间4 | `approval_time4` | string |  |
| `MCA955` | 审批时间5 | `approval_time5` | string |  |
| `MCA956` | 审批时间6 | `approval_time6` | string |  |
| `MCA957` | 终审时间 | `final_review_time` | string |  |
| `MCA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (QMSMCB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MCB001` | 单号 | `MCB001` | string |  |
| `MCB002` | 序号 | `MCB002` | string |  |
| `MCB003` | 检验类型 | `MCB003` | string |  |
| `MCB004` | 检验说明 | `MCB004` | string |  |
| `MCB005` | 收料单号 | `MCB005` | string |  |
| `MCB006` | 收料序号 | `MCB006` | string |  |
| `MCB007` | 品号 | `MCB007` | string |  |
| `MCB008` | 品名 | `MCB008` | string |  |
| `MCB009` | 规格 | `MCB009` | string |  |
| `MCB010` | 单位 | `MCB010` | string |  |
| `MCB011` | 检验数量 | `MCB011` | float |  |
| `MCB012` | 验收数量 | `MCB012` | float |  |
| `MCB013` | 验退数量 | `MCB013` | float |  |
| `MCB014` | 已委外进货量 | `MCB014` | float |  |
| `MCB015` | 已验退退回量 | `MCB015` | float |  |
| `MCB016` | 已报废量 | `MCB016` | float |  |
| `MCB017` | 备注 | `MCB017` | string |  |
| `MCB018` | 审核码 | `MCB018` | string |  |
| `MCB019` | 报废量 | `MCB019` | float |  |
| `MCB020` | 预留字段 | `MCB020` | string |  |
| `MCB021` | 预留字段 | `MCB021` | string |  |
| `MCB022` | 预留字段 | `MCB022` | string |  |
| `MCB023` | 预留字段 | `MCB023` | string |  |
| `MCB024` | 预留字段 | `MCB024` | float |  |
| `MCB025` | 预留字段 | `MCB025` | float |  |
| `MCB026` | 报废耗用统计量 | `MCB026` | float |  |
| `MCB027` | 换算分子 | `MCB027` | float |  |
| `MCB028` | 换算分母 | `MCB028` | float |  |
| `MCB029` | 库存单位 | `MCB029` | string |  |
| `MCB030` | 库存单位数量 | `MCB030` | float |  |
| `MCB901` | 录入者编号 | `entry_person_no` | string |  |
| `MCB902` | 录入时间 | `entry_time` | string |  |
| `MCB903` | 更改者编号 | `changer_no` | string |  |
| `MCB904` | 更改时间 | `change_time` | string |  |
| `MCB905` | 更新标记 | `update_flag` | integer |  |
| `MCB960` | 自定文字1 | `udf_text1` | string |  |
| `MCB961` | 自定文字2 | `udf_text2` | string |  |
| `MCB962` | 自定文字3 | `udf_text3` | string |  |
| `MCB963` | 自定文字4 | `udf_text4` | string |  |
| `MCB964` | 自定文字5 | `udf_text5` | string |  |
| `MCB965` | 自定文字6 | `udf_text6` | string |  |
| `MCB966` | 自定文字7 | `udf_text7` | string |  |
| `MCB967` | 自定文字8 | `udf_text8` | string |  |
| `MCB968` | 自定文字9 | `udf_text9` | string |  |
| `MCB969` | 自定文字10 | `udf_text10` | string |  |
| `MCB970` | 自定文字11 | `udf_text11` | string |  |
| `MCB971` | 自定文字12 | `udf_text12` | string |  |
| `MCB972` | 自定文字13 | `udf_text13` | string |  |
| `MCB973` | 自定文字14 | `udf_text14` | string |  |
| `MCB974` | 自定文字15 | `udf_text15` | string |  |
| `MCB975` | 自定文字16 | `udf_text16` | string |  |
| `MCB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `MCB980` | 自定数字1 | `udf_no1` | float |  |
| `MCB981` | 自定数字2 | `udf_no2` | float |  |
| `MCB982` | 自定数字3 | `udf_no3` | float |  |
| `MCB983` | 自定数字4 | `udf_no4` | float |  |
| `MCB984` | 自定数字5 | `udf_no5` | float |  |
| `MCB985` | 自定数字6 | `udf_no6` | float |  |
| `MCB986` | 自定数字7 | `udf_no7` | float |  |
| `MCB987` | 自定数字8 | `udf_no8` | float |  |
| `MCB988` | 自定数字9 | `udf_no9` | float |  |
| `MCB989` | 自定数字10 | `udf_no10` | float |  |
| `MCB990` | 自定数字11 | `udf_no11` | float |  |
| `MCB991` | 自定数字12 | `udf_no12` | float |  |
| `MCB992` | 自定数字13 | `udf_no13` | float |  |
| `MCB993` | 自定数字14 | `udf_no14` | float |  |
| `MCB994` | 自定数字15 | `udf_no15` | float |  |
| `MCB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "MCA001": ""
  ,"MCA002": ""
  ,"MCA003": ""
  ,"MCA004": ""
  ,"cdsDetail": [{
    "MCB001": ""
    ,"MCB001": ""
    ,"MCB002": ""
    ,"MCB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"MCA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"MCA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `MCA001` | `MCA001` | 单号 | 主键 |
| `MCA002` | `MCA002` | 性质 | |
| `MCA003` | `MCA003` | 日期 | |
| `MCA004` | `MCA004` | 供应商 | |
| `MCA005` | `MCA005` | 经办人 | |
| `MCA006` | `MCA006` | 部门 | |
| `MCA007` | `MCA007` | 项目 | |
| `MCA008` | `MCA008` | 审核码 | |
| `MCA009` | `MCA009` | 审核人 | |
| `MCA010` | `MCA010` | 审核时间 | |
| `MCB001` | `MCB001` | 单号 (单身) | |
| `MCB002` | `MCB002` | 序号 (单身) | |
| `MCB003` | `MCB003` | 检验类型 (单身) | |
| `MCB004` | `MCB004` | 检验说明 (单身) | |
| `MCB005` | `MCB005` | 收料单号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `MCA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `MCA001`
