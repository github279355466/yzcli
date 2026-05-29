# CLI 规格说明书：收款票据

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `receipt.invoice` |
| **DLL** | `PJMSC01` |
| **服务名称** | `收款票据` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "receipt.invoice" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "receipt.invoice" \
  --action "getMultiple" \
  --data '{"datakeys":[{"PAA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "receipt.invoice" \
  --action "create" \
  --data '{"PAA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "receipt.invoice" \
  --action "approve" \
  --data '{"datakeys":[{"PAA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `PAA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (PJMPAA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `PAA001` | 票据号码 | `PAA001` | string | 主键 |
| `PAA002` | 性质 | `PAA002` | string |  |
| `PAA003` | 结算方式 | `PAA003` | string |  |
| `PAA004` | 收票日 | `PAA004` | string |  |
| `PAA005` | 出票日 | `PAA005` | string |  |
| `PAA006` | 到期日 | `PAA006` | string |  |
| `PAA007` | 客户 | `PAA007` | string |  |
| `PAA008` | 客户全称 | `PAA008` | string |  |
| `PAA009` | 金额 | `PAA009` | float |  |
| `PAA010` | 实际结算金额 | `PAA010` | float |  |
| `PAA011` | 收款账号 | `PAA011` | string |  |
| `PAA012` | 利息 | `PAA012` | float |  |
| `PAA013` | 费用 | `PAA013` | float |  |
| `PAA014` | 收款人 | `PAA014` | string |  |
| `PAA015` | 部门 | `PAA015` | string |  |
| `PAA016` | 备注 | `PAA016` | string |  |
| `PAA017` | 前置来源 | `PAA017` | string |  |
| `PAA018` | 前置单号 | `PAA018` | string |  |
| `PAA019` | 前置序号 | `PAA019` | string |  |
| `PAA020` | 票况 | `PAA020` | string |  |
| `PAA021` | 核销码 | `PAA021` | string |  |
| `PAA022` | 审核码 | `PAA022` | string |  |
| `PAA023` | 异动日期 | `PAA023` | string |  |
| `PAA024` | 被背书人 | `PAA024` | string |  |
| `PAA025` | 预留字段 | `PAA025` | string |  |
| `PAA026` | 预留字段 | `PAA026` | string |  |
| `PAA027` | 预留字段 | `PAA027` | string |  |
| `PAA028` | 预留字段 | `PAA028` | string |  |
| `PAA029` | 预留字段 | `PAA029` | string |  |
| `PAA030` | 预留字段 | `PAA030` | string |  |
| `PAA031` | 预留字段 | `PAA031` | string |  |
| `PAA032` | 预留字段 | `PAA032` | string |  |
| `PAA033` | 预留字段 | `PAA033` | string |  |
| `PAA034` | 预留字段 | `PAA034` | float |  |
| `PAA035` | 预留字段 | `PAA035` | string |  |
| `PAA036` | 预留字段 | `PAA036` | string |  |
| `PAA037` | 预留字段 | `PAA037` | string |  |
| `PAA038` | 预留字段 | `PAA038` | string |  |
| `PAA039` | 预留字段 | `PAA039` | float |  |
| `PAA040` | 预留字段 | `PAA040` | float |  |
| `PAA041` | 审核人 | `PAA041` | string |  |
| `PAA042` | 币种 | `PAA042` | string |  |
| `PAA043` | 汇率 | `PAA043` | float |  |
| `PAA044` | 原币金额 | `PAA044` | float |  |
| `PAA045` | 原币结算金额 | `PAA045` | float |  |
| `PAA046` | 收款金额 | `PAA046` | float |  |
| `PAA047` | 付款金额 | `PAA047` | float |  |
| `PAA048` | 票据包号 | `PAA048` | string |  |
| `PAA049` | 子票区间起始序号 | `PAA049` | integer |  |
| `PAA050` | 子票区间截止序号 | `PAA050` | integer |  |
| `PAA051` | 可分包流转标识 | `PAA051` | string |  |
| `PAA052` | 拆分状态标识 | `PAA052` | string |  |
| `PAA053` | 子票据标识 | `PAA053` | string |  |
| `PAA054` | 拆分来源票据 | `PAA054` | string |  |
| `PAA901` | 录入者编号 | `entry_person_no` | string |  |
| `PAA902` | 录入时间 | `entry_time` | string |  |
| `PAA903` | 更改者编号 | `changer_no` | string |  |
| `PAA904` | 更改时间 | `change_time` | string |  |
| `PAA905` | 更新标记 | `update_flag` | integer |  |
| `PAA906` | 打印次数 | `print_count` | integer |  |
| `PAA907` | 打印时间 | `print_time` | string |  |
| `PAA908` | 打印人员 | `printer` | string |  |
| `PAA909` | 打印人员姓名 | `printer_name` | string |  |
| `PAA960` | 自定文字1 | `udf_text1` | string |  |
| `PAA961` | 自定文字2 | `udf_text2` | string |  |
| `PAA962` | 自定文字3 | `udf_text3` | string |  |
| `PAA963` | 自定文字4 | `udf_text4` | string |  |
| `PAA964` | 自定文字5 | `udf_text5` | string |  |
| `PAA965` | 自定文字6 | `udf_text6` | string |  |
| `PAA966` | 自定文字7 | `udf_text7` | string |  |
| `PAA967` | 自定文字8 | `udf_text8` | string |  |
| `PAA968` | 自定文字9 | `udf_text9` | string |  |
| `PAA969` | 自定文字10 | `udf_text10` | string |  |
| `PAA970` | 自定文字11 | `udf_text11` | string |  |
| `PAA971` | 自定文字12 | `udf_text12` | string |  |
| `PAA972` | 自定文字13 | `udf_text13` | string |  |
| `PAA973` | 自定文字14 | `udf_text14` | string |  |
| `PAA974` | 自定文字15 | `udf_text15` | string |  |
| `PAA975` | 自定文字16 | `udf_text16` | string |  |
| `PAA980` | 自定数字1 | `udf_no1` | float |  |
| `PAA981` | 自定数字2 | `udf_no2` | float |  |
| `PAA982` | 自定数字3 | `udf_no3` | float |  |
| `PAA983` | 自定数字4 | `udf_no4` | float |  |
| `PAA984` | 自定数字5 | `udf_no5` | float |  |
| `PAA985` | 自定数字6 | `udf_no6` | float |  |
| `PAA986` | 自定数字7 | `udf_no7` | float |  |
| `PAA987` | 自定数字8 | `udf_no8` | float |  |
| `PAA988` | 自定数字9 | `udf_no9` | float |  |
| `PAA989` | 自定数字10 | `udf_no10` | float |  |
| `PAA990` | 自定数字11 | `udf_no11` | float |  |
| `PAA991` | 自定数字12 | `udf_no12` | float |  |
| `PAA992` | 自定数字13 | `udf_no13` | float |  |
| `PAA993` | 自定数字14 | `udf_no14` | float |  |
| `PAA994` | 自定数字15 | `udf_no15` | float |  |
| `PAA995` | 自定数字16 | `udf_no16` | float |  |
| `PAA959` | 审核时间 | `review_time` | string |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "PAA001": ""
  ,"PAA002": ""
  ,"PAA003": ""
  ,"PAA004": ""
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"PAA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"PAA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `PAA001` | `PAA001` | 票据号码 | 主键 |
| `PAA002` | `PAA002` | 性质 | |
| `PAA003` | `PAA003` | 结算方式 | |
| `PAA004` | `PAA004` | 收票日 | |
| `PAA005` | `PAA005` | 出票日 | |
| `PAA006` | `PAA006` | 到期日 | |
| `PAA007` | `PAA007` | 客户 | |
| `PAA008` | `PAA008` | 客户全称 | |
| `PAA009` | `PAA009` | 金额 | |
| `PAA010` | `PAA010` | 实际结算金额 | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `PAA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `PAA001`
