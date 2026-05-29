# yzcli/commands/create.py - 新增命令
"""
新增命令模块
支持所有TypeKey的通用新增功能
"""

import json
import click

from ..core import (
    get_mapper,
    OutputFormatter,
)
from .base import add_common_options, handle_common_options, restore_field_mode, handle_error


@click.command(name='create')
@add_common_options
@click.argument('type_key', required=True)
@click.option('--json', '-j', 'json_arg',
              help='JSON数据，支持 @filename 语法从文件读取')
@click.option('--interactive', '-i', is_flag=True,
              help='交互模式，引导式输入必填字段')
@click.option('--batch', type=click.File('r', encoding='utf-8'),
              help='批量新增，从JSON文件加载多条记录')
@click.option('--dry-run', is_flag=True,
              help='预览模式，只显示要提交的数据而不实际调用API')
def create_cmd(type_key: str, json_arg: str, interactive: bool,
               batch: click.File, dry_run: bool, **kwargs):
    """新增 TYPE_KEY 类型的单据数据

    \b
    从JSON文件新增：
      yzcli create sales.order --json @new_order.json

    \b
    交互式新增（只提示必填字段）：
      yzcli create sales.order --interactive

    \b
    批量新增：
      yzcli create sales.order --batch @orders.json
    """
    try:
        kwargs, original_mode = handle_common_options(**kwargs)

        from ..core import get_client

        client = get_client()

        cds_master = []

        if batch:
            # 批量模式
            batch_data = json.load(batch)
            if isinstance(batch_data, list):
                cds_master = batch_data
            else:
                cds_master = [batch_data]

        elif json_arg:
            # JSON参数模式
            if json_arg.startswith('@'):
                filename = json_arg[1:]
                with open(filename, 'r', encoding='utf-8') as f:
                    data = json.load(f)
            else:
                data = json.loads(json_arg)

            if isinstance(data, list):
                cds_master = data
            else:
                cds_master = [data]

        elif interactive:
            # 交互模式
            mapper = get_mapper(type_key)
            required_fields = mapper.get_required_fields()

            if not required_fields:
                click.secho("未找到必填字段定义，可能无法正确创建单据", fg='yellow')
                return

            click.secho(f"\n新增 {type_key} 交互模式", fg='cyan')
            click.secho("=" * 50, fg='cyan')

            record = {}
            for field in required_fields:
                prompt = f"{field.display_label} ({field.json_name})"
                if field.data_type == 'string':
                    value = click.prompt(prompt, type=str, default='')
                elif field.data_type in ['int', 'integer']:
                    value = click.prompt(prompt, type=int, default=0)
                elif field.data_type in ['decimal', 'float', 'number']:
                    value = click.prompt(prompt, type=float, default=0.0)
                else:
                    value = click.prompt(prompt, type=str, default='')

                if value or value == 0:
                    record[field.json_name] = value

            # 询问是否需要单身明细
            if click.confirm("\n是否需要添加单身明细？", default=False):
                details = []
                while True:
                    click.echo(f"\n明细行 {len(details) + 1}:")
                    detail = {}
                    detail_json = click.prompt("  输入明细JSON（空行结束）", default='', show_default=False)
                    if not detail_json:
                        break
                    try:
                        detail = json.loads(detail_json)
                        details.append(detail)
                    except json.JSONDecodeError:
                        click.secho("  JSON格式错误，请重试", fg='red')

                if details:
                    record['cdsDetail'] = details

            cds_master = [record]

        else:
            raise click.ClickException("请指定 --json、--interactive 或 --batch 参数")

        if not cds_master:
            raise click.ClickException("没有有效的数据需要提交")

        # 预览模式
        if dry_run:
            click.secho("\n预览模式 - 将要提交的数据：", fg='yellow')
            click.secho("=" * 50, fg='yellow')
            formatter = OutputFormatter('table', True)
            for i, record in enumerate(cds_master, 1):
                click.echo(f"\n记录 {i}:")
                click.echo(formatter.format(record))
            click.secho("\n" + "=" * 50, fg='yellow')
            click.secho("实际提交时取消 --dry-run 选项", fg='cyan')
            restore_field_mode(original_mode)
            return

        # 执行创建
        response = client.create(type_key=type_key, cds_master=cds_master)

        # 输出结果
        if not response.success and response.code == '-1':
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
            click.secho(f"创建成功，共 {len(success_data)} 条记录\n", fg='green')

            for i, item in enumerate(success_data, 1):
                key_value = item.get('keyVaule', {}) or item.get('keyValue', {})

                if key_value:
                    click.echo(f"记录 {i}:")
                    for k, v in key_value.items():
                        click.echo(f"  {k}: {v}")
                else:
                    click.echo(f"记录 {i}: {item}")

        restore_field_mode(original_mode)

    except Exception as e:
        handle_error(e)
