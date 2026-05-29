# CLI 规格说明书：会计凭证

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `accounting.voucher` |
| **DLL** | `KJSKC04` |
| **服务名称** | `会计凭证` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "accounting.voucher" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "accounting.voucher" \
  --action "getMultiple" \
  --data '{"datakeys":[{"NDA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "accounting.voucher" \
  --action "create" \
  --data '{"NDA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "accounting.voucher" \
  --action "approve" \
  --data '{"datakeys":[{"NDA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `NDA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (KJSNDA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `NDA001` | 凭证类别 | `NDA001` | string |  |
| `NDA002` | 凭证编号 | `NDA002` | string |  |
| `NDA003` | 凭证日期 | `NDA003` | string |  |
| `NDA004` | 附件数 | `NDA004` | float |  |
| `NDA005` | 来源 | `NDA005` | string |  |
| `NDA006` | 来源单号 | `NDA006` | string |  |
| `NDA007` | 本币借方金额合计 | `NDA007` | float |  |
| `NDA008` | 本币贷方金额合计 | `NDA008` | float |  |
| `NDA009` | 制单 | `NDA009` | string |  |
| `NDA010` | 记账 | `NDA010` | string |  |
| `NDA011` | 记账码 | `NDA011` | string |  |
| `NDA012` | 审核 | `NDA012` | string |  |
| `NDA013` | 审核码 | `NDA013` | string |  |
| `NDA014` | 出纳 | `NDA014` | string |  |
| `NDA015` | 出纳码 | `NDA015` | string |  |
| `NDA016` | 性质 | `NDA016` | string |  |
| `NDA017` | 备注 | `NDA017` | string |  |
| `NDA018` | 作废码 | `NDA018` | string |  |
| `NDA019` | 现金流量对象 | `NDA019` | string |  |
| `NDA020` | 凭证属性 | `NDA020` | string |  |
| `NDA021` | 预留字段 | `NDA021` | string |  |
| `NDA022` | 预留字段 | `NDA022` | string |  |
| `NDA023` | 预留字段 | `NDA023` | string |  |
| `NDA024` | 预留字段 | `NDA024` | string |  |
| `NDA025` | 预留字段 | `NDA025` | float |  |
| `NDA026` | 预留字段 | `NDA026` | float |  |
| `NDA027` | 来源序号 | `NDA027` | string |  |
| `NDA028` | 总号 | `NDA028` | string |  |
| `NDA029` | 标错码 | `NDA029` | string |  |
| `NDA030` | 红冲码 | `NDA030` | string |  |
| `NDA031` | 红冲来源凭证类别 | `NDA031` | string |  |
| `NDA032` | 红冲来源凭证编号 | `NDA032` | string |  |
| `NDA901` | 录入者编号 | `entry_person_no` | string |  |
| `NDA902` | 录入时间 | `entry_time` | string |  |
| `NDA903` | 更改者编号 | `changer_no` | string |  |
| `NDA904` | 更改时间 | `change_time` | string |  |
| `NDA905` | 更新标记 | `update_flag` | integer |  |
| `NDA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (KJSNDB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `NDB001` | 凭证类别 | `NDB001` | string |  |
| `NDB002` | 凭证编号 | `NDB002` | string |  |
| `NDB003` | 序号 | `NDB003` | string |  |
| `NDB004` | 摘要 | `NDB004` | string |  |
| `NDB005` | 会计科目 | `NDB005` | string |  |
| `NDB006` | 借贷类型 | `NDB006` | integer |  |
| `NDB007` | 币种 | `NDB007` | string |  |
| `NDB008` | 汇率 | `NDB008` | float |  |
| `NDB009` | 原币金额 | `NDB009` | float |  |
| `NDB010` | 本币金额 | `NDB010` | float |  |
| `NDB011` | 部门 | `NDB011` | string |  |
| `NDB012` | 客户 | `NDB012` | string |  |
| `NDB013` | 供应商 | `NDB013` | string |  |
| `NDB014` | 数量 | `NDB014` | float |  |
| `NDB015` | 单价 | `NDB015` | float |  |
| `NDB016` | 项目 | `NDB016` | string |  |
| `NDB017` | 来源 | `NDB017` | string |  |
| `NDB018` | 来源单号 | `NDB018` | string |  |
| `NDB019` | 审核码 | `NDB019` | string |  |
| `NDB020` | 出纳码 | `NDB020` | string |  |
| `NDB021` | 现金流量表项目 | `NDB021` | string |  |
| `NDB022` | 核算项目名称 | `NDB022` | string |  |
| `NDB023` | 预留字段 | `NDB023` | string |  |
| `NDB024` | 预留字段 | `NDB024` | string |  |
| `NDB025` | 预留字段 | `NDB025` | float |  |
| `NDB026` | 预留字段 | `NDB026` | float |  |
| `NDB027` | 员工 | `NDB027` | string |  |
| `NDB028` | 结算方式 | `NDB028` | string |  |
| `NDB029` | 结算号 | `NDB029` | string |  |
| `NDB030` | 结算日期 | `NDB030` | string |  |
| `NDB031` | 来源序号 | `NDB031` | string |  |
| `NDB032` | 业务员 | `NDB032` | string |  |
| `NDB033` | 行号 | `NDB033` | string |  |
| `NDB901` | 录入者编号 | `entry_person_no` | string |  |
| `NDB902` | 录入时间 | `entry_time` | string |  |
| `NDB903` | 更改者编号 | `changer_no` | string |  |
| `NDB904` | 更改时间 | `change_time` | string |  |
| `NDB905` | 更新标记 | `update_flag` | integer |  |
| `NDB960` | 自定义项1 | `udf_text1` | string |  |
| `NDB961` | 自定义项2 | `udf_text2` | string |  |
| `NDB962` | 自定义项3 | `udf_text3` | string |  |
| `NDB963` | 自定义项4 | `udf_text4` | string |  |
| `NDB964` | 自定义项5 | `udf_text5` | string |  |
| `NDB965` | 自定义项6 | `udf_text6` | string |  |
| `NDB966` | 自定义项7 | `udf_text7` | string |  |
| `NDB967` | 自定义项8 | `udf_text8` | string |  |
| `NDB968` | 自定义项9 | `udf_text9` | string |  |
| `NDB969` | 自定义项10 | `udf_text10` | string |  |
| `NDB970` | 自定义项11 | `udf_text11` | string |  |
| `NDB971` | 自定义项12 | `udf_text12` | string |  |
| `NDB972` | 自定义项13 | `udf_text13` | string |  |
| `NDB973` | 自定义项14 | `udf_text14` | string |  |
| `NDB974` | 自定义项15 | `udf_text15` | string |  |
| `NDB975` | 自定义项16 | `udf_text16` | string |  |

### 3.3 扩展表 (KJSNDC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `NDC001` | 凭证类别 | `NDC001` | string |  |
| `NDC002` | 凭证编号 | `NDC002` | string |  |
| `NDC003` | 单身序号 | `NDC003` | string |  |
| `NDC004` | 序号 | `NDC004` | string |  |
| `NDC005` | 现金流量表项目 | `NDC005` | string |  |
| `NDC006` | 金额 | `NDC006` | float |  |
| `NDC007` | 预留字段 | `NDC007` | string |  |
| `NDC008` | 预留字段 | `NDC008` | string |  |
| `NDC009` | 预留字段 | `NDC009` | string |  |
| `NDC010` | 预留字段 | `NDC010` | string |  |
| `NDC011` | 预留字段 | `NDC011` | float |  |
| `NDC012` | 预留字段 | `NDC012` | float |  |
| `NDC901` | 录入者编号 | `entry_person_no` | string |  |
| `NDC902` | 录入时间 | `entry_time` | string |  |
| `NDC903` | 更改者编号 | `changer_no` | string |  |
| `NDC904` | 更改时间 | `change_time` | string |  |
| `NDC905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "NDA001": ""
  ,"NDA001": ""
  ,"NDA002": ""
  ,"NDA003": ""
  ,"cdsDetail": [{
    "NDB001": ""
    ,"NDB001": ""
    ,"NDB002": ""
    ,"NDB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"NDA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"NDA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `NDA001` | `NDA001` | 凭证类别 | |
| `NDA002` | `NDA002` | 凭证编号 | |
| `NDA003` | `NDA003` | 凭证日期 | |
| `NDA004` | `NDA004` | 附件数 | |
| `NDA005` | `NDA005` | 来源 | |
| `NDA006` | `NDA006` | 来源单号 | |
| `NDA007` | `NDA007` | 本币借方金额合计 | |
| `NDA008` | `NDA008` | 本币贷方金额合计 | |
| `NDA009` | `NDA009` | 制单 | |
| `NDA010` | `NDA010` | 记账 | |
| `NDB001` | `NDB001` | 凭证类别 (单身) | |
| `NDB002` | `NDB002` | 凭证编号 (单身) | |
| `NDB003` | `NDB003` | 序号 (单身) | |
| `NDB004` | `NDB004` | 摘要 (单身) | |
| `NDB005` | `NDB005` | 会计科目 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `NDA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `NDA001`
