# CLI 规格说明书：超领单

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `excess.material.requisition` |
| **DLL** | `SGMZC21` |
| **服务名称** | `超领单` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete`, `approve`, `disapprove` |
| **业务类型** | 交易单据 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "excess.material.requisition" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "excess.material.requisition" \
  --action "getMultiple" \
  --data '{"datakeys":[{"RBA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "excess.material.requisition" \
  --action "create" \
  --data '{"RBA001":"",...}' \
  --json
```

### 审核 / 撤审（approve / disapprove）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "excess.material.requisition" \
  --action "approve" \
  --data '{"datakeys":[{"RBA001":"?"}]}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `RBA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (SGMRBA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RBA001` | 类别 | `RBA001` | string |  |
| `RBA002` | 单号 | `RBA002` | string |  |
| `RBA003` | 性质 | `RBA003` | string |  |
| `RBA004` | 日期 | `RBA004` | string |  |
| `RBA005` | 经办人 | `RBA005` | string |  |
| `RBA006` | 工单单号 | `RBA006` | string |  |
| `RBA007` | 预留字段 | `RBA007` | float |  |
| `RBA008` | 预留字段 | `RBA008` | string |  |
| `RBA009` | 备注 | `RBA009` | string |  |
| `RBA010` | 审核者编号 | `RBA010` | string |  |
| `RBA011` | 审核者姓名 | `RBA011` | string |  |
| `RBA012` | 审核码 | `RBA012` | string |  |
| `RBA013` | 日期 | `RBA013` | string |  |
| `RBA014` | 部门 | `RBA014` | string |  |
| `RBA015` | 预留字段 | `RBA015` | string |  |
| `RBA016` | 预留字段 | `RBA016` | string |  |
| `RBA017` | 预留字段 | `RBA017` | string |  |
| `RBA018` | 预留字段 | `RBA018` | string |  |
| `RBA019` | 预留字段 | `RBA019` | float |  |
| `RBA020` | 预留字段 | `RBA020` | float |  |
| `RBA021` | 审核人 | `RBA021` | string |  |
| `RBA022` | 凭证抛转否 | `RBA022` | string |  |
| `RBA023` | 凭证 | `RBA023` | string |  |
| `RBA024` | 凭证类别 | `RBA024` | string |  |
| `RBA025` | 是否套领 | `RBA025` | string |  |
| `RBA026` | 套数 | `RBA026` | float |  |
| `RBA027` | 审核时间 | `RBA027` | string |  |
| `RBA028` | 打印次数 | `RBA028` | integer |  |
| `RBA029` | 打印人员 | `RBA029` | string |  |
| `RBA030` | 打印时间 | `RBA030` | string |  |
| `RBA901` | 录入者编号 | `entry_person_no` | string |  |
| `RBA902` | 录入时间 | `entry_time` | string |  |
| `RBA903` | 更改者编号 | `changer_no` | string |  |
| `RBA904` | 更改时间 | `change_time` | string |  |
| `RBA905` | 更新标记 | `update_flag` | integer |  |
| `RBA906` | 打印次数 | `print_count` | integer |  |
| `RBA907` | 打印时间 | `print_time` | string |  |
| `RBA908` | 打印人员 | `printer` | string |  |
| `RBA909` | 打印人员姓名 | `printer_name` | string |  |
| `RBA910` | 送审状态 | `submission_status` | string |  |
| `RBA911` | 送审人 | `reviewer` | string |  |
| `RBA912` | 审批人1 | `approver1` | string |  |
| `RBA913` | 审批结果 | `approval_result1` | string |  |
| `RBA914` | 审批意见 | `approval_opinion1` | string |  |
| `RBA915` | 审批人2 | `approver2` | string |  |
| `RBA916` | 审批结果 | `approval_result2` | string |  |
| `RBA917` | 审批意见 | `approval_opinion2` | string |  |
| `RBA918` | 审批人3 | `approver3` | string |  |
| `RBA919` | 审批结果 | `approval_result3` | string |  |
| `RBA920` | 审批意见 | `approval_opinion3` | string |  |
| `RBA921` | 审批人4 | `approver4` | string |  |
| `RBA922` | 审批结果 | `approval_result4` | string |  |
| `RBA923` | 审批意见 | `approval_opinion4` | string |  |
| `RBA924` | 审批人5 | `approver5` | string |  |
| `RBA925` | 审批结果 | `approval_result5` | string |  |
| `RBA926` | 审批意见 | `approval_opinion5` | string |  |
| `RBA927` | 审批人6 | `approver6` | string |  |
| `RBA928` | 审批结果 | `approval_result6` | string |  |
| `RBA929` | 审批意见 | `approval_opinion6` | string |  |
| `RBA930` | 终审人 | `final_approver` | string |  |
| `RBA931` | 审批结果 | `approval_result7` | string |  |
| `RBA932` | 审批意见 | `approval_opinion7` | string |  |
| `RBA933` | 通知人1 | `notifier1` | string |  |
| `RBA934` | 通知人2 | `notifier2` | string |  |
| `RBA935` | 通知人3 | `notifier3` | string |  |
| `RBA960` | 自定文字1 | `udf_text1` | string |  |
| `RBA961` | 自定文字2 | `udf_text2` | string |  |
| `RBA962` | 自定文字3 | `udf_text3` | string |  |
| `RBA963` | 自定文字4 | `udf_text4` | string |  |
| `RBA964` | 自定文字5 | `udf_text5` | string |  |
| `RBA965` | 自定文字6 | `udf_text6` | string |  |
| `RBA966` | 自定文字7 | `udf_text7` | string |  |
| `RBA967` | 自定文字8 | `udf_text8` | string |  |
| `RBA968` | 自定文字9 | `udf_text9` | string |  |
| `RBA969` | 自定文字10 | `udf_text10` | string |  |
| `RBA970` | 自定文字11 | `udf_text11` | string |  |
| `RBA971` | 自定文字12 | `udf_text12` | string |  |
| `RBA972` | 自定文字13 | `udf_text13` | string |  |
| `RBA973` | 自定文字14 | `udf_text14` | string |  |
| `RBA974` | 自定文字15 | `udf_text15` | string |  |
| `RBA975` | 自定文字16 | `udf_text16` | string |  |
| `RBA979` | 单头二维码 | `qr_code_on_doc_header` | string |  |
| `RBA980` | 自定数字1 | `udf_no1` | float |  |
| `RBA981` | 自定数字2 | `udf_no2` | float |  |
| `RBA982` | 自定数字3 | `udf_no3` | float |  |
| `RBA983` | 自定数字4 | `udf_no4` | float |  |
| `RBA984` | 自定数字5 | `udf_no5` | float |  |
| `RBA985` | 自定数字6 | `udf_no6` | float |  |
| `RBA986` | 自定数字7 | `udf_no7` | float |  |
| `RBA987` | 自定数字8 | `udf_no8` | float |  |
| `RBA988` | 自定数字9 | `udf_no9` | float |  |
| `RBA989` | 自定数字10 | `udf_no10` | float |  |
| `RBA990` | 自定数字11 | `udf_no11` | float |  |
| `RBA991` | 自定数字12 | `udf_no12` | float |  |
| `RBA992` | 自定数字13 | `udf_no13` | float |  |
| `RBA993` | 自定数字14 | `udf_no14` | float |  |
| `RBA994` | 自定数字15 | `udf_no15` | float |  |
| `RBA995` | 自定数字16 | `udf_no16` | float |  |
| `RBA950` | 送审时间 | `submission_time_for_review` | string |  |
| `RBA951` | 审批时间1 | `approval_time1` | string |  |
| `RBA952` | 审批时间2 | `approval_time2` | string |  |
| `RBA953` | 审批时间3 | `approval_time3` | string |  |
| `RBA954` | 审批时间4 | `approval_time4` | string |  |
| `RBA955` | 审批时间5 | `approval_time5` | string |  |
| `RBA956` | 审批时间6 | `approval_time6` | string |  |
| `RBA957` | 终审时间 | `final_review_time` | string |  |
| `RBA959` | 审核时间 | `review_time` | string |  |

