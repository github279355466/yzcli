# yzcli/core/api_client.py - OpenAPI 统一客户端
"""
OpenAPI 统一客户端模块
负责所有与易助ERP OpenAPI的HTTP通信
实现统一的请求格式、错误处理和响应解析
"""

import json
import time
from typing import Any, Dict, List, Optional
import requests
from dataclasses import dataclass

from .config import config_manager
from .logger import get_logger


@dataclass
class APIResponse:
    """API响应封装"""
    success: bool
    code: str
    message: str
    data: Dict[str, Any]
    raw_response: Dict[str, Any]


class APIClientError(Exception):
    """API客户端异常"""
    pass


class OpenAPIClient:
    """易助OpenAPI客户端"""

    def __init__(self, base_url: Optional[str] = None, user_token: Optional[str] = None):
        config = config_manager.get()
        self.base_url = base_url or config.erp.base_url
        self.user_token = user_token or config.erp.user_token
        self.timeout = config.erp.timeout
        self.session = requests.Session()

    def _build_headers(self, service_name: str) -> Dict[str, str]:
        """构建请求头"""
        return {
            'Content-Type': 'application/json; charset=utf-8',
            'digi-service': json.dumps({"name": service_name}),
            'digi-user-token': self.user_token
        }

    def _parse_response(self, response: requests.Response) -> APIResponse:
        """解析响应

        易助OpenAPI可能返回Content-Type为text/html但body是JSON，
        因此需要兼容处理，优先尝试JSON解析。
        """
        raw_data = None
        # 优先尝试response.json()（依赖Content-Type）
        try:
            raw_data = response.json()
        except (json.JSONDecodeError, requests.exceptions.JSONDecodeError):
            pass

        # 如果json()失败，手动尝试从text解析（兼容text/html响应头）
        if raw_data is None:
            try:
                raw_data = json.loads(response.text)
            except (json.JSONDecodeError, ValueError):
                raise APIClientError(f"响应不是有效的JSON: {response.text[:200]}")

        std_data = raw_data.get('std_data', {})
        execution = std_data.get('execution', {})
        code = execution.get('code', '-1')
        description = execution.get('description', '')

        success = code in ['0', '-0']  # 0=全部成功, -0=部分成功

        return APIResponse(
            success=success,
            code=code,
            message=description,
            data=std_data.get('parameter', {}),
            raw_response=raw_data
        )

    def call(self, service_name: str, parameter: Optional[Dict[str, Any]] = None) -> APIResponse:
        """
        调用OpenAPI服务

        Args:
            service_name: 服务名称，如 "yz.oapi.sales.order.query"
            parameter: 请求参数，对应 std_data.parameter

        Returns:
            APIResponse 对象
        """
        url = f"{self.base_url.rstrip('/')}"

        # 确保服务名称格式正确
        full_service_name = service_name if service_name.startswith('yz.oapi.') else f"yz.oapi.{service_name}"

        headers = self._build_headers(full_service_name)

        body = {
            "std_data": {
                "parameter": parameter or {}
            }
        }

        logger = get_logger()
        logger.debug(f"API 请求: service={full_service_name}, 参数={parameter}")
        start = time.time()
        try:
            response = self.session.post(
                url,
                headers=headers,
                json=body,
                timeout=self.timeout
            )
            response.raise_for_status()
            elapsed = time.time() - start
            api_response = self._parse_response(response)
            logger.debug(f"API 原始响应: service={full_service_name}, body={response.text[:1000]}")
            logger.info(f"API 响应: service={full_service_name}, code={api_response.code}, message={api_response.message}, 耗时={elapsed:.2f}s")
            return api_response
        except requests.RequestException as e:
            elapsed = time.time() - start
            logger.error(f"API 请求失败: service={full_service_name}, 错误={e}, 耗时={elapsed:.2f}s")
            raise APIClientError(f"HTTP请求失败: {str(e)}")
        except APIClientError as e:
            elapsed = time.time() - start
            logger.error(f"API 响应解析失败: service={full_service_name}, 错误={e}, 耗时={elapsed:.2f}s")
            raise


    # ===== 便捷方法 =====

    def typekey_list(self) -> List[Dict[str, Any]]:
        """获取所有可用的TypeKey列表"""
        resp = self.call("typekeyList")
        if not resp.success:
            raise APIClientError(f"获取TypeKey列表失败: {resp.message}")
        result = resp.data.get('result', {}).get('success', [])
        if result:
            return result[0].get('typekeys', [])
        return []

    def help(self, type_key: str) -> Dict[str, Any]:
        """获取指定TypeKey的帮助信息（字段元数据）"""
        # 先尝试从缓存获取
        cached = config_manager.get_typekey_help(type_key)
        config = config_manager.get()

        if config.cache.enabled and cached:
            # 检查是否过期
            if int(time.time()) - cached.get('cached_at', 0) < config.cache.ttl:
                return cached.get('data', {})

        # 从API获取
        service_name = type_key if type_key.startswith('yz.oapi.') else f"{type_key}"
        if not service_name.endswith('.help'):
            service_name = f"{service_name}.help"

        resp = self.call(service_name)
        if not resp.success:
            raise APIClientError(f"获取{type_key}帮助信息失败: {resp.message}")

        result = resp.data.get('result', {}).get('success', [])
        if result:
            help_data = result[0]
            # 缓存结果
            if config.cache.enabled:
                config_manager.cache_typekey_help(type_key, help_data)
            return help_data
        return {}

    def query(self, type_key: str, conditions: Optional[List[Dict]] = None,
              page_no: int = 1, page_size: int = 20,
              orders: Optional[List[Dict]] = None,
              use_has_next: bool = True, load_data_browse_config: bool = False,
              query_type: str = "all") -> APIResponse:
        """
        查询数据

        Args:
            type_key: 单据类型，如 "sales.order"
            conditions: 查询条件列表
            page_no: 页码
            page_size: 每页数量
            orders: 排序条件
            use_has_next: 是否使用分页
            load_data_browse_config: 是否加载浏览配置
            query_type: 查询类型，"all" 或 "key"
        """
        parameter = {
            "load_data_browse_config": load_data_browse_config,
            "page_no": page_no,
            "page_size": page_size,
            "use_has_next": use_has_next,
            "query_type": query_type
        }

        if conditions:
            parameter["conditions"] = conditions

        if orders:
            parameter["orders"] = orders

        return self.call(f"{type_key}.query", parameter)

    def get(self, type_key: str, datakeys: List[Dict[str, Any]],
            load_data_browse_config: bool = False) -> APIResponse:
        """
        读取单条/多条数据

        Args:
            type_key: 单据类型
            datakeys: 主键列表，如 [{"docNo": "xxx", "category": "84"}]
        """
        parameter = {
            "load_data_browse_config": load_data_browse_config,
            "datakeys": datakeys
        }
        return self.call(f"{type_key}.get", parameter)

    def create(self, type_key: str, cds_master: List[Dict[str, Any]]) -> APIResponse:
        """
        新增数据

        Args:
            type_key: 单据类型
            cds_master: 主表数据列表，支持单笔或批量
        """
        parameter = {
            "cdsMaster": cds_master
        }
        return self.call(f"{type_key}.create", parameter)

    def update(self, type_key: str, cds_master: List[Dict[str, Any]]) -> APIResponse:
        """
        更新数据

        Args:
            type_key: 单据类型
            cds_master: 主表数据列表（必须包含主键）
        """
        parameter = {
            "cdsMaster": cds_master
        }
        return self.call(f"{type_key}.update", parameter)

    def delete(self, type_key: str, datakeys: List[Dict[str, Any]]) -> APIResponse:
        """
        删除数据

        Args:
            type_key: 单据类型
            datakeys: 主键列表
        """
        parameter = {
            "datakeys": datakeys
        }
        return self.call(f"{type_key}.delete", parameter)

    def approve(self, type_key: str, datakeys: List[Dict[str, Any]]) -> APIResponse:
        """
        审核数据

        Args:
            type_key: 单据类型
            datakeys: 主键列表
        """
        parameter = {
            "datakeys": datakeys
        }
        return self.call(f"{type_key}.approve", parameter)

    def disapprove(self, type_key: str, datakeys: List[Dict[str, Any]]) -> APIResponse:
        """
        撤销审核

        Args:
            type_key: 单据类型
            datakeys: 主键列表
        """
        parameter = {
            "datakeys": datakeys
        }
        return self.call(f"{type_key}.disapprove", parameter)


# 全局客户端实例
_default_client: Optional[OpenAPIClient] = None


def get_client() -> OpenAPIClient:
    """获取全局客户端实例"""
    global _default_client
    if _default_client is None:
        _default_client = OpenAPIClient()
    return _default_client
