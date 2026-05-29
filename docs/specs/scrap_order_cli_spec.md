# CLI 规格说明书：报废单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `scrap.order` |
| **DLL** | `INVKC11` |
| **服务名称** | `报废单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "scrap.order" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "scrap.order" \
  --action "getMultiple" \
  --data '{"datakeys":[{"LJA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "scrap.order" \
  --action "create" \
  --data '{"LJA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "scrap.order" \
  --action "approve" \
  --data '{"datakeys":[{"LJA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `LJA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKLJA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LJA001` | 单号 | `LJA001` | string | 主键 |
| `LJA002` | 性质 | `LJA002` | string |  |
| `LJA003` | 日期 | `LJA003` | string |  |
| `LJA004` | 单据类别 | `LJA004` | string |  |
| `LJA005` | 经办人 | `LJA005` | string |  |
| `LJA006` | 项目 | `LJA006` | string |  |
| `LJA007` | 凭证抛转否 | `LJA007` | string |  |
| `LJA008` | 凭证 | `LJA008` | string |  |
| `LJA009` | 来源 | `LJA009` | string |  |
| `LJA010` | 来源单号 | `LJA010` | string |  |
| `LJA011` | 备注 | `LJA011` | string |  |
| `LJA012` | 审核码 | `LJA012` | string |  |
| `LJA013` | 调整方式 | `LJA013` | string |  |
| `LJA014` | 审核人 | `LJA014` | string |  |
| `LJA015` | 凭证类别 | `LJA015` | string |  |
| `LJA016` | 部门 | `LJA016` | string |  |
| `LJA017` | 日期 | `LJA017` | string |  |
| `LJA018` | 预留字段 | `LJA018` | string |  |
| `LJA019` | 预留字段 | `LJA019` | string |  |
| `LJA020` | 预留字段 | `LJA020` | string |  |
| `LJA021` | 预留字段 | `LJA021` | string |  |
| `LJA022` | 预留字段 | `LJA022` | float |  |
| `LJA023` | 预留字段 | `LJA023` | float |  |
| `LJA024` | 审核时间 | `LJA024` | string |  |
| `LJA901` | 录入者编号 | `entry_person_no` | string |  |
| `LJA902` | 录入时间 | `entry_time` | string |  |
| `LJA903` | 更改者编号 | `changer_no` | string |  |
| `LJA904` | 更改时间 | `change_time` | string |  |
| `LJA905` | 更新标记 | `update_flag` | integer |  |
| `LJA940` | 签核码 | `approval_code` | string |  |
| `LJA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `LJA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `LJA960` | 自定文字1 | `udf_text1` | string |  |
| `LJA961` | 自定文字2 | `udf_text2` | string |  |
| `LJA962` | 自定文字3 | `udf_text3` | string |  |
| `LJA963` | 自定文字4 | `udf_text4` | string |  |
| `LJA964` | 自定文字5 | `udf_text5` | string |  |
| `LJA965` | 自定文字6 | `udf_text6` | string |  |
| `LJA980` | 自定数字1 | `udf_no1` | float |  |
| `LJA981` | 自定数字2 | `udf_no2` | float |  |
| `LJA982` | 自定数字3 | `udf_no3` | float |  |
| `LJA983` | 自定数字4 | `udf_no4` | float |  |
| `LJA984` | 自定数字5 | `udf_no5` | float |  |
| `LJA985` | 自定数字6 | `udf_no6` | float |  |
| `LJA910` | 送审状态 | `submission_status` | string |  |
| `LJA911` | 送审人 | `reviewer` | string |  |
| `LJA912` | 审批人1 | `approver1` | string |  |
| `LJA913` | 审批结果 | `approval_result1` | string |  |
| `LJA914` | 审批意见 | `approval_opinion1` | string |  |
| `LJA915` | 审批人2 | `approver2` | string |  |
| `LJA916` | 审批结果 | `approval_result2` | string |  |
| `LJA917` | 审批意见 | `approval_opinion2` | string |  |
| `LJA918` | 审批人3 | `approver3` | string |  |
| `LJA919` | 审批结果 | `approval_result3` | string |  |
| `LJA920` | 审批意见 | `approval_opinion3` | string |  |
| `LJA921` | 审批人4 | `approver4` | string |  |
| `LJA922` | 审批结果 | `approval_result4` | string |  |
| `LJA923` | 审批意见 | `approval_opinion4` | string |  |
| `LJA924` | 审批人5 | `approver5` | string |  |
| `LJA925` | 审批结果 | `approval_result5` | string |  |
| `LJA926` | 审批意见 | `approval_opinion5` | string |  |
| `LJA927` | 审批人6 | `approver6` | string |  |
| `LJA928` | 审批结果 | `approval_result6` | string |  |
| `LJA929` | 审批意见 | `approval_opinion6` | string |  |
| `LJA930` | 终审人 | `final_approver` | string |  |
| `LJA931` | 审批结果 | `approval_result7` | string |  |
| `LJA932` | 审批意见 | `approval_opinion7` | string |  |
| `LJA933` | 通知人1 | `notifier1` | string |  |
| `LJA934` | 通知人2 | `notifier2` | string |  |
| `LJA935` | 通知人3 | `notifier3` | string |  |
| `LJA966` | 自定文字7 | `udf_text7` | string |  |
| `LJA967` | 自定文字8 | `udf_text8` | string |  |
| `LJA968` | 自定文字9 | `udf_text9` | string |  |
| `LJA969` | 自定文字10 | `udf_text10` | string |  |
| `LJA970` | 自定文字11 | `udf_text11` | string |  |
| `LJA971` | 自定文字12 | `udf_text12` | string |  |
| `LJA972` | 自定文字13 | `udf_text13` | string |  |
| `LJA973` | 自定文字14 | `udf_text14` | string |  |
| `LJA974` | 自定文字15 | `udf_text15` | string |  |
| `LJA975` | 自定文字16 | `udf_text16` | string |  |
| `LJA986` | 自定数字7 | `udf_no7` | float |  |
| `LJA987` | 自定数字8 | `udf_no8` | float |  |
| `LJA988` | 自定数字9 | `udf_no9` | float |  |
| `LJA989` | 自定数字10 | `udf_no10` | float |  |
| `LJA990` | 自定数字11 | `udf_no11` | float |  |
| `LJA991` | 自定数字12 | `udf_no12` | float |  |
| `LJA992` | 自定数字13 | `udf_no13` | float |  |
| `LJA993` | 自定数字14 | `udf_no14` | float |  |
| `LJA994` | 自定数字15 | `udf_no15` | float |  |
| `LJA995` | 自定数字16 | `udf_no16` | float |  |
| `LJA906` | 打印次数 | `print_count` | integer |  |
| `LJA907` | 打印时间 | `print_time` | string |  |
| `LJA908` | 打印人员 | `printer` | string |  |
| `LJA909` | 打印人员姓名 | `printer_name` | string |  |
| `LJA950` | 送审时间 | `submission_time_for_review` | string |  |
| `LJA951` | 审批时间1 | `approval_time1` | string |  |
| `LJA952` | 审批时间2 | `approval_time2` | string |  |
| `LJA953` | 审批时间3 | `approval_time3` | string |  |
| `LJA954` | 审批时间4 | `approval_time4` | string |  |
| `LJA955` | 审批时间5 | `approval_time5` | string |  |
| `LJA956` | 审批时间6 | `approval_time6` | string |  |
| `LJA957` | 终审时间 | `final_review_time` | string |  |
| `LJA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKLJB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LJB001` | 单号 | `LJB001` | string |  |
| `LJB002` | 序号 | `LJB002` | string |  |
| `LJB003` | 品号 | `LJB003` | string |  |
| `LJB004` | 品名 | `LJB004` | string |  |
| `LJB005` | 单位 | `LJB005` | string |  |
| `LJB006` | 转出仓库 | `LJB006` | string |  |
| `LJB007` | 转入仓库 | `LJB007` | string |  |
| `LJB008` | 数量 | `LJB008` | float |  |
| `LJB009` | 审核码 | `LJB009` | string |  |
| `LJB010` | 日期 | `LJB010` | string |  |
| `LJB011` | 预留字段 | `LJB011` | string |  |
| `LJB012` | 预留字段 | `LJB012` | string |  |
| `LJB013` | 预留字段 | `LJB013` | string |  |
| `LJB014` | 预留字段 | `LJB014` | string |  |
| `LJB015` | 预留字段 | `LJB015` | float |  |
| `LJB016` | 预留字段 | `LJB016` | float |  |
| `LJB017` | 批号 | `LJB017` | string |  |
| `LJB018` | 换算分子 | `LJB018` | float |  |
| `LJB019` | 换算分母 | `LJB019` | float |  |
| `LJB020` | 辅助单位 | `LJB020` | string |  |
| `LJB021` | 辅助数量 | `LJB021` | float |  |
| `LJB022` | 规格 | `LJB022` | string |  |
| `LJB023` | 来源 | `LJB023` | string |  |
| `LJB024` | 来源单号 | `LJB024` | string |  |
| `LJB025` | 来源序号 | `LJB025` | string |  |
| `LJB901` | 录入者编号 | `entry_person_no` | string |  |
| `LJB902` | 录入时间 | `entry_time` | string |  |
| `LJB903` | 更改者编号 | `changer_no` | string |  |
| `LJB904` | 更改时间 | `change_time` | string |  |
| `LJB905` | 更新标记 | `update_flag` | integer |  |
| `LJB960` | 自定文字1 | `udf_text1` | string |  |
| `LJB961` | 自定文字2 | `udf_text2` | string |  |
| `LJB962` | 自定文字3 | `udf_text3` | string |  |
| `LJB963` | 自定文字4 | `udf_text4` | string |  |
| `LJB964` | 自定文字5 | `udf_text5` | string |  |
| `LJB965` | 自定文字6 | `udf_text6` | string |  |
| `LJB980` | 自定数字1 | `udf_no1` | float |  |
| `LJB981` | 自定数字2 | `udf_no2` | float |  |
| `LJB982` | 自定数字3 | `udf_no3` | float |  |
| `LJB983` | 自定数字4 | `udf_no4` | float |  |
| `LJB984` | 自定数字5 | `udf_no5` | float |  |
| `LJB985` | 自定数字6 | `udf_no6` | float |  |
| `LJB966` | 自定文字7 | `udf_text7` | string |  |
| `LJB967` | 自定文字8 | `udf_text8` | string |  |
| `LJB968` | 自定文字9 | `udf_text9` | string |  |
| `LJB969` | 自定文字10 | `udf_text10` | string |  |
| `LJB970` | 自定文字11 | `udf_text11` | string |  |
| `LJB971` | 自定文字12 | `udf_text12` | string |  |
| `LJB972` | 自定文字13 | `udf_text13` | string |  |
| `LJB973` | 自定文字14 | `udf_text14` | string |  |
| `LJB974` | 自定文字15 | `udf_text15` | string |  |
| `LJB975` | 自定文字16 | `udf_text16` | string |  |
| `LJB986` | 自定数字7 | `udf_no7` | float |  |
| `LJB987` | 自定数字8 | `udf_no8` | float |  |
| `LJB988` | 自定数字9 | `udf_no9` | float |  |
| `LJB989` | 自定数字10 | `udf_no10` | float |  |
| `LJB990` | 自定数字11 | `udf_no11` | float |  |
| `LJB991` | 自定数字12 | `udf_no12` | float |  |
| `LJB992` | 自定数字13 | `udf_no13` | float |  |
| `LJB993` | 自定数字14 | `udf_no14` | float |  |
| `LJB994` | 自定数字15 | `udf_no15` | float |  |
| `LJB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "LJA001": ""
  ,"LJA002": ""
  ,"LJA003": ""
  ,"LJA004": ""
  ,"cdsDetail": [{
    "LJB001": ""
    ,"LJB001": ""
    ,"LJB002": ""
    ,"LJB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"LJA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"LJA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `LJA001` | `LJA001` | 单号 | 主键 |
| `LJA002` | `LJA002` | 性质 | |
| `LJA003` | `LJA003` | 日期 | |
| `LJA004` | `LJA004` | 单据类别 | |
| `LJA005` | `LJA005` | 经办人 | |
| `LJA006` | `LJA006` | 项目 | |
| `LJA007` | `LJA007` | 凭证抛转否 | |
| `LJA008` | `LJA008` | 凭证 | |
| `LJA009` | `LJA009` | 来源 | |
| `LJA010` | `LJA010` | 来源单号 | |
| `LJB001` | `LJB001` | 单号 (单身) | |
| `LJB002` | `LJB002` | 序号 (单身) | |
| `LJB003` | `LJB003` | 品号 (单身) | |
| `LJB004` | `LJB004` | 品名 (单身) | |
| `LJB005` | `LJB005` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `LJA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `LJA001`
