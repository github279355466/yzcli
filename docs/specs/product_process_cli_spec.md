# CLI 规格说明书：工艺路线

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `product.process` |
| **DLL** | `GYSYC01` |
| **服务名称** | `工艺路线` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "product.process" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "product.process" \
  --action "getMultiple" \
  --data '{"datakeys":[{"QBB001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "product.process" \
  --action "create" \
  --data '{"QBB001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `QBB001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (SGMQBB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `QBB001` | 工艺路线编号 | `QBB001` | string | 主键 |
| `QBB002` | 工艺路线名称 | `QBB002` | string |  |
| `QBB003` | 主要材料 | `QBB003` | string |  |
| `QBB004` | 备注 | `QBB004` | string |  |
| `QBB005` | 预留字段 | `QBB005` | string |  |
| `QBB006` | 预留字段 | `QBB006` | string |  |
| `QBB007` | 预留字段 | `QBB007` | string |  |
| `QBB008` | 预留字段 | `QBB008` | string |  |
| `QBB009` | 预留字段 | `QBB009` | float |  |
| `QBB010` | 预留字段 | `QBB010` | float |  |
| `QBB901` | 录入者编号 | `entry_person_no` | string |  |
| `QBB902` | 录入时间 | `entry_time` | string |  |
| `QBB903` | 更改者编号 | `changer_no` | string |  |
| `QBB904` | 更改时间 | `change_time` | string |  |
| `QBB905` | 更新标记 | `update_flag` | integer |  |
| `QBB960` | 自定文字1 | `udf_text1` | string |  |
| `QBB961` | 自定文字2 | `udf_text2` | string |  |
| `QBB962` | 自定文字3 | `udf_text3` | string |  |
| `QBB963` | 自定文字4 | `udf_text4` | string |  |
| `QBB964` | 自定文字5 | `udf_text5` | string |  |
| `QBB965` | 自定文字6 | `udf_text6` | string |  |
| `QBB980` | 自定数字1 | `udf_no1` | float |  |
| `QBB981` | 自定数字2 | `udf_no2` | float |  |
| `QBB982` | 自定数字3 | `udf_no3` | float |  |
| `QBB983` | 自定数字4 | `udf_no4` | float |  |
| `QBB984` | 自定数字5 | `udf_no5` | float |  |
| `QBB985` | 自定数字6 | `udf_no6` | float |  |
| `QBB966` | 自定文字7 | `udf_text7` | string |  |
| `QBB967` | 自定文字8 | `udf_text8` | string |  |
| `QBB968` | 自定文字9 | `udf_text9` | string |  |
| `QBB969` | 自定文字10 | `udf_text10` | string |  |
| `QBB970` | 自定文字11 | `udf_text11` | string |  |
| `QBB971` | 自定文字12 | `udf_text12` | string |  |
| `QBB972` | 自定文字13 | `udf_text13` | string |  |
| `QBB973` | 自定文字14 | `udf_text14` | string |  |
| `QBB974` | 自定文字15 | `udf_text15` | string |  |
| `QBB975` | 自定文字16 | `udf_text16` | string |  |
| `QBB986` | 自定数字7 | `udf_no7` | float |  |
| `QBB987` | 自定数字8 | `udf_no8` | float |  |
| `QBB988` | 自定数字9 | `udf_no9` | float |  |
| `QBB989` | 自定数字10 | `udf_no10` | float |  |
| `QBB990` | 自定数字11 | `udf_no11` | float |  |
| `QBB991` | 自定数字12 | `udf_no12` | float |  |
| `QBB992` | 自定数字13 | `udf_no13` | float |  |
| `QBB993` | 自定数字14 | `udf_no14` | float |  |
| `QBB994` | 自定数字15 | `udf_no15` | float |  |
| `QBB995` | 自定数字16 | `udf_no16` | float |  |
| `QBB906` | 打印次数 | `print_count` | integer |  |
| `QBB907` | 打印时间 | `print_time` | string |  |
| `QBB908` | 打印人员 | `printer` | string |  |
| `QBB909` | 打印人员姓名 | `printer_name` | string |  |

### 3.2 单身表 (SGMQBB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `QBB001` | 工艺路线编号 | `QBB001` | string | 主键 |
| `QBB002` | 工艺路线名称 | `QBB002` | string |  |
| `QBB003` | 主要材料 | `QBB003` | string |  |
| `QBB004` | 备注 | `QBB004` | string |  |
| `QBB005` | 预留字段 | `QBB005` | string |  |
| `QBB006` | 预留字段 | `QBB006` | string |  |
| `QBB007` | 预留字段 | `QBB007` | string |  |
| `QBB008` | 预留字段 | `QBB008` | string |  |
| `QBB009` | 预留字段 | `QBB009` | float |  |
| `QBB010` | 预留字段 | `QBB010` | float |  |
| `QBB901` | 录入者编号 | `entry_person_no` | string |  |
| `QBB902` | 录入时间 | `entry_time` | string |  |
| `QBB903` | 更改者编号 | `changer_no` | string |  |
| `QBB904` | 更改时间 | `change_time` | string |  |
| `QBB905` | 更新标记 | `update_flag` | integer |  |
| `QBB960` | 自定文字1 | `udf_text1` | string |  |
| `QBB961` | 自定文字2 | `udf_text2` | string |  |
| `QBB962` | 自定文字3 | `udf_text3` | string |  |
| `QBB963` | 自定文字4 | `udf_text4` | string |  |
| `QBB964` | 自定文字5 | `udf_text5` | string |  |
| `QBB965` | 自定文字6 | `udf_text6` | string |  |
| `QBB980` | 自定数字1 | `udf_no1` | float |  |
| `QBB981` | 自定数字2 | `udf_no2` | float |  |
| `QBB982` | 自定数字3 | `udf_no3` | float |  |
| `QBB983` | 自定数字4 | `udf_no4` | float |  |
| `QBB984` | 自定数字5 | `udf_no5` | float |  |
| `QBB985` | 自定数字6 | `udf_no6` | float |  |
| `QBB966` | 自定文字7 | `udf_text7` | string |  |
| `QBB967` | 自定文字8 | `udf_text8` | string |  |
| `QBB968` | 自定文字9 | `udf_text9` | string |  |
| `QBB969` | 自定文字10 | `udf_text10` | string |  |
| `QBB970` | 自定文字11 | `udf_text11` | string |  |
| `QBB971` | 自定文字12 | `udf_text12` | string |  |
| `QBB972` | 自定文字13 | `udf_text13` | string |  |
| `QBB973` | 自定文字14 | `udf_text14` | string |  |
| `QBB974` | 自定文字15 | `udf_text15` | string |  |
| `QBB975` | 自定文字16 | `udf_text16` | string |  |
| `QBB986` | 自定数字7 | `udf_no7` | float |  |
| `QBB987` | 自定数字8 | `udf_no8` | float |  |
| `QBB988` | 自定数字9 | `udf_no9` | float |  |
| `QBB989` | 自定数字10 | `udf_no10` | float |  |
| `QBB990` | 自定数字11 | `udf_no11` | float |  |
| `QBB991` | 自定数字12 | `udf_no12` | float |  |
| `QBB992` | 自定数字13 | `udf_no13` | float |  |
| `QBB993` | 自定数字14 | `udf_no14` | float |  |
| `QBB994` | 自定数字15 | `udf_no15` | float |  |
| `QBB995` | 自定数字16 | `udf_no16` | float |  |
| `QBB906` | 打印次数 | `print_count` | integer |  |
| `QBB907` | 打印时间 | `print_time` | string |  |
| `QBB908` | 打印人员 | `printer` | string |  |
| `QBB909` | 打印人员姓名 | `printer_name` | string |  |

### 3.3 扩展表 (SGMQBC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `QBC001` | 工艺路线编号 | `QBC001` | string |  |
| `QBC002` | 工序 | `QBC002` | string |  |
| `QBC003` | 工艺 | `QBC003` | string |  |
| `QBC004` | 工艺性质 | `QBC004` | string |  |
| `QBC005` | 主生产者 | `QBC005` | string |  |
| `QBC006` | 主生产者名称 | `QBC006` | string |  |
| `QBC007` | 工艺说明 | `QBC007` | string |  |
| `QBC008` | 移转管理 | `QBC008` | string |  |
| `QBC009` | 工时类型 | `QBC009` | string |  |
| `QBC010` | 工时批量 | `QBC010` | integer |  |
| `QBC011` | 固定工时 | `QBC011` | string |  |
| `QBC012` | 标准变动工时 | `QBC012` | string |  |
| `QBC013` | 备注 | `QBC013` | string |  |
| `QBC014` | 含税 | `QBC014` | string |  |
| `QBC015` | 含税委外单价 | `QBC015` | float |  |
| `QBC016` | 无税委外单价 | `QBC016` | float |  |
| `QBC017` | 税率 | `QBC017` | float |  |
| `QBC018` | 预留字段 | `QBC018` | string |  |
| `QBC019` | 预留字段 | `QBC019` | string |  |
| `QBC020` | 预留字段 | `QBC020` | string |  |
| `QBC021` | 预留字段 | `QBC021` | string |  |
| `QBC022` | 预留字段 | `QBC022` | float |  |
| `QBC023` | 预留字段 | `QBC023` | float |  |
| `QBC024` | 显示工序 | `QBC024` | string |  |
| `QBC901` | 录入者编号 | `entry_person_no` | string |  |
| `QBC902` | 录入时间 | `entry_time` | string |  |
| `QBC903` | 更改者编号 | `changer_no` | string |  |
| `QBC904` | 更改时间 | `change_time` | string |  |
| `QBC905` | 更新标记 | `update_flag` | integer |  |
| `QBC960` | 自定文字1 | `udf_text1` | string |  |
| `QBC961` | 自定文字2 | `udf_text2` | string |  |
| `QBC962` | 自定文字3 | `udf_text3` | string |  |
| `QBC963` | 自定文字4 | `udf_text4` | string |  |
| `QBC964` | 自定文字5 | `udf_text5` | string |  |
| `QBC965` | 自定文字6 | `udf_text6` | string |  |
| `QBC980` | 自定数字1 | `udf_no1` | float |  |
| `QBC981` | 自定数字2 | `udf_no2` | float |  |
| `QBC982` | 自定数字3 | `udf_no3` | float |  |
| `QBC983` | 自定数字4 | `udf_no4` | float |  |
| `QBC984` | 自定数字5 | `udf_no5` | float |  |
| `QBC985` | 自定数字6 | `udf_no6` | float |  |
| `QBC966` | 自定文字7 | `udf_text7` | string |  |
| `QBC967` | 自定文字8 | `udf_text8` | string |  |
| `QBC968` | 自定文字9 | `udf_text9` | string |  |
| `QBC969` | 自定文字10 | `udf_text10` | string |  |
| `QBC970` | 自定文字11 | `udf_text11` | string |  |
| `QBC971` | 自定文字12 | `udf_text12` | string |  |
| `QBC972` | 自定文字13 | `udf_text13` | string |  |
| `QBC973` | 自定文字14 | `udf_text14` | string |  |
| `QBC974` | 自定文字15 | `udf_text15` | string |  |
| `QBC975` | 自定文字16 | `udf_text16` | string |  |
| `QBC986` | 自定数字7 | `udf_no7` | float |  |
| `QBC987` | 自定数字8 | `udf_no8` | float |  |
| `QBC988` | 自定数字9 | `udf_no9` | float |  |
| `QBC989` | 自定数字10 | `udf_no10` | float |  |
| `QBC990` | 自定数字11 | `udf_no11` | float |  |
| `QBC991` | 自定数字12 | `udf_no12` | float |  |
| `QBC992` | 自定数字13 | `udf_no13` | float |  |
| `QBC993` | 自定数字14 | `udf_no14` | float |  |
| `QBC994` | 自定数字15 | `udf_no15` | float |  |
| `QBC995` | 自定数字16 | `udf_no16` | float |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "QBB001": ""
  ,"QBB002": ""
  ,"QBB003": ""
  ,"QBB004": ""
  ,"cdsDetail": [{
    "QBB001": ""
    ,"QBB002": ""
    ,"QBB003": ""
    ,"QBB004": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"QBB001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"QBB001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `QBB001` | `QBB001` | 工艺路线编号 | 主键 |
| `QBB002` | `QBB002` | 工艺路线名称 | |
| `QBB003` | `QBB003` | 主要材料 | |
| `QBB004` | `QBB004` | 备注 | |
| `QBB005` | `QBB005` | 预留字段 | |
| `QBB006` | `QBB006` | 预留字段 | |
| `QBB007` | `QBB007` | 预留字段 | |
| `QBB008` | `QBB008` | 预留字段 | |
| `QBB009` | `QBB009` | 预留字段 | |
| `QBB010` | `QBB010` | 预留字段 | |
| `QBB001` | `QBB001` | 工艺路线编号 (单身) | 主键 |
| `QBB002` | `QBB002` | 工艺路线名称 (单身) | |
| `QBB003` | `QBB003` | 主要材料 (单身) | |
| `QBB004` | `QBB004` | 备注 (单身) | |
| `QBB005` | `QBB005` | 预留字段 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `QBB001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `QBB001`
