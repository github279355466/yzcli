# CLI 规格说明书：借出单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `lend.doc` |
| **DLL** | `INVSC01` |
| **服务名称** | `借出单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "lend.doc" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "lend.doc" \
  --action "getMultiple" \
  --data '{"datakeys":[{"KAA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "lend.doc" \
  --action "create" \
  --data '{"KAA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "lend.doc" \
  --action "approve" \
  --data '{"datakeys":[{"KAA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `KAA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKKAA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `KAA001` | 单号 | `KAA001` | string | 主键 |
| `KAA002` | 性质 | `KAA002` | string |  |
| `KAA003` | 日期 | `KAA003` | string |  |
| `KAA004` | 客户 | `KAA004` | string |  |
| `KAA005` | 请款客户 | `KAA005` | string |  |
| `KAA006` | 经办人 | `KAA006` | string |  |
| `KAA007` | 部门 | `KAA007` | string |  |
| `KAA008` | 币种 | `KAA008` | string |  |
| `KAA009` | 汇率 | `KAA009` | float |  |
| `KAA010` | 专案 | `KAA010` | string |  |
| `KAA011` | 预还日期 | `KAA011` | string |  |
| `KAA012` | 送货邮编 | `KAA012` | string |  |
| `KAA013` | 送货地址 | `KAA013` | string |  |
| `KAA014` | 备注 | `KAA014` | string |  |
| `KAA015` | 复核编号 | `KAA015` | string |  |
| `KAA016` | 复核姓名 | `KAA016` | string |  |
| `KAA017` | 金额 | `KAA017` | float |  |
| `KAA018` | 本币金额 | `KAA018` | float |  |
| `KAA019` | 审核码 | `KAA019` | string |  |
| `KAA020` | 预留字段 | `KAA020` | string |  |
| `KAA021` | 预留字段 | `KAA021` | string |  |
| `KAA022` | 税率 | `KAA022` | float |  |
| `KAA023` | 本币税额 | `KAA023` | float |  |
| `KAA024` | 原币税额 | `KAA024` | float |  |
| `KAA025` | 预留字段 | `KAA025` | float |  |
| `KAA026` | 预留字段 | `KAA026` | float |  |
| `KAA027` | 预留字段 | `KAA027` | string |  |
| `KAA028` | 预留字段 | `KAA028` | string |  |
| `KAA029` | 预留字段 | `KAA029` | string |  |
| `KAA030` | 预留字段 | `KAA030` | string |  |
| `KAA031` | 预留字段 | `KAA031` | string |  |
| `KAA032` | 预留字段 | `KAA032` | string |  |
| `KAA033` | 预留字段 | `KAA033` | float |  |
| `KAA034` | 预留字段 | `KAA034` | float |  |
| `KAA035` | 审核人 | `KAA035` | string |  |
| `KAA036` | 价税合计 | `KAA036` | float |  |
| `KAA037` | 本币价税合计 | `KAA037` | float |  |
| `KAA038` | 交易对象 | `KAA038` | string |  |
| `KAA901` | 录入者编号 | `entry_person_no` | string |  |
| `KAA902` | 录入时间 | `entry_time` | string |  |
| `KAA903` | 更改者编号 | `changer_no` | string |  |
| `KAA904` | 更改时间 | `change_time` | string |  |
| `KAA905` | 更新标记 | `update_flag` | integer |  |
| `KAA906` | 打印次数 | `print_count` | integer |  |
| `KAA907` | 打印时间 | `print_time` | string |  |
| `KAA908` | 打印人员 | `printer` | string |  |
| `KAA909` | 打印人员姓名 | `printer_name` | string |  |
| `KAA910` | 送审状态 | `submission_status` | string |  |
| `KAA911` | 送审人 | `reviewer` | string |  |
| `KAA912` | 审批人1 | `approver1` | string |  |
| `KAA913` | 审批结果 | `approval_result1` | string |  |
| `KAA914` | 审批意见 | `approval_opinion1` | string |  |
| `KAA915` | 审批人2 | `approver2` | string |  |
| `KAA916` | 审批结果 | `approval_result2` | string |  |
| `KAA917` | 审批意见 | `approval_opinion2` | string |  |
| `KAA918` | 审批人3 | `approver3` | string |  |
| `KAA919` | 审批结果 | `approval_result3` | string |  |
| `KAA920` | 审批意见 | `approval_opinion3` | string |  |
| `KAA921` | 审批人4 | `approver4` | string |  |
| `KAA922` | 审批结果 | `approval_result4` | string |  |
| `KAA923` | 审批意见 | `approval_opinion4` | string |  |
| `KAA924` | 审批人5 | `approver5` | string |  |
| `KAA925` | 审批结果 | `approval_result5` | string |  |
| `KAA926` | 审批意见 | `approval_opinion5` | string |  |
| `KAA927` | 审批人6 | `approver6` | string |  |
| `KAA928` | 审批结果 | `approval_result6` | string |  |
| `KAA929` | 审批意见 | `approval_opinion6` | string |  |
| `KAA930` | 终审人 | `final_approver` | string |  |
| `KAA931` | 审批结果 | `approval_result7` | string |  |
| `KAA932` | 审批意见 | `approval_opinion7` | string |  |
| `KAA933` | 通知人1 | `notifier1` | string |  |
| `KAA934` | 通知人2 | `notifier2` | string |  |
| `KAA935` | 通知人3 | `notifier3` | string |  |
| `KAA940` | 签核码 | `approval_code` | string |  |
| `KAA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `KAA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `KAA960` | 自定文字1 | `udf_text1` | string |  |
| `KAA961` | 自定文字2 | `udf_text2` | string |  |
| `KAA962` | 自定文字3 | `udf_text3` | string |  |
| `KAA963` | 自定文字4 | `udf_text4` | string |  |
| `KAA964` | 自定文字5 | `udf_text5` | string |  |
| `KAA965` | 自定文字6 | `udf_text6` | string |  |
| `KAA966` | 自定文字7 | `udf_text7` | string |  |
| `KAA967` | 自定文字8 | `udf_text8` | string |  |
| `KAA968` | 自定文字9 | `udf_text9` | string |  |
| `KAA969` | 自定文字10 | `udf_text10` | string |  |
| `KAA970` | 自定文字11 | `udf_text11` | string |  |
| `KAA971` | 自定文字12 | `udf_text12` | string |  |
| `KAA972` | 自定文字13 | `udf_text13` | string |  |
| `KAA973` | 自定文字14 | `udf_text14` | string |  |
| `KAA974` | 自定文字15 | `udf_text15` | string |  |
| `KAA975` | 自定文字16 | `udf_text16` | string |  |
| `KAA980` | 自定数字1 | `udf_no1` | float |  |
| `KAA981` | 自定数字2 | `udf_no2` | float |  |
| `KAA982` | 自定数字3 | `udf_no3` | float |  |
| `KAA983` | 自定数字4 | `udf_no4` | float |  |
| `KAA984` | 自定数字5 | `udf_no5` | float |  |
| `KAA985` | 自定数字6 | `udf_no6` | float |  |
| `KAA986` | 自定数字7 | `udf_no7` | float |  |
| `KAA987` | 自定数字8 | `udf_no8` | float |  |
| `KAA988` | 自定数字9 | `udf_no9` | float |  |
| `KAA989` | 自定数字10 | `udf_no10` | float |  |
| `KAA990` | 自定数字11 | `udf_no11` | float |  |
| `KAA991` | 自定数字12 | `udf_no12` | float |  |
| `KAA992` | 自定数字13 | `udf_no13` | float |  |
| `KAA993` | 自定数字14 | `udf_no14` | float |  |
| `KAA994` | 自定数字15 | `udf_no15` | float |  |
| `KAA995` | 自定数字16 | `udf_no16` | float |  |
| `KAA950` | 送审时间 | `submission_time_for_review` | string |  |
| `KAA951` | 审批时间1 | `approval_time1` | string |  |
| `KAA952` | 审批时间2 | `approval_time2` | string |  |
| `KAA953` | 审批时间3 | `approval_time3` | string |  |
| `KAA954` | 审批时间4 | `approval_time4` | string |  |
| `KAA955` | 审批时间5 | `approval_time5` | string |  |
| `KAA956` | 审批时间6 | `approval_time6` | string |  |
| `KAA957` | 终审时间 | `final_review_time` | string |  |
| `KAA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKKAB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `KAB001` | 单号 | `KAB001` | string |  |
| `KAB002` | 序号 | `KAB002` | string |  |
| `KAB003` | 品号 | `KAB003` | string |  |
| `KAB004` | 品名 | `KAB004` | string |  |
| `KAB005` | 单位 | `KAB005` | string |  |
| `KAB006` | 仓库 | `KAB006` | string |  |
| `KAB007` | 数量 | `KAB007` | float |  |
| `KAB008` | 单价 | `KAB008` | float |  |
| `KAB009` | 金额 | `KAB009` | string |  |
| `KAB010` | 本币金额 | `KAB010` | string |  |
| `KAB011` | 预还日期 | `KAB011` | string |  |
| `KAB012` | 还货数量 | `KAB012` | float |  |
| `KAB013` | 销货数量 | `KAB013` | float |  |
| `KAB014` | 预留字段 | `KAB014` | float |  |
| `KAB015` | 预留字段 | `KAB015` | float |  |
| `KAB016` | 预留字段 | `KAB016` | string |  |
| `KAB017` | 前置来源 | `KAB017` | string |  |
| `KAB018` | 前置单号 | `KAB018` | string |  |
| `KAB019` | 前置序号 | `KAB019` | string |  |
| `KAB020` | 预留字段 | `KAB020` | float |  |
| `KAB021` | 原币税额 | `KAB021` | string |  |
| `KAB022` | 本币税额 | `KAB022` | string |  |
| `KAB023` | 审核码 | `KAB023` | string |  |
| `KAB024` | 预留字段 | `KAB024` | string |  |
| `KAB025` | 预留字段 | `KAB025` | string |  |
| `KAB026` | 预留字段 | `KAB026` | string |  |
| `KAB027` | 预留字段 | `KAB027` | string |  |
| `KAB028` | 预留字段 | `KAB028` | string |  |
| `KAB029` | 预留字段 | `KAB029` | float |  |
| `KAB030` | 预留字段 | `KAB030` | float |  |
| `KAB031` | 含税 | `KAB031` | string |  |
| `KAB032` | 含税单价 | `KAB032` | float |  |
| `KAB033` | 价税合计 | `KAB033` | string |  |
| `KAB034` | 本币价税合计 | `KAB034` | string |  |
| `KAB035` | 批号 | `KAB035` | string |  |
| `KAB036` | 换算分子 | `KAB036` | float |  |
| `KAB037` | 换算分母 | `KAB037` | float |  |
| `KAB038` | 辅助单位 | `KAB038` | string |  |
| `KAB039` | 辅助数量 | `KAB039` | float |  |
| `KAB040` | 税率 | `KAB040` | float |  |
| `KAB041` | 规格 | `KAB041` | string |  |
| `KAB901` | 录入者编号 | `entry_person_no` | string |  |
| `KAB902` | 录入时间 | `entry_time` | string |  |
| `KAB903` | 更改者编号 | `changer_no` | string |  |
| `KAB904` | 更改时间 | `change_time` | string |  |
| `KAB905` | 更新标记 | `update_flag` | integer |  |
| `KAB960` | 自定文字1 | `udf_text1` | string |  |
| `KAB961` | 自定文字2 | `udf_text2` | string |  |
| `KAB962` | 自定文字3 | `udf_text3` | string |  |
| `KAB963` | 自定文字4 | `udf_text4` | string |  |
| `KAB964` | 自定文字5 | `udf_text5` | string |  |
| `KAB965` | 自定文字6 | `udf_text6` | string |  |
| `KAB980` | 自定数字1 | `udf_no1` | float |  |
| `KAB981` | 自定数字2 | `udf_no2` | float |  |
| `KAB982` | 自定数字3 | `udf_no3` | float |  |
| `KAB983` | 自定数字4 | `udf_no4` | float |  |
| `KAB984` | 自定数字5 | `udf_no5` | float |  |
| `KAB985` | 自定数字6 | `udf_no6` | float |  |
| `KAB966` | 自定文字7 | `udf_text7` | string |  |
| `KAB967` | 自定文字8 | `udf_text8` | string |  |
| `KAB968` | 自定文字9 | `udf_text9` | string |  |
| `KAB969` | 自定文字10 | `udf_text10` | string |  |
| `KAB970` | 自定文字11 | `udf_text11` | string |  |
| `KAB971` | 自定文字12 | `udf_text12` | string |  |
| `KAB972` | 自定文字13 | `udf_text13` | string |  |
| `KAB973` | 自定文字14 | `udf_text14` | string |  |
| `KAB974` | 自定文字15 | `udf_text15` | string |  |
| `KAB975` | 自定文字16 | `udf_text16` | string |  |
| `KAB986` | 自定数字7 | `udf_no7` | float |  |
| `KAB987` | 自定数字8 | `udf_no8` | float |  |
| `KAB988` | 自定数字9 | `udf_no9` | float |  |
| `KAB989` | 自定数字10 | `udf_no10` | float |  |
| `KAB990` | 自定数字11 | `udf_no11` | float |  |
| `KAB991` | 自定数字12 | `udf_no12` | float |  |
| `KAB992` | 自定数字13 | `udf_no13` | float |  |
| `KAB993` | 自定数字14 | `udf_no14` | float |  |
| `KAB994` | 自定数字15 | `udf_no15` | float |  |
| `KAB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "KAA001": ""
  ,"KAA002": ""
  ,"KAA003": ""
  ,"KAA004": ""
  ,"cdsDetail": [{
    "KAB001": ""
    ,"KAB001": ""
    ,"KAB002": ""
    ,"KAB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"KAA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"KAA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `KAA001` | `KAA001` | 单号 | 主键 |
| `KAA002` | `KAA002` | 性质 | |
| `KAA003` | `KAA003` | 日期 | |
| `KAA004` | `KAA004` | 客户 | |
| `KAA005` | `KAA005` | 请款客户 | |
| `KAA006` | `KAA006` | 经办人 | |
| `KAA007` | `KAA007` | 部门 | |
| `KAA008` | `KAA008` | 币种 | |
| `KAA009` | `KAA009` | 汇率 | |
| `KAA010` | `KAA010` | 专案 | |
| `KAB001` | `KAB001` | 单号 (单身) | |
| `KAB002` | `KAB002` | 序号 (单身) | |
| `KAB003` | `KAB003` | 品号 (单身) | |
| `KAB004` | `KAB004` | 品名 (单身) | |
| `KAB005` | `KAB005` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `KAA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `KAA001`
