# yzcli/commands/delete.py - 删除命令
"""
删除命令模块
支持所有TypeKey的通用删除功能
"""

import json
import click

from ..core import (
    get_mapper,
    get_client,
)
from .base import add_common_options, handle_common_options, restore_field_mode, handle_error


def _build_datakeys(type_key: str, key: tuple, batch) -> list:
    """构建主键列表"""
    datakeys = []

    if batch:
        batch_data = json.load(batch)
        if isinstance(batch_data, list):
            datakeys = batch_data
        else:
            datakeys = [batch_data]
    elif key:
        key_dict = {}
        for k in key:
            if '=' in k:
                name, value = k.split('=', 1)
                key_dict[name.strip()] = value.strip()
        if key_dict:
            datakeys = [key_dict]
    else:
        mapper = get_mapper(type_key)
        pk_json_names = mapper.get_primary_keys_json_names()
        if not pk_json_names:
            pk_json_names = [f"key{i+1}" for i in range(2)]

        key_dict = {}
        click.secho("请输入要删除的单据主键：", fg='cyan')
        for pk_name in pk_json_names:
            value = click.prompt(f"  {pk_name}", type=str)
            key_dict[pk_name] = value
        datakeys = [key_dict]

    return datakeys


@click.command(name='delete')
@add_common_options
@click.argument('type_key', required=True)
@click.option('--key', '-k', multiple=True,
              help='主键键值对，格式: name=value，可多次使用指定多个主键')
@click.option('--batch', '-b', type=click.File('r', encoding='utf-8'),
              help='批量删除，从JSON文件加载主键列表')
@click.option('--force', '-f', is_flag=True,
              help='跳过确认提示，直接删除')
def delete_cmd(type_key: str, key: tuple, batch: click.File, force: bool, **kwargs):
    """删除 TYPE_KEY 类型的单据数据

    \b
    单主键示例：
      yzcli delete sales.order --key docNo=20250218000001

    \b
    复合主键示例：
      yzcli delete wo.stock.in --key docNo=20250218000001 --key category=84
    """
    try:
        kwargs, original_mode = handle_common_options(**kwargs)

        client = get_client()
        datakeys = _build_datakeys(type_key, key, batch)

        if not datakeys:
            raise click.ClickException("未指定任何主键")

        # 确认提示
        if not force:
            click.secho(f"\n将要删除以下 {len(datakeys)} 条记录：", fg='yellow')
            for i, dk in enumerate(datakeys, 1):
                keys_str = ', '.join(f"{k}={v}" for k, v in dk.items())
                click.echo(f"  {i}. {keys_str}")

            click.echo()
            if not click.confirm("确定要删除吗？此操作不可撤销！", default=False):
                click.echo("已取消操作")
                return

        # 执行删除
        response = client.delete(type_key=type_key, datakeys=datakeys)

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
            click.secho(f"删除成功，共 {len(success_data)} 条记录\n", fg='green')
            for i, item in enumerate(success_data, 1):
                if 'data' in item:
                    data = item['data']
                    keys_str = ', '.join(f"{k}={v}" for k, v in data.items())
                    click.echo(f"记录 {i}: {keys_str}")
                else:
                    click.echo(f"记录 {i}: {item}")

        restore_field_mode(original_mode)

    except Exception as e:
        handle_error(e)
