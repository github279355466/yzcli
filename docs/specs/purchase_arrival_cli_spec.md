# CLI 规格说明书：收料单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `purchase.arrival` |
| **DLL** | `QMSCC01` |
| **服务名称** | `收料单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.arrival" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.arrival" \
  --action "getMultiple" \
  --data '{"datakeys":[{"JCA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.arrival" \
  --action "create" \
  --data '{"JCA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.arrival" \
  --action "approve" \
  --data '{"datakeys":[{"JCA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `JCA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKJCA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JCA001` | 单号 | `JCA001` | string | 主键 |
| `JCA002` | 性质 | `JCA002` | string |  |
| `JCA003` | 日期 | `JCA003` | string |  |
| `JCA004` | 供应商 | `JCA004` | string |  |
| `JCA005` | 经办人 | `JCA005` | string |  |
| `JCA006` | 部门 | `JCA006` | string |  |
| `JCA007` | 专案 | `JCA007` | string |  |
| `JCA008` | 复核编号 | `JCA008` | string |  |
| `JCA009` | 复核姓名 | `JCA009` | string |  |
| `JCA010` | 备注 | `JCA010` | string |  |
| `JCA011` | 审核码 | `JCA011` | string |  |
| `JCA012` | 预留字段 | `JCA012` | string |  |
| `JCA013` | 预留字段 | `JCA013` | string |  |
| `JCA014` | 预留字段 | `JCA014` | string |  |
| `JCA015` | 预留字段 | `JCA015` | string |  |
| `JCA016` | 预留字段 | `JCA016` | string |  |
| `JCA017` | 预留字段 | `JCA017` | float |  |
| `JCA018` | 预留字段 | `JCA018` | float |  |
| `JCA019` | 审核人 | `JCA019` | string |  |
| `JCA020` | 供应商发货单号 | `JCA020` | string |  |
| `JCA901` | 录入者编号 | `entry_person_no` | string |  |
| `JCA902` | 录入时间 | `entry_time` | string |  |
| `JCA903` | 更改者编号 | `changer_no` | string |  |
| `JCA904` | 更改时间 | `change_time` | string |  |
| `JCA905` | 更新标记 | `update_flag` | integer |  |
| `JCA906` | 打印次数 | `print_count` | integer |  |
| `JCA907` | 打印时间 | `print_time` | string |  |
| `JCA908` | 打印人员 | `printer` | string |  |
| `JCA909` | 打印人员姓名 | `printer_name` | string |  |
| `JCA910` | 送审状态 | `submission_status` | string |  |
| `JCA911` | 送审人 | `reviewer` | string |  |
| `JCA912` | 审批人1 | `approver1` | string |  |
| `JCA913` | 审批结果 | `approval_result1` | string |  |
| `JCA914` | 审批意见 | `approval_opinion1` | string |  |
| `JCA915` | 审批人2 | `approver2` | string |  |
| `JCA916` | 审批结果 | `approval_result2` | string |  |
| `JCA917` | 审批意见 | `approval_opinion2` | string |  |
| `JCA918` | 审批人3 | `approver3` | string |  |
| `JCA919` | 审批结果 | `approval_result3` | string |  |
| `JCA920` | 审批意见 | `approval_opinion3` | string |  |
| `JCA921` | 审批人4 | `approver4` | string |  |
| `JCA922` | 审批结果 | `approval_result4` | string |  |
| `JCA923` | 审批意见 | `approval_opinion4` | string |  |
| `JCA924` | 审批人5 | `approver5` | string |  |
| `JCA925` | 审批结果 | `approval_result5` | string |  |
| `JCA926` | 审批意见 | `approval_opinion5` | string |  |
| `JCA927` | 审批人6 | `approver6` | string |  |
| `JCA928` | 审批结果 | `approval_result6` | string |  |
| `JCA929` | 审批意见 | `approval_opinion6` | string |  |
| `JCA930` | 终审人 | `final_approver` | string |  |
| `JCA931` | 审批结果 | `approval_result7` | string |  |
| `JCA932` | 审批意见 | `approval_opinion7` | string |  |
| `JCA933` | 通知人1 | `notifier1` | string |  |
| `JCA934` | 通知人2 | `notifier2` | string |  |
| `JCA935` | 通知人3 | `notifier3` | string |  |
| `JCA960` | 自定文字1 | `udf_text1` | string |  |
| `JCA961` | 自定文字2 | `udf_text2` | string |  |
| `JCA962` | 自定文字3 | `udf_text3` | string |  |
| `JCA963` | 自定文字4 | `udf_text4` | string |  |
| `JCA964` | 自定文字5 | `udf_text5` | string |  |
| `JCA965` | 自定文字6 | `udf_text6` | string |  |
| `JCA966` | 自定文字7 | `udf_text7` | string |  |
| `JCA967` | 自定文字8 | `udf_text8` | string |  |
| `JCA968` | 自定文字9 | `udf_text9` | string |  |
| `JCA969` | 自定文字10 | `udf_text10` | string |  |
| `JCA970` | 自定文字11 | `udf_text11` | string |  |
| `JCA971` | 自定文字12 | `udf_text12` | string |  |
| `JCA972` | 自定文字13 | `udf_text13` | string |  |
| `JCA973` | 自定文字14 | `udf_text14` | string |  |
| `JCA974` | 自定文字15 | `udf_text15` | string |  |
| `JCA975` | 自定文字16 | `udf_text16` | string |  |
| `JCA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `JCA980` | 自定数字1 | `udf_no1` | float |  |
| `JCA981` | 自定数字2 | `udf_no2` | float |  |
| `JCA982` | 自定数字3 | `udf_no3` | float |  |
| `JCA983` | 自定数字4 | `udf_no4` | float |  |
| `JCA984` | 自定数字5 | `udf_no5` | float |  |
| `JCA985` | 自定数字6 | `udf_no6` | float |  |
| `JCA986` | 自定数字7 | `udf_no7` | float |  |
| `JCA987` | 自定数字8 | `udf_no8` | float |  |
| `JCA988` | 自定数字9 | `udf_no9` | float |  |
| `JCA989` | 自定数字10 | `udf_no10` | float |  |
| `JCA990` | 自定数字11 | `udf_no11` | float |  |
| `JCA991` | 自定数字12 | `udf_no12` | float |  |
| `JCA992` | 自定数字13 | `udf_no13` | float |  |
| `JCA993` | 自定数字14 | `udf_no14` | float |  |
| `JCA994` | 自定数字15 | `udf_no15` | float |  |
| `JCA995` | 自定数字16 | `udf_no16` | float |  |
| `JCA950` | 送审时间 | `submission_time_for_review` | string |  |
| `JCA951` | 审批时间1 | `approval_time1` | string |  |
| `JCA952` | 审批时间2 | `approval_time2` | string |  |
| `JCA953` | 审批时间3 | `approval_time3` | string |  |
| `JCA954` | 审批时间4 | `approval_time4` | string |  |
| `JCA955` | 审批时间5 | `approval_time5` | string |  |
| `JCA956` | 审批时间6 | `approval_time6` | string |  |
| `JCA957` | 终审时间 | `final_review_time` | string |  |
| `JCA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKJCB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JCB001` | 单号 | `JCB001` | string |  |
| `JCB002` | 序号 | `JCB002` | string |  |
| `JCB003` | 品号 | `JCB003` | string |  |
| `JCB004` | 品名 | `JCB004` | string |  |
| `JCB005` | 单位 | `JCB005` | string |  |
| `JCB006` | 数量 | `JCB006` | float |  |
| `JCB007` | 验收数量 | `JCB007` | float |  |
| `JCB008` | 验退数量 | `JCB008` | float |  |
| `JCB009` | 前置来源 | `JCB009` | string |  |
| `JCB010` | 前置单据 | `JCB010` | string |  |
| `JCB011` | 前置序号 | `JCB011` | string |  |
| `JCB012` | 审核码 | `JCB012` | string |  |
| `JCB013` | 预留字段 | `JCB013` | string |  |
| `JCB014` | 赠品 | `JCB014` | string |  |
| `JCB015` | 预留字段 | `JCB015` | string |  |
| `JCB016` | 预留字段 | `JCB016` | string |  |
| `JCB017` | 预留字段 | `JCB017` | string |  |
| `JCB018` | 预留字段 | `JCB018` | string |  |
| `JCB019` | 预留字段 | `JCB019` | float |  |
| `JCB020` | 预留字段 | `JCB020` | float |  |
| `JCB021` | 换算分子 | `JCB021` | float |  |
| `JCB022` | 换算分母 | `JCB022` | float |  |
| `JCB023` | 辅助单位 | `JCB023` | string |  |
| `JCB024` | 辅助数量 | `JCB024` | float |  |
| `JCB025` | 规格 | `JCB025` | string |  |
| `JCB026` | 供应商发货序号 | `JCB026` | string |  |
| `JCB901` | 录入者编号 | `entry_person_no` | string |  |
| `JCB902` | 录入时间 | `entry_time` | string |  |
| `JCB903` | 更改者编号 | `changer_no` | string |  |
| `JCB904` | 更改时间 | `change_time` | string |  |
| `JCB905` | 更新标记 | `update_flag` | integer |  |
| `JCB960` | 自定文字1 | `udf_text1` | string |  |
| `JCB961` | 自定文字2 | `udf_text2` | string |  |
| `JCB962` | 自定文字3 | `udf_text3` | string |  |
| `JCB963` | 自定文字4 | `udf_text4` | string |  |
| `JCB964` | 自定文字5 | `udf_text5` | string |  |
| `JCB965` | 自定文字6 | `udf_text6` | string |  |
| `JCB966` | 自定文字7 | `udf_text7` | string |  |
| `JCB967` | 自定文字8 | `udf_text8` | string |  |
| `JCB968` | 自定文字9 | `udf_text9` | string |  |
| `JCB969` | 自定文字10 | `udf_text10` | string |  |
| `JCB970` | 自定文字11 | `udf_text11` | string |  |
| `JCB971` | 自定文字12 | `udf_text12` | string |  |
| `JCB972` | 自定文字13 | `udf_text13` | string |  |
| `JCB973` | 自定文字14 | `udf_text14` | string |  |
| `JCB974` | 自定文字15 | `udf_text15` | string |  |
| `JCB975` | 自定文字16 | `udf_text16` | string |  |
| `JCB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `JCB980` | 自定数字1 | `udf_no1` | float |  |
| `JCB981` | 自定数字2 | `udf_no2` | float |  |
| `JCB982` | 自定数字3 | `udf_no3` | float |  |
| `JCB983` | 自定数字4 | `udf_no4` | float |  |
| `JCB984` | 自定数字5 | `udf_no5` | float |  |
| `JCB985` | 自定数字6 | `udf_no6` | float |  |
| `JCB986` | 自定数字7 | `udf_no7` | float |  |
| `JCB987` | 自定数字8 | `udf_no8` | float |  |
| `JCB988` | 自定数字9 | `udf_no9` | float |  |
| `JCB989` | 自定数字10 | `udf_no10` | float |  |
| `JCB990` | 自定数字11 | `udf_no11` | float |  |
| `JCB991` | 自定数字12 | `udf_no12` | float |  |
| `JCB992` | 自定数字13 | `udf_no13` | float |  |
| `JCB993` | 自定数字14 | `udf_no14` | float |  |
| `JCB994` | 自定数字15 | `udf_no15` | float |  |
| `JCB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "JCA001": ""
  ,"JCA002": ""
  ,"JCA003": ""
  ,"JCA004": ""
  ,"cdsDetail": [{
    "JCB001": ""
    ,"JCB001": ""
    ,"JCB002": ""
    ,"JCB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"JCA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"JCA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `JCA001` | `JCA001` | 单号 | 主键 |
| `JCA002` | `JCA002` | 性质 | |
| `JCA003` | `JCA003` | 日期 | |
| `JCA004` | `JCA004` | 供应商 | |
| `JCA005` | `JCA005` | 经办人 | |
| `JCA006` | `JCA006` | 部门 | |
| `JCA007` | `JCA007` | 专案 | |
| `JCA008` | `JCA008` | 复核编号 | |
| `JCA009` | `JCA009` | 复核姓名 | |
| `JCA010` | `JCA010` | 备注 | |
| `JCB001` | `JCB001` | 单号 (单身) | |
| `JCB002` | `JCB002` | 序号 (单身) | |
| `JCB003` | `JCB003` | 品号 (单身) | |
| `JCB004` | `JCB004` | 品名 (单身) | |
| `JCB005` | `JCB005` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `JCA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `JCA001`
