# CLI 规格说明书：银行存提单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `bank.deposit.receipt` |
| **DLL** | `PJMCC02` |
| **服务名称** | `银行存提单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bank.deposit.receipt" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bank.deposit.receipt" \
  --action "getMultiple" \
  --data '{"datakeys":[{"PRA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bank.deposit.receipt" \
  --action "create" \
  --data '{"PRA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bank.deposit.receipt" \
  --action "approve" \
  --data '{"datakeys":[{"PRA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `PRA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (PJMPRA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `PRA001` | 单号 | `PRA001` | string | 主键 |
| `PRA002` | 性质 | `PRA002` | string |  |
| `PRA003` | 日期 | `PRA003` | string |  |
| `PRA004` | 存提种类 | `PRA004` | string |  |
| `PRA005` | 账号 | `PRA005` | string |  |
| `PRA006` | 币种 | `PRA006` | string |  |
| `PRA007` | 汇率 | `PRA007` | float |  |
| `PRA008` | 金额 | `PRA008` | float |  |
| `PRA009` | 本币金额 | `PRA009` | float |  |
| `PRA010` | 人员 | `PRA010` | string |  |
| `PRA011` | 部门 | `PRA011` | string |  |
| `PRA012` | 备注 | `PRA012` | string |  |
| `PRA013` | 对方科目 | `PRA013` | string |  |
| `PRA014` | 凭证抛转否 | `PRA014` | string |  |
| `PRA015` | 凭证编号 | `PRA015` | string |  |
| `PRA016` | 预留字段 | `PRA016` | string |  |
| `PRA017` | 预留字段 | `PRA017` | string |  |
| `PRA018` | 审核码 | `PRA018` | string |  |
| `PRA019` | 预留字段 | `PRA019` | string |  |
| `PRA020` | 预留字段 | `PRA020` | string |  |
| `PRA021` | 预留字段 | `PRA021` | string |  |
| `PRA022` | 预留字段 | `PRA022` | string |  |
| `PRA023` | 预留字段 | `PRA023` | string |  |
| `PRA024` | 预留字段 | `PRA024` | float |  |
| `PRA025` | 预留字段 | `PRA025` | float |  |
| `PRA026` | 审核人 | `PRA026` | string |  |
| `PRA027` | 凭证类别 | `PRA027` | string |  |
| `PRA028` | 业务类型 | `PRA028` | string |  |
| `PRA029` | 对方类型 | `PRA029` | string |  |
| `PRA030` | 对方户名 | `PRA030` | string |  |
| `PRA031` | 对方编号 | `PRA031` | string |  |
| `PRA032` | 对方账号 | `PRA032` | string |  |
| `PRA033` | 对方开户行 | `PRA033` | string |  |
| `PRA034` | 手续费用 | `PRA034` | string |  |
| `PRA035` | 手续费承担 | `PRA035` | string |  |
| `PRA036` | 本币手续费用 | `PRA036` | string |  |
| `PRA901` | 录入者编号 | `entry_person_no` | string |  |
| `PRA902` | 录入时间 | `entry_time` | string |  |
| `PRA903` | 更改者编号 | `changer_no` | string |  |
| `PRA904` | 更改时间 | `change_time` | string |  |
| `PRA905` | 更新标记 | `update_flag` | integer |  |
| `PRA960` | 自定文字1 | `udf_text1` | string |  |
| `PRA961` | 自定文字2 | `udf_text2` | string |  |
| `PRA962` | 自定文字3 | `udf_text3` | string |  |
| `PRA963` | 自定文字4 | `udf_text4` | string |  |
| `PRA964` | 自定文字5 | `udf_text5` | string |  |
| `PRA965` | 自定文字6 | `udf_text6` | string |  |
| `PRA980` | 自定数字1 | `udf_no1` | float |  |
| `PRA981` | 自定数字2 | `udf_no2` | float |  |
| `PRA982` | 自定数字3 | `udf_no3` | float |  |
| `PRA983` | 自定数字4 | `udf_no4` | float |  |
| `PRA984` | 自定数字5 | `udf_no5` | float |  |
| `PRA985` | 自定数字6 | `udf_no6` | float |  |
| `PRA966` | 自定文字7 | `udf_text7` | string |  |
| `PRA967` | 自定文字8 | `udf_text8` | string |  |
| `PRA968` | 自定文字9 | `udf_text9` | string |  |
| `PRA969` | 自定文字10 | `udf_text10` | string |  |
| `PRA970` | 自定文字11 | `udf_text11` | string |  |
| `PRA971` | 自定文字12 | `udf_text12` | string |  |
| `PRA972` | 自定文字13 | `udf_text13` | string |  |
| `PRA973` | 自定文字14 | `udf_text14` | string |  |
| `PRA974` | 自定文字15 | `udf_text15` | string |  |
| `PRA975` | 自定文字16 | `udf_text16` | string |  |
| `PRA986` | 自定数字7 | `udf_no7` | float |  |
| `PRA987` | 自定数字8 | `udf_no8` | float |  |
| `PRA988` | 自定数字9 | `udf_no9` | float |  |
| `PRA989` | 自定数字10 | `udf_no10` | float |  |
| `PRA990` | 自定数字11 | `udf_no11` | float |  |
| `PRA991` | 自定数字12 | `udf_no12` | float |  |
| `PRA992` | 自定数字13 | `udf_no13` | float |  |
| `PRA993` | 自定数字14 | `udf_no14` | float |  |
| `PRA994` | 自定数字15 | `udf_no15` | float |  |
| `PRA995` | 自定数字16 | `udf_no16` | float |  |
| `PRA906` | 打印次数 | `print_count` | integer |  |
| `PRA907` | 打印时间 | `print_time` | string |  |
| `PRA908` | 打印人员 | `printer` | string |  |
| `PRA909` | 打印人员姓名 | `printer_name` | string |  |
| `PRA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (PJMPRB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `PRB001` | 单号 | `PRB001` | string |  |
| `PRB002` | 序号 | `PRB002` | string |  |
| `PRB003` | 审核码 | `PRB003` | string |  |
| `PRB004` | 预留字段 | `PRB004` | string |  |
| `PRB005` | 预留字段 | `PRB005` | string |  |
| `PRB901` | 录入者编号 | `entry_person_no` | string |  |
| `PRB902` | 录入时间 | `entry_time` | string |  |
| `PRB903` | 更改者编号 | `changer_no` | string |  |
| `PRB904` | 更改时间 | `change_time` | string |  |
| `PRB905` | 更新标记 | `update_flag` | integer |  |
| `PRB960` | 自定文字1 | `udf_text1` | string |  |
| `PRB961` | 自定文字2 | `udf_text2` | string |  |
| `PRB962` | 自定文字3 | `udf_text3` | string |  |
| `PRB963` | 自定文字4 | `udf_text4` | string |  |
| `PRB964` | 自定文字5 | `udf_text5` | string |  |
| `PRB965` | 自定文字6 | `udf_text6` | string |  |
| `PRB980` | 自定数字1 | `udf_no1` | float |  |
| `PRB981` | 自定数字2 | `udf_no2` | float |  |
| `PRB982` | 自定数字3 | `udf_no3` | float |  |
| `PRB983` | 自定数字4 | `udf_no4` | float |  |
| `PRB984` | 自定数字5 | `udf_no5` | float |  |
| `PRB985` | 自定数字6 | `udf_no6` | float |  |
| `PRB966` | 自定文字7 | `udf_text7` | string |  |
| `PRB967` | 自定文字8 | `udf_text8` | string |  |
| `PRB968` | 自定文字9 | `udf_text9` | string |  |
| `PRB969` | 自定文字10 | `udf_text10` | string |  |
| `PRB970` | 自定文字11 | `udf_text11` | string |  |
| `PRB971` | 自定文字12 | `udf_text12` | string |  |
| `PRB972` | 自定文字13 | `udf_text13` | string |  |
| `PRB973` | 自定文字14 | `udf_text14` | string |  |
| `PRB974` | 自定文字15 | `udf_text15` | string |  |
| `PRB975` | 自定文字16 | `udf_text16` | string |  |
| `PRB986` | 自定数字7 | `udf_no7` | float |  |
| `PRB987` | 自定数字8 | `udf_no8` | float |  |
| `PRB988` | 自定数字9 | `udf_no9` | float |  |
| `PRB989` | 自定数字10 | `udf_no10` | float |  |
| `PRB990` | 自定数字11 | `udf_no11` | float |  |
| `PRB991` | 自定数字12 | `udf_no12` | float |  |
| `PRB992` | 自定数字13 | `udf_no13` | float |  |
| `PRB993` | 自定数字14 | `udf_no14` | float |  |
| `PRB994` | 自定数字15 | `udf_no15` | float |  |
| `PRB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (PJMPRC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `PRC001` | 银行账号 | `PRC001` | string |  |
| `PRC002` | 前置符 | `PRC002` | string |  |
| `PRC003` | 起始号码 | `PRC003` | string |  |
| `PRC004` | 截止号码 | `PRC004` | string |  |
| `PRC005` | 购买日期 | `PRC005` | string |  |
| `PRC006` | 支票本号码 | `PRC006` | string |  |
| `PRC007` | 预留字段 | `PRC007` | string |  |
| `PRC008` | 预留字段 | `PRC008` | string |  |
| `PRC009` | 预留字段 | `PRC009` | string |  |
| `PRC010` | 预留字段 | `PRC010` | string |  |
| `PRC011` | 预留字段 | `PRC011` | float |  |
| `PRC901` | 录入者编号 | `entry_person_no` | string |  |
| `PRC902` | 录入时间 | `entry_time` | string |  |
| `PRC903` | 更改者编号 | `changer_no` | string |  |
| `PRC904` | 更改时间 | `change_time` | string |  |
| `PRC905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "PRA001": ""
  ,"PRA002": ""
  ,"PRA003": ""
  ,"PRA004": ""
  ,"cdsDetail": [{
    "PRB001": ""
    ,"PRB001": ""
    ,"PRB002": ""
    ,"PRB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"PRA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"PRA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `PRA001` | `PRA001` | 单号 | 主键 |
| `PRA002` | `PRA002` | 性质 | |
| `PRA003` | `PRA003` | 日期 | |
| `PRA004` | `PRA004` | 存提种类 | |
| `PRA005` | `PRA005` | 账号 | |
| `PRA006` | `PRA006` | 币种 | |
| `PRA007` | `PRA007` | 汇率 | |
| `PRA008` | `PRA008` | 金额 | |
| `PRA009` | `PRA009` | 本币金额 | |
| `PRA010` | `PRA010` | 人员 | |
| `PRB001` | `PRB001` | 单号 (单身) | |
| `PRB002` | `PRB002` | 序号 (单身) | |
| `PRB003` | `PRB003` | 审核码 (单身) | |
| `PRB004` | `PRB004` | 预留字段 (单身) | |
| `PRB005` | `PRB005` | 预留字段 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `PRA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `PRA001`
