# yzcli/__main__.py - 命令行入口
"""
易助ERP OpenAPI CLI 工具
类似 cli-anything 的通用架构，支持所有 TypeKey 的通用操作
"""

import sys
# Windows 控制台默认 GBK，强制 stdout/stderr 为 UTF-8 避免乱码
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")

import click

from . import __version__
from .commands import (
    agent_cmd, skill_cmd,
    query_cmd, get_cmd, create_cmd, update_cmd, delete_cmd,
    approve_cmd, disapprove_cmd, help_cmd, config_cmd,
)
from .commands.config import config_discover


CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])


@click.group(context_settings=CONTEXT_SETTINGS, invoke_without_command=True)
@click.version_option(__version__, '-v', '--version')
@click.pass_context
def cli(ctx):
    """
    易助ERP OpenAPI 命令行工具

    \b
    支持的命令：
      query    - 查询数据
      get      - 读取单条/多条数据
      create   - 新增数据
      update   - 更新数据
      delete   - 删除数据
      approve  - 审核单据
      disapprove - 撤销审核
      help     - 查看字段说明
      config   - 配置管理
      discover - 发现所有可用的TypeKey

    \b
    使用示例：
      yzcli query sales.order --condition "customer=000002"
      yzcli get wo.stock.in --key docNo=20250218000001 --key category=84
      yzcli create sales.order --interactive
      yzcli help sales.order
      yzcli config show
    """
    # 初始化上下文对象
    ctx.ensure_object(dict)

    # 如果没有子命令，显示帮助
    if ctx.invoked_subcommand is None:
        click.echo(ctx.get_help())


# 注册命令
cli.add_command(agent_cmd, name='agent')
cli.add_command(query_cmd, name='query')
cli.add_command(get_cmd, name='get')
cli.add_command(create_cmd, name='create')
cli.add_command(update_cmd, name='update')
cli.add_command(delete_cmd, name='delete')
cli.add_command(approve_cmd, name='approve')
cli.add_command(disapprove_cmd, name='disapprove')
cli.add_command(help_cmd, name='help')
cli.add_command(config_cmd, name='config')
cli.add_command(config_discover, name='discover')
cli.add_command(skill_cmd, name='skill')


def main():
    """入口函数"""
    try:
        cli(prog_name='yzcli')
    except KeyboardInterrupt:
        click.echo("\n操作已取消")
        sys.exit(1)


if __name__ == '__main__':
    main()
