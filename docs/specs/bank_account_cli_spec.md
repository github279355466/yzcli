# CLI 规格说明书：开户账号

## 1. 命令摘要

| 属性 | 值 |
| --- | --- |
| **TypeKey** | `bank.account` |
| **DLL** | `TPAGC36` |
| **服务名称** | `开户账号` |
| **支持的操作** | `fastquery`, `getMultiple`, `create`, `update`, `delete` |
| **业务类型** | 基础资料 |

## 2. 命令语法

### 查询列表（fastquery）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bank.account" \
  --action "fastquery" \
  --data '{"page_no":1,"page_size":10,"use_has_next":true}' \
  --json
```

### 读取详情（getMultiple）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bank.account" \
  --action "getMultiple" \
  --data '{"datakeys":[{"CAA001":"?"}]}' \
  --json
```

### 新增（create）

```bash
python3 scripts/erp_generic_adapter.py \
  --type-key "bank.account" \
  --action "create" \
  --data '{"CAA001":"",...}' \
  --json
```


## 3. 字段映射表

> **写入操作（create/update）** 使用 `字段编号`（如 `CAA001`）

> **读取响应（getMultiple）** 同时返回 `字段编号` 和 `节点名称`（可读别名）

> **条件查询（fastquery）** 条件中的字段名使用 `节点名称`（可读别名）


### 3.1 单头表 (TPACAA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `CAA001` | 序 | `CAA001` | string | 主键 |
| `CAA002` | 历别 | `CAA002` | string |  |
| `CAA003` | 日期间隔符 | `CAA003` | string |  |
| `CAA004` | 记账本位币 | `CAA004` | string |  |
| `CAA005` | 税率 | `CAA005` | float |  |
| `CAA006` | 多币管理 | `CAA006` | string |  |
| `CAA007` | 专案管理 | `CAA007` | string |  |
| `CAA008` | 品号输入方式 | `CAA008` | string |  |
| `CAA009` | 税额计算方式 | `CAA009` | string |  |
| `CAA010` | 数量小数取位 | `CAA010` | integer |  |
| `CAA011` | 单价小数取位 | `CAA011` | integer |  |
| `CAA012` | 原币金额小数取位 | `CAA012` | integer |  |
| `CAA013` | 本币金额小数取位 | `CAA013` | integer |  |
| `CAA014` | 本币税额小数取位 | `CAA014` | integer |  |
| `CAA015` | 汇率小数取位 | `CAA015` | integer |  |
| `CAA016` | 原币税额小数取位 | `CAA016` | integer |  |
| `CAA017` | 预留字段 | `CAA017` | integer |  |
| `CAA018` | 预留字段 | `CAA018` | integer |  |
| `CAA019` | 复核管理 | `CAA019` | string |  |
| `CAA020` | 部门管理 | `CAA020` | string |  |
| `CAA021` | 基础数据启用模糊查询 | `CAA021` | string |  |
| `CAA022` | 预留字段 | `CAA022` | float |  |
| `CAA023` | 批号管理 | `CAA023` | string |  |
| `CAA024` | 出库时指定批号 | `CAA024` | string |  |
| `CAA025` | 批号拆分原则 | `CAA025` | string |  |
| `CAA026` | 是否启用附件功能 | `CAA026` | string |  |
| `CAA027` | 是否限制附件 | `CAA027` | string |  |
| `CAA028` | 附件大小 | `CAA028` | integer |  |
| `CAA029` | 是否压缩附件 | `CAA029` | string |  |
| `CAA030` | 口令连续输错几次锁定 | `CAA030` | integer |  |
| `CAA031` | 启用快速查询 | `CAA031` | string |  |
| `CAA032` | 启用多级审批 | `CAA032` | string |  |
| `CAA033` | 启用自动短信 | `CAA033` | string |  |
| `CAA034` | 条码比对参数 | `CAA034` | string |  |
| `CAA035` | 清除连接管理 | `CAA035` | string |  |
| `CAA036` | 清除时间(分钟) | `CAA036` | integer |  |
| `CAA037` | 集成SOAP地址 | `soap` | string |  |
| `CAA901` | 录入者编号 | `entry_person_no` | string |  |
| `CAA902` | 录入时间 | `entry_time` | string |  |
| `CAA903` | 更改者编号 | `changer_no` | string |  |
| `CAA904` | 更改时间 | `change_time` | string |  |
| `CAA905` | 更新标记 | `update_flag` | integer |  |

## 4. 请求结构示例

> **注意**：适配器会自动包装 `std_data.parameter` 层。`--data` 参数只传**内层业务数据**，无需包含 `std_data` 和 `parameter`。

> 完整 API 报文 = `{"std_data": {"parameter": <--data内容> }}`

### 4.1 创建/更新（--data 传入内容）

```json
{
  "CAA001": ""
  ,"CAA002": ""
  ,"CAA003": ""
  ,"CAA004": ""
}
```
> 适配器自动包装为：`{"std_data": {"parameter": {"cdsMaster": [<--data内容>]}}}`

### 4.2 读取/审核/删除（--data 传入内容）

```json
{"datakeys": [{"CAA001": "?"}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`

### 4.3 条件查询（--data 传入内容）

```json
{"page_no":1,"page_size":10,"use_has_next":true,"conditions":[{"fields":[{"field_name":"CAA001","value":"?","operator":"like"}]}]}
```
> 适配器自动包装为：`{"std_data": {"parameter": <--data内容>}}`


## 5. 关键响应字段

| 字段编号 | 节点名称(别名) | 名称 | 说明 |
| --- | --- | --- | --- |
| `CAA001` | `CAA001` | 序 | 主键 |
| `CAA002` | `CAA002` | 历别 | |
| `CAA003` | `CAA003` | 日期间隔符 | |
| `CAA004` | `CAA004` | 记账本位币 | |
| `CAA005` | `CAA005` | 税率 | |
| `CAA006` | `CAA006` | 多币管理 | |
| `CAA007` | `CAA007` | 专案管理 | |
| `CAA008` | `CAA008` | 品号输入方式 | |
| `CAA009` | `CAA009` | 税额计算方式 | |
| `CAA010` | `CAA010` | 数量小数取位 | |

## 6. 退出码 (Exit Codes)

| 代码 | 含义 | 说明 |
| --- | --- | --- |
| 0 | 成功 | 操作成功完成 |
| 2 | 验证错误 | 参数格式错误或缺少必填字段 |
| 3 | 权限错误 | Token 无效或未设置 |
| 7 | 事务失败 | ERP 业务逻辑错误 |

## 7. 字段命名规则

- **写入（create/update）**：使用 `字段编号` 列（如 `CAA001`）
- **读取响应（getMultiple）**：同时返回 `字段编号` 和 `节点名称`
- **条件查询（fastquery）**：条件中的字段名使用 `节点名称`（别名）
- **审批/删除**：通过 `datakeys` 定位，使用主键 `CAA001`