### 3.2 单身表 (SGMRBB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RBB001` | 类别 | `RBB001` | string |  |
| `RBB002` | 单号 | `RBB002` | string |  |
| `RBB003` | 序号 | `RBB003` | string |  |
| `RBB004` | 子件品号 | `RBB004` | string |  |
| `RBB005` | 品名(预留) | `RBB005` | string |  |
| `RBB006` | 单位 | `RBB006` | string |  |
| `RBB007` | 转出仓库 | `RBB007` | string |  |
| `RBB008` | 转入仓库 | `RBB008` | string |  |
| `RBB009` | 数量 | `RBB009` | float |  |
| `RBB010` | 工单单号 | `RBB010` | string |  |
| `RBB011` | 工单序号 | `RBB011` | string |  |
| `RBB012` | 备注 | `RBB012` | string |  |
| `RBB013` | 审核码 | `RBB013` | string |  |
| `RBB014` | (预留)日期 | `RBB014` | string |  |
| `RBB015` | (预留)可替代 | `RBB015` | string |  |
| `RBB016` | 预留字段 | `RBB016` | string |  |
| `RBB017` | 预留字段 | `RBB017` | string |  |
| `RBB018` | 预留字段 | `RBB018` | string |  |
| `RBB019` | 预留字段 | `RBB019` | float |  |
| `RBB020` | 预留字段 | `RBB020` | float |  |
| `RBB021` | 批号 | `RBB021` | string |  |
| `RBB022` | 规格 | `RBB022` | string |  |
| `RBB023` | 来源 | `RBB023` | string |  |
| `RBB024` | 被替代序号 | `RBB024` | string |  |
| `RBB025` | 换算分子 | `RBB025` | float |  |
| `RBB026` | 换算分母 | `RBB026` | float |  |
| `RBB027` | 库存单位 | `RBB027` | string |  |
| `RBB028` | 库存数量 | `RBB028` | float |  |
| `RBB901` | 录入者编号 | `entry_person_no` | string |  |
| `RBB902` | 录入时间 | `entry_time` | string |  |
| `RBB903` | 更改者编号 | `changer_no` | string |  |
| `RBB904` | 更改时间 | `change_time` | string |  |
| `RBB905` | 更新标记 | `update_flag` | integer |  |
| `RBB960` | 自定文字1 | `udf_text1` | string |  |
| `RBB961` | 自定文字2 | `udf_text2` | string |  |
| `RBB962` | 自定文字3 | `udf_text3` | string |  |
| `RBB963` | 自定文字4 | `udf_text4` | string |  |
| `RBB964` | 自定文字5 | `udf_text5` | string |  |
| `RBB965` | 自定文字6 | `udf_text6` | string |  |
| `RBB966` | 自定文字7 | `udf_text7` | string |  |
| `RBB967` | 自定文字8 | `udf_text8` | string |  |
| `RBB968` | 自定文字9 | `udf_text9` | string |  |
| `RBB969` | 自定文字10 | `udf_text10` | string |  |
| `RBB970` | 自定文字11 | `udf_text11` | string |  |
| `RBB971` | 自定文字12 | `udf_text12` | string |  |
| `RBB972` | 自定文字13 | `udf_text13` | string |  |
| `RBB973` | 自定文字14 | `udf_text14` | string |  |
| `RBB974` | 自定文字15 | `udf_text15` | string |  |
| `RBB975` | 自定文字16 | `udf_text16` | string |  |
| `RBB979` | 单身二维码 | `qr_code_on_doc_header` | string |  |
| `RBB980` | 自定数字1 | `udf_no1` | float |  |
| `RBB981` | 自定数字2 | `udf_no2` | float |  |
| `RBB982` | 自定数字3 | `udf_no3` | float |  |
| `RBB983` | 自定数字4 | `udf_no4` | float |  |
| `RBB984` | 自定数字5 | `udf_no5` | float |  |
| `RBB985` | 自定数字6 | `udf_no6` | float |  |
| `RBB986` | 自定数字7 | `udf_no7` | float |  |
| `RBB987` | 自定数字8 | `udf_no8` | float |  |
| `RBB988` | 自定数字9 | `udf_no9` | float |  |
| `RBB989` | 自定数字10 | `udf_no10` | float |  |
| `RBB990` | 自定数字11 | `udf_no11` | float |  |
| `RBB991` | 自定数字12 | `udf_no12` | float |  |
| `RBB992` | 自定数字13 | `udf_no13` | float |  |
| `RBB993` | 自定数字14 | `udf_no14` | float |  |
| `RBB994` | 自定数字15 | `udf_no15` | float |  |
| `RBB995` | 自定数字16 | `udf_no16` | float |  |

