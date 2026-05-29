# yzcli/commands/base.py - 命令基类
"""
命令基类模块
提供所有命令的通用功能和选项
"""

import json
import logging
import sys
from typing import Any, Optional

import click

from ..core import (
    get_client,
    get_mapper,
    config_manager,
    APIClientError,
)


def add_common_options(f):
    """添加通用选项，这是 Click 友好的版本"""
    f = click.option('--field-mode', type=click.Choice(['english_name', 'field_number']),
                     help='字段命名模式: english_name 或 field_number')(f)
    f = click.option('--output', '-o', type=click.Choice(['table', 'json', 'csv']),
                     help='输出格式: table/json/csv')(f)
    f = click.option('--pretty/--no-pretty', default=None,
                     help='JSON输出是否格式化')(f)
    f = click.option('--token', help='覆盖配置的 user_token')(f)
    f = click.option('--base-url', help='覆盖配置的 base_url')(f)
    f = click.option('--debug/--no-debug', default=False,
                     help='是否显示调试信息')(f)
    return f


def handle_common_options(**kwargs):
    """处理通用选项，返回修改后的 kwargs（已移除通用选项）"""
    field_mode = kwargs.pop('field_mode', None)
    output_format = kwargs.pop('output', None)
    pretty_print = kwargs.pop('pretty', None)
    token = kwargs.pop('token', None)
    base_url = kwargs.pop('base_url', None)
    debug = kwargs.pop('debug', False)

    # 保存到上下文
    ctx = click.get_current_context()
    ctx.ensure_object(dict)
    ctx.obj['field_mode'] = field_mode
    ctx.obj['output_format'] = output_format
    ctx.obj['pretty_print'] = pretty_print
    ctx.obj['debug'] = debug

    # 设置日志级别
    from ..core import get_logger
    logger = get_logger()
    if debug:
        logger.setLevel('DEBUG')
        for h in logger.handlers:
            if not isinstance(h, logging.NullHandler):
                h.setLevel(logging.DEBUG)
    logger.debug(f"命令选项: field_mode={field_mode}, output={output_format}, pretty={pretty_print}, base_url_override={bool(base_url)}, token_override={bool(token)}, debug={debug}")

    # 临时覆盖配置
    original_mode = None
    if field_mode:
        config = config_manager.get()
        original_mode = config.field_mode
        config.field_mode = field_mode

    # 初始化客户端
    if token or base_url:
        client = get_client()
        if token:
            client.user_token = token
        if base_url:
            client.base_url = base_url

    return kwargs, original_mode


def restore_field_mode(original_mode):
    """恢复字段模式配置"""
    if original_mode is not None:
        config = config_manager.get()
        config.field_mode = original_mode


def handle_error(e: Exception):
    """处理异常"""
    debug = False
    try:
        ctx = click.get_current_context()
        if ctx and ctx.obj:
            debug = ctx.obj.get('debug', False)
    except RuntimeError:
        pass

    try:
        from ..core import get_logger
        get_logger().exception("命令执行失败")
    except Exception:
        pass

    if isinstance(e, APIClientError):
        click.secho(f"API错误: {str(e)}", fg='red', err=True)
    else:
        click.secho(f"错误: {str(e)}", fg='red', err=True)

    if debug:
        import traceback
        click.secho("\n调试信息:", fg='yellow', err=True)
        traceback.print_exc()

    sys.exit(1)


class BaseCommand(click.Command):
    """基础命令类，提供通用功能"""

    def __init__(self, name: str, type_key: Optional[str] = None, **kwargs):
        super().__init__(name, **kwargs)
        self.type_key = type_key
        self._client = None
        self._mapper = None

    @property
    def client(self):
        """获取API客户端"""
        if self._client is None:
            self._client = get_client()
        return self._client

    @property
    def mapper(self):
        """获取字段映射器"""
        if self._mapper is None and self.type_key:
            self._mapper = get_mapper(self.type_key)
        return self._mapper

    def parse_json_file(self, json_arg: str) -> Any:
        """解析JSON参数，支持@文件名语法"""
        if json_arg.startswith('@'):
            filename = json_arg[1:]
            try:
                with open(filename, 'r', encoding='utf-8') as f:
                    return json.load(f)
            except IOError as e:
                raise click.ClickException(f"无法读取文件 {filename}: {e}")
            except json.JSONDecodeError as e:
                raise click.ClickException(f"JSON文件格式错误: {e}")
        else:
            try:
                return json.loads(json_arg)
            except json.JSONDecodeError as e:
                raise click.ClickException(f"JSON格式错误: {e}")
