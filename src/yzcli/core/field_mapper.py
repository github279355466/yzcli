# yzcli/core/field_mapper.py - 字段双向映射器
"""
字段双向映射器
支持字段编号 (RCA001) 和英文节点名 (category) 之间的双向转换
从 help 服务动态获取字段元数据
"""

import re
from typing import Any, Dict, List, Optional
from dataclasses import dataclass

from .api_client import get_client
from .config import config_manager


@dataclass
class FieldMeta:
    """字段元数据"""
    field_number: str  # 字段编号，如 RCA001
    json_name: str     # 英文节点名，如 category
    display_label: str  # 中文显示名，如 类别
    data_type: str    # 数据类型
    size: int          # 长度
    required: bool     # 是否必填
    read_only: bool    # 是否只读
    visible: bool      # 是否显示
    field_kind: str   # 字段类型（主键字段/普通字段/计算字段）


class FieldMapper:
    """字段双向映射器"""

    def __init__(self, type_key: str):
        self.type_key = type_key
        self._field_map_by_number: Dict[str, FieldMeta] = {}
        self._field_map_by_json_name: Dict[str, FieldMeta] = {}
        self._primary_keys: List[str] = []
        self._loaded = False
        self._client = get_client()

    def load(self) -> None:
        """加载字段元数据"""
        if self._loaded:
            return

        help_data = self._client.help(self.type_key)

        # 解析 cdsMaster 字段
        cds_master = help_data.get('cdsMaster', {})
        self._parse_field_list(cds_master.get('fieldList', []))

        # 解析 cdsDetail 字段
        cds_detail = cds_master.get('cdsDetail', {})
        if cds_detail:
            self._parse_field_list(cds_detail.get('fieldList', []), prefix='detail.')

        # 解析 cdsDetail2 字段
        cds_detail2 = cds_detail.get('cdsDetail2', {}) if isinstance(cds_detail, dict) else {}
        if cds_detail2:
            self._parse_field_list(cds_detail2.get('fieldList', []), prefix='detail2.')

        # 收集主键字段
        self._primary_keys = [
            meta.field_number
            for meta in self._field_map_by_number.values()
            if meta.field_kind == '主键字段'
        ]

        self._loaded = True

    def _parse_field_list(self, field_list: List[Dict], prefix: str = '') -> None:
        """解析字段列表"""
        for field in field_list:
            field_number = field.get('name', '')
            json_name = prefix + field.get('jsonName', '')
            display_label = field.get('displayLabel', '')
            data_type = field.get('dataType', 'string')

            try:
                size = int(field.get('size', '0'))
            except (ValueError, TypeError):
                size = 0

            required = field.get('required', 'F') == 'T'
            read_only = field.get('readOnly', 'F') == 'T'
            visible = field.get('visible', 'F') == 'T'
            field_kind = field.get('fieldKind', '')

            meta = FieldMeta(
                field_number=field_number,
                json_name=json_name,
                display_label=display_label,
                data_type=data_type,
                size=size,
                required=required,
                read_only=read_only,
                visible=visible,
                field_kind=field_kind
            )

            self._field_map_by_number[field_number] = meta
            if json_name:
                self._field_map_by_json_name[json_name] = meta

    def to_english(self, field_number: str) -> Optional[str]:
        """字段编号 -> 英文节点名"""
        self.load()
        meta = self._field_map_by_number.get(field_number)
        return meta.json_name if meta else None

    def to_field_number(self, json_name: str) -> Optional[str]:
        """英文节点名 -> 字段编号"""
        self.load()
        meta = self._field_map_by_json_name.get(json_name)
        return meta.field_number if meta else None

    def get_meta(self, field: str) -> Optional[FieldMeta]:
        """根据字段名（编号或英文名）获取元数据"""
        self.load()
        # 先按字段编号查
        if field in self._field_map_by_number:
            return self._field_map_by_number[field]
        # 再按英文名查
        if field in self._field_map_by_json_name:
            return self._field_map_by_json_name[field]
        return None

    def get_required_fields(self) -> List[FieldMeta]:
        """获取所有必填字段"""
        self.load()
        return [
            meta for meta in self._field_map_by_number.values()
            if meta.required and not meta.read_only
        ]

    def get_primary_keys(self) -> List[str]:
        """获取主键字段列表（字段编号）"""
        self.load()
        return self._primary_keys

    def get_primary_keys_json_names(self) -> List[str]:
        """获取主键字段的英文节点名列表"""
        self.load()
        return [
            meta.json_name
            for meta in self._field_map_by_number.values()
            if meta.field_kind == '主键字段' and meta.json_name
        ]

    def all_fields(self) -> List[FieldMeta]:
        """获取所有字段"""
        self.load()
        return list(self._field_map_by_number.values())

    def convert_field_name(self, field_name: str, target_mode: Optional[str] = None) -> str:
        """
        转换字段名到目标模式

        Args:
            field_name: 原始字段名（可能是编号或英文名）
            target_mode: 目标模式，"english_name" 或 "field_number"，None则使用配置
        """
        if target_mode is None:
            config = config_manager.get()
            target_mode = config.field_mode

        meta = self.get_meta(field_name)
        if not meta:
            return field_name  # 未知字段，原样返回

        if target_mode == 'english_name':
            return meta.json_name or field_name
        else:
            return meta.field_number


