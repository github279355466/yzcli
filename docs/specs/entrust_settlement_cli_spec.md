# CLI 规格说明书：委托结算单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `entrust.settlement` |
| **DLL** | `COPSC07` |
| **服务名称** | `委托结算单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "entrust.settlement" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "entrust.settlement" \
  --action "getMultiple" \
  --data '{"datakeys":[{"KIA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "entrust.settlement" \
  --action "create" \
  --data '{"KIA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "entrust.settlement" \
  --action "approve" \
  --data '{"datakeys":[{"KIA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `KIA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKKIA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `KIA001` | 单号 | `KIA001` | string | 主键 |
| `KIA002` | 性质 | `KIA002` | string |  |
| `KIA003` | 日期 | `KIA003` | string |  |
| `KIA004` | 客户 | `KIA004` | string |  |
| `KIA005` | 请款客户 | `KIA005` | string |  |
| `KIA006` | 业务员 | `KIA006` | string |  |
| `KIA007` | 部门 | `KIA007` | string |  |
| `KIA008` | 币种 | `KIA008` | string |  |
| `KIA009` | 汇率 | `KIA009` | float |  |
| `KIA010` | 项目 | `KIA010` | string |  |
| `KIA011` | 邮编 | `KIA011` | string |  |
| `KIA012` | 地址 | `KIA012` | string |  |
| `KIA013` | 预结帐日 | `KIA013` | string |  |
| `KIA014` | 预收款日 | `KIA014` | string |  |
| `KIA015` | 备注 | `KIA015` | string |  |
| `KIA016` | 审核码 | `KIA016` | string |  |
| `KIA017` | 审核人 | `KIA017` | string |  |
| `KIA018` | 审核时间 | `KIA018` | string |  |
| `KIA019` | 预留字段 | `KIA019` | string |  |
| `KIA020` | 预留字段 | `KIA020` | string |  |
| `KIA021` | 预留字段 | `KIA021` | string |  |
| `KIA022` | 预留字段 | `KIA022` | string |  |
| `KIA023` | 预留字段 | `KIA023` | float |  |
| `KIA024` | 预留字段 | `KIA024` | float |  |
| `KIA025` | 无税金额 | `KIA025` | float |  |
| `KIA026` | 税额 | `KIA026` | float |  |
| `KIA027` | 价税合计 | `KIA027` | float |  |
| `KIA028` | 本币无税金额 | `KIA028` | float |  |
| `KIA029` | 本币税额 | `KIA029` | float |  |
| `KIA030` | 本币价税合计 | `KIA030` | float |  |
| `KIA031` | 已收金额 | `KIA031` | string |  |
| `KIA032` | 本币已收金额 | `KIA032` | string |  |
| `KIA033` | 直接生成发票 | `KIA033` | string |  |
| `KIA034` | 发票号码 | `KIA034` | string |  |
| `KIA035` | 购买票据否 | `KIA035` | string |  |
| `KIA036` | 发票种类 | `KIA036` | string |  |
| `KIA037` | 现结 | `KIA037` | string |  |
| `KIA038` | 结算方式 | `KIA038` | string |  |
| `KIA039` | 票据号码 | `KIA039` | string |  |
| `KIA040` | 银行账号 | `KIA040` | string |  |
| `KIA041` | 收款单号 | `KIA041` | string |  |
| `KIA940` | 签核码 | `approval_code` | string |  |
| `KIA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `KIA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `KIA042` | 结算科目 | `KIA042` | string |  |
| `KIA901` | 录入者编号 | `entry_person_no` | string |  |
| `KIA902` | 录入时间 | `entry_time` | string |  |
| `KIA903` | 更改者编号 | `changer_no` | string |  |
| `KIA904` | 更改时间 | `change_time` | string |  |
| `KIA905` | 更新标记 | `update_flag` | integer |  |
| `KIA960` | 自定文字1 | `udf_text1` | string |  |
| `KIA961` | 自定文字2 | `udf_text2` | string |  |
| `KIA962` | 自定文字3 | `udf_text3` | string |  |
| `KIA963` | 自定文字4 | `udf_text4` | string |  |
| `KIA964` | 自定文字5 | `udf_text5` | string |  |
| `KIA965` | 自定文字6 | `udf_text6` | string |  |
| `KIA980` | 自定数字1 | `udf_no1` | float |  |
| `KIA981` | 自定数字2 | `udf_no2` | float |  |
| `KIA982` | 自定数字3 | `udf_no3` | float |  |
| `KIA983` | 自定数字4 | `udf_no4` | float |  |
| `KIA984` | 自定数字5 | `udf_no5` | float |  |
| `KIA985` | 自定数字6 | `udf_no6` | float |  |
| `KIA910` | 送审状态 | `submission_status` | string |  |
| `KIA911` | 送审人 | `reviewer` | string |  |
| `KIA912` | 审批人1 | `approver1` | string |  |
| `KIA913` | 审批结果 | `approval_result1` | string |  |
| `KIA914` | 审批意见 | `approval_opinion1` | string |  |
| `KIA915` | 审批人2 | `approver2` | string |  |
| `KIA916` | 审批结果 | `approval_result2` | string |  |
| `KIA917` | 审批意见 | `approval_opinion2` | string |  |
| `KIA918` | 审批人3 | `approver3` | string |  |
| `KIA919` | 审批结果 | `approval_result3` | string |  |
| `KIA920` | 审批意见 | `approval_opinion3` | string |  |
| `KIA921` | 审批人4 | `approver4` | string |  |
| `KIA922` | 审批结果 | `approval_result4` | string |  |
| `KIA923` | 审批意见 | `approval_opinion4` | string |  |
| `KIA924` | 审批人5 | `approver5` | string |  |
| `KIA925` | 审批结果 | `approval_result5` | string |  |
| `KIA926` | 审批意见 | `approval_opinion5` | string |  |
| `KIA927` | 审批人6 | `approver6` | string |  |
| `KIA928` | 审批结果 | `approval_result6` | string |  |
| `KIA929` | 审批意见 | `approval_opinion6` | string |  |
| `KIA930` | 终审人 | `final_approver` | string |  |
| `KIA931` | 审批结果 | `approval_result7` | string |  |
| `KIA932` | 审批意见 | `approval_opinion7` | string |  |
| `KIA933` | 通知人1 | `notifier1` | string |  |
| `KIA934` | 通知人2 | `notifier2` | string |  |
| `KIA935` | 通知人3 | `notifier3` | string |  |
| `KIA966` | 自定文字7 | `udf_text7` | string |  |
| `KIA967` | 自定文字8 | `udf_text8` | string |  |
| `KIA968` | 自定文字9 | `udf_text9` | string |  |
| `KIA969` | 自定文字10 | `udf_text10` | string |  |
| `KIA970` | 自定文字11 | `udf_text11` | string |  |
| `KIA971` | 自定文字12 | `udf_text12` | string |  |
| `KIA972` | 自定文字13 | `udf_text13` | string |  |
| `KIA973` | 自定文字14 | `udf_text14` | string |  |
| `KIA974` | 自定文字15 | `udf_text15` | string |  |
| `KIA975` | 自定文字16 | `udf_text16` | string |  |
| `KIA986` | 自定数字7 | `udf_no7` | float |  |
| `KIA987` | 自定数字8 | `udf_no8` | float |  |
| `KIA988` | 自定数字9 | `udf_no9` | float |  |
| `KIA989` | 自定数字10 | `udf_no10` | float |  |
| `KIA990` | 自定数字11 | `udf_no11` | float |  |
| `KIA991` | 自定数字12 | `udf_no12` | float |  |
| `KIA992` | 自定数字13 | `udf_no13` | float |  |
| `KIA993` | 自定数字14 | `udf_no14` | float |  |
| `KIA994` | 自定数字15 | `udf_no15` | float |  |
| `KIA995` | 自定数字16 | `udf_no16` | float |  |
| `KIA906` | 打印次数 | `print_count` | integer |  |
| `KIA907` | 打印时间 | `print_time` | string |  |
| `KIA908` | 打印人员 | `printer` | string |  |
| `KIA909` | 打印人员姓名 | `printer_name` | string |  |
| `KIA950` | 送审时间 | `submission_time_for_review` | string |  |
| `KIA951` | 审批时间1 | `approval_time1` | string |  |
| `KIA952` | 审批时间2 | `approval_time2` | string |  |
| `KIA953` | 审批时间3 | `approval_time3` | string |  |
| `KIA954` | 审批时间4 | `approval_time4` | string |  |
| `KIA955` | 审批时间5 | `approval_time5` | string |  |
| `KIA956` | 审批时间6 | `approval_time6` | string |  |
| `KIA957` | 终审时间 | `final_review_time` | string |  |
| `KIA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKKIB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `KIB001` | 单号 | `KIB001` | string |  |
| `KIB002` | 序号 | `KIB002` | string |  |
| `KIB003` | 来源 | `KIB003` | string |  |
| `KIB004` | 来源单号 | `KIB004` | string |  |
| `KIB005` | 来源序号 | `KIB005` | string |  |
| `KIB006` | 品号 | `KIB006` | string |  |
| `KIB007` | 品名 | `KIB007` | string |  |
| `KIB008` | 交易单位 | `KIB008` | string |  |
| `KIB009` | 仓库 | `KIB009` | string |  |
| `KIB010` | 未结算数量 | `KIB010` | float |  |
| `KIB011` | 结算数量 | `KIB011` | float |  |
| `KIB012` | 定价 | `KIB012` | float |  |
| `KIB013` | 折扣率 | `KIB013` | float |  |
| `KIB014` | 含税 | `KIB014` | string |  |
| `KIB015` | 含税单价 | `KIB015` | float |  |
| `KIB016` | 单价 | `KIB016` | float |  |
| `KIB017` | 原币金额 | `KIB017` | string |  |
| `KIB018` | 原币税额 | `KIB018` | string |  |
| `KIB019` | 原币价税合计 | `KIB019` | string |  |
| `KIB020` | 本币金额 | `KIB020` | string |  |
| `KIB021` | 本币税额 | `KIB021` | string |  |
| `KIB022` | 本币价税合计 | `KIB022` | string |  |
| `KIB023` | 税率 | `KIB023` | float |  |
| `KIB024` | 批号 | `KIB024` | string |  |
| `KIB025` | 批号说明 | `KIB025` | string |  |
| `KIB026` | 生产日期 | `KIB026` | string |  |
| `KIB027` | 有效日期 | `KIB027` | string |  |
| `KIB028` | 审核码 | `KIB028` | string |  |
| `KIB029` | 预留字段 | `KIB029` | string |  |
| `KIB030` | 预留字段 | `KIB030` | string |  |
| `KIB031` | 预留字段 | `KIB031` | string |  |
| `KIB032` | 预留字段 | `KIB032` | string |  |
| `KIB033` | 预留字段 | `KIB033` | float |  |
| `KIB034` | 预留字段 | `KIB034` | float |  |
| `KIB035` | 规格 | `KIB035` | string |  |
| `KIB036` | 已开票数量 | `KIB036` | float |  |
| `KIB901` | 录入者编号 | `entry_person_no` | string |  |
| `KIB902` | 录入时间 | `entry_time` | string |  |
| `KIB903` | 更改者编号 | `changer_no` | string |  |
| `KIB904` | 更改时间 | `change_time` | string |  |
| `KIB905` | 更新标记 | `update_flag` | integer |  |
| `KIB960` | 自定文字1 | `udf_text1` | string |  |
| `KIB961` | 自定文字2 | `udf_text2` | string |  |
| `KIB962` | 自定文字3 | `udf_text3` | string |  |
| `KIB963` | 自定文字4 | `udf_text4` | string |  |
| `KIB964` | 自定文字5 | `udf_text5` | string |  |
| `KIB965` | 自定文字6 | `udf_text6` | string |  |
| `KIB980` | 自定数字1 | `udf_no1` | float |  |
| `KIB981` | 自定数字2 | `udf_no2` | float |  |
| `KIB982` | 自定数字3 | `udf_no3` | float |  |
| `KIB983` | 自定数字4 | `udf_no4` | float |  |
| `KIB984` | 自定数字5 | `udf_no5` | float |  |
| `KIB985` | 自定数字6 | `udf_no6` | float |  |
| `KIB966` | 自定文字7 | `udf_text7` | string |  |
| `KIB967` | 自定文字8 | `udf_text8` | string |  |
| `KIB968` | 自定文字9 | `udf_text9` | string |  |
| `KIB969` | 自定文字10 | `udf_text10` | string |  |
| `KIB970` | 自定文字11 | `udf_text11` | string |  |
| `KIB971` | 自定文字12 | `udf_text12` | string |  |
| `KIB972` | 自定文字13 | `udf_text13` | string |  |
| `KIB973` | 自定文字14 | `udf_text14` | string |  |
| `KIB974` | 自定文字15 | `udf_text15` | string |  |
| `KIB975` | 自定文字16 | `udf_text16` | string |  |
| `KIB986` | 自定数字7 | `udf_no7` | float |  |
| `KIB987` | 自定数字8 | `udf_no8` | float |  |
| `KIB988` | 自定数字9 | `udf_no9` | float |  |
| `KIB989` | 自定数字10 | `udf_no10` | float |  |
| `KIB990` | 自定数字11 | `udf_no11` | float |  |
| `KIB991` | 自定数字12 | `udf_no12` | float |  |
| `KIB992` | 自定数字13 | `udf_no13` | float |  |
| `KIB993` | 自定数字14 | `udf_no14` | float |  |
| `KIB994` | 自定数字15 | `udf_no15` | float |  |
| `KIB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (JSKKIC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `KIC001` | 客户 | `KIC001` | string |  |
| `KIC002` | 品号 | `KIC002` | string |  |
| `KIC003` | 数量 | `KIC003` | float |  |
| `KIC004` | 预留字段 | `KIC004` | string |  |
| `KIC005` | 预留字段 | `KIC005` | string |  |
| `KIC006` | 预留字段 | `KIC006` | string |  |
| `KIC007` | 预留字段 | `KIC007` | string |  |
| `KIC008` | 预留字段 | `KIC008` | float |  |
| `KIC009` | 预留字段 | `KIC009` | float |  |
| `KIC901` | 录入者编号 | `entry_person_no` | string |  |
| `KIC902` | 录入时间 | `entry_time` | string |  |
| `KIC903` | 更改者编号 | `changer_no` | string |  |
| `KIC904` | 更改时间 | `change_time` | string |  |
| `KIC905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "KIA001": ""
  ,"KIA002": ""
  ,"KIA003": ""
  ,"KIA004": ""
  ,"cdsDetail": [{
    "KIB001": ""
    ,"KIB001": ""
    ,"KIB002": ""
    ,"KIB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"KIA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"KIA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `KIA001` | `KIA001` | 单号 | 主键 |
| `KIA002` | `KIA002` | 性质 | |
| `KIA003` | `KIA003` | 日期 | |
| `KIA004` | `KIA004` | 客户 | |
| `KIA005` | `KIA005` | 请款客户 | |
| `KIA006` | `KIA006` | 业务员 | |
| `KIA007` | `KIA007` | 部门 | |
| `KIA008` | `KIA008` | 币种 | |
| `KIA009` | `KIA009` | 汇率 | |
| `KIA010` | `KIA010` | 项目 | |
| `KIB001` | `KIB001` | 单号 (单身) | |
| `KIB002` | `KIB002` | 序号 (单身) | |
| `KIB003` | `KIB003` | 来源 (单身) | |
| `KIB004` | `KIB004` | 来源单号 (单身) | |
| `KIB005` | `KIB005` | 来源序号 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `KIA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `KIA001`
