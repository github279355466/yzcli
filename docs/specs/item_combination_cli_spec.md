# CLI 规格说明书：商品组合单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `item.combination` |
| **DLL** | `INVKC07` |
| **服务名称** | `商品组合单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.combination" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.combination" \
  --action "getMultiple" \
  --data '{"datakeys":[{"LFA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.combination" \
  --action "create" \
  --data '{"LFA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "item.combination" \
  --action "approve" \
  --data '{"datakeys":[{"LFA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `LFA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (JSKLFA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LFA001` | 单号 | `LFA001` | string | 主键 |
| `LFA002` | 性质 | `LFA002` | string |  |
| `LFA003` | 日期 | `LFA003` | string |  |
| `LFA004` | 组合品号 | `LFA004` | string |  |
| `LFA005` | 仓库 | `LFA005` | string |  |
| `LFA006` | 组合数量 | `LFA006` | float |  |
| `LFA007` | 单位成本 | `LFA007` | float |  |
| `LFA008` | 成本 | `LFA008` | float |  |
| `LFA009` | (预留) | `LFA009` | string |  |
| `LFA010` | (预留) | `LFA010` | string |  |
| `LFA011` | (预留) | `LFA011` | string |  |
| `LFA012` | 复核编号 | `LFA012` | string |  |
| `LFA013` | 复核姓名 | `LFA013` | string |  |
| `LFA014` | 审核码 | `LFA014` | string |  |
| `LFA015` | 备注 | `LFA015` | string |  |
| `LFA016` | 经办人 | `LFA016` | string |  |
| `LFA017` | (预留)部门 | `LFA017` | string |  |
| `LFA018` | 预留 | `LFA018` | string |  |
| `LFA019` | 预留 | `LFA019` | string |  |
| `LFA020` | (预留)日期 | `LFA020` | string |  |
| `LFA021` | 预留字段 | `LFA021` | string |  |
| `LFA022` | 预留字段 | `LFA022` | string |  |
| `LFA023` | 预留字段 | `LFA023` | string |  |
| `LFA024` | 预留字段 | `LFA024` | string |  |
| `LFA025` | 预留字段 | `LFA025` | string |  |
| `LFA026` | 预留字段 | `LFA026` | float |  |
| `LFA027` | 预留字段 | `LFA027` | float |  |
| `LFA028` | 预留(品名) | `LFA028` | string |  |
| `LFA029` | 审核人 | `LFA029` | string |  |
| `LFA030` | 批号 | `LFA030` | string |  |
| `LFA031` | 审核时间 | `LFA031` | string |  |
| `LFA032` | 规格 | `LFA032` | string |  |
| `LFA033` | 批号说明 | `LFA033` | string |  |
| `LFA034` | 生产日期 | `LFA034` | string |  |
| `LFA035` | 有效日期 | `LFA035` | string |  |
| `LFA901` | 录入者编号 | `entry_person_no` | string |  |
| `LFA902` | 录入时间 | `entry_time` | string |  |
| `LFA903` | 更改者编号 | `changer_no` | string |  |
| `LFA904` | 更改时间 | `change_time` | string |  |
| `LFA905` | 更新标记 | `update_flag` | integer |  |
| `LFA960` | 自定文字1 | `udf_text1` | string |  |
| `LFA961` | 自定文字2 | `udf_text2` | string |  |
| `LFA962` | 自定文字3 | `udf_text3` | string |  |
| `LFA963` | 自定文字4 | `udf_text4` | string |  |
| `LFA964` | 自定文字5 | `udf_text5` | string |  |
| `LFA965` | 自定文字6 | `udf_text6` | string |  |
| `LFA980` | 自定数字1 | `udf_no1` | float |  |
| `LFA981` | 自定数字2 | `udf_no2` | float |  |
| `LFA982` | 自定数字3 | `udf_no3` | float |  |
| `LFA983` | 自定数字4 | `udf_no4` | float |  |
| `LFA984` | 自定数字5 | `udf_no5` | float |  |
| `LFA985` | 自定数字6 | `udf_no6` | float |  |
| `LFA910` | 送审状态 | `submission_status` | string |  |
| `LFA911` | 送审人 | `reviewer` | string |  |
| `LFA912` | 审批人1 | `approver1` | string |  |
| `LFA913` | 审批结果 | `approval_result1` | string |  |
| `LFA914` | 审批意见 | `approval_opinion1` | string |  |
| `LFA915` | 审批人2 | `approver2` | string |  |
| `LFA916` | 审批结果 | `approval_result2` | string |  |
| `LFA917` | 审批意见 | `approval_opinion2` | string |  |
| `LFA918` | 审批人3 | `approver3` | string |  |
| `LFA919` | 审批结果 | `approval_result3` | string |  |
| `LFA920` | 审批意见 | `approval_opinion3` | string |  |
| `LFA921` | 审批人4 | `approver4` | string |  |
| `LFA922` | 审批结果 | `approval_result4` | string |  |
| `LFA923` | 审批意见 | `approval_opinion4` | string |  |
| `LFA924` | 审批人5 | `approver5` | string |  |
| `LFA925` | 审批结果 | `approval_result5` | string |  |
| `LFA926` | 审批意见 | `approval_opinion5` | string |  |
| `LFA927` | 审批人6 | `approver6` | string |  |
| `LFA928` | 审批结果 | `approval_result6` | string |  |
| `LFA929` | 审批意见 | `approval_opinion6` | string |  |
| `LFA930` | 终审人 | `final_approver` | string |  |
| `LFA931` | 审批结果 | `approval_result7` | string |  |
| `LFA932` | 审批意见 | `approval_opinion7` | string |  |
| `LFA933` | 通知人1 | `notifier1` | string |  |
| `LFA934` | 通知人2 | `notifier2` | string |  |
| `LFA935` | 通知人3 | `notifier3` | string |  |
| `LFA966` | 自定文字7 | `udf_text7` | string |  |
| `LFA967` | 自定文字8 | `udf_text8` | string |  |
| `LFA968` | 自定文字9 | `udf_text9` | string |  |
| `LFA969` | 自定文字10 | `udf_text10` | string |  |
| `LFA970` | 自定文字11 | `udf_text11` | string |  |
| `LFA971` | 自定文字12 | `udf_text12` | string |  |
| `LFA972` | 自定文字13 | `udf_text13` | string |  |
| `LFA973` | 自定文字14 | `udf_text14` | string |  |
| `LFA974` | 自定文字15 | `udf_text15` | string |  |
| `LFA975` | 自定文字16 | `udf_text16` | string |  |
| `LFA986` | 自定数字7 | `udf_no7` | float |  |
| `LFA987` | 自定数字8 | `udf_no8` | float |  |
| `LFA988` | 自定数字9 | `udf_no9` | float |  |
| `LFA989` | 自定数字10 | `udf_no10` | float |  |
| `LFA990` | 自定数字11 | `udf_no11` | float |  |
| `LFA991` | 自定数字12 | `udf_no12` | float |  |
| `LFA992` | 自定数字13 | `udf_no13` | float |  |
| `LFA993` | 自定数字14 | `udf_no14` | float |  |
| `LFA994` | 自定数字15 | `udf_no15` | float |  |
| `LFA995` | 自定数字16 | `udf_no16` | float |  |
| `LFA906` | 打印次数 | `print_count` | integer |  |
| `LFA907` | 打印时间 | `print_time` | string |  |
| `LFA908` | 打印人员 | `printer` | string |  |
| `LFA909` | 打印人员姓名 | `printer_name` | string |  |
| `LFA950` | 送审时间 | `submission_time_for_review` | string |  |
| `LFA951` | 审批时间1 | `approval_time1` | string |  |
| `LFA952` | 审批时间2 | `approval_time2` | string |  |
| `LFA953` | 审批时间3 | `approval_time3` | string |  |
| `LFA954` | 审批时间4 | `approval_time4` | string |  |
| `LFA955` | 审批时间5 | `approval_time5` | string |  |
| `LFA956` | 审批时间6 | `approval_time6` | string |  |
| `LFA957` | 终审时间 | `final_review_time` | string |  |
| `LFA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (JSKLFB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `LFB001` | 单号 | `LFB001` | string |  |
| `LFB002` | 序号 | `LFB002` | string |  |
| `LFB003` | 子件品号 | `LFB003` | string |  |
| `LFB004` | 仓库 | `LFB004` | string |  |
| `LFB005` | 组成量 | `LFB005` | float |  |
| `LFB006` | 单位成本 | `LFB006` | float |  |
| `LFB007` | 成本 | `LFB007` | string |  |
| `LFB008` | 审核码 | `LFB008` | string |  |
| `LFB009` | 预留 | `LFB009` | string |  |
| `LFB010` | 预留 | `LFB010` | string |  |
| `LFB011` | (预留)日期 | `LFB011` | string |  |
| `LFB012` | 预留字段 | `LFB012` | string |  |
| `LFB013` | 预留字段 | `LFB013` | string |  |
| `LFB014` | 预留字段 | `LFB014` | string |  |
| `LFB015` | 预留字段 | `LFB015` | string |  |
| `LFB016` | 预留字段 | `LFB016` | string |  |
| `LFB017` | 预留字段 | `LFB017` | string |  |
| `LFB018` | 预留字段 | `LFB018` | string |  |
| `LFB019` | 预留字段 | `LFB019` | float |  |
| `LFB020` | 预留字段 | `LFB020` | float |  |
| `LFB021` | 预留(品名) | `LFB021` | string |  |
| `LFB022` | 批号 | `LFB022` | string |  |
| `LFB023` | 规格 | `LFB023` | string |  |
| `LFB901` | 录入者编号 | `entry_person_no` | string |  |
| `LFB902` | 录入时间 | `entry_time` | string |  |
| `LFB903` | 更改者编号 | `changer_no` | string |  |
| `LFB904` | 更改时间 | `change_time` | string |  |
| `LFB905` | 更新标记 | `update_flag` | integer |  |
| `LFB960` | 自定文字1 | `udf_text1` | string |  |
| `LFB961` | 自定文字2 | `udf_text2` | string |  |
| `LFB962` | 自定文字3 | `udf_text3` | string |  |
| `LFB963` | 自定文字4 | `udf_text4` | string |  |
| `LFB964` | 自定文字5 | `udf_text5` | string |  |
| `LFB965` | 自定文字6 | `udf_text6` | string |  |
| `LFB980` | 自定数字1 | `udf_no1` | float |  |
| `LFB981` | 自定数字2 | `udf_no2` | float |  |
| `LFB982` | 自定数字3 | `udf_no3` | float |  |
| `LFB983` | 自定数字4 | `udf_no4` | float |  |
| `LFB984` | 自定数字5 | `udf_no5` | float |  |
| `LFB985` | 自定数字6 | `udf_no6` | float |  |
| `LFB966` | 自定文字7 | `udf_text7` | string |  |
| `LFB967` | 自定文字8 | `udf_text8` | string |  |
| `LFB968` | 自定文字9 | `udf_text9` | string |  |
| `LFB969` | 自定文字10 | `udf_text10` | string |  |
| `LFB970` | 自定文字11 | `udf_text11` | string |  |
| `LFB971` | 自定文字12 | `udf_text12` | string |  |
| `LFB972` | 自定文字13 | `udf_text13` | string |  |
| `LFB973` | 自定文字14 | `udf_text14` | string |  |
| `LFB974` | 自定文字15 | `udf_text15` | string |  |
| `LFB975` | 自定文字16 | `udf_text16` | string |  |
| `LFB986` | 自定数字7 | `udf_no7` | float |  |
| `LFB987` | 自定数字8 | `udf_no8` | float |  |
| `LFB988` | 自定数字9 | `udf_no9` | float |  |
| `LFB989` | 自定数字10 | `udf_no10` | float |  |
| `LFB990` | 自定数字11 | `udf_no11` | float |  |
| `LFB991` | 自定数字12 | `udf_no12` | float |  |
| `LFB992` | 自定数字13 | `udf_no13` | float |  |
| `LFB993` | 自定数字14 | `udf_no14` | float |  |
| `LFB994` | 自定数字15 | `udf_no15` | float |  |
| `LFB995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "LFA001": ""
  ,"LFA002": ""
  ,"LFA003": ""
  ,"LFA004": ""
  ,"cdsDetail": [{
    "LFB001": ""
    ,"LFB001": ""
    ,"LFB002": ""
    ,"LFB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"LFA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"LFA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `LFA001` | `LFA001` | 单号 | 主键 |
| `LFA002` | `LFA002` | 性质 | |
| `LFA003` | `LFA003` | 日期 | |
| `LFA004` | `LFA004` | 组合品号 | |
| `LFA005` | `LFA005` | 仓库 | |
| `LFA006` | `LFA006` | 组合数量 | |
| `LFA007` | `LFA007` | 单位成本 | |
| `LFA008` | `LFA008` | 成本 | |
| `LFA009` | `LFA009` | (预留) | |
| `LFA010` | `LFA010` | (预留) | |
| `LFB001` | `LFB001` | 单号 (单身) | |
| `LFB002` | `LFB002` | 序号 (单身) | |
| `LFB003` | `LFB003` | 子件品号 (单身) | |
| `LFB004` | `LFB004` | 仓库 (单身) | |
| `LFB005` | `LFB005` | 组成量 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `LFA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `LFA001`