class ConditionParser:
    """查询条件解析器 - 解析命令行的条件语法"""

    def __init__(self, mapper: FieldMapper):
        self.mapper = mapper
        # 支持的操作符
        self.operators = ['>=', '<=', '<>', '!=', '>', '<', '=', 'like', 'in', 'not in', 'between', 'exists']
        # 操作符优先级排序（长的在前，避免短的先匹配）
        self.sorted_ops = sorted(self.operators, key=lambda x: -len(x))

    def parse(self, condition_str: str) -> Dict[str, Any]:
        """
        解析条件字符串

        支持的语法：
        - "customer=000002"
        - "qty > 10"
        - "date between 20250101 and 20251231"
        - "status in (1,2,3)"
        - "customer like KH000%"
        """
        condition_str = condition_str.strip()

        # 查找匹配的操作符
        for op in self.sorted_ops:
            pattern = r'\s+' + re.escape(op) + r'\s+'
            match = re.search(pattern, condition_str, re.IGNORECASE)
            if match:
                field = condition_str[:match.start()].strip()
                value = condition_str[match.end():].strip()
                operator = op.upper()
                break
        else:
            # 尝试无空格的 =
            if '=' in condition_str:
                field, value = condition_str.split('=', 1)
                field = field.strip()
                value = value.strip()
                operator = '='
            else:
                raise ValueError(f"无法解析条件: {condition_str}")

        # API查询条件和排序中的field_name必须始终使用字段编号
        # 因为服务器端API会自动将字段编号映射到数据库列名
        # 而英文名(jsonName)只有在服务器开启了英文节点配置后才有效
        # 为确保兼容性，查询条件和排序始终发送字段编号
        field_number = self.mapper.to_field_number(field)
        if field_number:
            field = field_number
        # 如果找不到对应字段编号，原样传递（可能是自定义字段）

        # 处理特殊值格式
        if operator in ['IN', 'NOT IN']:
            # 保留括号格式，API需要
            if not value.startswith('('):
                value = f"({value})"
        elif operator == 'BETWEEN':
            # BETWEEN 需要 "A and B" 格式
            pass
        elif operator == 'EXISTS':
            # EXISTS 子查询，直接保留
            pass

        return {
            "field_name": field,
            "operator": operator,
            "value": value
        }

    def parse_order(self, order_str: str) -> Dict[str, str]:
        """解析排序条件，如 "date:desc" 或 "customer" """
        if ':' in order_str:
            field, direction = order_str.split(':', 1)
            field = field.strip()
            direction = direction.strip().upper()
            if direction not in ['ASC', 'DESC']:
                direction = 'ASC'
        else:
            field = order_str.strip()
            direction = 'ASC'

        # 排序字段也必须始终使用字段编号
        field_number = self.mapper.to_field_number(field)
        if field_number:
            field = field_number

        return {
            "field_name": field,
            "order_type": direction
        }


def get_mapper(type_key: str) -> FieldMapper:
    """获取指定TypeKey的字段映射器"""
    return FieldMapper(type_key)
