# yzcli/core/config.py - 配置管理模块
"""
配置管理模块
负责加载、保存和访问CLI配置
支持配置文件、环境变量和命令行参数三种方式
"""

import json
import time
from pathlib import Path
from typing import Any, Dict, Optional
import yaml
from dataclasses import dataclass, field, asdict


DEFAULT_CONFIG_DIR = Path.home() / ".yzcli"
DEFAULT_CONFIG_FILE = DEFAULT_CONFIG_DIR / "config.yaml"
DEFAULT_CACHE_DIR = DEFAULT_CONFIG_DIR / "cache"
TYPEKEY_CACHE_FILE = DEFAULT_CACHE_DIR / "typekey_cache.json"


@dataclass
class ERPConfig:
    """ERP连接配置"""
    base_url: str = "http://172.16.6.22:8103"
    user_token: str = ""
    timeout: int = 30


@dataclass
class OutputConfig:
    """输出配置"""
    format: str = "table"  # table/json/csv
    page_size: int = 20
    pretty_print: bool = True


@dataclass
class CacheConfig:
    """缓存配置"""
    enabled: bool = True
    ttl: int = 86400  # 24小时


@dataclass
class LogConfig:
    """日志配置"""
    enabled: bool = True
    level: str = "INFO"         # DEBUG/INFO/WARNING/ERROR
    dir: str = ""               # 空则用 ~/.yzcli/logs/
    max_days: int = 7           # 保留天数
    console: bool = False       # 是否同时输出到控制台


@dataclass
class AppConfig:
    """应用主配置"""
    erp: ERPConfig = field(default_factory=ERPConfig)
    output: OutputConfig = field(default_factory=OutputConfig)
    cache: CacheConfig = field(default_factory=CacheConfig)
    log: LogConfig = field(default_factory=LogConfig)
    field_mode: str = "english_name"  # english_name / field_number


class ConfigManager:
    """配置管理器"""

    def __init__(self, config_path: Optional[Path] = None):
        self.config_path = config_path or DEFAULT_CONFIG_FILE
        self._config: Optional[AppConfig] = None
        self._ensure_dirs()

    def _ensure_dirs(self) -> None:
        """确保必要的目录存在"""
        DEFAULT_CONFIG_DIR.mkdir(parents=True, exist_ok=True)
        DEFAULT_CACHE_DIR.mkdir(parents=True, exist_ok=True)

    def load(self) -> AppConfig:
        """加载配置文件"""
        if self._config is not None:
            return self._config

        if not self.config_path.exists():
            self._config = AppConfig()
            return self._config

        try:
            with open(self.config_path, 'r', encoding='utf-8') as f:
                data = yaml.safe_load(f) or {}

            self._config = AppConfig(
                erp=ERPConfig(**data.get('erp', {})),
                output=OutputConfig(**data.get('output', {})),
                cache=CacheConfig(**data.get('cache', {})),
                log=LogConfig(**data.get('log', {})),
                field_mode=data.get('field_mode', 'english_name')
            )
        except Exception:
            self._config = AppConfig()

        return self._config

    def save(self, config: Optional[AppConfig] = None) -> None:
        """保存配置到文件"""
        config = config or self._config or AppConfig()

        # 转换为字典
        data = {
            'erp': asdict(config.erp),
            'output': asdict(config.output),
            'cache': asdict(config.cache),
            'log': asdict(config.log),
            'field_mode': config.field_mode
        }

        with open(self.config_path, 'w', encoding='utf-8') as f:
            yaml.dump(data, f, allow_unicode=True, default_flow_style=False)

    def get(self) -> AppConfig:
        """获取当前配置"""
        return self.load()

    def set_field(self, section: str, key: str, value: Any) -> None:
        """设置配置项"""
        config = self.load()

        if section == 'erp':
            setattr(config.erp, key, value)
        elif section == 'output':
            setattr(config.output, key, value)
        elif section == 'cache':
            setattr(config.cache, key, value)
        elif section == 'log':
            setattr(config.log, key, value)
        elif section == 'field_mode':
            config.field_mode = value

        self.save(config)

    # TypeKey 缓存相关方法
    def load_typekey_cache(self) -> Dict[str, Any]:
        """加载TypeKey元数据缓存"""
        if not TYPEKEY_CACHE_FILE.exists():
            return {}

        try:
            with open(TYPEKEY_CACHE_FILE, 'r', encoding='utf-8') as f:
                return json.load(f)
        except Exception:
            return {}

    def save_typekey_cache(self, data: Dict[str, Any]) -> None:
        """保存TypeKey元数据缓存"""
        with open(TYPEKEY_CACHE_FILE, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)

    def get_typekey_help(self, type_key: str) -> Optional[Dict[str, Any]]:
        """获取缓存的TypeKey帮助信息"""
        cache = self.load_typekey_cache()
        return cache.get(type_key)

    def cache_typekey_help(self, type_key: str, help_data: Dict[str, Any]) -> None:
        """缓存TypeKey帮助信息"""
        cache = self.load_typekey_cache()
        cache[type_key] = {
            'data': help_data,
            'cached_at': int(time.time())
        }
        self.save_typekey_cache(cache)


# 全局配置管理器实例
config_manager = ConfigManager()
