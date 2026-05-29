# yzcli/commands/update.py - 更新命令
"""
更新命令模块
支持所有TypeKey的通用更新功能
"""

import json
import click

from ..core import (
    get_mapper,
    get_client,
)
from .base import add_common_options, handle_common_options, restore_field_mode, handle_error


@click.command(name='update')
@add_common_options
@click.argument('type_key', required=True)
@click.option('--json', '-j', 'json_arg', required=True,
              help='JSON数据，支持 @filename 语法从文件读取')
@click.option('--dry-run', is_flag=True,
              help='预览模式，只显示要更新的数据而不实际调用API')
def update_cmd(type_key: str, json_arg: str, dry_run: bool, **kwargs):
    """更新 TYPE_KEY 类型的单据数据

    \b
    从JSON文件更新：
      yzcli update sales.order --json @update_order.json

    \b
    注意：更新数据必须包含所有主键字段！
    """
    try:
        kwargs, original_mode = handle_common_options(**kwargs)

        client = get_client()

        # 解析JSON数据
        if json_arg.startswith('@'):
            filename = json_arg[1:]
            with open(filename, 'r', encoding='utf-8') as f:
                data = json.load(f)
        else:
            data = json.loads(json_arg)

        if isinstance(data, list):
            cds_master = data
        elif "cdsMaster" in data:
            # 支持 { "cdsMaster": [...] } 包装格式
            cds_master = data["cdsMaster"]
        else:
            cds_master = [data]

        # 校验主键字段（仅检查 master 层级的 PK，detail.* 由 ERP 内部校验）
        mapper = get_mapper(type_key)
        pk_json_names = [
            pk for pk in mapper.get_primary_keys_json_names()
            if not pk.startswith("detail.")
        ]

        for record in cds_master:
            missing_pks = [pk for pk in pk_json_names if pk not in record]
            if missing_pks:
                click.secho(f"记录缺少主键字段: {', '.join(missing_pks)}", fg='yellow')
                click.secho("主键字段必须存在才能进行更新", fg='yellow')

        # 预览模式
        if dry_run:
            click.secho("\n预览模式 - 将要更新的数据：", fg='yellow')
            click.secho("=" * 50, fg='yellow')
            for i, record in enumerate(cds_master, 1):
                click.echo(f"\n记录 {i}:")
                for key, value in record.items():
                    if key in pk_json_names:
                        click.secho(f"  {key} (主键): {value}", fg='cyan')
                    else:
                        click.echo(f"  {key}: {value}")
            click.secho("\n" + "=" * 50, fg='yellow')
            click.secho("实际执行时取消 --dry-run 选项", fg='cyan')
            restore_field_mode(original_mode)
            return

        # 执行更新
        response = client.update(type_key=type_key, cds_master=cds_master)

        # 输出结果
        if not response.success:
            click.secho(f"执行失败: {response.message}", fg='red')

            # 显示详细错误信息
            result = response.data.get('result', {})
            error_data = result.get('error', [])
            if error_data:
                for error in error_data:
                    msg = error.get('message', str(error))
                    click.secho(f"  - {msg}", fg='yellow')

            restore_field_mode(original_mode)
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
            click.secho(f"更新成功，共 {len(success_data)} 条记录\n", fg='green')
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
