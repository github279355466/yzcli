# yzcli/commands/help.py - 帮助命令
"""
帮助命令模块
显示指定TypeKey的字段元数据信息
"""

import click

from ..core import (
    get_mapper,
    OutputFormatter,
)
from .base import add_common_options, handle_common_options, restore_field_mode, handle_error


@click.command(name='help')
@add_common_options
@click.argument('type_key', required=True)
@click.option('--required-only', is_flag=True,
              help='只显示必填字段')
@click.option('--pk-only', is_flag=True,
              help='只显示主键字段')
@click.option('--writable-only', is_flag=True,
              help='只显示可写字段')
def help_cmd(type_key: str, required_only: bool, pk_only: bool, writable_only: bool, **kwargs):
    """显示 TYPE_KEY 类型的字段元数据信息

    \b
    显示所有字段的编号、英文名、中文名、类型、长度等信息
    """
    try:
        kwargs, original_mode = handle_common_options(**kwargs)

        mapper = get_mapper(type_key)
        fields = mapper.all_fields()

        # 过滤
        if required_only:
            fields = [f for f in fields if f.required]
        if pk_only:
            fields = [f for f in fields if f.field_kind == '主键字段']  # 主键字段
        if writable_only:
            fields = [f for f in fields if not f.read_only]

        if not fields:
            click.secho("没有找到符合条件的字段", fg='yellow')
            return

        # 准备显示数据
        display_data = []
        for field in fields:
            tags = []
            if field.field_kind == '主键字段':  # 主键字段
                tags.append('PK')
            if field.required:
                tags.append('*')
            if field.read_only:
                tags.append('RO')
            if field.field_kind == '计算字段':  # 计算字段
                tags.append('CALC')

            tag_str = ' '.join(tags) if tags else ''

            display_data.append({
                'field_number': field.field_number,
                'json_name': field.json_name,
                'label': field.display_label,
                'type': field.data_type,
                'size': field.size,
                'flags': tag_str,
            })

        # 输出
        click.secho(f"{type_key} 字段说明 (共 {len(display_data)} 个字段)", fg='cyan')
        click.secho("=" * 100, fg='cyan')

        ctx = click.get_current_context()
        output_format = ctx.obj.get('output_format') if ctx.obj else None
        pretty_print = ctx.obj.get('pretty_print') if ctx.obj else None
        formatter = OutputFormatter(output_format, pretty_print)
        click.echo(formatter.format(display_data))

        # 显示图例
        click.secho("\n图例:", fg='cyan')
        click.echo("  PK=主键字段  *=必填字段  RO=只读字段  CALC=计算字段")

        restore_field_mode(original_mode)

    except Exception as e:
        handle_error(e)
