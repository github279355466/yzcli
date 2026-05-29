# CLI 规格说明书：委外收料单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `outsourcing.purchase.arrival` |
| **DLL** | `QMSCC04` |
| **服务名称** | `委外收料单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.arrival" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.arrival" \
  --action "getMultiple" \
  --data '{"datakeys":[{"MBA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.arrival" \
  --action "create" \
  --data '{"MBA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "outsourcing.purchase.arrival" \
  --action "approve" \
  --data '{"datakeys":[{"MBA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `MBA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (QMSMBA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MBA001` | 单号 | `MBA001` | string | 主键 |
| `MBA002` | 性质 | `MBA002` | string |  |
| `MBA003` | 日期 | `MBA003` | string |  |
| `MBA004` | 供应商 | `MBA004` | string |  |
| `MBA005` | 经办人 | `MBA005` | string |  |
| `MBA006` | 部门 | `MBA006` | string |  |
| `MBA007` | 项目 | `MBA007` | string |  |
| `MBA008` | 审核码 | `MBA008` | string |  |
| `MBA009` | 审核人 | `MBA009` | string |  |
| `MBA010` | 审核时间 | `MBA010` | string |  |
| `MBA011` | 备注 | `MBA011` | string |  |
| `MBA012` | 预留字段 | `MBA012` | string |  |
| `MBA013` | 预留字段 | `MBA013` | string |  |
| `MBA014` | 预留字段 | `MBA014` | string |  |
| `MBA015` | 预留字段 | `MBA015` | string |  |
| `MBA016` | 预留字段 | `MBA016` | float |  |
| `MBA017` | 预留字段 | `MBA017` | float |  |
| `MBA018` | 供应商发货单号 | `MBA018` | string |  |
| `MBA901` | 录入者编号 | `entry_person_no` | string |  |
| `MBA902` | 录入时间 | `entry_time` | string |  |
| `MBA903` | 更改者编号 | `changer_no` | string |  |
| `MBA904` | 更改时间 | `change_time` | string |  |
| `MBA905` | 更新标记 | `update_flag` | integer |  |
| `MBA906` | 打印次数 | `print_count` | integer |  |
| `MBA907` | 打印时间 | `print_time` | string |  |
| `MBA908` | 打印人员 | `printer` | string |  |
| `MBA909` | 打印人员姓名 | `printer_name` | string |  |
| `MBA910` | 送审状态 | `submission_status` | string |  |
| `MBA911` | 送审人 | `reviewer` | string |  |
| `MBA912` | 审批人1 | `approver1` | string |  |
| `MBA913` | 审批结果 | `approval_result1` | string |  |
| `MBA914` | 审批意见 | `approval_opinion1` | string |  |
| `MBA915` | 审批人2 | `approver2` | string |  |
| `MBA916` | 审批结果 | `approval_result2` | string |  |
| `MBA917` | 审批意见 | `approval_opinion2` | string |  |
| `MBA918` | 审批人3 | `approver3` | string |  |
| `MBA919` | 审批结果 | `approval_result3` | string |  |
| `MBA920` | 审批意见 | `approval_opinion3` | string |  |
| `MBA921` | 审批人4 | `approver4` | string |  |
| `MBA922` | 审批结果 | `approval_result4` | string |  |
| `MBA923` | 审批意见 | `approval_opinion4` | string |  |
| `MBA924` | 审批人5 | `approver5` | string |  |
| `MBA925` | 审批结果 | `approval_result5` | string |  |
| `MBA926` | 审批意见 | `approval_opinion5` | string |  |
| `MBA927` | 审批人6 | `approver6` | string |  |
| `MBA928` | 审批结果 | `approval_result6` | string |  |
| `MBA929` | 审批意见 | `approval_opinion6` | string |  |
| `MBA930` | 终审人 | `final_approver` | string |  |
| `MBA931` | 审批结果 | `approval_result7` | string |  |
| `MBA932` | 审批意见 | `approval_opinion7` | string |  |
| `MBA933` | 通知人1 | `notifier1` | string |  |
| `MBA934` | 通知人2 | `notifier2` | string |  |
| `MBA935` | 通知人3 | `notifier3` | string |  |
| `MBA960` | 自定文字1 | `udf_text1` | string |  |
| `MBA961` | 自定文字2 | `udf_text2` | string |  |
| `MBA962` | 自定文字3 | `udf_text3` | string |  |
| `MBA963` | 自定文字4 | `udf_text4` | string |  |
| `MBA964` | 自定文字5 | `udf_text5` | string |  |
| `MBA965` | 自定文字6 | `udf_text6` | string |  |
| `MBA966` | 自定文字7 | `udf_text7` | string |  |
| `MBA967` | 自定文字8 | `udf_text8` | string |  |
| `MBA968` | 自定文字9 | `udf_text9` | string |  |
| `MBA969` | 自定文字10 | `udf_text10` | string |  |
| `MBA970` | 自定文字11 | `udf_text11` | string |  |
| `MBA971` | 自定文字12 | `udf_text12` | string |  |
| `MBA972` | 自定文字13 | `udf_text13` | string |  |
| `MBA973` | 自定文字14 | `udf_text14` | string |  |
| `MBA974` | 自定文字15 | `udf_text15` | string |  |
| `MBA975` | 自定文字16 | `udf_text16` | string |  |
| `MBA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `MBA980` | 自定数字1 | `udf_no1` | float |  |
| `MBA981` | 自定数字2 | `udf_no2` | float |  |
| `MBA982` | 自定数字3 | `udf_no3` | float |  |
| `MBA983` | 自定数字4 | `udf_no4` | float |  |
| `MBA984` | 自定数字5 | `udf_no5` | float |  |
| `MBA985` | 自定数字6 | `udf_no6` | float |  |
| `MBA986` | 自定数字7 | `udf_no7` | float |  |
| `MBA987` | 自定数字8 | `udf_no8` | float |  |
| `MBA988` | 自定数字9 | `udf_no9` | float |  |
| `MBA989` | 自定数字10 | `udf_no10` | float |  |
| `MBA990` | 自定数字11 | `udf_no11` | float |  |
| `MBA991` | 自定数字12 | `udf_no12` | float |  |
| `MBA992` | 自定数字13 | `udf_no13` | float |  |
| `MBA993` | 自定数字14 | `udf_no14` | float |  |
| `MBA994` | 自定数字15 | `udf_no15` | float |  |
| `MBA995` | 自定数字16 | `udf_no16` | float |  |
| `MBA950` | 送审时间 | `submission_time_for_review` | string |  |
| `MBA951` | 审批时间1 | `approval_time1` | string |  |
| `MBA952` | 审批时间2 | `approval_time2` | string |  |
| `MBA953` | 审批时间3 | `approval_time3` | string |  |
| `MBA954` | 审批时间4 | `approval_time4` | string |  |
| `MBA955` | 审批时间5 | `approval_time5` | string |  |
| `MBA956` | 审批时间6 | `approval_time6` | string |  |
| `MBA957` | 终审时间 | `final_review_time` | string |  |
| `MBA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (QMSMBB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MBB001` | 单号 | `MBB001` | string |  |
| `MBB002` | 序号 | `MBB002` | string |  |
| `MBB003` | 品号 | `MBB003` | string |  |
| `MBB004` | 品名 | `MBB004` | string |  |
| `MBB005` | 规格 | `MBB005` | string |  |
| `MBB006` | 单位 | `MBB006` | string |  |
| `MBB007` | 数量 | `MBB007` | float |  |
| `MBB008` | 验收数量 | `MBB008` | float |  |
| `MBB009` | 验退数量 | `MBB009` | float |  |
| `MBB010` | 前置来源 | `MBB010` | string |  |
| `MBB011` | 前置单号 | `MBB011` | string |  |
| `MBB012` | 前置序号 | `MBB012` | string |  |
| `MBB013` | 备注 | `MBB013` | string |  |
| `MBB014` | 审核码 | `MBB014` | string |  |
| `MBB015` | 预留字段 | `MBB015` | string |  |
| `MBB016` | 预留字段 | `MBB016` | string |  |
| `MBB017` | 预留字段 | `MBB017` | string |  |
| `MBB018` | 预留字段 | `MBB018` | string |  |
| `MBB019` | 预留字段 | `MBB019` | float |  |
| `MBB020` | 预留字段 | `MBB020` | float |  |
| `MBB021` | 换算分子 | `MBB021` | float |  |
| `MBB022` | 换算分母 | `MBB022` | float |  |
| `MBB023` | 库存单位 | `MBB023` | string |  |
| `MBB024` | 库存单位数量 | `MBB024` | float |  |
| `MBB025` | 供应商发货序号 | `MBB025` | string |  |
| `MBB901` | 录入者编号 | `entry_person_no` | string |  |
| `MBB902` | 录入时间 | `entry_time` | string |  |
| `MBB903` | 更改者编号 | `changer_no` | string |  |
| `MBB904` | 更改时间 | `change_time` | string |  |
| `MBB905` | 更新标记 | `update_flag` | integer |  |
| `MBB960` | 自定文字1 | `udf_text1` | string |  |
| `MBB961` | 自定文字2 | `udf_text2` | string |  |
| `MBB962` | 自定文字3 | `udf_text3` | string |  |
| `MBB963` | 自定文字4 | `udf_text4` | string |  |
| `MBB964` | 自定文字5 | `udf_text5` | string |  |
| `MBB965` | 自定文字6 | `udf_text6` | string |  |
| `MBB966` | 自定文字7 | `udf_text7` | string |  |
| `MBB967` | 自定文字8 | `udf_text8` | string |  |
| `MBB968` | 自定文字9 | `udf_text9` | string |  |
| `MBB969` | 自定文字10 | `udf_text10` | string |  |
| `MBB970` | 自定文字11 | `udf_text11` | string |  |
| `MBB971` | 自定文字12 | `udf_text12` | string |  |
| `MBB972` | 自定文字13 | `udf_text13` | string |  |
| `MBB973` | 自定文字14 | `udf_text14` | string |  |
| `MBB974` | 自定文字15 | `udf_text15` | string |  |
| `MBB975` | 自定文字16 | `udf_text16` | string |  |
| `MBB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `MBB980` | 自定数字1 | `udf_no1` | float |  |
| `MBB981` | 自定数字2 | `udf_no2` | float |  |
| `MBB982` | 自定数字3 | `udf_no3` | float |  |
| `MBB983` | 自定数字4 | `udf_no4` | float |  |
| `MBB984` | 自定数字5 | `udf_no5` | float |  |
| `MBB985` | 自定数字6 | `udf_no6` | float |  |
| `MBB986` | 自定数字7 | `udf_no7` | float |  |
| `MBB987` | 自定数字8 | `udf_no8` | float |  |
| `MBB988` | 自定数字9 | `udf_no9` | float |  |
| `MBB989` | 自定数字10 | `udf_no10` | float |  |
| `MBB990` | 自定数字11 | `udf_no11` | float |  |
| `MBB991` | 自定数字12 | `udf_no12` | float |  |
| `MBB992` | 自定数字13 | `udf_no13` | float |  |
| `MBB993` | 自定数字14 | `udf_no14` | float |  |
| `MBB994` | 自定数字15 | `udf_no15` | float |  |
| `MBB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "MBA001": ""
  ,"MBA002": ""
  ,"MBA003": ""
  ,"MBA004": ""
  ,"cdsDetail": [{
    "MBB001": ""
    ,"MBB001": ""
    ,"MBB002": ""
    ,"MBB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"MBA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"MBA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `MBA001` | `MBA001` | 单号 | 主键 |
| `MBA002` | `MBA002` | 性质 | |
| `MBA003` | `MBA003` | 日期 | |
| `MBA004` | `MBA004` | 供应商 | |
| `MBA005` | `MBA005` | 经办人 | |
| `MBA006` | `MBA006` | 部门 | |
| `MBA007` | `MBA007` | 项目 | |
| `MBA008` | `MBA008` | 审核码 | |
| `MBA009` | `MBA009` | 审核人 | |
| `MBA010` | `MBA010` | 审核时间 | |
| `MBB001` | `MBB001` | 单号 (单身) | |
| `MBB002` | `MBB002` | 序号 (单身) | |
| `MBB003` | `MBB003` | 品号 (单身) | |
| `MBB004` | `MBB004` | 品名 (单身) | |
| `MBB005` | `MBB005` | 规格 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `MBA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `MBA001`
