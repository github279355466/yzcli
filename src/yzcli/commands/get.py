# yzcli/commands/get.py - 读取命令
"""
读取命令模块
支持所有TypeKey的通用读取功能
"""

import json
import click

from ..core import (
    get_mapper,
    OutputFormatter,
)
from .base import add_common_options, handle_common_options, restore_field_mode, handle_error


@click.command(name='get')
@add_common_options
@click.argument('type_key', required=True)
@click.option('--key', '-k', multiple=True,
              help='主键键值对，格式: name=value，可多次使用指定多个主键')
@click.option('--batch', '-b', type=click.File('r', encoding='utf-8'),
              help='批量读取，从JSON文件加载主键列表')
@click.option('--show-detail', is_flag=True, default=True,
              help='显示单身明细数据')
def get_cmd(type_key: str, key: tuple, batch: click.File, show_detail: bool, **kwargs):
    """读取 TYPE_KEY 类型的单据数据

    \b
    单主键示例：
      yzcli get sales.order --key docNo=20250218000001

    \b
    复合主键示例：
      yzcli get wo.stock.in --key docNo=20250218000001 --key category=84

    \b
    批量读取：
      yzcli get wo.stock.in --batch @keys.json
    """
    try:
        kwargs, original_mode = handle_common_options(**kwargs)

        from ..core import get_client

        client = get_client()

        # 构建 datakeys
        datakeys = []

        if batch:
            # 从文件批量加载
            batch_data = json.load(batch)
            if isinstance(batch_data, list):
                datakeys = batch_data
            else:
                datakeys = [batch_data]
        elif key:
            # 从命令行参数构建
            key_dict = {}
            for k in key:
                if '=' in k:
                    name, value = k.split('=', 1)
                    key_dict[name.strip()] = value.strip()
            if key_dict:
                datakeys = [key_dict]
        else:
            # 交互式输入主键
            mapper = get_mapper(type_key)
            pk_json_names = mapper.get_primary_keys_json_names()
            if not pk_json_names:
                pk_json_names = [f"key{i+1}" for i in range(2)]

            key_dict = {}
            click.secho("请输入主键值：", fg='cyan')
            for pk_name in pk_json_names:
                value = click.prompt(f"  {pk_name}", type=str)
                key_dict[pk_name] = value
            datakeys = [key_dict]

        if not datakeys:
            raise click.ClickException("未指定任何主键")

        response = client.get(type_key=type_key, datakeys=datakeys)

        # 输出结果
        result = response.data.get('result', {})
        success_data = result.get('success', [])
        error_data = result.get('error', [])

        if not response.success and response.code == '-1':
            click.secho(f"执行失败: {response.message}", fg='red')
            if error_data:
                click.secho("错误数据:", fg='red')
                for error in error_data:
                    msg = error.get('message', str(error))
                    click.echo(f"  - {msg}")
            restore_field_mode(original_mode)
            return

        if error_data:
            click.secho("错误数据:", fg='red')
            for error in error_data:
                msg = error.get('message', str(error))
                click.echo(f"  - {msg}")

        if success_data:
            for i, item in enumerate(success_data, 1):
                if len(success_data) > 1:
                    click.echo(f"\n记录 {i}:")

                # 主表数据
                if 'cdsMaster' in item:
                    master = item['cdsMaster']
                    if isinstance(master, list) and len(master) == 1:
                        master = master[0]
                    ctx = click.get_current_context()
                    output_format = ctx.obj.get('output_format') if ctx.obj else None
                    pretty_print = ctx.obj.get('pretty_print') if ctx.obj else None
                    formatter = OutputFormatter(output_format, pretty_print)
                    click.echo(formatter.format(master))

                # 单身明细
                if show_detail and 'cdsDetail' in item:
                    details = item['cdsDetail']
                    if details:
                        if isinstance(details, list):
                            click.echo(f"\n单身明细：共 {len(details)} 条")
                            output_format = ctx.obj.get('output_format') if ctx.obj else None
                            pretty_print = ctx.obj.get('pretty_print') if ctx.obj else None
                            formatter = OutputFormatter(output_format, pretty_print)
                            click.echo(formatter.format(details))
                        else:
                            click.echo(f"\n单身明细：{details}")
        else:
            click.secho("没有找到数据", fg='yellow')

        restore_field_mode(original_mode)

    except Exception as e:
        handle_error(e)
