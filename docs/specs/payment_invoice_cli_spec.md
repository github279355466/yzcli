# CLI 规格说明书：付款票据

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `payment.invoice` |
| **DLL** | `PJMFC01` |
| **服务名称** | `付款票据` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "payment.invoice" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "payment.invoice" \
  --action "getMultiple" \
  --data '{"datakeys":[{"PIA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "payment.invoice" \
  --action "create" \
  --data '{"PIA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "payment.invoice" \
  --action "approve" \
  --data '{"datakeys":[{"PIA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `PIA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (PJMPIA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `PIA001` | 票据号码 | `PIA001` | string | 主键 |
| `PIA002` | 性质 | `PIA002` | string |  |
| `PIA003` | 结算方式 | `PIA003` | string |  |
| `PIA004` | 出票日 | `PIA004` | string |  |
| `PIA005` | 到期日 | `PIA005` | string |  |
| `PIA006` | 供应商 | `PIA006` | string |  |
| `PIA007` | 供应商全称 | `PIA007` | string |  |
| `PIA008` | 金额 | `PIA008` | float |  |
| `PIA009` | 实际结算金额 | `PIA009` | float |  |
| `PIA010` | 付款帐号 | `PIA010` | string |  |
| `PIA011` | 利息 | `PIA011` | float |  |
| `PIA012` | 费用 | `PIA012` | float |  |
| `PIA013` | 付款人 | `PIA013` | string |  |
| `PIA014` | 部门 | `PIA014` | string |  |
| `PIA015` | 备注 | `PIA015` | string |  |
| `PIA016` | 前置来源 | `PIA016` | string |  |
| `PIA017` | 前置单号 | `PIA017` | string |  |
| `PIA018` | 前置序号 | `PIA018` | string |  |
| `PIA019` | 票况 | `PIA019` | string |  |
| `PIA020` | 核销码 | `PIA020` | string |  |
| `PIA021` | 审核码 | `PIA021` | string |  |
| `PIA022` | 异动日期 | `PIA022` | string |  |
| `PIA023` | 预留字段 | `PIA023` | string |  |
| `PIA024` | 预留字段 | `PIA024` | string |  |
| `PIA025` | 预留字段 | `PIA025` | string |  |
| `PIA026` | 预留字段 | `PIA026` | string |  |
| `PIA027` | 预留字段 | `PIA027` | string |  |
| `PIA028` | 预留字段 | `PIA028` | string |  |
| `PIA029` | 预留字段 | `PIA029` | string |  |
| `PIA030` | 预留字段 | `PIA030` | string |  |
| `PIA031` | 预留字段 | `PIA031` | string |  |
| `PIA032` | 预留字段 | `PIA032` | string |  |
| `PIA033` | 预留字段 | `PIA033` | string |  |
| `PIA034` | 预留字段 | `PIA034` | string |  |
| `PIA035` | 预留字段 | `PIA035` | string |  |
| `PIA036` | 预留字段 | `PIA036` | string |  |
| `PIA037` | 预留字段 | `PIA037` | float |  |
| `PIA038` | 预留字段 | `PIA038` | string |  |
| `PIA039` | 预留字段 | `PIA039` | string |  |
| `PIA040` | 预留字段 | `PIA040` | string |  |
| `PIA041` | 预留字段 | `PIA041` | string |  |
| `PIA042` | 预留字段 | `PIA042` | float |  |
| `PIA043` | 预留字段 | `PIA043` | float |  |
| `PIA044` | 审核人 | `PIA044` | string |  |
| `PIA045` | 币种 | `PIA045` | string |  |
| `PIA046` | 汇率 | `PIA046` | float |  |
| `PIA047` | 原币金额 | `PIA047` | float |  |
| `PIA048` | 原币结算金额 | `PIA048` | float |  |
| `PIA049` | 付款金额 | `PIA049` | float |  |
| `PIA050` | 收款单位类型 | `PIA050` | string |  |
| `PIA051` | 票据包号 | `PIA051` | string |  |
| `PIA052` | 子票区间起始序号 | `PIA052` | string |  |
| `PIA053` | 子票区间截止序号 | `PIA053` | string |  |
| `PIA054` | 可分包流转标识 | `PIA054` | string |  |
| `PIA055` | 拆分状态标识 | `PIA055` | string |  |
| `PIA056` | 子票标识 | `PIA056` | string |  |
| `PIA057` | 拆分来源票据 | `PIA057` | string |  |
| `PIA901` | 录入者编号 | `entry_person_no` | string |  |
| `PIA902` | 录入时间 | `entry_time` | string |  |
| `PIA903` | 更改者编号 | `changer_no` | string |  |
| `PIA904` | 更改时间 | `change_time` | string |  |
| `PIA905` | 更新标记 | `update_flag` | integer |  |
| `PIA960` | 自定文字1 | `udf_text1` | string |  |
| `PIA961` | 自定文字2 | `udf_text2` | string |  |
| `PIA962` | 自定文字3 | `udf_text3` | string |  |
| `PIA963` | 自定文字4 | `udf_text4` | string |  |
| `PIA964` | 自定文字5 | `udf_text5` | string |  |
| `PIA965` | 自定文字6 | `udf_text6` | string |  |
| `PIA980` | 自定数字1 | `udf_no1` | float |  |
| `PIA981` | 自定数字2 | `udf_no2` | float |  |
| `PIA982` | 自定数字3 | `udf_no3` | float |  |
| `PIA983` | 自定数字4 | `udf_no4` | float |  |
| `PIA984` | 自定数字5 | `udf_no5` | float |  |
| `PIA985` | 自定数字6 | `udf_no6` | float |  |
| `PIA966` | 自定文字7 | `udf_text7` | string |  |
| `PIA967` | 自定文字8 | `udf_text8` | string |  |
| `PIA968` | 自定文字9 | `udf_text9` | string |  |
| `PIA969` | 自定文字10 | `udf_text10` | string |  |
| `PIA970` | 自定文字11 | `udf_text11` | string |  |
| `PIA971` | 自定文字12 | `udf_text12` | string |  |
| `PIA972` | 自定文字13 | `udf_text13` | string |  |
| `PIA973` | 自定文字14 | `udf_text14` | string |  |
| `PIA974` | 自定文字15 | `udf_text15` | string |  |
| `PIA975` | 自定文字16 | `udf_text16` | string |  |
| `PIA986` | 自定数字7 | `udf_no7` | float |  |
| `PIA987` | 自定数字8 | `udf_no8` | float |  |
| `PIA988` | 自定数字9 | `udf_no9` | float |  |
| `PIA989` | 自定数字10 | `udf_no10` | float |  |
| `PIA990` | 自定数字11 | `udf_no11` | float |  |
| `PIA991` | 自定数字12 | `udf_no12` | float |  |
| `PIA992` | 自定数字13 | `udf_no13` | float |  |
| `PIA993` | 自定数字14 | `udf_no14` | float |  |
| `PIA994` | 自定数字15 | `udf_no15` | float |  |
| `PIA995` | 自定数字16 | `udf_no16` | float |  |
| `PIA906` | 打印次数 | `print_count` | integer |  |
| `PIA907` | 打印时间 | `print_time` | string |  |
| `PIA908` | 打印人员 | `printer` | string |  |
| `PIA909` | 打印人员姓名 | `printer_name` | string |  |
| `PIA959` | 审核时间 | `review_time` | string |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "PIA001": ""
  ,"PIA002": ""
  ,"PIA003": ""
  ,"PIA004": ""
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"PIA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"PIA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `PIA001` | `PIA001` | 票据号码 | 主键 |
| `PIA002` | `PIA002` | 性质 | |
| `PIA003` | `PIA003` | 结算方式 | |
| `PIA004` | `PIA004` | 出票日 | |
| `PIA005` | `PIA005` | 到期日 | |
| `PIA006` | `PIA006` | 供应商 | |
| `PIA007` | `PIA007` | 供应商全称 | |
| `PIA008` | `PIA008` | 金额 | |
| `PIA009` | `PIA009` | 实际结算金额 | |
| `PIA010` | `PIA010` | 付款帐号 | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `PIA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `PIA001`
