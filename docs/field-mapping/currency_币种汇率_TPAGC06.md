# 币种汇率 (currency) JSON 节点对照表

## DLL: TPAGC06

### 单头表 (TPABBA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `BBA001` | 币种编号 | `BBA001` | string | 主键 |
| `BBA002` | 货币名称 | `currency_name` | string |  |
| `BBA003` | 汇率 | `BBA003` | float |  |
| `BBA004` | 英文名称 | `BBA004` | string |  |
| `BBA005` | 预留字段1 | `BBA005` | string |  |
| `BBA006` | 预留字段2 | `BBA006` | float |  |
| `BBA007` | 货币符号 | `BBA007` | string |  |
| `BBA901` | 录入者编号 | `entry_person_no` | string |  |
| `BBA902` | 录入时间 | `entry_time` | string |  |
| `BBA903` | 更改者编号 | `changer_no` | string |  |
| `BBA904` | 更改时间 | `change_time` | string |  |
| `BBA905` | 更新标记 | `update_flag` | integer |  |

### 单身表 (TPABBB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `BBB001` | 生效日期 | `BBB001` | string |  |
| `BBB002` | 币种 | `BBB002` | string |  |
| `BBB003` | 记帐汇率 | `BBB003` | float |  |
| `BBB004` | 调整汇率 | `BBB004` | float |  |
| `BBB005` | 预留字段 | `BBB005` | float |  |
| `BBB006` | 预留字段 | `BBB006` | string |  |
| `BBB007` | 预留字段 | `BBB007` | string |  |
| `BBB008` | 预留字段 | `BBB008` | float |  |
| `BBB901` | 录入者编号 | `entry_person_no` | string |  |
| `BBB902` | 录入时间 | `entry_time` | string |  |
| `BBB903` | 更改者编号 | `changer_no` | string |  |
| `BBB904` | 更改时间 | `change_time` | string |  |
| `BBB905` | 更新标记 | `update_flag` | integer |  |
