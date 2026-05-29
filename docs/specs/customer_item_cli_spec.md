# CLI 规格说明书：客户品号

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `customer.item` |
| **DLL** | `TPAGC11` |
| **服务名称** | `客户品号` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "customer.item" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "customer.item" \
  --action "getMultiple" \
  --data '{"datakeys":[{"DEF001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "customer.item" \
  --action "create" \
  --data '{"DEF001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `DEF001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPADEF)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DEF001` | 品号 | `item_no` | string |  |
| `DEF002` | 客户编号 | `customer_no` | string |  |
| `DEF003` | 客户品号 | `customer_item_no` | string |  |
| `DEF004` | 客户品名 | `customer_product_name` | string |  |
| `DEF005` | 预留字段 | `reserved_field` | string |  |
| `DEF006` | 客户规格 | `customer_specifications` | string |  |
| `DEF901` | 录入者编号 | `entry_person_no` | string |  |
| `DEF902` | 录入时间 | `entry_time` | string |  |
| `DEF903` | 更改者编号 | `changer_no` | string |  |
| `DEF904` | 更改时间 | `change_time` | string |  |
| `DEF905` | 更新标记 | `update_flag` | integer |  |
| `DEF960` | 自定文字1 | `udf_text1` | string |  |
| `DEF961` | 自定文字2 | `udf_text2` | string |  |
| `DEF962` | 自定文字3 | `udf_text3` | string |  |
| `DEF963` | 自定文字4 | `udf_text4` | string |  |
| `DEF964` | 自定文字5 | `udf_text5` | string |  |
| `DEF965` | 自定文字6 | `udf_text6` | string |  |
| `DEF980` | 自定数字1 | `udf_no1` | float |  |
| `DEF981` | 自定数字2 | `udf_no2` | float |  |
| `DEF982` | 自定数字3 | `udf_no3` | float |  |
| `DEF983` | 自定数字4 | `udf_no4` | float |  |
| `DEF984` | 自定数字5 | `udf_no5` | float |  |
| `DEF985` | 自定数字6 | `udf_no6` | float |  |
| `DEF966` | 自定文字7 | `udf_text7` | string |  |
| `DEF967` | 自定文字8 | `udf_text8` | string |  |
| `DEF968` | 自定文字9 | `udf_text9` | string |  |
| `DEF969` | 自定文字10 | `udf_text10` | string |  |
| `DEF970` | 自定文字11 | `udf_text11` | string |  |
| `DEF971` | 自定文字12 | `udf_text12` | string |  |
| `DEF972` | 自定文字13 | `udf_text13` | string |  |
| `DEF973` | 自定文字14 | `udf_text14` | string |  |
| `DEF974` | 自定文字15 | `udf_text15` | string |  |
| `DEF975` | 自定文字16 | `udf_text16` | string |  |
| `DEF986` | 自定数字7 | `udf_no7` | float |  |
| `DEF987` | 自定数字8 | `udf_no8` | float |  |
| `DEF988` | 自定数字9 | `udf_no9` | float |  |
| `DEF989` | 自定数字10 | `udf_no10` | float |  |
| `DEF990` | 自定数字11 | `udf_no11` | float |  |
| `DEF991` | 自定数字12 | `udf_no12` | float |  |
| `DEF992` | 自定数字13 | `udf_no13` | float |  |
| `DEF993` | 自定数字14 | `udf_no14` | float |  |
| `DEF994` | 自定数字15 | `udf_no15` | float |  |
| `DEF995` | 自定数字16 | `udf_no16` | float |  |
| `DEF906` | 打印次数 | `print_count` | integer |  |
| `DEF907` | 打印时间 | `print_time` | string |  |
| `DEF908` | 打印人员 | `printer` | string |  |
| `DEF909` | 打印人员姓名 | `printer_name` | string |  |

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
  "DEF001": ""
  ,"DEF001": ""
  ,"DEF002": ""
  ,"DEF003": ""
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
{"datakeys": [{"DEF001": "?"}]}
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
| `DEF001` | `item_no` | 品号 | |
| `DEF002` | `customer_no` | 客户编号 | |
| `DEF003` | `customer_item_no` | 客户品号 | |
| `DEF004` | `customer_product_name` | 客户品名 | |
| `DEF005` | `reserved_field` | 预留字段 | |
| `DEF006` | `customer_specifications` | 客户规格 | |
| `DEF901` | `entry_person_no` | 录入者编号 | |
| `DEF902` | `entry_time` | 录入时间 | |
| `DEF903` | `changer_no` | 更改者编号 | |
| `DEF904` | `change_time` | 更改时间 | |
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

- **写入（create/update）**：使用 `字段编号` 列（如 `DEF001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `DEF001`
