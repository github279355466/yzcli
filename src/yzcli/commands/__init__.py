# yzcli/commands/__init__.py
"""命令模块"""

from .agent import agent_cmd
from .base import add_common_options, handle_common_options, restore_field_mode, handle_error
from .query import query_cmd
from .get import get_cmd
from .create import create_cmd
from .update import update_cmd
from .delete import delete_cmd
from .approve import approve_cmd, disapprove_cmd
from .help import help_cmd
from .config import config_cmd
from .skill import skill_cmd

__all__ = [
    'agent_cmd', 'skill_cmd',
    'add_common_options', 'handle_common_options', 'restore_field_mode', 'handle_error',
    'query_cmd', 'get_cmd', 'create_cmd', 'update_cmd', 'delete_cmd',
    'approve_cmd', 'disapprove_cmd', 'help_cmd', 'config_cmd',
]
