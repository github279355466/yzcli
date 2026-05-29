# 应收账款开账 (accounts.receivable) JSON 节点对照表

## DLL: YSFSC01

### 单头表 (YSFGEA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GEA001` | 单号 | `GEA001` | string | 主键 |
| `GEA002` | (预留)性质 | `GEA002` | string |  |
| `GEA003` | 日期 | `GEA003` | string |  |
| `GEA004` | 业务员 | `GEA004` | string |  |
| `GEA005` | 部门 | `GEA005` | string |  |
| `GEA006` | 币种 | `GEA006` | string |  |
| `GEA007` | 专案 | `GEA007` | string |  |
| `GEA008` | 复核编号 | `GEA008` | string |  |
| `GEA009` | 复核姓名 | `GEA009` | string |  |
| `GEA010` | 审核码 | `GEA010` | string |  |
| `GEA011` | 日期 | `GEA011` | string |  |
| `GEA012` | 预留字段 | `GEA012` | string |  |
| `GEA013` | 预留字段 | `GEA013` | string |  |
| `GEA014` | 预留字段 | `GEA014` | string |  |
| `GEA015` | 预留字段 | `GEA015` | string |  |
| `GEA016` | 预留字段 | `GEA016` | float |  |
| `GEA017` | 预留字段 | `GEA017` | float |  |
| `GEA018` | 预留字段 | `GEA018` | string |  |
| `GEA019` | 预留字段 | `GEA019` | float |  |
| `GEA020` | 审核人 | `GEA020` | string |  |
| `GEA901` | 录入者编号 | `entry_person_no` | string |  |
| `GEA902` | 录入时间 | `entry_time` | string |  |
| `GEA903` | 更改者编号 | `changer_no` | string |  |
| `GEA904` | 更改时间 | `change_time` | string |  |
| `GEA905` | 更新标记 | `update_flag` | integer |  |
| `GEA960` | 自定文字1 | `udf_text1` | string |  |
| `GEA961` | 自定文字2 | `udf_text2` | string |  |
| `GEA962` | 自定文字3 | `udf_text3` | string |  |
| `GEA963` | 自定文字4 | `udf_text4` | string |  |
| `GEA964` | 自定文字5 | `udf_text5` | string |  |
| `GEA965` | 自定文字6 | `udf_text6` | string |  |
| `GEA980` | 自定数字1 | `udf_no1` | float |  |
| `GEA981` | 自定数字2 | `udf_no2` | float |  |
| `GEA982` | 自定数字3 | `udf_no3` | float |  |
| `GEA983` | 自定数字4 | `udf_no4` | float |  |
| `GEA984` | 自定数字5 | `udf_no5` | float |  |
| `GEA985` | 自定数字6 | `udf_no6` | float |  |
| `GEA966` | 自定文字7 | `udf_text7` | string |  |
| `GEA967` | 自定文字8 | `udf_text8` | string |  |
| `GEA968` | 自定文字9 | `udf_text9` | string |  |
| `GEA969` | 自定文字10 | `udf_text10` | string |  |
| `GEA970` | 自定文字11 | `udf_text11` | string |  |
| `GEA971` | 自定文字12 | `udf_text12` | string |  |
| `GEA972` | 自定文字13 | `udf_text13` | string |  |
| `GEA973` | 自定文字14 | `udf_text14` | string |  |
| `GEA974` | 自定文字15 | `udf_text15` | string |  |
| `GEA975` | 自定文字16 | `udf_text16` | string |  |
| `GEA986` | 自定数字7 | `udf_no7` | float |  |
| `GEA987` | 自定数字8 | `udf_no8` | float |  |
| `GEA988` | 自定数字9 | `udf_no9` | float |  |
| `GEA989` | 自定数字10 | `udf_no10` | float |  |
| `GEA990` | 自定数字11 | `udf_no11` | float |  |
| `GEA991` | 自定数字12 | `udf_no12` | float |  |
| `GEA992` | 自定数字13 | `udf_no13` | float |  |
| `GEA993` | 自定数字14 | `udf_no14` | float |  |
| `GEA994` | 自定数字15 | `udf_no15` | float |  |
| `GEA995` | 自定数字16 | `udf_no16` | float |  |
| `GEA906` | 打印次数 | `print_count` | integer |  |
| `GEA907` | 打印时间 | `print_time` | string |  |
| `GEA908` | 打印人员 | `printer` | string |  |
| `GEA909` | 打印人员姓名 | `printer_name` | string |  |
| `GEA959` | 审核时间 | `review_time` | string |  |

