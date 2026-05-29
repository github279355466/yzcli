# CLI 规格说明书：商品组合关系

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `commodity.combination` |
| **DLL** | `TPAGC44` |
| **服务名称** | `商品组合关系` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "commodity.combination" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "commodity.combination" \
  --action "getMultiple" \
  --data '{"datakeys":[{"DEI001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "commodity.combination" \
  --action "create" \
  --data '{"DEI001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `DEI001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPADEI)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DEI001` | 主件品号 | `DEI001` | string |  |
| `DEI002` | 序号 | `DEI002` | string |  |
| `DEI003` | 副产品品号 | `DEI003` | string |  |
| `DEI004` | 数量 | `DEI004` | float |  |
| `DEI005` | 备注 | `DEI005` | string |  |
| `DEI006` | 预留字段 | `DEI006` | string |  |
| `DEI007` | 预留字段 | `DEI007` | string |  |
| `DEI008` | 预留字段 | `DEI008` | string |  |
| `DEI009` | 预留字段 | `DEI009` | string |  |
| `DEI010` | 预留字段 | `DEI010` | float |  |
| `DEI011` | 预留字段 | `DEI011` | float |  |
| `DEI960` | 自定文字1 | `udf_text1` | string |  |
| `DEI961` | 自定文字2 | `udf_text2` | string |  |
| `DEI962` | 自定文字3 | `udf_text3` | string |  |
| `DEI963` | 自定文字4 | `udf_text4` | string |  |
| `DEI964` | 自定文字5 | `udf_text5` | string |  |
| `DEI965` | 自定文字6 | `udf_text6` | string |  |
| `DEI980` | 自定数字1 | `udf_no1` | float |  |
| `DEI981` | 自定数字2 | `udf_no2` | float |  |
| `DEI982` | 自定数字3 | `udf_no3` | float |  |
| `DEI983` | 自定数字4 | `udf_no4` | float |  |
| `DEI984` | 自定数字5 | `udf_no5` | float |  |
| `DEI985` | 自定数字6 | `udf_no6` | float |  |
| `DEI901` | 录入者编号 | `entry_person_no` | string |  |
| `DEI902` | 录入时间 | `entry_time` | string |  |
| `DEI903` | 更改者编号 | `changer_no` | string |  |
| `DEI904` | 更改时间 | `change_time` | string |  |
| `DEI905` | 更新标记 | `update_flag` | integer |  |
| `DEI966` | 自定文字7 | `udf_text7` | string |  |
| `DEI967` | 自定文字8 | `udf_text8` | string |  |
| `DEI968` | 自定文字9 | `udf_text9` | string |  |
| `DEI969` | 自定文字10 | `udf_text10` | string |  |
| `DEI970` | 自定文字11 | `udf_text11` | string |  |
| `DEI971` | 自定文字12 | `udf_text12` | string |  |
| `DEI972` | 自定文字13 | `udf_text13` | string |  |
| `DEI973` | 自定文字14 | `udf_text14` | string |  |
| `DEI974` | 自定文字15 | `udf_text15` | string |  |
| `DEI975` | 自定文字16 | `udf_text16` | string |  |
| `DEI986` | 自定数字7 | `udf_no7` | float |  |
| `DEI987` | 自定数字8 | `udf_no8` | float |  |
| `DEI988` | 自定数字9 | `udf_no9` | float |  |
| `DEI989` | 自定数字10 | `udf_no10` | float |  |
| `DEI990` | 自定数字11 | `udf_no11` | float |  |
| `DEI991` | 自定数字12 | `udf_no12` | float |  |
| `DEI992` | 自定数字13 | `udf_no13` | float |  |
| `DEI993` | 自定数字14 | `udf_no14` | float |  |
| `DEI994` | 自定数字15 | `udf_no15` | float |  |
| `DEI995` | 自定数字16 | `udf_no16` | float |  |

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
  "DEI001": ""
  ,"DEI001": ""
  ,"DEI002": ""
  ,"DEI003": ""
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
{"datakeys": [{"DEI001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"DEI001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `DEI001` | `DEI001` | 主件品号 | |
| `DEI002` | `DEI002` | 序号 | |
| `DEI003` | `DEI003` | 副产品品号 | |
| `DEI004` | `DEI004` | 数量 | |
| `DEI005` | `DEI005` | 备注 | |
| `DEI006` | `DEI006` | 预留字段 | |
| `DEI007` | `DEI007` | 预留字段 | |
| `DEI008` | `DEI008` | 预留字段 | |
| `DEI009` | `DEI009` | 预留字段 | |
| `DEI010` | `DEI010` | 预留字段 | |
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

- **写入（create/update）**：使用 `字段编号` 列（如 `DEI001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `DEI001`
