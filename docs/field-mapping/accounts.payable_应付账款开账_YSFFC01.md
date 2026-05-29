# 应付账款开账 (accounts.payable) JSON 节点对照表

## DLL: YSFFC01

### 单头表 (YSFGRA)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GRA001` | 单号 | `GRA001` | string | 主键 |
| `GRA002` | (预留)性质 | `GRA002` | string |  |
| `GRA003` | 日期 | `GRA003` | string |  |
| `GRA004` | 经办人 | `GRA004` | string |  |
| `GRA005` | 部门 | `GRA005` | string |  |
| `GRA006` | 币种 | `GRA006` | string |  |
| `GRA007` | 专案 | `GRA007` | string |  |
| `GRA008` | 复核编号 | `GRA008` | string |  |
| `GRA009` | 复核姓名 | `GRA009` | string |  |
| `GRA010` | 审核码 | `GRA010` | string |  |
| `GRA011` | 日期 | `GRA011` | string |  |
| `GRA012` | 预留字段 | `GRA012` | string |  |
| `GRA013` | 预留字段 | `GRA013` | string |  |
| `GRA014` | 预留字段 | `GRA014` | string |  |
| `GRA015` | 预留字段 | `GRA015` | string |  |
| `GRA016` | 预留字段 | `GRA016` | float |  |
| `GRA017` | 预留字段 | `GRA017` | float |  |
| `GRA018` | 预留字段 | `GRA018` | string |  |
| `GRA019` | 预留字段 | `GRA019` | float |  |
| `GRA020` | 审核人 | `GRA020` | string |  |
| `GRA901` | 录入者编号 | `entry_person_no` | string |  |
| `GRA902` | 录入时间 | `entry_time` | string |  |
| `GRA903` | 更改者编号 | `changer_no` | string |  |
| `GRA904` | 更改时间 | `change_time` | string |  |
| `GRA905` | 更新标记 | `update_flag` | integer |  |
| `GRA960` | 自定文字1 | `udf_text1` | string |  |
| `GRA961` | 自定文字2 | `udf_text2` | string |  |
| `GRA962` | 自定文字3 | `udf_text3` | string |  |
| `GRA963` | 自定文字4 | `udf_text4` | string |  |
| `GRA964` | 自定文字5 | `udf_text5` | string |  |
| `GRA965` | 自定文字6 | `udf_text6` | string |  |
| `GRA980` | 自定数字1 | `udf_no1` | float |  |
| `GRA981` | 自定数字2 | `udf_no2` | float |  |
| `GRA982` | 自定数字3 | `udf_no3` | float |  |
| `GRA983` | 自定数字4 | `udf_no4` | float |  |
| `GRA984` | 自定数字5 | `udf_no5` | float |  |
| `GRA985` | 自定数字6 | `udf_no6` | float |  |
| `GRA966` | 自定文字7 | `udf_text7` | string |  |
| `GRA967` | 自定文字8 | `udf_text8` | string |  |
| `GRA968` | 自定文字9 | `udf_text9` | string |  |
| `GRA969` | 自定文字10 | `udf_text10` | string |  |
| `GRA970` | 自定文字11 | `udf_text11` | string |  |
| `GRA971` | 自定文字12 | `udf_text12` | string |  |
| `GRA972` | 自定文字13 | `udf_text13` | string |  |
| `GRA973` | 自定文字14 | `udf_text14` | string |  |
| `GRA974` | 自定文字15 | `udf_text15` | string |  |
| `GRA975` | 自定文字16 | `udf_text16` | string |  |
| `GRA986` | 自定数字7 | `udf_no7` | float |  |
| `GRA987` | 自定数字8 | `udf_no8` | float |  |
| `GRA988` | 自定数字9 | `udf_no9` | float |  |
| `GRA989` | 自定数字10 | `udf_no10` | float |  |
| `GRA990` | 自定数字11 | `udf_no11` | float |  |
| `GRA991` | 自定数字12 | `udf_no12` | float |  |
| `GRA992` | 自定数字13 | `udf_no13` | float |  |
| `GRA993` | 自定数字14 | `udf_no14` | float |  |
| `GRA994` | 自定数字15 | `udf_no15` | float |  |
| `GRA995` | 自定数字16 | `udf_no16` | float |  |
| `GRA906` | 打印次数 | `print_count` | integer |  |
| `GRA907` | 打印时间 | `print_time` | string |  |
| `GRA908` | 打印人员 | `printer` | string |  |
| `GRA909` | 打印人员姓名 | `printer_name` | string |  |
| `GRA959` | 审核时间 | `review_time` | string |  |

