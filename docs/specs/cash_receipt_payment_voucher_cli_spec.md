# CLI 规格说明书：现金收付单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `cash.receipt.payment.voucher` |
| **DLL** | `PJMCC03` |
| **服务名称** | `现金收付单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "cash.receipt.payment.voucher" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "cash.receipt.payment.voucher" \
  --action "getMultiple" \
  --data '{"datakeys":[{"PRE001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "cash.receipt.payment.voucher" \
  --action "create" \
  --data '{"PRE001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "cash.receipt.payment.voucher" \
  --action "approve" \
  --data '{"datakeys":[{"PRE001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `PRE001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (PJMPRE)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `PRE001` | 单号 | `PRE001` | string | 主键 |
| `PRE002` | 性质 | `PRE002` | string |  |
| `PRE003` | 日期 | `PRE003` | string |  |
| `PRE004` | 收支类型 | `PRE004` | integer |  |
| `PRE005` | 币种 | `PRE005` | string |  |
| `PRE006` | 汇率 | `PRE006` | float |  |
| `PRE007` | 金额 | `PRE007` | float |  |
| `PRE008` | 本币金额 | `PRE008` | float |  |
| `PRE009` | 人员 | `PRE009` | string |  |
| `PRE010` | 部门 | `PRE010` | string |  |
| `PRE011` | 备注 | `PRE011` | string |  |
| `PRE012` | 对方科目 | `PRE012` | string |  |
| `PRE013` | 凭证抛转否 | `PRE013` | string |  |
| `PRE014` | 凭证编号 | `PRE014` | string |  |
| `PRE015` | 预留字段 | `PRE015` | string |  |
| `PRE016` | 预留字段 | `PRE016` | string |  |
| `PRE017` | 审核码 | `PRE017` | string |  |
| `PRE018` | 预留字段 | `PRE018` | string |  |
| `PRE019` | 预留字段 | `PRE019` | string |  |
| `PRE020` | 预留字段 | `PRE020` | string |  |
| `PRE021` | 预留字段 | `PRE021` | string |  |
| `PRE022` | 预留字段 | `PRE022` | string |  |
| `PRE023` | 预留字段 | `PRE023` | float |  |
| `PRE024` | 预留字段 | `PRE024` | float |  |
| `PRE025` | 审核人 | `PRE025` | string |  |
| `PRE026` | 凭证类别 | `PRE026` | string |  |
| `PRE027` | 来源单号 | `PRE027` | string |  |
| `PRE028` | 前置来源 | `PRE028` | string |  |
| `PRE029` | 前置单号 | `PRE029` | string |  |
| `PRE030` | 金额 | `PRE030` | float |  |
| `PRE901` | 录入者编号 | `entry_person_no` | string |  |
| `PRE902` | 录入时间 | `entry_time` | string |  |
| `PRE903` | 更改者编号 | `changer_no` | string |  |
| `PRE904` | 更改时间 | `change_time` | string |  |
| `PRE905` | 更新标记 | `update_flag` | integer |  |
| `PRE960` | 自定文字1 | `udf_text1` | string |  |
| `PRE961` | 自定文字2 | `udf_text2` | string |  |
| `PRE962` | 自定文字3 | `udf_text3` | string |  |
| `PRE963` | 自定文字4 | `udf_text4` | string |  |
| `PRE964` | 自定文字5 | `udf_text5` | string |  |
| `PRE965` | 自定文字6 | `udf_text6` | string |  |
| `PRE980` | 自定数字1 | `udf_no1` | float |  |
| `PRE981` | 自定数字2 | `udf_no2` | float |  |
| `PRE982` | 自定数字3 | `udf_no3` | float |  |
| `PRE983` | 自定数字4 | `udf_no4` | float |  |
| `PRE984` | 自定数字5 | `udf_no5` | float |  |
| `PRE985` | 自定数字6 | `udf_no6` | float |  |
| `PRE966` | 自定文字7 | `udf_text7` | string |  |
| `PRE967` | 自定文字8 | `udf_text8` | string |  |
| `PRE968` | 自定文字9 | `udf_text9` | string |  |
| `PRE969` | 自定文字10 | `udf_text10` | string |  |
| `PRE970` | 自定文字11 | `udf_text11` | string |  |
| `PRE971` | 自定文字12 | `udf_text12` | string |  |
| `PRE972` | 自定文字13 | `udf_text13` | string |  |
| `PRE973` | 自定文字14 | `udf_text14` | string |  |
| `PRE974` | 自定文字15 | `udf_text15` | string |  |
| `PRE975` | 自定文字16 | `udf_text16` | string |  |
| `PRE986` | 自定数字7 | `udf_no7` | float |  |
| `PRE987` | 自定数字8 | `udf_no8` | float |  |
| `PRE988` | 自定数字9 | `udf_no9` | float |  |
| `PRE989` | 自定数字10 | `udf_no10` | float |  |
| `PRE990` | 自定数字11 | `udf_no11` | float |  |
| `PRE991` | 自定数字12 | `udf_no12` | float |  |
| `PRE992` | 自定数字13 | `udf_no13` | float |  |
| `PRE993` | 自定数字14 | `udf_no14` | float |  |
| `PRE994` | 自定数字15 | `udf_no15` | float |  |
| `PRE995` | 自定数字16 | `udf_no16` | float |  |
| `PRE906` | 打印次数 | `print_count` | integer |  |
| `PRE907` | 打印时间 | `print_time` | string |  |
| `PRE908` | 打印人员 | `printer` | string |  |
| `PRE909` | 打印人员姓名 | `printer_name` | string |  |
| `PRE959` | 审核时间 | `review_time` | string |  |

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
  "PRE001": ""
  ,"PRE002": ""
  ,"PRE003": ""
  ,"PRE004": 1
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
{"datakeys": [{"PRE001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"PRE001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `PRE001` | `PRE001` | 单号 | 主键 |
| `PRE002` | `PRE002` | 性质 | |
| `PRE003` | `PRE003` | 日期 | |
| `PRE004` | `PRE004` | 收支类型 | |
| `PRE005` | `PRE005` | 币种 | |
| `PRE006` | `PRE006` | 汇率 | |
| `PRE007` | `PRE007` | 金额 | |
| `PRE008` | `PRE008` | 本币金额 | |
| `PRE009` | `PRE009` | 人员 | |
| `PRE010` | `PRE010` | 部门 | |
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

- **写入（create/update）**：使用 `字段编号` 列（如 `PRE001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `PRE001`
