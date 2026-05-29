# CLI 规格说明书：应付账款开账

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `accounts.payable` |
| **DLL** | `YSFFC01` |
| **服务名称** | `应付账款开账` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "accounts.payable" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "accounts.payable" \
  --action "getMultiple" \
  --data '{"datakeys":[{"GRA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "accounts.payable" \
  --action "create" \
  --data '{"GRA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "accounts.payable" \
  --action "approve" \
  --data '{"datakeys":[{"GRA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `GRA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (YSFGRA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GRA001` | 单号 | `GRA001` | string | 主键 |
| `GRA002` | (预留)性质 | `GRA002` | string |  |
| `GRA003` | 日期 | `GRA003` | string |  |
| `GRA004` | 经办人 | `GRA004` | string |  |
| `GRA005` | 部门 | `GRA005` | string |  |
| `GRA006` | 币种 | `GRA006` | string |  |
| `GRA007` | 专案 | `GRA007` | string |  |
| `GRA008` | 复核编号 | `GRA008` | string |  |
| `GRA009` | 复核姓名 | `GRA009` | string |  |
| `GRA010` | 审核码 | `GRA010` | string |  |
| `GRA011` | 日期 | `GRA011` | string |  |
| `GRA012` | 预留字段 | `GRA012` | string |  |
| `GRA013` | 预留字段 | `GRA013` | string |  |
| `GRA014` | 预留字段 | `GRA014` | string |  |
| `GRA015` | 预留字段 | `GRA015` | string |  |
| `GRA016` | 预留字段 | `GRA016` | float |  |
| `GRA017` | 预留字段 | `GRA017` | float |  |
| `GRA018` | 预留字段 | `GRA018` | string |  |
| `GRA019` | 预留字段 | `GRA019` | float |  |
| `GRA020` | 审核人 | `GRA020` | string |  |
| `GRA901` | 录入者编号 | `entry_person_no` | string |  |
| `GRA902` | 录入时间 | `entry_time` | string |  |
| `GRA903` | 更改者编号 | `changer_no` | string |  |
| `GRA904` | 更改时间 | `change_time` | string |  |
| `GRA905` | 更新标记 | `update_flag` | integer |  |
| `GRA960` | 自定文字1 | `udf_text1` | string |  |
| `GRA961` | 自定文字2 | `udf_text2` | string |  |
| `GRA962` | 自定文字3 | `udf_text3` | string |  |
| `GRA963` | 自定文字4 | `udf_text4` | string |  |
| `GRA964` | 自定文字5 | `udf_text5` | string |  |
| `GRA965` | 自定文字6 | `udf_text6` | string |  |
| `GRA980` | 自定数字1 | `udf_no1` | float |  |
| `GRA981` | 自定数字2 | `udf_no2` | float |  |
| `GRA982` | 自定数字3 | `udf_no3` | float |  |
| `GRA983` | 自定数字4 | `udf_no4` | float |  |
| `GRA984` | 自定数字5 | `udf_no5` | float |  |
| `GRA985` | 自定数字6 | `udf_no6` | float |  |
| `GRA966` | 自定文字7 | `udf_text7` | string |  |
| `GRA967` | 自定文字8 | `udf_text8` | string |  |
| `GRA968` | 自定文字9 | `udf_text9` | string |  |
| `GRA969` | 自定文字10 | `udf_text10` | string |  |
| `GRA970` | 自定文字11 | `udf_text11` | string |  |
| `GRA971` | 自定文字12 | `udf_text12` | string |  |
| `GRA972` | 自定文字13 | `udf_text13` | string |  |
| `GRA973` | 自定文字14 | `udf_text14` | string |  |
| `GRA974` | 自定文字15 | `udf_text15` | string |  |
| `GRA975` | 自定文字16 | `udf_text16` | string |  |
| `GRA986` | 自定数字7 | `udf_no7` | float |  |
| `GRA987` | 自定数字8 | `udf_no8` | float |  |
| `GRA988` | 自定数字9 | `udf_no9` | float |  |
| `GRA989` | 自定数字10 | `udf_no10` | float |  |
| `GRA990` | 自定数字11 | `udf_no11` | float |  |
| `GRA991` | 自定数字12 | `udf_no12` | float |  |
| `GRA992` | 自定数字13 | `udf_no13` | float |  |
| `GRA993` | 自定数字14 | `udf_no14` | float |  |
| `GRA994` | 自定数字15 | `udf_no15` | float |  |
| `GRA995` | 自定数字16 | `udf_no16` | float |  |
| `GRA906` | 打印次数 | `print_count` | integer |  |
| `GRA907` | 打印时间 | `print_time` | string |  |
| `GRA908` | 打印人员 | `printer` | string |  |
| `GRA909` | 打印人员姓名 | `printer_name` | string |  |
| `GRA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (YSFGRB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GRB001` | 单号 | `GRB001` | string |  |
| `GRB002` | 序号 | `GRB002` | string |  |
| `GRB003` | 供应商 | `GRB003` | string |  |
| `GRB004` | 应付金额 | `GRB004` | float |  |
| `GRB005` | 预付金额 | `GRB005` | float |  |
| `GRB006` | 本币应付 | `GRB006` | float |  |
| `GRB007` | 本币预付 | `GRB007` | float |  |
| `GRB008` | 审核码 | `GRB008` | string |  |
| `GRB009` | 预付款日 | `GRB009` | string |  |
| `GRB010` | (预留)日期 | `GRB010` | string |  |
| `GRB011` | 预留字段 | `GRB011` | string |  |
| `GRB012` | (预留)日期 | `GRB012` | string |  |
| `GRB013` | (预留) | `GRB013` | float |  |
| `GRB014` | 预兑现日 | `GRB014` | string |  |
| `GRB015` | 预留 | `GRB015` | string |  |
| `GRB016` | 预留字段 | `GRB016` | string |  |
| `GRB017` | 预留字段 | `GRB017` | string |  |
| `GRB018` | 预留字段 | `GRB018` | string |  |
| `GRB019` | 预留字段 | `GRB019` | string |  |
| `GRB020` | 预留字段 | `GRB020` | string |  |
| `GRB021` | 预留字段 | `GRB021` | string |  |
| `GRB022` | 预留字段 | `GRB022` | string |  |
| `GRB023` | 预留字段 | `GRB023` | string |  |
| `GRB024` | 预留字段 | `GRB024` | string |  |
| `GRB901` | 录入者编号 | `entry_person_no` | string |  |
| `GRB902` | 录入时间 | `entry_time` | string |  |
| `GRB903` | 更改者编号 | `changer_no` | string |  |
| `GRB904` | 更改时间 | `change_time` | string |  |
| `GRB905` | 更新标记 | `update_flag` | integer |  |
| `GRB960` | 自定文字1 | `udf_text1` | string |  |
| `GRB961` | 自定文字2 | `udf_text2` | string |  |
| `GRB962` | 自定文字3 | `udf_text3` | string |  |
| `GRB963` | 自定文字4 | `udf_text4` | string |  |
| `GRB964` | 自定文字5 | `udf_text5` | string |  |
| `GRB965` | 自定文字6 | `udf_text6` | string |  |
| `GRB980` | 自定数字1 | `udf_no1` | float |  |
| `GRB981` | 自定数字2 | `udf_no2` | float |  |
| `GRB982` | 自定数字3 | `udf_no3` | float |  |
| `GRB983` | 自定数字4 | `udf_no4` | float |  |
| `GRB984` | 自定数字5 | `udf_no5` | float |  |
| `GRB985` | 自定数字6 | `udf_no6` | float |  |
| `GRB966` | 自定文字7 | `udf_text7` | string |  |
| `GRB967` | 自定文字8 | `udf_text8` | string |  |
| `GRB968` | 自定文字9 | `udf_text9` | string |  |
| `GRB969` | 自定文字10 | `udf_text10` | string |  |
| `GRB970` | 自定文字11 | `udf_text11` | string |  |
| `GRB971` | 自定文字12 | `udf_text12` | string |  |
| `GRB972` | 自定文字13 | `udf_text13` | string |  |
| `GRB973` | 自定文字14 | `udf_text14` | string |  |
| `GRB974` | 自定文字15 | `udf_text15` | string |  |
| `GRB975` | 自定文字16 | `udf_text16` | string |  |
| `GRB986` | 自定数字7 | `udf_no7` | float |  |
| `GRB987` | 自定数字8 | `udf_no8` | float |  |
| `GRB988` | 自定数字9 | `udf_no9` | float |  |
| `GRB989` | 自定数字10 | `udf_no10` | float |  |
| `GRB990` | 自定数字11 | `udf_no11` | float |  |
| `GRB991` | 自定数字12 | `udf_no12` | float |  |
| `GRB992` | 自定数字13 | `udf_no13` | float |  |
| `GRB993` | 自定数字14 | `udf_no14` | float |  |
| `GRB994` | 自定数字15 | `udf_no15` | float |  |
| `GRB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "GRA001": ""
  ,"GRA002": ""
  ,"GRA003": ""
  ,"GRA004": ""
  ,"cdsDetail": [{
    "GRB001": ""
    ,"GRB001": ""
    ,"GRB002": ""
    ,"GRB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"GRA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"GRA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `GRA001` | `GRA001` | 单号 | 主键 |
| `GRA002` | `GRA002` | (预留)性质 | |
| `GRA003` | `GRA003` | 日期 | |
| `GRA004` | `GRA004` | 经办人 | |
| `GRA005` | `GRA005` | 部门 | |
| `GRA006` | `GRA006` | 币种 | |
| `GRA007` | `GRA007` | 专案 | |
| `GRA008` | `GRA008` | 复核编号 | |
| `GRA009` | `GRA009` | 复核姓名 | |
| `GRA010` | `GRA010` | 审核码 | |
| `GRB001` | `GRB001` | 单号 (单身) | |
| `GRB002` | `GRB002` | 序号 (单身) | |
| `GRB003` | `GRB003` | 供应商 (单身) | |
| `GRB004` | `GRB004` | 应付金额 (单身) | |
| `GRB005` | `GRB005` | 预付金额 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `GRA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `GRA001`