### 单身表 (YSFGRB)

| 字段编号 | 名称 | 节点名称(别名) | 类型 | 备注 |
| --- | --- | --- | --- | --- |
| `GRB001` | 单号 | `GRB001` | string |  |
| `GRB002` | 序号 | `GRB002` | string |  |
| `GRB003` | 供应商 | `GRB003` | string |  |
| `GRB004` | 应付金额 | `GRB004` | float |  |
| `GRB005` | 预付金额 | `GRB005` | float |  |
| `GRB006` | 本币应付 | `GRB006` | float |  |
| `GRB007` | 本币预付 | `GRB007` | float |  |
| `GRB008` | 审核码 | `GRB008` | string |  |
| `GRB009` | 预付款日 | `GRB009` | string |  |
| `GRB010` | (预留)日期 | `GRB010` | string |  |
| `GRB011` | 预留字段 | `GRB011` | string |  |
| `GRB012` | (预留)日期 | `GRB012` | string |  |
| `GRB013` | (预留) | `GRB013` | float |  |
| `GRB014` | 预兑现日 | `GRB014` | string |  |
| `GRB015` | 预留 | `GRB015` | string |  |
| `GRB016` | 预留字段 | `GRB016` | string |  |
| `GRB017` | 预留字段 | `GRB017` | string |  |
| `GRB018` | 预留字段 | `GRB018` | string |  |
| `GRB019` | 预留字段 | `GRB019` | string |  |
| `GRB020` | 预留字段 | `GRB020` | string |  |
| `GRB021` | 预留字段 | `GRB021` | string |  |
| `GRB022` | 预留字段 | `GRB022` | string |  |
| `GRB023` | 预留字段 | `GRB023` | string |  |
| `GRB024` | 预留字段 | `GRB024` | string |  |
| `GRB901` | 录入者编号 | `entry_person_no` | string |  |
| `GRB902` | 录入时间 | `entry_time` | string |  |
| `GRB903` | 更改者编号 | `changer_no` | string |  |
| `GRB904` | 更改时间 | `change_time` | string |  |
| `GRB905` | 更新标记 | `update_flag` | integer |  |
| `GRB960` | 自定文字1 | `udf_text1` | string |  |
| `GRB961` | 自定文字2 | `udf_text2` | string |  |
| `GRB962` | 自定文字3 | `udf_text3` | string |  |
| `GRB963` | 自定文字4 | `udf_text4` | string |  |
| `GRB964` | 自定文字5 | `udf_text5` | string |  |
| `GRB965` | 自定文字6 | `udf_text6` | string |  |
| `GRB980` | 自定数字1 | `udf_no1` | float |  |
| `GRB981` | 自定数字2 | `udf_no2` | float |  |
| `GRB982` | 自定数字3 | `udf_no3` | float |  |
| `GRB983` | 自定数字4 | `udf_no4` | float |  |
| `GRB984` | 自定数字5 | `udf_no5` | float |  |
| `GRB985` | 自定数字6 | `udf_no6` | float |  |
| `GRB966` | 自定文字7 | `udf_text7` | string |  |
| `GRB967` | 自定文字8 | `udf_text8` | string |  |
| `GRB968` | 自定文字9 | `udf_text9` | string |  |
| `GRB969` | 自定文字10 | `udf_text10` | string |  |
| `GRB970` | 自定文字11 | `udf_text11` | string |  |
| `GRB971` | 自定文字12 | `udf_text12` | string |  |
| `GRB972` | 自定文字13 | `udf_text13` | string |  |
| `GRB973` | 自定文字14 | `udf_text14` | string |  |
| `GRB974` | 自定文字15 | `udf_text15` | string |  |
| `GRB975` | 自定文字16 | `udf_text16` | string |  |
| `GRB986` | 自定数字7 | `udf_no7` | float |  |
| `GRB987` | 自定数字8 | `udf_no8` | float |  |
| `GRB988` | 自定数字9 | `udf_no9` | float |  |
| `GRB989` | 自定数字10 | `udf_no10` | float |  |
| `GRB990` | 自定数字11 | `udf_no11` | float |  |
| `GRB991` | 自定数字12 | `udf_no12` | float |  |
| `GRB992` | 自定数字13 | `udf_no13` | float |  |
| `GRB993` | 自定数字14 | `udf_no14` | float |  |
| `GRB994` | 自定数字15 | `udf_no15` | float |  |
| `GRB995` | 自定数字16 | `udf_no16` | float |  |
