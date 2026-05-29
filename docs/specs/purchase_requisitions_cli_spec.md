# CLI 规格说明书：请购单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `purchase.requisitions` |
| **DLL** | `PURCC02` |
| **服务名称** | `请购单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.requisitions" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.requisitions" \
  --action "getMultiple" \
  --data '{"datakeys":[{"HBA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.requisitions" \
  --action "create" \
  --data '{"HBA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "purchase.requisitions" \
  --action "approve" \
  --data '{"datakeys":[{"HBA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `HBA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (DCSHBA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HBA001` | 单号 | `docNo` | string | 主键 |
| `HBA002` | 性质 | `nature` | string |  |
| `HBA003` | 日期 | `date` | string |  |
| `HBA004` | 请购人 | `requisitioner` | string |  |
| `HBA005` | 部门 | `dept` | string |  |
| `HBA006` | 专案编号 | `project_no` | string |  |
| `HBA007` | 备注 | `remarks` | string |  |
| `HBA008` | 审核码 | `approve_status` | string |  |
| `HBA009` | 复核编号 | `review_no` | string |  |
| `HBA010` | 复核姓名 | `review_name` | string |  |
| `HBA011` | 预留字段 | `reserved_field1` | string |  |
| `HBA012` | 预留字段 | `reserved_field2` | string |  |
| `HBA013` | 预留字段 | `reserved_field3` | string |  |
| `HBA014` | 预留字段 | `reserved_field4` | string |  |
| `HBA015` | 预留字段 | `reserved_field5` | float |  |
| `HBA016` | 预留字段 | `reserved_field6` | float |  |
| `HBA017` | 预留字段 | `reserved_field7` | string |  |
| `HBA018` | 审核人 | `auditor` | string |  |
| `HBA901` | 录入者编号 | `entry_person_no` | string |  |
| `HBA902` | 录入时间 | `entry_time` | string |  |
| `HBA903` | 更改者编号 | `changer_no` | string |  |
| `HBA904` | 更改时间 | `change_time` | string |  |
| `HBA905` | 更新标记 | `update_flag` | integer |  |
| `HBA906` | 打印次数 | `print_count` | integer |  |
| `HBA907` | 打印时间 | `print_time` | string |  |
| `HBA908` | 打印人员 | `printer` | string |  |
| `HBA909` | 打印人员姓名 | `printer_name` | string |  |
| `HBA910` | 送审状态 | `submission_status` | string |  |
| `HBA911` | 送审人 | `reviewer` | string |  |
| `HBA912` | 审批人1 | `approver1` | string |  |
| `HBA913` | 审批结果 | `approval_result1` | string |  |
| `HBA914` | 审批意见 | `approval_opinion1` | string |  |
| `HBA915` | 审批人2 | `approver2` | string |  |
| `HBA916` | 审批结果 | `approval_result2` | string |  |
| `HBA917` | 审批意见 | `approval_opinion2` | string |  |
| `HBA918` | 审批人3 | `approver3` | string |  |
| `HBA919` | 审批结果 | `approval_result3` | string |  |
| `HBA920` | 审批意见 | `approval_opinion3` | string |  |
| `HBA921` | 审批人4 | `approver4` | string |  |
| `HBA922` | 审批结果 | `approval_result4` | string |  |
| `HBA923` | 审批意见 | `approval_opinion4` | string |  |
| `HBA924` | 审批人5 | `approver5` | string |  |
| `HBA925` | 审批结果 | `approval_result5` | string |  |
| `HBA926` | 审批意见 | `approval_opinion5` | string |  |
| `HBA927` | 审批人6 | `approver6` | string |  |
| `HBA928` | 审批结果 | `approval_result6` | string |  |
| `HBA929` | 审批意见 | `approval_opinion6` | string |  |
| `HBA930` | 终审人 | `final_approver` | string |  |
| `HBA931` | 审批结果 | `approval_result7` | string |  |
| `HBA932` | 审批意见 | `approval_opinion7` | string |  |
| `HBA933` | 通知人1 | `notifier1` | string |  |
| `HBA934` | 通知人2 | `notifier2` | string |  |
| `HBA935` | 通知人3 | `notifier3` | string |  |
| `HBA940` | 签核码 | `approval_code` | string |  |
| `HBA941` | 工作流表单代号 | `workflow_form_code` | string |  |
| `HBA942` | 工作流表单编号 | `workflow_form_no` | string |  |
| `HBA950` | 送审时间 | `submission_time_for_review` | string |  |
| `HBA951` | 审批时间1 | `approval_time1` | string |  |
| `HBA952` | 审批时间2 | `approval_time2` | string |  |
| `HBA953` | 审批时间3 | `approval_time3` | string |  |
| `HBA954` | 审批时间4 | `approval_time4` | string |  |
| `HBA955` | 审批时间5 | `approval_time5` | string |  |
| `HBA956` | 审批时间6 | `approval_time6` | string |  |
| `HBA957` | 终审时间 | `final_review_time` | string |  |
| `HBA959` | 审核时间 | `review_time` | string |  |
| `HBA960` | 自定文字1 | `udf_text1` | string |  |
| `HBA961` | 自定文字2 | `udf_text2` | string |  |
| `HBA962` | 自定文字3 | `udf_text3` | string |  |
| `HBA963` | 自定文字4 | `udf_text4` | string |  |
| `HBA964` | 自定文字5 | `udf_text5` | string |  |
| `HBA965` | 自定文字6 | `udf_text6` | string |  |
| `HBA966` | 自定文字7 | `udf_text7` | string |  |
| `HBA967` | 自定文字8 | `udf_text8` | string |  |
| `HBA968` | 自定文字9 | `udf_text9` | string |  |
| `HBA969` | 自定文字10 | `udf_text10` | string |  |
| `HBA970` | 自定文字11 | `udf_text11` | string |  |
| `HBA971` | 自定文字12 | `udf_text12` | string |  |
| `HBA972` | 自定文字13 | `udf_text13` | string |  |
| `HBA973` | 自定文字14 | `udf_text14` | string |  |
| `HBA974` | 自定文字15 | `udf_text15` | string |  |
| `HBA975` | 自定文字16 | `udf_text16` | string |  |
| `HBA980` | 自定数字1 | `udf_no1` | float |  |
| `HBA981` | 自定数字2 | `udf_no2` | float |  |
| `HBA982` | 自定数字3 | `udf_no3` | float |  |
| `HBA983` | 自定数字4 | `udf_no4` | float |  |
| `HBA984` | 自定数字5 | `udf_no5` | float |  |
| `HBA985` | 自定数字6 | `udf_no6` | float |  |
| `HBA986` | 自定数字7 | `udf_no7` | float |  |
| `HBA987` | 自定数字8 | `udf_no8` | float |  |
| `HBA988` | 自定数字9 | `udf_no9` | float |  |
| `HBA989` | 自定数字10 | `udf_no10` | float |  |
| `HBA990` | 自定数字11 | `udf_no11` | float |  |
| `HBA991` | 自定数字12 | `udf_no12` | float |  |
| `HBA992` | 自定数字13 | `udf_no13` | float |  |
| `HBA993` | 自定数字14 | `udf_no14` | float |  |
| `HBA994` | 自定数字15 | `udf_no15` | float |  |
| `HBA995` | 自定数字16 | `udf_no16` | float |  |

### 3.2 单身表 (DCSHBB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `HBB001` | 单号 | `docNo` | string |  |
| `HBB002` | 序号 | `seq` | string |  |
| `HBB003` | 品号 | `item_no` | string |  |
| `HBB004` | 品名 | `product_name` | string |  |
| `HBB005` | 单位 | `unit` | string |  |
| `HBB006` | 数量 | `qty` | float |  |
| `HBB007` | 需求日期 | `demand_date` | string |  |
| `HBB008` | 已采 | `already_purchased` | string |  |
| `HBB009` | 审核码 | `approve_status` | string |  |
| `HBB010` | 预留字段 | `reserved_field1` | string |  |
| `HBB011` | 预留字段 | `reserved_field2` | string |  |
| `HBB012` | 预留字段 | `reserved_field3` | string |  |
| `HBB013` | 预留字段 | `reserved_field4` | string |  |
| `HBB014` | 预留字段 | `reserved_field5` | float |  |
| `HBB015` | 预留字段 | `reserved_field6` | float |  |
| `HBB016` | 预留字段 | `reserved_field7` | string |  |
| `HBB017` | 换算分子 | `conversion_numerator` | float |  |
| `HBB018` | 换算分母 | `conversion_denominator` | float |  |
| `HBB019` | 辅助单位 | `auxiliary_unit` | string |  |
| `HBB020` | 辅助数量 | `auxiliary_qty` | float |  |
| `HBB021` | 规格 | `specification` | string |  |
| `HBB022` | 结束 | `end` | string |  |
| `HBB023` | 底稿量 | `draft_qty` | float |  |
| `HBB024` | 直接采购量 | `direct_purchase_qty` | float |  |
| `HBB025` | 指定结束原因 | `specified_end_reason` | string |  |
| `HBB901` | 录入者编号 | `entry_person_no` | string |  |
| `HBB902` | 录入时间 | `entry_time` | string |  |
| `HBB903` | 更改者编号 | `changer_no` | string |  |
| `HBB904` | 更改时间 | `change_time` | string |  |
| `HBB905` | 更新标记 | `update_flag` | integer |  |
| `HBB960` | 自定文字1 | `udf_text1` | string |  |
| `HBB961` | 自定文字2 | `udf_text2` | string |  |
| `HBB962` | 自定文字3 | `udf_text3` | string |  |
| `HBB963` | 自定文字4 | `udf_text4` | string |  |
| `HBB964` | 自定文字5 | `udf_text5` | string |  |
| `HBB965` | 自定文字6 | `udf_text6` | string |  |
| `HBB966` | 自定文字7 | `udf_text7` | string |  |
| `HBB967` | 自定文字8 | `udf_text8` | string |  |
| `HBB968` | 自定文字9 | `udf_text9` | string |  |
| `HBB969` | 自定文字10 | `udf_text10` | string |  |
| `HBB970` | 自定文字11 | `udf_text11` | string |  |
| `HBB971` | 自定文字12 | `udf_text12` | string |  |
| `HBB972` | 自定文字13 | `udf_text13` | string |  |
| `HBB973` | 自定文字14 | `udf_text14` | string |  |
| `HBB974` | 自定文字15 | `udf_text15` | string |  |
| `HBB975` | 自定文字16 | `udf_text16` | string |  |
| `HBB980` | 自定数字1 | `udf_no1` | float |  |
| `HBB981` | 自定数字2 | `udf_no2` | float |  |
| `HBB982` | 自定数字3 | `udf_no3` | float |  |
| `HBB983` | 自定数字4 | `udf_no4` | float |  |
| `HBB984` | 自定数字5 | `udf_no5` | float |  |
| `HBB985` | 自定数字6 | `udf_no6` | float |  |
| `HBB986` | 自定数字7 | `udf_no7` | float |  |
| `HBB987` | 自定数字8 | `udf_no8` | float |  |
| `HBB988` | 自定数字9 | `udf_no9` | float |  |
| `HBB989` | 自定数字10 | `udf_no10` | float |  |
| `HBB990` | 自定数字11 | `udf_no11` | float |  |
| `HBB991` | 自定数字12 | `udf_no12` | float |  |
| `HBB992` | 自定数字13 | `udf_no13` | float |  |
| `HBB993` | 自定数字14 | `udf_no14` | float |  |
| `HBB994` | 自定数字15 | `udf_no15` | float |  |
| `HBB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "HBA001": ""
  ,"HBA002": ""
  ,"HBA003": ""
  ,"HBA004": ""
  ,"cdsDetail": [{
    "HBB001": ""
    ,"HBB001": ""
    ,"HBB002": ""
    ,"HBB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"HBA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"docNo","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `HBA001` | `docNo` | 单号 | 主键 |
| `HBA002` | `nature` | 性质 | |
| `HBA003` | `date` | 日期 | |
| `HBA004` | `requisitioner` | 请购人 | |
| `HBA005` | `dept` | 部门 | |
| `HBA006` | `project_no` | 专案编号 | |
| `HBA007` | `remarks` | 备注 | |
| `HBA008` | `approve_status` | 审核码 | |
| `HBA009` | `review_no` | 复核编号 | |
| `HBA010` | `review_name` | 复核姓名 | |
| `HBB001` | `docNo` | 单号 (单身) | |
| `HBB002` | `seq` | 序号 (单身) | |
| `HBB003` | `item_no` | 品号 (单身) | |
| `HBB004` | `product_name` | 品名 (单身) | |
| `HBB005` | `unit` | 单位 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `HBA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `HBA001`
