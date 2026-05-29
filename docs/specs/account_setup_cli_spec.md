# CLI 规格说明书：开户账号

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `account.setup` |
| **DLL** | `PJMCC01` |
| **服务名称** | `开户账号` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "account.setup" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "account.setup" \
  --action "getMultiple" \
  --data '{"datakeys":[{"PQA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "account.setup" \
  --action "create" \
  --data '{"PQA001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `PQA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (PJMPQA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `PQA001` | 账号 | `PQA001` | string | 主键 |
| `PQA002` | 预留字段 | `PQA002` | string |  |
| `PQA003` | 账号开户行 | `PQA003` | string |  |
| `PQA004` | 币种 | `PQA004` | string |  |
| `PQA005` | 预留字段 | `PQA005` | string |  |
| `PQA006` | 存款科目 | `PQA006` | string |  |
| `PQA007` | 联系人 | `PQA007` | string |  |
| `PQA008` | 联系电话 | `PQA008` | string |  |
| `PQA009` | 备注 | `PQA009` | string |  |
| `PQA010` | 注销码 | `PQA010` | string |  |
| `PQA011` | 开户日期 | `PQA011` | string |  |
| `PQA012` | 预留字段 | `PQA012` | string |  |
| `PQA013` | 预留字段 | `PQA013` | string |  |
| `PQA014` | 预留字段 | `PQA014` | string |  |
| `PQA015` | 预留字段 | `PQA015` | float |  |
| `PQA016` | 预留字段 | `PQA016` | float |  |
| `PQA017` | 银行行号 | `PQA017` | string |  |
| `PQA018` | 银行全称 | `PQA018` | string |  |
| `PQA019` | 启用银企直连 | `PQA019` | string |  |
| `PQA020` | 主账号 | `PQA020` | string |  |
| `PQA901` | 录入者编号 | `entry_person_no` | string |  |
| `PQA902` | 录入时间 | `entry_time` | string |  |
| `PQA903` | 更改者编号 | `changer_no` | string |  |
| `PQA904` | 更改时间 | `change_time` | string |  |
| `PQA905` | 更新标记 | `update_flag` | integer |  |
| `PQA960` | 自定文字1 | `udf_text1` | string |  |
| `PQA961` | 自定文字2 | `udf_text2` | string |  |
| `PQA962` | 自定文字3 | `udf_text3` | string |  |
| `PQA963` | 自定文字4 | `udf_text4` | string |  |
| `PQA964` | 自定文字5 | `udf_text5` | string |  |
| `PQA965` | 自定文字6 | `udf_text6` | string |  |
| `PQA980` | 自定数字1 | `udf_no1` | float |  |
| `PQA981` | 自定数字2 | `udf_no2` | float |  |
| `PQA982` | 自定数字3 | `udf_no3` | float |  |
| `PQA983` | 自定数字4 | `udf_no4` | float |  |
| `PQA984` | 自定数字5 | `udf_no5` | float |  |
| `PQA985` | 自定数字6 | `udf_no6` | float |  |
| `PQA966` | 自定文字7 | `udf_text7` | string |  |
| `PQA967` | 自定文字8 | `udf_text8` | string |  |
| `PQA968` | 自定文字9 | `udf_text9` | string |  |
| `PQA969` | 自定文字10 | `udf_text10` | string |  |
| `PQA970` | 自定文字11 | `udf_text11` | string |  |
| `PQA971` | 自定文字12 | `udf_text12` | string |  |
| `PQA972` | 自定文字13 | `udf_text13` | string |  |
| `PQA973` | 自定文字14 | `udf_text14` | string |  |
| `PQA974` | 自定文字15 | `udf_text15` | string |  |
| `PQA975` | 自定文字16 | `udf_text16` | string |  |
| `PQA986` | 自定数字7 | `udf_no7` | float |  |
| `PQA987` | 自定数字8 | `udf_no8` | float |  |
| `PQA988` | 自定数字9 | `udf_no9` | float |  |
| `PQA989` | 自定数字10 | `udf_no10` | float |  |
| `PQA990` | 自定数字11 | `udf_no11` | float |  |
| `PQA991` | 自定数字12 | `udf_no12` | float |  |
| `PQA992` | 自定数字13 | `udf_no13` | float |  |
| `PQA993` | 自定数字14 | `udf_no14` | float |  |
| `PQA994` | 自定数字15 | `udf_no15` | float |  |
| `PQA995` | 自定数字16 | `udf_no16` | float |  |
| `PQA906` | 打印次数 | `print_count` | integer |  |
| `PQA907` | 打印时间 | `print_time` | string |  |
| `PQA908` | 打印人员 | `printer` | string |  |
| `PQA909` | 打印人员姓名 | `printer_name` | string |  |

### 3.2 单身表 (PJMPQB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `PQB001` | 银行账号 | `PQB001` | string |  |
| `PQB002` | 银行交易流水号 | `PQB002` | string |  |
| `PQB003` | 收支借贷标识 | `PQB003` | string |  |
| `PQB004` | 交易类型 | `PQB004` | string |  |
| `PQB005` | 交易日期 | `PQB005` | string |  |
| `PQB006` | 计息日期 | `PQB006` | string |  |
| `PQB007` | 交易状态 | `PQB007` | string |  |
| `PQB008` | 对方开户行联行号 | `PQB008` | string |  |
| `PQB009` | 交易金额 | `PQB009` | float |  |
| `PQB010` | 交易币种 | `PQB010` | string |  |
| `PQB011` | 摘要 | `PQB011` | string |  |
| `PQB012` | 附言 | `PQB012` | string |  |
| `PQB013` | 虚拟账号 | `PQB013` | string |  |
| `PQB014` | 对方银行账号 | `PQB014` | string |  |
| `PQB015` | 对方账号名称 | `PQB015` | string |  |
| `PQB016` | 结算对象类型 | `PQB016` | string |  |
| `PQB017` | 结算对象编号 | `PQB017` | string |  |
| `PQB018` | 结算对象简称 | `PQB018` | string |  |
| `PQB019` | 单据类型 | `PQB019` | string |  |
| `PQB020` | 单号 | `PQB020` | string |  |
| `PQB021` | 已生单 | `PQB021` | string |  |
| `PQB022` | 手工过账 | `PQB022` | string |  |
| `PQB023` | 失败原因 | `PQB023` | string |  |
| `PQB024` | 付款类型 | `PQB024` | string |  |
| `PQB025` | 预留字段 | `PQB025` | string |  |
| `PQB026` | 预留字段 | `PQB026` | string |  |
| `PQB027` | 预留字段 | `PQB027` | string |  |
| `PQB028` | 预留字段 | `PQB028` | string |  |
| `PQB029` | 预留字段 | `PQB029` | float |  |
| `PQB030` | 预留字段 | `PQB030` | float |  |
| `PQB901` | 录入者编号 | `entry_person_no` | string |  |
| `PQB902` | 录入时间 | `entry_time` | string |  |
| `PQB903` | 更改者编号 | `changer_no` | string |  |
| `PQB904` | 更改时间 | `change_time` | string |  |
| `PQB905` | 更新标记 | `update_flag` | integer |  |
| `PQB906` | 打印次数 | `print_count` | integer |  |
| `PQB907` | 打印时间 | `print_time` | string |  |
| `PQB908` | 打印人员 | `printer` | string |  |
| `PQB960` | 自定文字1 | `udf_text1` | string |  |
| `PQB961` | 自定文字2 | `udf_text2` | string |  |
| `PQB962` | 自定文字3 | `udf_text3` | string |  |
| `PQB963` | 自定文字4 | `udf_text4` | string |  |
| `PQB964` | 自定文字5 | `udf_text5` | string |  |
| `PQB965` | 自定文字6 | `udf_text6` | string |  |
| `PQB966` | 自定文字7 | `udf_text7` | string |  |
| `PQB967` | 自定文字8 | `udf_text8` | string |  |
| `PQB968` | 自定文字9 | `udf_text9` | string |  |
| `PQB969` | 自定文字10 | `udf_text10` | string |  |
| `PQB970` | 自定文字11 | `udf_text11` | string |  |
| `PQB971` | 自定文字12 | `udf_text12` | string |  |
| `PQB972` | 自定文字13 | `udf_text13` | string |  |
| `PQB973` | 自定文字14 | `udf_text14` | string |  |
| `PQB974` | 自定文字15 | `udf_text15` | string |  |
| `PQB975` | 自定文字16 | `udf_text16` | string |  |
| `PQB980` | 自定数字1 | `udf_no1` | float |  |
| `PQB981` | 自定数字2 | `udf_no2` | float |  |
| `PQB982` | 自定数字3 | `udf_no3` | float |  |
| `PQB983` | 自定数字4 | `udf_no4` | float |  |
| `PQB984` | 自定数字5 | `udf_no5` | float |  |
| `PQB985` | 自定数字6 | `udf_no6` | float |  |
| `PQB986` | 自定数字7 | `udf_no7` | float |  |
| `PQB987` | 自定数字8 | `udf_no8` | float |  |
| `PQB988` | 自定数字9 | `udf_no9` | float |  |
| `PQB989` | 自定数字10 | `udf_no10` | float |  |
| `PQB990` | 自定数字11 | `udf_no11` | float |  |
| `PQB991` | 自定数字12 | `udf_no12` | float |  |
| `PQB992` | 自定数字13 | `udf_no13` | float |  |
| `PQB993` | 自定数字14 | `udf_no14` | float |  |
| `PQB994` | 自定数字15 | `udf_no15` | float |  |
| `PQB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (PJMPQC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `PQC001` | 银行账号 | `PQC001` | string |  |
| `PQC004` | 结算流水号 | `PQC004` | string |  |
| `PQC009` | 记账日期 | `PQC009` | string |  |
| `PQC002` | 虚拟账号 | `PQC002` | string |  |
| `PQC003` | 账户银行的行名 | `PQC003` | string |  |
| `PQC005` | 企业内部交易号 | `PQC005` | string |  |
| `PQC006` | 收支借贷标识 | `PQC006` | string |  |
| `PQC007` | 交易类型 | `PQC007` | string |  |
| `PQC008` | 交易时间 | `PQC008` | string |  |
| `PQC010` | 交易状态 | `PQC010` | string |  |
| `PQC011` | 交易状态说明 | `PQC011` | string |  |
| `PQC012` | 对方银行账号 | `PQC012` | string |  |
| `PQC013` | 对方账号名称 | `PQC013` | string |  |
| `PQC014` | 对方银行行名 | `PQC014` | string |  |
| `PQC015` | 对方银行账号开户行联行号 | `PQC015` | string |  |
| `PQC016` | 对方银行账号开户行名称 | `PQC016` | string |  |
| `PQC017` | 附言 | `PQC017` | string |  |
| `PQC018` | 摘要 | `PQC018` | string |  |
| `PQC019` | 交易币种 | `PQC019` | string |  |
| `PQC020` | 交易金额 | `PQC020` | float |  |
| `PQC021` | 创建时间 | `PQC021` | string |  |
| `PQC022` | 最后修改时间 | `PQC022` | string |  |
| `PQC023` | 已处理 | `PQC023` | string |  |
| `PQC024` | 预留字段 | `PQC024` | string |  |
| `PQC025` | 预留字段 | `PQC025` | string |  |
| `PQC026` | 预留字段 | `PQC026` | string |  |
| `PQC027` | 预留字段 | `PQC027` | string |  |
| `PQC028` | 预留字段 | `PQC028` | float |  |
| `PQC029` | 预留字段 | `PQC029` | float |  |
| `PQC901` | 录入者编号 | `entry_person_no` | string |  |
| `PQC902` | 录入时间 | `entry_time` | string |  |
| `PQC903` | 更改者编号 | `changer_no` | string |  |
| `PQC904` | 更改时间 | `change_time` | string |  |
| `PQC905` | 更新标记 | `update_flag` | integer |  |
| `PQC906` | 打印次数 | `print_count` | integer |  |
| `PQC907` | 打印时间 | `print_time` | string |  |
| `PQC908` | 打印人员 | `printer` | string |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "PQA001": ""
  ,"PQA002": ""
  ,"PQA003": ""
  ,"PQA004": ""
  ,"cdsDetail": [{
    "PQB001": ""
    ,"PQB001": ""
    ,"PQB002": ""
    ,"PQB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"PQA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"PQA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `PQA001` | `PQA001` | 账号 | 主键 |
| `PQA002` | `PQA002` | 预留字段 | |
| `PQA003` | `PQA003` | 账号开户行 | |
| `PQA004` | `PQA004` | 币种 | |
| `PQA005` | `PQA005` | 预留字段 | |
| `PQA006` | `PQA006` | 存款科目 | |
| `PQA007` | `PQA007` | 联系人 | |
| `PQA008` | `PQA008` | 联系电话 | |
| `PQA009` | `PQA009` | 备注 | |
| `PQA010` | `PQA010` | 注销码 | |
| `PQB001` | `PQB001` | 银行账号 (单身) | |
| `PQB002` | `PQB002` | 银行交易流水号 (单身) | |
| `PQB003` | `PQB003` | 收支借贷标识 (单身) | |
| `PQB004` | `PQB004` | 交易类型 (单身) | |
| `PQB005` | `PQB005` | 交易日期 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `PQA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `PQA001`