### 3.3 扩展表 (SGMRBC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `RBC001` | 类别 | `RBC001` | string |  |
| `RBC002` | 单号 | `RBC002` | string |  |
| `RBC003` | 领料单序号 | `RBC003` | string |  |
| `RBC006` | 序号 | `RBC006` | string |  |
| `RBC004` | 批号 | `RBC004` | string |  |
| `RBC005` | 拆分量 | `RBC005` | float |  |
| `RBC901` | 录入者编号 | `entry_person_no` | string |  |
| `RBC902` | 录入时间 | `entry_time` | string |  |
| `RBC903` | 更改者编号 | `changer_no` | string |  |
| `RBC904` | 更改时间 | `change_time` | string |  |
| `RBC905` | 更新标记 | `update_flag` | integer |  |
| `RBC960` | 自定文字1 | `udf_text1` | string |  |
| `RBC961` | 自定文字2 | `udf_text2` | string |  |
| `RBC962` | 自定文字3 | `udf_text3` | string |  |
| `RBC963` | 自定文字4 | `udf_text4` | string |  |
| `RBC964` | 自定文字5 | `udf_text5` | string |  |
| `RBC965` | 自定文字6 | `udf_text6` | string |  |
| `RBC980` | 自定数字1 | `udf_no1` | float |  |
| `RBC981` | 自定数字2 | `udf_no2` | float |  |
| `RBC982` | 自定数字3 | `udf_no3` | float |  |
| `RBC983` | 自定数字4 | `udf_no4` | float |  |
| `RBC984` | 自定数字5 | `udf_no5` | float |  |
| `RBC985` | 自定数字6 | `udf_no6` | float |  |
| `RBC966` | 自定文字7 | `udf_text7` | string |  |
| `RBC967` | 自定文字8 | `udf_text8` | string |  |
| `RBC968` | 自定文字9 | `udf_text9` | string |  |
| `RBC969` | 自定文字10 | `udf_text10` | string |  |
| `RBC970` | 自定文字11 | `udf_text11` | string |  |
| `RBC971` | 自定文字12 | `udf_text12` | string |  |
| `RBC972` | 自定文字13 | `udf_text13` | string |  |
| `RBC973` | 自定文字14 | `udf_text14` | string |  |
| `RBC974` | 自定文字15 | `udf_text15` | string |  |
| `RBC975` | 自定文字16 | `udf_text16` | string |  |
| `RBC986` | 自定数字7 | `udf_no7` | float |  |
| `RBC987` | 自定数字8 | `udf_no8` | float |  |
| `RBC988` | 自定数字9 | `udf_no9` | float |  |
| `RBC989` | 自定数字10 | `udf_no10` | float |  |
| `RBC990` | 自定数字11 | `udf_no11` | float |  |
| `RBC991` | 自定数字12 | `udf_no12` | float |  |
| `RBC992` | 自定数字13 | `udf_no13` | float |  |
| `RBC993` | 自定数字14 | `udf_no14` | float |  |
| `RBC994` | 自定数字15 | `udf_no15` | float |  |
| `RBC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "RBA001": ""
  ,"RBA001": ""
  ,"RBA002": ""
  ,"RBA003": ""
  ,"cdsDetail": [{
    "RBB001": ""
    ,"RBB001": ""
    ,"RBB002": ""
    ,"RBB003": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"RBA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"RBA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `RBA001` | `RBA001` | 类别 | |
| `RBA002` | `RBA002` | 单号 | |
| `RBA003` | `RBA003` | 性质 | |
| `RBA004` | `RBA004` | 日期 | |
| `RBA005` | `RBA005` | 经办人 | |
| `RBA006` | `RBA006` | 工单单号 | |
| `RBA007` | `RBA007` | 预留字段 | |
| `RBA008` | `RBA008` | 预留字段 | |
| `RBA009` | `RBA009` | 备注 | |
| `RBA010` | `RBA010` | 审核者编号 | |
| `RBB001` | `RBB001` | 类别 (单身) | |
| `RBB002` | `RBB002` | 单号 (单身) | |
| `RBB003` | `RBB003` | 序号 (单身) | |
| `RBB004` | `RBB004` | 子件品号 (单身) | |
| `RBB005` | `RBB005` | 品名(预留) (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `RBA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `RBA001`
