# yzcli/core/logger.py - 日志模块
"""
日志模块
支持按日期切割的文件日志，自动清理过期日志
"""

import logging
import os
import time
import glob
from datetime import datetime
from pathlib import Path
from typing import Optional

from .config import config_manager, DEFAULT_CONFIG_DIR

# 默认日志目录
DEFAULT_LOG_DIR = DEFAULT_CONFIG_DIR / "logs"

# 全局 logger 实例
_logger: Optional[logging.Logger] = None
_current_signature: Optional[tuple] = None


def _clean_old_logs(log_dir: Path, max_days: int) -> None:
    """清理超过保留天数的日志文件"""
    if max_days <= 0:
        return

    cutoff = time.time() - max_days * 86400
    pattern = str(log_dir / "yzcli_*.log")

    for log_file in glob.glob(pattern):
        try:
            if os.path.getmtime(log_file) < cutoff:
                os.remove(log_file)
        except OSError:
            pass


def _remove_handlers(logger: logging.Logger) -> None:
    for handler in logger.handlers[:]:
        logger.removeHandler(handler)
        handler.close()


def _setup_logger() -> logging.Logger:
    """初始化并返回 logger 实例"""
    global _logger, _current_signature

    config = config_manager.get()
    log_config = config.log
    level_name = log_config.level.upper()
    level = getattr(logging, level_name, logging.INFO)
    log_dir = Path(log_config.dir).expanduser() if log_config.dir else DEFAULT_LOG_DIR
    today = datetime.now().strftime("%Y%m%d")
    log_file = log_dir / f"yzcli_{today}.log"
    signature = (log_config.enabled, level_name, str(log_dir), log_config.max_days, log_config.console, str(log_file))

    logger = logging.getLogger("yzcli")
    logger.propagate = False
    logger.setLevel(level)

    if _logger is logger and _current_signature == signature:
        return logger

    _remove_handlers(logger)

    if not log_config.enabled:
        logger.addHandler(logging.NullHandler())
        _logger = logger
        _current_signature = signature
        return logger

    log_dir.mkdir(parents=True, exist_ok=True)

    formatter = logging.Formatter(
        fmt='[%(asctime)s] [%(levelname)s] [%(module)s] %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )

    file_handler = logging.FileHandler(log_file, encoding='utf-8')
    file_handler.setLevel(level)
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)

    if log_config.console:
        console_handler = logging.StreamHandler()
        console_handler.setLevel(level)
        console_handler.setFormatter(formatter)
        logger.addHandler(console_handler)

    _clean_old_logs(log_dir, log_config.max_days)

    _logger = logger
    _current_signature = signature
    return logger


def get_logger() -> logging.Logger:
    """获取 yzcli logger 实例"""
    return _setup_logger()


def set_log_level(level: str) -> None:
    """动态设置日志级别

    Args:
        level: 日志级别名称，如 DEBUG/INFO/WARNING/ERROR
    """
    logger = logging.getLogger("yzcli")
    level_value = getattr(logging, level.upper(), logging.INFO)
    logger.setLevel(level_value)

    # 同步更新所有 handler 的级别
    for handler in logger.handlers:
        if not isinstance(handler, logging.NullHandler):
            handler.setLevel(level_value)


def disable_logging() -> None:
    """禁用日志（移除所有非 NullHandler 的 handler）"""
    global _current_signature
    logger = logging.getLogger("yzcli")
    _remove_handlers(logger)
    logger.addHandler(logging.NullHandler())
    _current_signature = None
