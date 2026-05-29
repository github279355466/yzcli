# CLI 规格说明书：副产品入库单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `sub.product.stock.in` |
| **DLL** | `SGMZC14` |
| **服务名称** | `副产品入库单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sub.product.stock.in" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sub.product.stock.in" \
  --action "getMultiple" \
  --data '{"datakeys":[{"RLA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sub.product.stock.in" \
  --action "create" \
  --data '{"RLA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "sub.product.stock.in" \
  --action "approve" \
  --data '{"datakeys":[{"RLA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `RLA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (SGMRLA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RLA001` | 单号 | `RLA001` | string | 主键 |
| `RLA002` | 性质 | `RLA002` | string |  |
| `RLA003` | 日期 | `RLA003` | string |  |
| `RLA004` | 经办人 | `RLA004` | string |  |
| `RLA005` | 部门 | `RLA005` | string |  |
| `RLA006` | 工单单号 | `RLA006` | string |  |
| `RLA007` | 主件品号 | `RLA007` | string |  |
| `RLA008` | 凭证抛转否 | `RLA008` | string |  |
| `RLA009` | 凭证 | `RLA009` | string |  |
| `RLA010` | 凭证类别 | `RLA010` | string |  |
| `RLA011` | 审核码 | `RLA011` | string |  |
| `RLA012` | 审核人 | `RLA012` | string |  |
| `RLA013` | 备注 | `RLA013` | string |  |
| `RLA014` | 来源单号 | `RLA014` | string |  |
| `RLA015` | 来源序号 | `RLA015` | string |  |
| `RLA016` | 审核时间 | `RLA016` | string |  |
| `RLA960` | 自定文字1 | `udf_text1` | string |  |
| `RLA961` | 自定文字2 | `udf_text2` | string |  |
| `RLA962` | 自定文字3 | `udf_text3` | string |  |
| `RLA963` | 自定文字4 | `udf_text4` | string |  |
| `RLA964` | 自定文字5 | `udf_text5` | string |  |
| `RLA965` | 自定文字6 | `udf_text6` | string |  |
| `RLA980` | 自定数字1 | `udf_no1` | float |  |
| `RLA981` | 自定数字2 | `udf_no2` | float |  |
| `RLA982` | 自定数字3 | `udf_no3` | float |  |
| `RLA983` | 自定数字4 | `udf_no4` | float |  |
| `RLA984` | 自定数字5 | `udf_no5` | float |  |
| `RLA985` | 自定数字6 | `udf_no6` | float |  |
| `RLA901` | 录入者编号 | `entry_person_no` | string |  |
| `RLA902` | 录入时间 | `entry_time` | string |  |
| `RLA903` | 更改者编号 | `changer_no` | string |  |
| `RLA904` | 更改时间 | `change_time` | string |  |
| `RLA905` | 更新标记 | `update_flag` | integer |  |
| `RLA910` | 送审状态 | `submission_status` | string |  |
| `RLA911` | 送审人 | `reviewer` | string |  |
| `RLA912` | 审批人1 | `approver1` | string |  |
| `RLA913` | 审批结果 | `approval_result1` | string |  |
| `RLA914` | 审批意见 | `approval_opinion1` | string |  |
| `RLA915` | 审批人2 | `approver2` | string |  |
| `RLA916` | 审批结果 | `approval_result2` | string |  |
| `RLA917` | 审批意见 | `approval_opinion2` | string |  |
| `RLA918` | 审批人3 | `approver3` | string |  |
| `RLA919` | 审批结果 | `approval_result3` | string |  |
| `RLA920` | 审批意见 | `approval_opinion3` | string |  |
| `RLA921` | 审批人4 | `approver4` | string |  |
| `RLA922` | 审批结果 | `approval_result4` | string |  |
| `RLA923` | 审批意见 | `approval_opinion4` | string |  |
| `RLA924` | 审批人5 | `approver5` | string |  |
| `RLA925` | 审批结果 | `approval_result5` | string |  |
| `RLA926` | 审批意见 | `approval_opinion5` | string |  |
| `RLA927` | 审批人6 | `approver6` | string |  |
| `RLA928` | 审批结果 | `approval_result6` | string |  |
| `RLA929` | 审批意见 | `approval_opinion6` | string |  |
| `RLA930` | 终审人 | `final_approver` | string |  |
| `RLA931` | 审批结果 | `approval_result7` | string |  |
| `RLA932` | 审批意见 | `approval_opinion7` | string |  |
| `RLA933` | 通知人1 | `notifier1` | string |  |
| `RLA934` | 通知人2 | `notifier2` | string |  |
| `RLA935` | 通知人3 | `notifier3` | string |  |
| `RLA966` | 自定文字7 | `udf_text7` | string |  |
| `RLA967` | 自定文字8 | `udf_text8` | string |  |
| `RLA968` | 自定文字9 | `udf_text9` | string |  |
| `RLA969` | 自定文字10 | `udf_text10` | string |  |
| `RLA970` | 自定文字11 | `udf_text11` | string |  |
| `RLA971` | 自定文字12 | `udf_text12` | string |  |
| `RLA972` | 自定文字13 | `udf_text13` | string |  |
| `RLA973` | 自定文字14 | `udf_text14` | string |  |
| `RLA974` | 自定文字15 | `udf_text15` | string |  |
| `RLA975` | 自定文字16 | `udf_text16` | string |  |
| `RLA986` | 自定数字7 | `udf_no7` | float |  |
| `RLA987` | 自定数字8 | `udf_no8` | float |  |
| `RLA988` | 自定数字9 | `udf_no9` | float |  |
| `RLA989` | 自定数字10 | `udf_no10` | float |  |
| `RLA990` | 自定数字11 | `udf_no11` | float |  |
| `RLA991` | 自定数字12 | `udf_no12` | float |  |
| `RLA992` | 自定数字13 | `udf_no13` | float |  |
| `RLA993` | 自定数字14 | `udf_no14` | float |  |
| `RLA994` | 自定数字15 | `udf_no15` | float |  |
| `RLA995` | 自定数字16 | `udf_no16` | float |  |
| `RLA906` | 打印次数 | `print_count` | integer |  |
| `RLA907` | 打印时间 | `print_time` | string |  |
| `RLA908` | 打印人员 | `printer` | string |  |
| `RLA909` | 打印人员姓名 | `printer_name` | string |  |
| `RLA950` | 送审时间 | `submission_time_for_review` | string |  |
| `RLA951` | 审批时间1 | `approval_time1` | string |  |
| `RLA952` | 审批时间2 | `approval_time2` | string |  |
| `RLA953` | 审批时间3 | `approval_time3` | string |  |
| `RLA954` | 审批时间4 | `approval_time4` | string |  |
| `RLA955` | 审批时间5 | `approval_time5` | string |  |
| `RLA956` | 审批时间6 | `approval_time6` | string |  |
| `RLA957` | 终审时间 | `final_review_time` | string |  |
| `RLA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (SGMRLB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RLB001` | 单号 | `RLB001` | string |  |
| `RLB002` | 序号 | `RLB002` | string |  |
| `RLB003` | 副产品品号 | `RLB003` | string |  |
| `RLB004` | 副产品品名 | `RLB004` | string |  |
| `RLB005` | 入库仓库 | `RLB005` | string |  |
| `RLB006` | 入库数量 | `RLB006` | float |  |
| `RLB007` | 批号 | `RLB007` | string |  |
| `RLB008` | 材料成本 | `RLB008` | float |  |
| `RLB009` | 人工费用 | `RLB009` | float |  |
| `RLB010` | 制造费用 | `RLB010` | float |  |
| `RLB011` | 委外费用 | `RLB011` | float |  |
| `RLB012` | 备注 | `RLB012` | string |  |
| `RLB013` | 预留字段 | `RLB013` | string |  |
| `RLB014` | 预留字段 | `RLB014` | string |  |
| `RLB015` | 预留字段 | `RLB015` | string |  |
| `RLB016` | 预留字段 | `RLB016` | string |  |
| `RLB017` | 预留字段 | `RLB017` | float |  |
| `RLB018` | 预留字段 | `RLB018` | float |  |
| `RLB019` | 批号说明 | `RLB019` | string |  |
| `RLB020` | 生产日期 | `RLB020` | string |  |
| `RLB021` | 有效日期 | `RLB021` | string |  |
| `RLB901` | 录入者编号 | `entry_person_no` | string |  |
| `RLB902` | 录入时间 | `entry_time` | string |  |
| `RLB903` | 更改者编号 | `changer_no` | string |  |
| `RLB904` | 更改时间 | `change_time` | string |  |
| `RLB905` | 更新标记 | `update_flag` | integer |  |
| `RLB960` | 自定文字1 | `udf_text1` | string |  |
| `RLB961` | 自定文字2 | `udf_text2` | string |  |
| `RLB962` | 自定文字3 | `udf_text3` | string |  |
| `RLB963` | 自定文字4 | `udf_text4` | string |  |
| `RLB964` | 自定文字5 | `udf_text5` | string |  |
| `RLB965` | 自定文字6 | `udf_text6` | string |  |
| `RLB966` | 自定文字7 | `udf_text7` | string |  |
| `RLB967` | 自定文字8 | `udf_text8` | string |  |
| `RLB968` | 自定文字9 | `udf_text9` | string |  |
| `RLB969` | 自定文字10 | `udf_text10` | string |  |
| `RLB970` | 自定文字11 | `udf_text11` | string |  |
| `RLB971` | 自定文字12 | `udf_text12` | string |  |
| `RLB972` | 自定文字13 | `udf_text13` | string |  |
| `RLB973` | 自定文字14 | `udf_text14` | string |  |
| `RLB974` | 自定文字15 | `udf_text15` | string |  |
| `RLB975` | 自定文字16 | `udf_text16` | string |  |
| `RLB980` | 自定数字1 | `udf_no1` | float |  |
| `RLB981` | 自定数字2 | `udf_no2` | float |  |
| `RLB982` | 自定数字3 | `udf_no3` | float |  |
| `RLB983` | 自定数字4 | `udf_no4` | float |  |
| `RLB984` | 自定数字5 | `udf_no5` | float |  |
| `RLB985` | 自定数字6 | `udf_no6` | float |  |
| `RLB986` | 自定数字7 | `udf_no7` | float |  |
| `RLB987` | 自定数字8 | `udf_no8` | float |  |
| `RLB988` | 自定数字9 | `udf_no9` | float |  |
| `RLB989` | 自定数字10 | `udf_no10` | float |  |
| `RLB990` | 自定数字11 | `udf_no11` | float |  |
| `RLB991` | 自定数字12 | `udf_no12` | float |  |
| `RLB992` | 自定数字13 | `udf_no13` | float |  |
| `RLB993` | 自定数字14 | `udf_no14` | float |  |
| `RLB994` | 自定数字15 | `udf_no15` | float |  |
| `RLB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "RLA001": ""
  ,"RLA002": ""
  ,"RLA003": ""
  ,"RLA004": ""
  ,"cdsDetail": [{
    "RLB001": ""
    ,"RLB001": ""
    ,"RLB002": ""
    ,"RLB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"RLA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"RLA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `RLA001` | `RLA001` | 单号 | 主键 |
| `RLA002` | `RLA002` | 性质 | |
| `RLA003` | `RLA003` | 日期 | |
| `RLA004` | `RLA004` | 经办人 | |
| `RLA005` | `RLA005` | 部门 | |
| `RLA006` | `RLA006` | 工单单号 | |
| `RLA007` | `RLA007` | 主件品号 | |
| `RLA008` | `RLA008` | 凭证抛转否 | |
| `RLA009` | `RLA009` | 凭证 | |
| `RLA010` | `RLA010` | 凭证类别 | |
| `RLB001` | `RLB001` | 单号 (单身) | |
| `RLB002` | `RLB002` | 序号 (单身) | |
| `RLB003` | `RLB003` | 副产品品号 (单身) | |
| `RLB004` | `RLB004` | 副产品品名 (单身) | |
| `RLB005` | `RLB005` | 入库仓库 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `RLA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `RLA001`
