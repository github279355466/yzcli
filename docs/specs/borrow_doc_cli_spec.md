# CLI 规格说明书：借入单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `borrow.doc` |
| **DLL** | `INVJC01` |
| **服务名称** | `借入单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "borrow.doc" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "borrow.doc" \
  --action "getMultiple" \
  --data '{"datakeys":[{"JAA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "borrow.doc" \
  --action "create" \
  --data '{"JAA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "borrow.doc" \
  --action "approve" \
  --data '{"datakeys":[{"JAA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `JAA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKJAA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JAA001` | 单号 | `JAA001` | string | 主键 |
| `JAA002` | 性质 | `JAA002` | string |  |
| `JAA003` | 日期 | `JAA003` | string |  |
| `JAA004` | 供应商 | `JAA004` | string |  |
| `JAA005` | 预留字段 | `JAA005` | string |  |
| `JAA006` | 经办人 | `JAA006` | string |  |
| `JAA007` | 部门 | `JAA007` | string |  |
| `JAA008` | 币种 | `JAA008` | string |  |
| `JAA009` | 汇率 | `JAA009` | float |  |
| `JAA010` | 专案 | `JAA010` | string |  |
| `JAA011` | 预还日期 | `JAA011` | string |  |
| `JAA012` | 送货邮编 | `JAA012` | string |  |
| `JAA013` | 送货地址 | `JAA013` | string |  |
| `JAA014` | 备注 | `JAA014` | string |  |
| `JAA015` | 复核编号 | `JAA015` | string |  |
| `JAA016` | 复核姓名 | `JAA016` | string |  |
| `JAA017` | 金额 | `JAA017` | float |  |
| `JAA018` | 本币金额 | `JAA018` | float |  |
| `JAA019` | 审核码 | `JAA019` | string |  |
| `JAA020` | 预留字段 | `JAA020` | string |  |
| `JAA021` | 预留字段 | `JAA021` | string |  |
| `JAA022` | 税率 | `JAA022` | float |  |
| `JAA023` | 本币税额 | `JAA023` | float |  |
| `JAA024` | 原币税额 | `JAA024` | float |  |
| `JAA025` | 预留字段 | `JAA025` | float |  |
| `JAA026` | 预留字段 | `JAA026` | float |  |
| `JAA027` | 预留字段 | `JAA027` | string |  |
| `JAA028` | 预留字段 | `JAA028` | string |  |
| `JAA029` | 预留字段 | `JAA029` | string |  |
| `JAA030` | 预留字段 | `JAA030` | string |  |
| `JAA031` | 预留字段 | `JAA031` | string |  |
| `JAA032` | 预留字段 | `JAA032` | string |  |
| `JAA033` | 预留字段 | `JAA033` | float |  |
| `JAA034` | 预留字段 | `JAA034` | float |  |
| `JAA035` | 审核人 | `JAA035` | string |  |
| `JAA036` | 价税合计 | `JAA036` | float |  |
| `JAA037` | 本币价税合计 | `JAA037` | float |  |
| `JAA901` | 录入者编号 | `entry_person_no` | string |  |
| `JAA902` | 录入时间 | `entry_time` | string |  |
| `JAA903` | 更改者编号 | `changer_no` | string |  |
| `JAA904` | 更改时间 | `change_time` | string |  |
| `JAA905` | 更新标记 | `update_flag` | integer |  |
| `JAA940` | 签核码 | `approval_code` | string |  |
| `JAA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `JAA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `JAA960` | 自定文字1 | `udf_text1` | string |  |
| `JAA961` | 自定文字2 | `udf_text2` | string |  |
| `JAA962` | 自定文字3 | `udf_text3` | string |  |
| `JAA963` | 自定文字4 | `udf_text4` | string |  |
| `JAA964` | 自定文字5 | `udf_text5` | string |  |
| `JAA965` | 自定文字6 | `udf_text6` | string |  |
| `JAA980` | 自定数字1 | `udf_no1` | float |  |
| `JAA981` | 自定数字2 | `udf_no2` | float |  |
| `JAA982` | 自定数字3 | `udf_no3` | float |  |
| `JAA983` | 自定数字4 | `udf_no4` | float |  |
| `JAA984` | 自定数字5 | `udf_no5` | float |  |
| `JAA985` | 自定数字6 | `udf_no6` | float |  |
| `JAA910` | 送审状态 | `submission_status` | string |  |
| `JAA911` | 送审人 | `reviewer` | string |  |
| `JAA912` | 审批人1 | `approver1` | string |  |
| `JAA913` | 审批结果 | `approval_result1` | string |  |
| `JAA914` | 审批意见 | `approval_opinion1` | string |  |
| `JAA915` | 审批人2 | `approver2` | string |  |
| `JAA916` | 审批结果 | `approval_result2` | string |  |
| `JAA917` | 审批意见 | `approval_opinion2` | string |  |
| `JAA918` | 审批人3 | `approver3` | string |  |
| `JAA919` | 审批结果 | `approval_result3` | string |  |
| `JAA920` | 审批意见 | `approval_opinion3` | string |  |
| `JAA921` | 审批人4 | `approver4` | string |  |
| `JAA922` | 审批结果 | `approval_result4` | string |  |
| `JAA923` | 审批意见 | `approval_opinion4` | string |  |
| `JAA924` | 审批人5 | `approver5` | string |  |
| `JAA925` | 审批结果 | `approval_result5` | string |  |
| `JAA926` | 审批意见 | `approval_opinion5` | string |  |
| `JAA927` | 审批人6 | `approver6` | string |  |
| `JAA928` | 审批结果 | `approval_result6` | string |  |
| `JAA929` | 审批意见 | `approval_opinion6` | string |  |
| `JAA930` | 终审人 | `final_approver` | string |  |
| `JAA931` | 审批结果 | `approval_result7` | string |  |
| `JAA932` | 审批意见 | `approval_opinion7` | string |  |
| `JAA933` | 通知人1 | `notifier1` | string |  |
| `JAA934` | 通知人2 | `notifier2` | string |  |
| `JAA935` | 通知人3 | `notifier3` | string |  |
| `JAA966` | 自定文字7 | `udf_text7` | string |  |
| `JAA967` | 自定文字8 | `udf_text8` | string |  |
| `JAA968` | 自定文字9 | `udf_text9` | string |  |
| `JAA969` | 自定文字10 | `udf_text10` | string |  |
| `JAA970` | 自定文字11 | `udf_text11` | string |  |
| `JAA971` | 自定文字12 | `udf_text12` | string |  |
| `JAA972` | 自定文字13 | `udf_text13` | string |  |
| `JAA973` | 自定文字14 | `udf_text14` | string |  |
| `JAA974` | 自定文字15 | `udf_text15` | string |  |
| `JAA975` | 自定文字16 | `udf_text16` | string |  |
| `JAA986` | 自定数字7 | `udf_no7` | float |  |
| `JAA987` | 自定数字8 | `udf_no8` | float |  |
| `JAA988` | 自定数字9 | `udf_no9` | float |  |
| `JAA989` | 自定数字10 | `udf_no10` | float |  |
| `JAA990` | 自定数字11 | `udf_no11` | float |  |
| `JAA991` | 自定数字12 | `udf_no12` | float |  |
| `JAA992` | 自定数字13 | `udf_no13` | float |  |
| `JAA993` | 自定数字14 | `udf_no14` | float |  |
| `JAA994` | 自定数字15 | `udf_no15` | float |  |
| `JAA995` | 自定数字16 | `udf_no16` | float |  |
| `JAA906` | 打印次数 | `print_count` | integer |  |
| `JAA907` | 打印时间 | `print_time` | string |  |
| `JAA908` | 打印人员 | `printer` | string |  |
| `JAA909` | 打印人员姓名 | `printer_name` | string |  |
| `JAA950` | 送审时间 | `submission_time_for_review` | string |  |
| `JAA951` | 审批时间1 | `approval_time1` | string |  |
| `JAA952` | 审批时间2 | `approval_time2` | string |  |
| `JAA953` | 审批时间3 | `approval_time3` | string |  |
| `JAA954` | 审批时间4 | `approval_time4` | string |  |
| `JAA955` | 审批时间5 | `approval_time5` | string |  |
| `JAA956` | 审批时间6 | `approval_time6` | string |  |
| `JAA957` | 终审时间 | `final_review_time` | string |  |
| `JAA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKJAB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `JAB001` | 单号 | `JAB001` | string |  |
| `JAB002` | 序号 | `JAB002` | string |  |
| `JAB003` | 品号 | `JAB003` | string |  |
| `JAB004` | 品名 | `JAB004` | string |  |
| `JAB005` | 单位 | `JAB005` | string |  |
| `JAB006` | 仓库 | `JAB006` | string |  |
| `JAB007` | 数量 | `JAB007` | float |  |
| `JAB008` | 单价 | `JAB008` | float |  |
| `JAB009` | 金额 | `JAB009` | string |  |
| `JAB010` | 本币金额 | `JAB010` | string |  |
| `JAB011` | 预还日期 | `JAB011` | string |  |
| `JAB012` | 还货数量 | `JAB012` | float |  |
| `JAB013` | 进货数量 | `JAB013` | float |  |
| `JAB014` | 预留字段 | `JAB014` | float |  |
| `JAB015` | 预留字段 | `JAB015` | float |  |
| `JAB016` | 预留字段 | `JAB016` | string |  |
| `JAB017` | 前置来源 | `JAB017` | string |  |
| `JAB018` | 前置单号 | `JAB018` | string |  |
| `JAB019` | 前置序号 | `JAB019` | string |  |
| `JAB020` | 预留字段 | `JAB020` | float |  |
| `JAB021` | 原币税额 | `JAB021` | string |  |
| `JAB022` | 本币税额 | `JAB022` | string |  |
| `JAB023` | 审核码 | `JAB023` | string |  |
| `JAB024` | 预留字段 | `JAB024` | string |  |
| `JAB025` | 预留字段 | `JAB025` | string |  |
| `JAB026` | 预留字段 | `JAB026` | string |  |
| `JAB027` | 预留字段 | `JAB027` | string |  |
| `JAB028` | 预留字段 | `JAB028` | string |  |
| `JAB029` | 预留字段 | `JAB029` | float |  |
| `JAB030` | 预留字段 | `JAB030` | float |  |
| `JAB031` | 含税 | `JAB031` | string |  |
| `JAB032` | 含税单价 | `JAB032` | float |  |
| `JAB033` | 价税合计 | `JAB033` | string |  |
| `JAB034` | 本币价税合计 | `JAB034` | string |  |
| `JAB035` | 批号 | `JAB035` | string |  |
| `JAB036` | 换算分子 | `JAB036` | float |  |
| `JAB037` | 换算分母 | `JAB037` | float |  |
| `JAB038` | 辅助单位 | `JAB038` | string |  |
| `JAB039` | 辅助数量 | `JAB039` | float |  |
| `JAB040` | 税率 | `JAB040` | float |  |
| `JAB041` | 规格 | `JAB041` | string |  |
| `JAB901` | 录入者编号 | `entry_person_no` | string |  |
| `JAB902` | 录入时间 | `entry_time` | string |  |
| `JAB903` | 更改者编号 | `changer_no` | string |  |
| `JAB904` | 更改时间 | `change_time` | string |  |
| `JAB905` | 更新标记 | `update_flag` | integer |  |
| `JAB960` | 自定文字1 | `udf_text1` | string |  |
| `JAB961` | 自定文字2 | `udf_text2` | string |  |
| `JAB962` | 自定文字3 | `udf_text3` | string |  |
| `JAB963` | 自定文字4 | `udf_text4` | string |  |
| `JAB964` | 自定文字5 | `udf_text5` | string |  |
| `JAB965` | 自定文字6 | `udf_text6` | string |  |
| `JAB980` | 自定数字1 | `udf_no1` | float |  |
| `JAB981` | 自定数字2 | `udf_no2` | float |  |
| `JAB982` | 自定数字3 | `udf_no3` | float |  |
| `JAB983` | 自定数字4 | `udf_no4` | float |  |
| `JAB984` | 自定数字5 | `udf_no5` | float |  |
| `JAB985` | 自定数字6 | `udf_no6` | float |  |
| `JAB042` | 批号说明 | `JAB042` | string |  |
| `JAB043` | 生产日期 | `JAB043` | string |  |
| `JAB044` | 有效日期 | `JAB044` | string |  |
| `JAB966` | 自定文字7 | `udf_text7` | string |  |
| `JAB967` | 自定文字8 | `udf_text8` | string |  |
| `JAB968` | 自定文字9 | `udf_text9` | string |  |
| `JAB969` | 自定文字10 | `udf_text10` | string |  |
| `JAB970` | 自定文字11 | `udf_text11` | string |  |
| `JAB971` | 自定文字12 | `udf_text12` | string |  |
| `JAB972` | 自定文字13 | `udf_text13` | string |  |
| `JAB973` | 自定文字14 | `udf_text14` | string |  |
| `JAB974` | 自定文字15 | `udf_text15` | string |  |
| `JAB975` | 自定文字16 | `udf_text16` | string |  |
| `JAB986` | 自定数字7 | `udf_no7` | float |  |
| `JAB987` | 自定数字8 | `udf_no8` | float |  |
| `JAB988` | 自定数字9 | `udf_no9` | float |  |
| `JAB989` | 自定数字10 | `udf_no10` | float |  |
| `JAB990` | 自定数字11 | `udf_no11` | float |  |
| `JAB991` | 自定数字12 | `udf_no12` | float |  |
| `JAB992` | 自定数字13 | `udf_no13` | float |  |
| `JAB993` | 自定数字14 | `udf_no14` | float |  |
| `JAB994` | 自定数字15 | `udf_no15` | float |  |
| `JAB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "JAA001": ""
  ,"JAA002": ""
  ,"JAA003": ""
  ,"JAA004": ""
  ,"cdsDetail": [{
    "JAB001": ""
    ,"JAB001": ""
    ,"JAB002": ""
    ,"JAB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"JAA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"JAA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `JAA001` | `JAA001` | 单号 | 主键 |
| `JAA002` | `JAA002` | 性质 | |
| `JAA003` | `JAA003` | 日期 | |
| `JAA004` | `JAA004` | 供应商 | |
| `JAA005` | `JAA005` | 预留字段 | |
| `JAA006` | `JAA006` | 经办人 | |
| `JAA007` | `JAA007` | 部门 | |
| `JAA008` | `JAA008` | 币种 | |
| `JAA009` | `JAA009` | 汇率 | |
| `JAA010` | `JAA010` | 专案 | |
| `JAB001` | `JAB001` | 单号 (单身) | |
| `JAB002` | `JAB002` | 序号 (单身) | |
| `JAB003` | `JAB003` | 品号 (单身) | |
| `JAB004` | `JAB004` | 品名 (单身) | |
| `JAB005` | `JAB005` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `JAA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `JAA001`
