# 批号信息 (item.lot) JSON 节点对照表

## DLL: TPAGC39

### 单头表 (TPADEH)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `DEH001` | 品号 | `item_no` | string |  |
| `DEH002` | 批号 | `batch_no` | string |  |
| `DEH003` | 批号说明 | `batch_no_descpt` | string |  |
| `DEH004` | 最早入库日 | `earliest_stockin_date` | string |  |
| `DEH005` | 生产日期 | `production_date` | string |  |
| `DEH006` | 有效日期 | `effective_date` | string |  |
| `DEH007` | 备注 | `remarks` | string |  |
| `DEH901` | 录入者编号 | `entry_person_no` | string |  |
| `DEH902` | 录入时间 | `entry_time` | string |  |
| `DEH903` | 更改者编号 | `changer_no` | string |  |
| `DEH904` | 更改者时间 | `change_time` | string |  |
| `DEH905` | 更新标记 | `update_flag` | integer |  |
| `DEH960` | 自定文字1 | `udf_text1` | string |  |
| `DEH961` | 自定文字2 | `udf_text2` | string |  |
| `DEH962` | 自定文字3 | `udf_text3` | string |  |
| `DEH963` | 自定文字4 | `udf_text4` | string |  |
| `DEH964` | 自定文字5 | `udf_text5` | string |  |
| `DEH965` | 自定文字6 | `udf_text6` | string |  |
| `DEH980` | 自定数字1 | `udf_no1` | float |  |
| `DEH981` | 自定数字2 | `udf_no2` | float |  |
| `DEH982` | 自定数字3 | `udf_no3` | float |  |
| `DEH983` | 自定数字4 | `udf_no4` | float |  |
| `DEH984` | 自定数字5 | `udf_no5` | float |  |
| `DEH985` | 自定数字6 | `udf_no6` | float |  |
| `DEH008` | 注销码 | `cancellation_code` | string |  |
| `DEH009` | 注销日期 | `cancellation_date` | string |  |
| `DEH966` | 自定文字7 | `udf_text7` | string |  |
| `DEH967` | 自定文字8 | `udf_text8` | string |  |
| `DEH968` | 自定文字9 | `udf_text9` | string |  |
| `DEH969` | 自定文字10 | `udf_text10` | string |  |
| `DEH970` | 自定文字11 | `udf_text11` | string |  |
| `DEH971` | 自定文字12 | `udf_text12` | string |  |
| `DEH972` | 自定文字13 | `udf_text13` | string |  |
| `DEH973` | 自定文字14 | `udf_text14` | string |  |
| `DEH974` | 自定文字15 | `udf_text15` | string |  |
| `DEH975` | 自定文字16 | `udf_text16` | string |  |
| `DEH986` | 自定数字7 | `udf_no7` | float |  |
| `DEH987` | 自定数字8 | `udf_no8` | float |  |
| `DEH988` | 自定数字9 | `udf_no9` | float |  |
| `DEH989` | 自定数字10 | `udf_no10` | float |  |
| `DEH990` | 自定数字11 | `udf_no11` | float |  |
| `DEH991` | 自定数字12 | `udf_no12` | float |  |
| `DEH992` | 自定数字13 | `udf_no13` | float |  |
| `DEH993` | 自定数字14 | `udf_no14` | float |  |
| `DEH994` | 自定数字15 | `udf_no15` | float |  |
| `DEH995` | 自定数字16 | `udf_no16` | float |  |

### 单身表 (TPADEB)

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

### 扩展表 (TPADEC)

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
