# yzcli/commands/query.py - 查询命令
"""
查询命令模块
支持所有TypeKey的通用查询功能
"""

import click

from ..core import (
    get_mapper,
    ConditionParser,
    OutputFormatter,
)
from .base import add_common_options, handle_common_options, restore_field_mode, handle_error


@click.command(name='query')
@add_common_options
@click.argument('type_key', required=True)
@click.option('--condition', '-c', multiple=True,
              help='查询条件，可多次使用，如: customer=000002, qty>10')
@click.option('--order-by', multiple=True,
              help='排序条件，如: date:desc, customer')
@click.option('--page', '-p', type=int, default=1, help='页码，默认1')
@click.option('--page-size', '-s', type=int, default=20, help='每页数量，默认20')
@click.option('--no-page', is_flag=True, help='不使用分页')
@click.option('--key-only', is_flag=True, help='只返回主键字段')
def query_cmd(type_key: str, condition: tuple, order_by: tuple,
              page: int, page_size: int, no_page: bool, key_only: bool,
              **kwargs):
    """查询 TYPE_KEY 类型的数据

    \b
    查询条件语法：
      等于:      field=value
      大于:      field>value
      大于等于:  field>=value
      小于:      field<value
      小于等于:  field<=value
      不等于:    field<>value
      LIKE:      field like PATTERN
      IN:        field in (v1,v2,v3)
      BETWEEN:   field between v1 and v2
      EXISTS:    field exists (...)

    \b
    示例：
      yzcli query sales.order --condition "customer=000002"
      yzcli query sales.order -c "qty>10" -c "date>=20250101"
      yzcli query sales.order --order-by date:desc --page 2
    """
    try:
        kwargs, original_mode = handle_common_options(**kwargs)

        from ..core import get_client

        client = get_client()
        mapper = get_mapper(type_key)
        parser = ConditionParser(mapper)

        # 解析条件
        conditions = []
        for cond_str in condition:
            conditions.append(parser.parse(cond_str))

        # 解析排序
        orders = []
        for order_str in order_by:
            orders.append(parser.parse_order(order_str))

        # 构造查询参数
        query_params = {}

        if conditions:
            # 简单情况下使用 AND 组合
            query_params['conditions'] = [{
                "groups": [{
                    "fields": conditions
                }]
            }]

        if orders:
            query_params['orders'] = orders

        response = client.query(
            type_key=type_key,
            conditions=query_params.get('conditions'),
            orders=query_params.get('orders'),
            page_no=page,
            page_size=page_size,
            use_has_next=not no_page,
            query_type="key" if key_only else "all"
        )

        # 输出结果
        if not response.success and response.code == '-1':
            # 完全失败
            click.secho(f"执行失败: {response.message}", fg='red')
            return

        result = response.data.get('result', {})
        success_data = result.get('success', [])
        error_data = result.get('error', [])

        if error_data:
            click.secho("错误数据:", fg='red')
            for error in error_data:
                msg = error.get('message', str(error))
                click.echo(f"  - {msg}")

        if success_data:
            # 提取记录总数（API返回的值可能是字符串）
            total = int(success_data[0].get('total_result', 0)) if success_data else 0
            page_count = int(success_data[0].get('page_count', 0))
            current_page = int(success_data[0].get('page_no', 0))

            # 提取实际数据
            records = []
            for item in success_data:
                if 'cdsMaster' in item:
                    master = item['cdsMaster']
                    if isinstance(master, list):
                        records.extend(master)
                    else:
                        records.append(master)

            click.secho(f"查询结果：共 {total} 条记录", fg='cyan')
            if page_count > 1:
                click.echo(f"当前第 {current_page}/{page_count} 页")
            click.echo("")

            if records:
                ctx = click.get_current_context()
                output_format = ctx.obj.get('output_format') if ctx.obj else None
                pretty_print = ctx.obj.get('pretty_print') if ctx.obj else None
                formatter = OutputFormatter(output_format, pretty_print)
                click.echo(formatter.format(records))
            else:
                click.echo("没有找到匹配的记录")
        else:
            click.secho("没有找到数据", fg='yellow')

        restore_field_mode(original_mode)

    except Exception as e:
        handle_error(e)
