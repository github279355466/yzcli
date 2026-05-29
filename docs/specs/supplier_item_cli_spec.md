# CLI 规格说明书：供应商品号

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `supplier.item` |
| **DLL** | `TPAGC12` |
| **服务名称** | `供应商品号` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "supplier.item" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "supplier.item" \
  --action "getMultiple" \
  --data '{"datakeys":[{"DEG001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "supplier.item" \
  --action "create" \
  --data '{"DEG001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `DEG001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPADEG)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DEG001` | 品号 | `item_no` | string |  |
| `DEG002` | 供应商编号 | `supplier_no` | string |  |
| `DEG003` | 供应商品号 | `supplier_product_no` | string |  |
| `DEG004` | 供应商品名 | `supplier_product_name` | string |  |
| `DEG005` | 预留字段 | `reserved_field` | string |  |
| `DEG006` | 供应商规格 | `supplier_specifications` | string |  |
| `DEG901` | 录入者编号 | `entry_person_no` | string |  |
| `DEG902` | 录入时间 | `entry_time` | string |  |
| `DEG903` | 更改者编号 | `changer_no` | string |  |
| `DEG904` | 更改时间 | `change_time` | string |  |
| `DEG905` | 更新标记 | `update_flag` | integer |  |
| `DEG960` | 自定文字1 | `udf_text1` | string |  |
| `DEG961` | 自定文字2 | `udf_text2` | string |  |
| `DEG962` | 自定文字3 | `udf_text3` | string |  |
| `DEG963` | 自定文字4 | `udf_text4` | string |  |
| `DEG964` | 自定文字5 | `udf_text5` | string |  |
| `DEG965` | 自定文字6 | `udf_text6` | string |  |
| `DEG980` | 自定数字1 | `udf_no1` | float |  |
| `DEG981` | 自定数字2 | `udf_no2` | float |  |
| `DEG982` | 自定数字3 | `udf_no3` | float |  |
| `DEG983` | 自定数字4 | `udf_no4` | float |  |
| `DEG984` | 自定数字5 | `udf_no5` | float |  |
| `DEG985` | 自定数字6 | `udf_no6` | float |  |
| `DEG966` | 自定文字7 | `udf_text7` | string |  |
| `DEG967` | 自定文字8 | `udf_text8` | string |  |
| `DEG968` | 自定文字9 | `udf_text9` | string |  |
| `DEG969` | 自定文字10 | `udf_text10` | string |  |
| `DEG970` | 自定文字11 | `udf_text11` | string |  |
| `DEG971` | 自定文字12 | `udf_text12` | string |  |
| `DEG972` | 自定文字13 | `udf_text13` | string |  |
| `DEG973` | 自定文字14 | `udf_text14` | string |  |
| `DEG974` | 自定文字15 | `udf_text15` | string |  |
| `DEG975` | 自定文字16 | `udf_text16` | string |  |
| `DEG986` | 自定数字7 | `udf_no7` | float |  |
| `DEG987` | 自定数字8 | `udf_no8` | float |  |
| `DEG988` | 自定数字9 | `udf_no9` | float |  |
| `DEG989` | 自定数字10 | `udf_no10` | float |  |
| `DEG990` | 自定数字11 | `udf_no11` | float |  |
| `DEG991` | 自定数字12 | `udf_no12` | float |  |
| `DEG992` | 自定数字13 | `udf_no13` | float |  |
| `DEG993` | 自定数字14 | `udf_no14` | float |  |
| `DEG994` | 自定数字15 | `udf_no15` | float |  |
| `DEG995` | 自定数字16 | `udf_no16` | float |  |
| `DEG906` | 打印次数 | `print_count` | integer |  |
| `DEG907` | 打印时间 | `print_time` | string |  |
| `DEG908` | 打印人员 | `printer` | string |  |
| `DEG909` | 打印人员姓名 | `printer_name` | string |  |

### 3.2 单身表 (TPADEB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DEB001` | 品号 | `DEB001` | string | 主键 |
| `DEB002` | 图档 | `DEB002` | string |  |
| `DEB003` | 图档类型 | `DEB003` | string |  |
| `DEB901` | 录入者编号 | `entry_person_no` | string |  |
| `DEB902` | 录入时间 | `entry_time` | string |  |
| `DEB903` | 更改者编号 | `changer_no` | string |  |
| `DEB904` | 更改时间 | `change_time` | string |  |
| `DEB905` | 更新标记 | `update_flag` | integer |  |

### 3.3 扩展表 (TPADEC)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DEC001` | 品号 | `DEC001` | string |  |
| `DEC002` | 换算单位 | `DEC002` | string |  |
| `DEC003` | 换算分子 | `DEC003` | float |  |
| `DEC004` | 换算分母 | `DEC004` | float |  |
| `DEC005` | 预留字段 | `DEC005` | float |  |
| `DEC006` | 预留字段 | `DEC006` | string |  |
| `DEC007` | 是否固定比率 | `DEC007` | string |  |
| `DEC901` | 录入者编号 | `entry_person_no` | string |  |
| `DEC902` | 录入时间 | `entry_time` | string |  |
| `DEC903` | 更改者编号 | `changer_no` | string |  |
| `DEC904` | 更改时间 | `change_time` | string |  |
| `DEC905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "DEG001": ""
  ,"DEG001": ""
  ,"DEG002": ""
  ,"DEG003": ""
  ,"cdsDetail": [{
    "DEB001": ""
    ,"DEB002": ""
    ,"DEB003": ""
    ,"DEB901": ""
  }]
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"DEG001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"item_no","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `DEG001` | `item_no` | 品号 | |
| `DEG002` | `supplier_no` | 供应商编号 | |
| `DEG003` | `supplier_product_no` | 供应商品号 | |
| `DEG004` | `supplier_product_name` | 供应商品名 | |
| `DEG005` | `reserved_field` | 预留字段 | |
| `DEG006` | `supplier_specifications` | 供应商规格 | |
| `DEG901` | `entry_person_no` | 录入者编号 | |
| `DEG902` | `entry_time` | 录入时间 | |
| `DEG903` | `changer_no` | 更改者编号 | |
| `DEG904` | `change_time` | 更改时间 | |
| `DEB001` | `DEB001` | 品号 (单身) | 主键 |
| `DEB002` | `DEB002` | 图档 (单身) | |
| `DEB003` | `DEB003` | 图档类型 (单身) | |
| `DEB901` | `entry_person_no` | 录入者编号 (单身) | |
| `DEB902` | `entry_time` | 录入时间 (单身) | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `DEG001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `DEG001`
