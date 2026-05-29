# CLI 规格说明书：调拨单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `transfer` |
| **DLL** | `INVKC03` |
| **服务名称** | `调拨单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "transfer" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "transfer" \
  --action "getMultiple" \
  --data '{"datakeys":[{"LCA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "transfer" \
  --action "create" \
  --data '{"LCA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "transfer" \
  --action "approve" \
  --data '{"datakeys":[{"LCA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `LCA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKLCA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LCA001` | 单号 | `LCA001` | string | 主键 |
| `LCA002` | 性质 | `LCA002` | string |  |
| `LCA003` | 日期 | `LCA003` | string |  |
| `LCA004` | 经办人 | `LCA004` | string |  |
| `LCA005` | 专案 | `LCA005` | string |  |
| `LCA006` | 备注 | `LCA006` | string |  |
| `LCA007` | 复核编号 | `LCA007` | string |  |
| `LCA008` | 复核姓名 | `LCA008` | string |  |
| `LCA009` | 审核码 | `LCA009` | string |  |
| `LCA010` | 日期 | `LCA010` | string |  |
| `LCA011` | 部门 | `LCA011` | string |  |
| `LCA012` | 预留字段 | `LCA012` | string |  |
| `LCA013` | 预留字段 | `LCA013` | string |  |
| `LCA014` | 预留字段 | `LCA014` | string |  |
| `LCA015` | 预留字段 | `LCA015` | string |  |
| `LCA016` | 预留字段 | `LCA016` | float |  |
| `LCA017` | 预留字段 | `LCA017` | float |  |
| `LCA018` | 审核人 | `LCA018` | string |  |
| `LCA019` | 审核时间 | `LCA019` | string |  |
| `LCA901` | 录入者编号 | `entry_person_no` | string |  |
| `LCA902` | 录入时间 | `entry_time` | string |  |
| `LCA903` | 更改者编号 | `changer_no` | string |  |
| `LCA904` | 更改时间 | `change_time` | string |  |
| `LCA905` | 更新标记 | `update_flag` | integer |  |
| `LCA906` | 打印次数 | `print_count` | integer |  |
| `LCA907` | 打印时间 | `print_time` | string |  |
| `LCA908` | 打印人员 | `printer` | string |  |
| `LCA909` | 打印人员姓名 | `printer_name` | string |  |
| `LCA910` | 送审状态 | `submission_status` | string |  |
| `LCA911` | 送审人 | `reviewer` | string |  |
| `LCA912` | 审批人1 | `approver1` | string |  |
| `LCA913` | 审批结果 | `approval_result1` | string |  |
| `LCA914` | 审批意见 | `approval_opinion1` | string |  |
| `LCA915` | 审批人2 | `approver2` | string |  |
| `LCA916` | 审批结果 | `approval_result2` | string |  |
| `LCA917` | 审批意见 | `approval_opinion2` | string |  |
| `LCA918` | 审批人3 | `approver3` | string |  |
| `LCA919` | 审批结果 | `approval_result3` | string |  |
| `LCA920` | 审批意见 | `approval_opinion3` | string |  |
| `LCA921` | 审批人4 | `approver4` | string |  |
| `LCA922` | 审批结果 | `approval_result4` | string |  |
| `LCA923` | 审批意见 | `approval_opinion4` | string |  |
| `LCA924` | 审批人5 | `approver5` | string |  |
| `LCA925` | 审批结果 | `approval_result5` | string |  |
| `LCA926` | 审批意见 | `approval_opinion5` | string |  |
| `LCA927` | 审批人6 | `approver6` | string |  |
| `LCA928` | 审批结果 | `approval_result6` | string |  |
| `LCA929` | 审批意见 | `approval_opinion6` | string |  |
| `LCA930` | 终审人 | `final_approver` | string |  |
| `LCA931` | 审批结果 | `approval_result7` | string |  |
| `LCA932` | 审批意见 | `approval_opinion7` | string |  |
| `LCA933` | 通知人1 | `notifier1` | string |  |
| `LCA934` | 通知人2 | `notifier2` | string |  |
| `LCA935` | 通知人3 | `notifier3` | string |  |
| `LCA960` | 自定文字1 | `udf_text1` | string |  |
| `LCA961` | 自定文字2 | `udf_text2` | string |  |
| `LCA962` | 自定文字3 | `udf_text3` | string |  |
| `LCA963` | 自定文字4 | `udf_text4` | string |  |
| `LCA964` | 自定文字5 | `udf_text5` | string |  |
| `LCA965` | 自定文字6 | `udf_text6` | string |  |
| `LCA966` | 自定文字7 | `udf_text7` | string |  |
| `LCA967` | 自定文字8 | `udf_text8` | string |  |
| `LCA968` | 自定文字9 | `udf_text9` | string |  |
| `LCA969` | 自定文字10 | `udf_text10` | string |  |
| `LCA970` | 自定文字11 | `udf_text11` | string |  |
| `LCA971` | 自定文字12 | `udf_text12` | string |  |
| `LCA972` | 自定文字13 | `udf_text13` | string |  |
| `LCA973` | 自定文字14 | `udf_text14` | string |  |
| `LCA974` | 自定文字15 | `udf_text15` | string |  |
| `LCA975` | 自定文字16 | `udf_text16` | string |  |
| `LCA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `LCA980` | 自定数字1 | `udf_no1` | float |  |
| `LCA981` | 自定数字2 | `udf_no2` | float |  |
| `LCA982` | 自定数字3 | `udf_no3` | float |  |
| `LCA983` | 自定数字4 | `udf_no4` | float |  |
| `LCA984` | 自定数字5 | `udf_no5` | float |  |
| `LCA985` | 自定数字6 | `udf_no6` | float |  |
| `LCA986` | 自定数字7 | `udf_no7` | float |  |
| `LCA987` | 自定数字8 | `udf_no8` | float |  |
| `LCA988` | 自定数字9 | `udf_no9` | float |  |
| `LCA989` | 自定数字10 | `udf_no10` | float |  |
| `LCA990` | 自定数字11 | `udf_no11` | float |  |
| `LCA991` | 自定数字12 | `udf_no12` | float |  |
| `LCA992` | 自定数字13 | `udf_no13` | float |  |
| `LCA993` | 自定数字14 | `udf_no14` | float |  |
| `LCA994` | 自定数字15 | `udf_no15` | float |  |
| `LCA995` | 自定数字16 | `udf_no16` | float |  |
| `LCA950` | 送审时间 | `submission_time_for_review` | string |  |
| `LCA951` | 审批时间1 | `approval_time1` | string |  |
| `LCA952` | 审批时间2 | `approval_time2` | string |  |
| `LCA953` | 审批时间3 | `approval_time3` | string |  |
| `LCA954` | 审批时间4 | `approval_time4` | string |  |
| `LCA955` | 审批时间5 | `approval_time5` | string |  |
| `LCA956` | 审批时间6 | `approval_time6` | string |  |
| `LCA957` | 终审时间 | `final_review_time` | string |  |
| `LCA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKLCB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LCB001` | 单号 | `LCB001` | string |  |
| `LCB002` | 序号 | `LCB002` | string |  |
| `LCB003` | 品号 | `LCB003` | string |  |
| `LCB004` | 品名 | `LCB004` | string |  |
| `LCB005` | 单位 | `LCB005` | string |  |
| `LCB006` | 转出仓库 | `LCB006` | string |  |
| `LCB007` | 转入仓库 | `LCB007` | string |  |
| `LCB008` | 数量 | `LCB008` | float |  |
| `LCB009` | 审核码 | `LCB009` | string |  |
| `LCB010` | (预留)日期 | `LCB010` | string |  |
| `LCB011` | 预留字段 | `LCB011` | string |  |
| `LCB012` | 预留字段 | `LCB012` | string |  |
| `LCB013` | 预留字段 | `LCB013` | string |  |
| `LCB014` | 预留字段 | `LCB014` | string |  |
| `LCB015` | 预留字段 | `LCB015` | float |  |
| `LCB016` | 预留字段 | `LCB016` | float |  |
| `LCB017` | 批号 | `LCB017` | string |  |
| `LCB018` | 换算分子 | `LCB018` | float |  |
| `LCB019` | 换算分母 | `LCB019` | float |  |
| `LCB020` | 辅助单位 | `LCB020` | string |  |
| `LCB021` | 辅助数量 | `LCB021` | float |  |
| `LCB022` | 规格 | `LCB022` | string |  |
| `LCB901` | 录入者编号 | `entry_person_no` | string |  |
| `LCB902` | 录入时间 | `entry_time` | string |  |
| `LCB903` | 更改者编号 | `changer_no` | string |  |
| `LCB904` | 更改时间 | `change_time` | string |  |
| `LCB905` | 更新标记 | `update_flag` | integer |  |
| `LCB960` | 自定文字1 | `udf_text1` | string |  |
| `LCB961` | 自定文字2 | `udf_text2` | string |  |
| `LCB962` | 自定文字3 | `udf_text3` | string |  |
| `LCB963` | 自定文字4 | `udf_text4` | string |  |
| `LCB964` | 自定文字5 | `udf_text5` | string |  |
| `LCB965` | 自定文字6 | `udf_text6` | string |  |
| `LCB966` | 自定文字7 | `udf_text7` | string |  |
| `LCB967` | 自定文字8 | `udf_text8` | string |  |
| `LCB968` | 自定文字9 | `udf_text9` | string |  |
| `LCB969` | 自定文字10 | `udf_text10` | string |  |
| `LCB970` | 自定文字11 | `udf_text11` | string |  |
| `LCB971` | 自定文字12 | `udf_text12` | string |  |
| `LCB972` | 自定文字13 | `udf_text13` | string |  |
| `LCB973` | 自定文字14 | `udf_text14` | string |  |
| `LCB974` | 自定文字15 | `udf_text15` | string |  |
| `LCB975` | 自定文字16 | `udf_text16` | string |  |
| `LCB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `LCB980` | 自定数字1 | `udf_no1` | float |  |
| `LCB981` | 自定数字2 | `udf_no2` | float |  |
| `LCB982` | 自定数字3 | `udf_no3` | float |  |
| `LCB983` | 自定数字4 | `udf_no4` | float |  |
| `LCB984` | 自定数字5 | `udf_no5` | float |  |
| `LCB985` | 自定数字6 | `udf_no6` | float |  |
| `LCB986` | 自定数字7 | `udf_no7` | float |  |
| `LCB987` | 自定数字8 | `udf_no8` | float |  |
| `LCB988` | 自定数字9 | `udf_no9` | float |  |
| `LCB989` | 自定数字10 | `udf_no10` | float |  |
| `LCB990` | 自定数字11 | `udf_no11` | float |  |
| `LCB991` | 自定数字12 | `udf_no12` | float |  |
| `LCB992` | 自定数字13 | `udf_no13` | float |  |
| `LCB993` | 自定数字14 | `udf_no14` | float |  |
| `LCB994` | 自定数字15 | `udf_no15` | float |  |
| `LCB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "LCA001": ""
  ,"LCA002": ""
  ,"LCA003": ""
  ,"LCA004": ""
  ,"cdsDetail": [{
    "LCB001": ""
    ,"LCB001": ""
    ,"LCB002": ""
    ,"LCB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"LCA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"LCA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `LCA001` | `LCA001` | 单号 | 主键 |
| `LCA002` | `LCA002` | 性质 | |
| `LCA003` | `LCA003` | 日期 | |
| `LCA004` | `LCA004` | 经办人 | |
| `LCA005` | `LCA005` | 专案 | |
| `LCA006` | `LCA006` | 备注 | |
| `LCA007` | `LCA007` | 复核编号 | |
| `LCA008` | `LCA008` | 复核姓名 | |
| `LCA009` | `LCA009` | 审核码 | |
| `LCA010` | `LCA010` | 日期 | |
| `LCB001` | `LCB001` | 单号 (单身) | |
| `LCB002` | `LCB002` | 序号 (单身) | |
| `LCB003` | `LCB003` | 品号 (单身) | |
| `LCB004` | `LCB004` | 品名 (单身) | |
| `LCB005` | `LCB005` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `LCA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `LCA001`
