# CLI 规格说明书：进货检验单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `purchase.arrival.inspection` |
| **DLL** | `QMSCC02` |
| **服务名称** | `进货检验单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.arrival.inspection" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.arrival.inspection" \
  --action "getMultiple" \
  --data '{"datakeys":[{"MFA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.arrival.inspection" \
  --action "create" \
  --data '{"MFA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.arrival.inspection" \
  --action "approve" \
  --data '{"datakeys":[{"MFA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `MFA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (QMSMFA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MFA001` | 单号 | `MFA001` | string | 主键 |
| `MFA002` | 性质 | `MFA002` | string |  |
| `MFA003` | 日期 | `MFA003` | string |  |
| `MFA004` | 供应商 | `MFA004` | string |  |
| `MFA005` | 经办人 | `MFA005` | string |  |
| `MFA006` | 部门 | `MFA006` | string |  |
| `MFA007` | 项目 | `MFA007` | string |  |
| `MFA008` | 审核码 | `MFA008` | string |  |
| `MFA009` | 审核人 | `MFA009` | string |  |
| `MFA010` | 审核时间 | `MFA010` | string |  |
| `MFA011` | 备注 | `MFA011` | string |  |
| `MFA012` | 预留字段 | `MFA012` | string |  |
| `MFA013` | 预留字段 | `MFA013` | string |  |
| `MFA014` | 预留字段 | `MFA014` | string |  |
| `MFA015` | 预留字段 | `MFA015` | string |  |
| `MFA016` | 预留字段 | `MFA016` | float |  |
| `MFA017` | 预留字段 | `MFA017` | float |  |
| `MFA901` | 录入者编号 | `entry_person_no` | string |  |
| `MFA902` | 录入时间 | `entry_time` | string |  |
| `MFA903` | 更改者编号 | `changer_no` | string |  |
| `MFA904` | 更改时间 | `change_time` | string |  |
| `MFA905` | 更新标记 | `update_flag` | integer |  |
| `MFA906` | 打印次数 | `print_count` | integer |  |
| `MFA907` | 打印时间 | `print_time` | string |  |
| `MFA908` | 打印人员 | `printer` | string |  |
| `MFA909` | 打印人员姓名 | `printer_name` | string |  |
| `MFA910` | 送审状态 | `submission_status` | string |  |
| `MFA911` | 送审人 | `reviewer` | string |  |
| `MFA912` | 审批人1 | `approver1` | string |  |
| `MFA913` | 审批结果 | `approval_result1` | string |  |
| `MFA914` | 审批意见 | `approval_opinion1` | string |  |
| `MFA915` | 审批人2 | `approver2` | string |  |
| `MFA916` | 审批结果 | `approval_result2` | string |  |
| `MFA917` | 审批意见 | `approval_opinion2` | string |  |
| `MFA918` | 审批人3 | `approver3` | string |  |
| `MFA919` | 审批结果 | `approval_result3` | string |  |
| `MFA920` | 审批意见 | `approval_opinion3` | string |  |
| `MFA921` | 审批人4 | `approver4` | string |  |
| `MFA922` | 审批结果 | `approval_result4` | string |  |
| `MFA923` | 审批意见 | `approval_opinion4` | string |  |
| `MFA924` | 审批人5 | `approver5` | string |  |
| `MFA925` | 审批结果 | `approval_result5` | string |  |
| `MFA926` | 审批意见 | `approval_opinion5` | string |  |
| `MFA927` | 审批人6 | `approver6` | string |  |
| `MFA928` | 审批结果 | `approval_result6` | string |  |
| `MFA929` | 审批意见 | `approval_opinion6` | string |  |
| `MFA930` | 终审人 | `final_approver` | string |  |
| `MFA931` | 审批结果 | `approval_result7` | string |  |
| `MFA932` | 审批意见 | `approval_opinion7` | string |  |
| `MFA933` | 通知人1 | `notifier1` | string |  |
| `MFA934` | 通知人2 | `notifier2` | string |  |
| `MFA935` | 通知人3 | `notifier3` | string |  |
| `MFA960` | 自定文字1 | `udf_text1` | string |  |
| `MFA961` | 自定文字2 | `udf_text2` | string |  |
| `MFA962` | 自定文字3 | `udf_text3` | string |  |
| `MFA963` | 自定文字4 | `udf_text4` | string |  |
| `MFA964` | 自定文字5 | `udf_text5` | string |  |
| `MFA965` | 自定文字6 | `udf_text6` | string |  |
| `MFA966` | 自定文字7 | `udf_text7` | string |  |
| `MFA967` | 自定文字8 | `udf_text8` | string |  |
| `MFA968` | 自定文字9 | `udf_text9` | string |  |
| `MFA969` | 自定文字10 | `udf_text10` | string |  |
| `MFA970` | 自定文字11 | `udf_text11` | string |  |
| `MFA971` | 自定文字12 | `udf_text12` | string |  |
| `MFA972` | 自定文字13 | `udf_text13` | string |  |
| `MFA973` | 自定文字14 | `udf_text14` | string |  |
| `MFA974` | 自定文字15 | `udf_text15` | string |  |
| `MFA975` | 自定文字16 | `udf_text16` | string |  |
| `MFA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `MFA980` | 自定数字1 | `udf_no1` | float |  |
| `MFA981` | 自定数字2 | `udf_no2` | float |  |
| `MFA982` | 自定数字3 | `udf_no3` | float |  |
| `MFA983` | 自定数字4 | `udf_no4` | float |  |
| `MFA984` | 自定数字5 | `udf_no5` | float |  |
| `MFA985` | 自定数字6 | `udf_no6` | float |  |
| `MFA986` | 自定数字7 | `udf_no7` | float |  |
| `MFA987` | 自定数字8 | `udf_no8` | float |  |
| `MFA988` | 自定数字9 | `udf_no9` | float |  |
| `MFA989` | 自定数字10 | `udf_no10` | float |  |
| `MFA990` | 自定数字11 | `udf_no11` | float |  |
| `MFA991` | 自定数字12 | `udf_no12` | float |  |
| `MFA992` | 自定数字13 | `udf_no13` | float |  |
| `MFA993` | 自定数字14 | `udf_no14` | float |  |
| `MFA994` | 自定数字15 | `udf_no15` | float |  |
| `MFA995` | 自定数字16 | `udf_no16` | float |  |
| `MFA950` | 送审时间 | `submission_time_for_review` | string |  |
| `MFA951` | 审批时间1 | `approval_time1` | string |  |
| `MFA952` | 审批时间2 | `approval_time2` | string |  |
| `MFA953` | 审批时间3 | `approval_time3` | string |  |
| `MFA954` | 审批时间4 | `approval_time4` | string |  |
| `MFA955` | 审批时间5 | `approval_time5` | string |  |
| `MFA956` | 审批时间6 | `approval_time6` | string |  |
| `MFA957` | 终审时间 | `final_review_time` | string |  |
| `MFA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (QMSMFB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `MFB001` | 单号 | `MFB001` | string |  |
| `MFB002` | 序号 | `MFB002` | string |  |
| `MFB003` | 检验类型 | `MFB003` | string |  |
| `MFB004` | 检验说明 | `MFB004` | string |  |
| `MFB005` | 收料单号 | `MFB005` | string |  |
| `MFB006` | 收料序号 | `MFB006` | string |  |
| `MFB007` | 品号 | `MFB007` | string |  |
| `MFB008` | 品名 | `MFB008` | string |  |
| `MFB009` | 规格 | `MFB009` | string |  |
| `MFB010` | 检验数量 | `MFB010` | float |  |
| `MFB011` | 验收数量 | `MFB011` | float |  |
| `MFB012` | 验退数量 | `MFB012` | float |  |
| `MFB013` | 换算分子 | `MFB013` | float |  |
| `MFB014` | 换算分母 | `MFB014` | float |  |
| `MFB015` | 辅助单位 | `MFB015` | string |  |
| `MFB016` | 辅助数量 | `MFB016` | float |  |
| `MFB017` | 已交量 | `MFB017` | float |  |
| `MFB018` | 已验退退回量 | `MFB018` | float |  |
| `MFB019` | 备注 | `MFB019` | string |  |
| `MFB020` | 审核码 | `MFB020` | string |  |
| `MFB021` | 单位 | `MFB021` | string |  |
| `MFB022` | 预留字段 | `MFB022` | string |  |
| `MFB023` | 预留字段 | `MFB023` | string |  |
| `MFB024` | 预留字段 | `MFB024` | string |  |
| `MFB025` | 预留字段 | `MFB025` | string |  |
| `MFB026` | 预留字段 | `MFB026` | float |  |
| `MFB027` | 预留字段 | `MFB027` | float |  |
| `MFB901` | 录入者编号 | `entry_person_no` | string |  |
| `MFB902` | 录入时间 | `entry_time` | string |  |
| `MFB903` | 更改者编号 | `changer_no` | string |  |
| `MFB904` | 更改时间 | `change_time` | string |  |
| `MFB905` | 更新标记 | `update_flag` | integer |  |
| `MFB960` | 自定文字1 | `udf_text1` | string |  |
| `MFB961` | 自定文字2 | `udf_text2` | string |  |
| `MFB962` | 自定文字3 | `udf_text3` | string |  |
| `MFB963` | 自定文字4 | `udf_text4` | string |  |
| `MFB964` | 自定文字5 | `udf_text5` | string |  |
| `MFB965` | 自定文字6 | `udf_text6` | string |  |
| `MFB966` | 自定文字7 | `udf_text7` | string |  |
| `MFB967` | 自定文字8 | `udf_text8` | string |  |
| `MFB968` | 自定文字9 | `udf_text9` | string |  |
| `MFB969` | 自定文字10 | `udf_text10` | string |  |
| `MFB970` | 自定文字11 | `udf_text11` | string |  |
| `MFB971` | 自定文字12 | `udf_text12` | string |  |
| `MFB972` | 自定文字13 | `udf_text13` | string |  |
| `MFB973` | 自定文字14 | `udf_text14` | string |  |
| `MFB974` | 自定文字15 | `udf_text15` | string |  |
| `MFB975` | 自定文字16 | `udf_text16` | string |  |
| `MFB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `MFB980` | 自定数字1 | `udf_no1` | float |  |
| `MFB981` | 自定数字2 | `udf_no2` | float |  |
| `MFB982` | 自定数字3 | `udf_no3` | float |  |
| `MFB983` | 自定数字4 | `udf_no4` | float |  |
| `MFB984` | 自定数字5 | `udf_no5` | float |  |
| `MFB985` | 自定数字6 | `udf_no6` | float |  |
| `MFB986` | 自定数字7 | `udf_no7` | float |  |
| `MFB987` | 自定数字8 | `udf_no8` | float |  |
| `MFB988` | 自定数字9 | `udf_no9` | float |  |
| `MFB989` | 自定数字10 | `udf_no10` | float |  |
| `MFB990` | 自定数字11 | `udf_no11` | float |  |
| `MFB991` | 自定数字12 | `udf_no12` | float |  |
| `MFB992` | 自定数字13 | `udf_no13` | float |  |
| `MFB993` | 自定数字14 | `udf_no14` | float |  |
| `MFB994` | 自定数字15 | `udf_no15` | float |  |
| `MFB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "MFA001": ""
  ,"MFA002": ""
  ,"MFA003": ""
  ,"MFA004": ""
  ,"cdsDetail": [{
    "MFB001": ""
    ,"MFB001": ""
    ,"MFB002": ""
    ,"MFB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"MFA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"MFA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `MFA001` | `MFA001` | 单号 | 主键 |
| `MFA002` | `MFA002` | 性质 | |
| `MFA003` | `MFA003` | 日期 | |
| `MFA004` | `MFA004` | 供应商 | |
| `MFA005` | `MFA005` | 经办人 | |
| `MFA006` | `MFA006` | 部门 | |
| `MFA007` | `MFA007` | 项目 | |
| `MFA008` | `MFA008` | 审核码 | |
| `MFA009` | `MFA009` | 审核人 | |
| `MFA010` | `MFA010` | 审核时间 | |
| `MFB001` | `MFB001` | 单号 (单身) | |
| `MFB002` | `MFB002` | 序号 (单身) | |
| `MFB003` | `MFB003` | 检验类型 (单身) | |
| `MFB004` | `MFB004` | 检验说明 (单身) | |
| `MFB005` | `MFB005` | 收料单号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `MFA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `MFA001`
