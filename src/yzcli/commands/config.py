# yzcli/commands/config.py - 配置命令
"""
配置命令模块
管理CLI配置
"""

import click
import yaml
import os

from ..core import (
    config_manager,
    get_client,
    OutputFormatter,
)


@click.group()
def config_cmd():
    """管理 yzcli 配置"""
    pass


@config_cmd.command(name='show')
def config_show():
    """显示当前配置"""
    config = config_manager.get()

    data = {
        'erp': {
            'base_url': config.erp.base_url,
            'timeout': config.erp.timeout,
            'user_token': config.erp.user_token[:20] + '...' if config.erp.user_token else '(未设置)',
        },
        'field_mode': config.field_mode,
        'output': {
            'format': config.output.format,
            'page_size': config.output.page_size,
            'pretty_print': config.output.pretty_print,
        },
        'cache': {
            'enabled': config.cache.enabled,
            'ttl_seconds': config.cache.ttl,
        },
        'log': {
            'enabled': config.log.enabled,
            'level': config.log.level,
            'dir': config.log.dir or '~/.yzcli/logs/',
            'max_days': config.log.max_days,
            'console': config.log.console,
        },
        'config_file': str(config_manager.config_path) if config_manager.config_path else '默认路径',
    }

    click.secho("当前配置", fg='cyan')
    click.secho("=" * 50, fg='cyan')
    formatter = OutputFormatter('table')
    click.echo(formatter.format(data))


@config_cmd.command(name='set')
@click.argument('key')
@click.argument('value')
def config_set(key: str, value: str):
    """设置配置项

    \b
    支持的配置项：
      erp.base_url      ERP服务地址
      erp.timeout       请求超时（秒）
      erp.user_token    用户认证令牌
      field_mode        字段模式: english_name / field_number
      output.format     输出格式: table / json / csv
      output.page_size  默认分页大小
      log.enabled       是否启用日志: true / false
      log.level         日志级别: DEBUG / INFO / WARNING / ERROR
      log.dir           日志目录，留空使用 ~/.yzcli/logs/
      log.max_days      日志保留天数
      log.console       是否同时输出到控制台: true / false
    """
    config = config_manager.get()

    key_map = {
        'erp.base_url': ('erp', 'base_url'),
        'erp.timeout': ('erp', 'timeout'),
        'erp.user_token': ('erp', 'user_token'),
        'field_mode': (None, 'field_mode'),
        'output.format': ('output', 'format'),
        'output.page_size': ('output', 'page_size'),
        'output.pretty_print': ('output', 'pretty_print'),
        'log.enabled': ('log', 'enabled'),
        'log.level': ('log', 'level'),
        'log.dir': ('log', 'dir'),
        'log.max_days': ('log', 'max_days'),
        'log.console': ('log', 'console'),
    }

    if key not in key_map:
        raise click.ClickException(f"未知的配置项: {key}\n支持的配置项: {', '.join(key_map.keys())}")

    section, field = key_map[key]

    # 类型转换
    if field in ('timeout', 'page_size', 'max_days'):
        try:
            value = int(value)
        except ValueError:
            raise click.ClickException(f"{field} 必须是整数")
    elif field in ('pretty_print', 'enabled', 'console'):
        value = value.lower() in ['true', '1', 'yes', 'on']
    elif field == 'level':
        value = value.upper()
        if value not in ['DEBUG', 'INFO', 'WARNING', 'ERROR']:
            raise click.ClickException("log.level 必须是 DEBUG / INFO / WARNING / ERROR")

    if section:
        setattr(getattr(config, section), field, value)
    else:
        setattr(config, field, value)

    config_manager.save(config)
    click.secho(f"已设置 {key} = {value}", fg='green')


@config_cmd.command(name='get')
@click.argument('key')
def config_get(key: str):
    """获取配置项值"""
    config = config_manager.get()

    key_map = {
        'erp.base_url': config.erp.base_url,
        'erp.timeout': str(config.erp.timeout),
        'erp.user_token': config.erp.user_token,
        'field_mode': config.field_mode,
        'output.format': config.output.format,
        'output.page_size': str(config.output.page_size),
        'output.pretty_print': str(config.output.pretty_print),
        'log.enabled': str(config.log.enabled),
        'log.level': config.log.level,
        'log.dir': config.log.dir,
        'log.max_days': str(config.log.max_days),
        'log.console': str(config.log.console),
    }

    if key not in key_map:
        raise click.ClickException(f"未知的配置项: {key}")

    click.echo(key_map[key])


@config_cmd.command(name='init')
@click.option('--force', is_flag=True, help='强制覆盖现有配置')
def config_init(force: bool):
    """初始化配置文件"""
    config_dir = config_manager.config_path.parent if config_manager.config_path else None
    if not config_dir:
        config_dir = click.get_app_dir('yzcli')

    config_file = os.path.join(config_dir, 'config.yaml')

    if os.path.exists(config_file) and not force:
        raise click.ClickException(f"配置文件已存在: {config_file}\n使用 --force 选项覆盖")

    # 创建目录
    os.makedirs(config_dir, exist_ok=True)

    # 创建默认配置
    default_config = {
        'erp': {
            'base_url': 'http://172.16.6.22:8103',
            'user_token': '',
            'timeout': 30,
        },
        'field_mode': 'english_name',
        'output': {
            'format': 'table',
            'page_size': 20,
            'pretty_print': True,
        },
        'cache': {
            'enabled': True,
            'ttl': 86400,
        },
        'log': {
            'enabled': True,
            'level': 'INFO',
            'dir': '',
            'max_days': 7,
            'console': False,
        },
    }

    with open(config_file, 'w', encoding='utf-8') as f:
        yaml.dump(default_config, f, allow_unicode=True, default_flow_style=False)

    click.secho(f"配置文件已创建: {config_file}", fg='green')
    click.secho("请编辑该文件配置您的 ERP 地址和 user_token", fg='yellow')


@config_cmd.command(name='discover')
@click.option('--refresh', is_flag=True, help='强制刷新缓存')
@click.option('--search', help='过滤关键字，只显示包含该关键字的TypeKey')
def config_discover(refresh: bool, search: str):
    """发现所有可用的TypeKey"""
    client = get_client()

    click.secho("正在获取可用的TypeKey列表...", fg='cyan')

    type_keys = client.typekey_list()

    if search:
        search_lower = search.lower()
        type_keys = [
            tk for tk in type_keys
            if search_lower in tk.get('name', '').lower()
            or search_lower in tk.get('description', '').lower()
        ]

    if not type_keys:
        click.secho("没有找到可用的TypeKey", fg='yellow')
        return

    # 按名称排序
    type_keys.sort(key=lambda x: x.get('name', ''))

    # 准备显示数据
    display_data = []
    for tk in type_keys:
        name = tk.get('name', '')
        description = tk.get('description', '')
        subservices = tk.get('subservices', [])
        if isinstance(subservices, list):
            ops = [s.get('name', '') for s in subservices]
            ops_str = ', '.join(sorted(ops))
        else:
            ops_str = str(subservices)

        display_data.append({
            'TypeKey': name,
            '描述': description,
            '支持操作': ops_str,
        })

    click.secho(f"\n发现 {len(display_data)} 个可用的TypeKey\n", fg='cyan')

    formatter = OutputFormatter('table')
    click.echo(formatter.format(display_data))

    # 保存到缓存
    if refresh or not config_manager.load_typekey_cache():
        cache_data = {tk.get('name'): tk for tk in type_keys}
        config_manager.save_typekey_cache(cache_data)
