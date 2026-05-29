# yzcli/core/output.py - 输出格式化模块
"""
输出格式化模块
支持 Table/JSON/CSV 三种输出格式
统一处理API响应数据的格式化显示
"""

import json
import csv
import sys
from io import StringIO
from typing import Any, Dict, List, Optional

from tabulate import tabulate

from .config import config_manager


class OutputFormatter:
    """输出格式化器"""

    def __init__(self, format_type: Optional[str] = None, pretty_print: Optional[bool] = None):
        config = config_manager.get()
        self.format_type = format_type or config.output.format
        self.pretty_print = pretty_print if pretty_print is not None else config.output.pretty_print

    def format(self, data: Any, headers: Optional[List[str]] = None) -> str:
        """格式化数据"""
        if self.format_type == 'json':
            return self._format_json(data)
        elif self.format_type == 'csv':
            return self._format_csv(data, headers)
        else:  # table
            return self._format_table(data, headers)

    def _format_json(self, data: Any) -> str:
        """格式化为JSON"""
        if self.pretty_print:
            return json.dumps(data, ensure_ascii=False, indent=2)
        else:
            return json.dumps(data, ensure_ascii=False)

    def _format_csv(self, data: Any, headers: Optional[List[str]] = None) -> str:
        """格式化为CSV"""
        output = StringIO()

        if isinstance(data, dict):
            # 单条记录
            if headers:
                writer = csv.DictWriter(output, fieldnames=headers)
                writer.writeheader()
                writer.writerow({k: data.get(k, '') for k in headers})
            else:
                writer = csv.DictWriter(output, fieldnames=data.keys())
                writer.writeheader()
                writer.writerow(data)
        elif isinstance(data, list):
            # 多条记录
            if data:
                if headers:
                    writer = csv.DictWriter(output, fieldnames=headers)
                    writer.writeheader()
                    for row in data:
                        if isinstance(row, dict):
                            writer.writerow({k: row.get(k, '') for k in headers})
                else:
                    first = data[0]
                    if isinstance(first, dict):
                        writer = csv.DictWriter(output, fieldnames=first.keys())
                        writer.writeheader()
                        for row in data:
                            if isinstance(row, dict):
                                writer.writerow(row)
                    else:
                        writer = csv.writer(output)
                        for row in data:
                            writer.writerow([row])
        else:
            # 其他类型直接转字符串
            output.write(str(data))

        return output.getvalue()

    def _format_table(self, data: Any, headers: Optional[List[str]] = None) -> str:
        """格式化为Table"""
        if isinstance(data, dict):
            # 单条记录，转换为键值对表格，值统一转字符串避免类型比较
            rows = [[k, str(v) if v is not None else ''] for k, v in data.items()]
            return tabulate(rows, headers=["字段", "值"], tablefmt="simple")

        elif isinstance(data, list) and data:
            first = data[0]
            if isinstance(first, dict):
                # 字典列表，使用字典键作为表头
                if not headers:
                    headers = list(first.keys())
                rows = []
                for item in data:
                    if isinstance(item, dict):
                        # 所有值统一转字符串，避免tabulate排序时类型比较错误
                        rows.append([str(item.get(h, '')) if item.get(h) is not None else '' for h in headers])
                return tabulate(rows, headers=headers, tablefmt="simple")
            else:
                # 普通列表
                return tabulate([[str(x)] for x in data], headers=headers or ["值"], tablefmt="simple")

        else:
            # 其他类型直接转字符串
            return str(data)


class APIResponseFormatter:
    """API响应格式化器"""

    def __init__(self, formatter: Optional[OutputFormatter] = None):
        self.formatter = formatter or OutputFormatter()

    def format_response(self, response: Any, success_handler=None) -> str:
        """格式化API响应"""
        # 处理成功/错误分离的响应
        if hasattr(response, 'success') and hasattr(response, 'data'):
            if not response.success and response.code == '-1':
                # 完全失败
                return self._format_error(response)
            else:
                # 成功或部分成功
                result = response.data.get('result', {})
                success_data = result.get('success', [])
                error_data = result.get('error', [])

                output_parts = []

                if success_data:
                    if success_handler:
                        formatted = success_handler(success_data)
                        if formatted:
                            output_parts.append(formatted)
                    else:
                        output_parts.append("✅ 成功数据:")
                        output_parts.append(self.formatter.format(success_data))

                if error_data:
                    output_parts.append("\n❌ 错误数据:")
                    for error in error_data:
                        msg = error.get('message', str(error))
                        output_parts.append(f"  - {msg}")

                if response.code == '-0':
                    output_parts.insert(0, f"⚠️  部分成功 ({len(success_data)} 成功, {len(error_data)} 失败)")
                elif response.code == '0':
                    output_parts.insert(0, "✅ 执行成功")

                return '\n'.join(output_parts)

        # 普通数据直接格式化
        return self.formatter.format(response)

    def _format_error(self, response) -> str:
        """格式化错误响应"""
        result = response.data.get('result', {})
        error_data = result.get('error', [])

        if error_data:
            messages = [e.get('message', str(e)) for e in error_data]
            return "❌ 执行失败:\n" + '\n'.join(f"  - {msg}" for msg in messages)
        else:
            return f"❌ 执行失败: {response.message}"

    def format_query_result(self, success_data: List[Dict]) -> str:
        """格式化查询结果"""
        if not success_data:
            return "📭 没有找到数据"

        # 查询结果通常包含 cdsMaster 数据
        if len(success_data) == 1 and 'cdsMaster' in success_data[0]:
            records = success_data[0]['cdsMaster']
        else:
            records = success_data

        if not records:
            return "📭 没有找到数据"

        count = len(records)
        output = [f"📊 查询结果：共 {count} 条记录\n"]

        if isinstance(records, list):
            output.append(self.formatter.format(records))
        else:
            output.append(str(records))

        return '\n'.join(output)

    def format_get_result(self, success_data: List[Dict]) -> str:
        """格式化读取结果"""
        if not success_data:
            return "📭 没有找到数据"

        if len(success_data) == 1 and 'cdsMaster' in success_data[0]:
            # 单条详细记录
            record = success_data[0]['cdsMaster']
            if isinstance(record, list) and len(record) == 1:
                record = record[0]

            output = ["📋 单据详情：\n"]
            output.append(self.formatter.format(record))

            # 显示单身数据
            if 'cdsDetail' in success_data[0]:
                details = success_data[0]['cdsDetail']
                output.append(f"\n📝 单身明细：共 {len(details) if isinstance(details, list) else 1} 条")
                if isinstance(details, list):
                    output.append(self.formatter.format(details))
                else:
                    output.append(str(details))

            return '\n'.join(output)
        else:
            # 多条记录
            return self.format_query_result(success_data)


def print_output(data: Any, format_type: Optional[str] = None,
                 headers: Optional[List[str]] = None, file=None) -> None:
    """打印输出的便捷函数"""
    formatter = OutputFormatter(format_type=format_type)
    output = formatter.format(data, headers=headers)
    print(output, file=file or sys.stdout)


def print_response(response: Any, format_type: Optional[str] = None,
                   success_handler=None) -> None:
    """打印API响应的便捷函数"""
    formatter = OutputFormatter(format_type=format_type)
    resp_formatter = APIResponseFormatter(formatter)
    output = resp_formatter.format_response(response, success_handler)
    print(output)