### 单身表 (YSFGEB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GEB001` | 单号 | `GEB001` | string |  |
| `GEB002` | 序号 | `GEB002` | string |  |
| `GEB003` | 请款客户 | `GEB003` | string |  |
| `GEB004` | 应收金额 | `GEB004` | float |  |
| `GEB005` | 预收金额 | `GEB005` | float |  |
| `GEB006` | 本币应收 | `GEB006` | float |  |
| `GEB007` | 本币预收 | `GEB007` | float |  |
| `GEB008` | 审核码 | `GEB008` | string |  |
| `GEB009` | 预收款日 | `GEB009` | string |  |
| `GEB010` | (预留)日期 | `GEB010` | string |  |
| `GEB011` | (预留)客户 | `GEB011` | string |  |
| `GEB012` | (预留)日期 | `GEB012` | string |  |
| `GEB013` | 预留字段 | `GEB013` | float |  |
| `GEB014` | 预兑现日 | `GEB014` | string |  |
| `GEB015` | 预留 | `GEB015` | string |  |
| `GEB016` | 预留字段 | `GEB016` | string |  |
| `GEB017` | 预留字段 | `GEB017` | string |  |
| `GEB018` | 预留字段 | `GEB018` | string |  |
| `GEB019` | 预留字段 | `GEB019` | string |  |
| `GEB020` | 预留字段 | `GEB020` | string |  |
| `GEB021` | 预留字段 | `GEB021` | string |  |
| `GEB022` | 预留字段 | `GEB022` | string |  |
| `GEB023` | 预留字段 | `GEB023` | string |  |
| `GEB024` | 预留字段 | `GEB024` | string |  |
| `GEB901` | 录入者编号 | `entry_person_no` | string |  |
| `GEB902` | 录入时间 | `entry_time` | string |  |
| `GEB903` | 更改者编号 | `changer_no` | string |  |
| `GEB904` | 更改时间 | `change_time` | string |  |
| `GEB905` | 更新标记 | `update_flag` | integer |  |
| `GEB960` | 自定文字1 | `udf_text1` | string |  |
| `GEB961` | 自定文字2 | `udf_text2` | string |  |
| `GEB962` | 自定文字3 | `udf_text3` | string |  |
| `GEB963` | 自定文字4 | `udf_text4` | string |  |
| `GEB964` | 自定文字5 | `udf_text5` | string |  |
| `GEB965` | 自定文字6 | `udf_text6` | string |  |
| `GEB980` | 自定数字1 | `udf_no1` | float |  |
| `GEB981` | 自定数字2 | `udf_no2` | float |  |
| `GEB982` | 自定数字3 | `udf_no3` | float |  |
| `GEB983` | 自定数字4 | `udf_no4` | float |  |
| `GEB984` | 自定数字5 | `udf_no5` | float |  |
| `GEB985` | 自定数字6 | `udf_no6` | float |  |
| `GEB966` | 自定文字7 | `udf_text7` | string |  |
| `GEB967` | 自定文字8 | `udf_text8` | string |  |
| `GEB968` | 自定文字9 | `udf_text9` | string |  |
| `GEB969` | 自定文字10 | `udf_text10` | string |  |
| `GEB970` | 自定文字11 | `udf_text11` | string |  |
| `GEB971` | 自定文字12 | `udf_text12` | string |  |
| `GEB972` | 自定文字13 | `udf_text13` | string |  |
| `GEB973` | 自定文字14 | `udf_text14` | string |  |
| `GEB974` | 自定文字15 | `udf_text15` | string |  |
| `GEB975` | 自定文字16 | `udf_text16` | string |  |
| `GEB986` | 自定数字7 | `udf_no7` | float |  |
| `GEB987` | 自定数字8 | `udf_no8` | float |  |
| `GEB988` | 自定数字9 | `udf_no9` | float |  |
| `GEB989` | 自定数字10 | `udf_no10` | float |  |
| `GEB990` | 自定数字11 | `udf_no11` | float |  |
| `GEB991` | 自定数字12 | `udf_no12` | float |  |
| `GEB992` | 自定数字13 | `udf_no13` | float |  |
| `GEB993` | 自定数字14 | `udf_no14` | float |  |
| `GEB994` | 自定数字15 | `udf_no15` | float |  |
| `GEB995` | 自定数字16 | `udf_no16` | float |  |
