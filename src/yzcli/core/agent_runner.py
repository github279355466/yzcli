"""Agent runner: field conversion and OpenAPIClient dispatch"""
import copy
import time
from typing import Any, Dict, List, Optional, Callable
from .api_client import APIResponse, APIClientError, OpenAPIClient, get_client
from .field_mapper import FieldMapper, get_mapper
from .logger import get_logger


def convert_agent_fields(data: Dict[str, Any], mapper: FieldMapper) -> tuple[Dict[str, Any], List[Dict[str, Any]]]:
    """Convert field names in agent request input"""
    converted = copy.deepcopy(data)
    conversions = []

    if "datakeys" in converted:
        for i, dk in enumerate(converted["datakeys"]):
            if isinstance(dk, dict):
                for old_key in list(dk.keys()):
                    new_key = mapper.convert_field_name(old_key, target_mode="field_number")
                    if new_key != old_key:
                        dk[new_key] = dk.pop(old_key)
                        conversions.append({"path": f"datakeys[{i}].{old_key}", "from": old_key, "to": new_key})

    if "conditions" in converted:
        for i, cond in enumerate(converted["conditions"]):
            if isinstance(cond, dict) and "groups" in cond:
                for j, group in enumerate(cond["groups"]):
                    if isinstance(group, dict) and "fields" in group:
                        for k, field in enumerate(group["fields"]):
                            if isinstance(field, dict) and "field_name" in field:
                                old_name = field["field_name"]
                                new_name = mapper.convert_field_name(old_name, target_mode="field_number")
                                if new_name != old_name:
                                    field["field_name"] = new_name
                                    conversions.append({
                                        "path": f"conditions[{i}].groups[{j}].fields[{k}].field_name",
                                        "from": old_name,
                                        "to": new_name,
                                    })

    if "orders" in converted:
        for i, order in enumerate(converted["orders"]):
            if isinstance(order, dict) and "field_name" in order:
                old_name = order["field_name"]
                new_name = mapper.convert_field_name(old_name, target_mode="field_number")
                if new_name != old_name:
                    order["field_name"] = new_name
                    conversions.append({"path": f"orders[{i}].field_name", "from": old_name, "to": new_name})

    if "cdsMaster" in converted:
        for i, master in enumerate(converted["cdsMaster"]):
            if isinstance(master, dict):
                _convert_dict_keys(master, i, "cdsMaster", mapper, conversions)
                if "cdsDetail" in master:
                    for j, detail in enumerate(master["cdsDetail"]):
                        if isinstance(detail, dict):
                            _convert_dict_keys(detail, j, f"cdsMaster[{i}].cdsDetail", mapper, conversions)
                if "cdsDetail2" in master:
                    for j, detail in enumerate(master["cdsDetail2"]):
                        if isinstance(detail, dict):
                            _convert_dict_keys(detail, j, f"cdsMaster[{i}].cdsDetail2", mapper, conversions)

    if "cdsDetail" in converted:
        for i, detail in enumerate(converted["cdsDetail"]):
            if isinstance(detail, dict):
                _convert_dict_keys(detail, i, "cdsDetail", mapper, conversions)

    if "cdsDetail2" in converted:
        for i, detail in enumerate(converted["cdsDetail2"]):
            if isinstance(detail, dict):
                _convert_dict_keys(detail, i, "cdsDetail2", mapper, conversions)

    return converted, conversions


def _convert_dict_keys(d: Dict[str, Any], index: int, prefix: str, mapper: FieldMapper, conversions: List[Dict[str, Any]]):
    """Helper to convert dict keys"""
    for old_key in list(d.keys()):
        if old_key in ("cdsDetail", "cdsDetail2"):
            continue
        new_key = mapper.convert_field_name(old_key, target_mode="field_number")
        if new_key != old_key:
            d[new_key] = d.pop(old_key)
            conversions.append({"path": f"{prefix}[{index}].{old_key}", "from": old_key, "to": new_key})


def run_agent_request(
    data: Dict[str, Any],
    client: Optional[OpenAPIClient] = None,
    mapper_factory: Optional[Callable[[str], FieldMapper]] = None,
    explain: bool = False,
) -> Dict[str, Any]:
    """Run agent request and return unified response"""
    from .agent_models import validate_agent_request

    logger = get_logger()
    t0 = time.perf_counter()
    logger.info("[CLI] request_start type_key=%s operation=%s", data.get("type_key", "?"), data.get("operation", "?"))

    if client is None:
        client = get_client()

    if mapper_factory is None:
        mapper_factory = get_mapper

    validation = validate_agent_request(data)
    if not validation["success"]:
        logger.info("[CLI] validation_failed elapsed=%.0fms", (time.perf_counter() - t0) * 1000)
        return validation

    request = validation["request"]
    type_key = request["type_key"]
    raw_operation = request["operation"]
    # Normalize new operation names to legacy names for internal routing
    from .agent_models import _OPERATION_ALIASES
    operation = _OPERATION_ALIASES.get(raw_operation, raw_operation)
    input_data = request["input"]

    t1 = time.perf_counter()
    try:
        mapper = mapper_factory(type_key)
        converted_input, conversions = convert_agent_fields(input_data, mapper)
    except Exception as e:
        logger.info("[CLI] mapping_error elapsed=%.0fms", (time.perf_counter() - t0) * 1000)
        return {
            "success": False,
            "error": {
                "type": "mapping_error",
                "message": f"Field mapping failed: {e}",
                "details": {"error": str(e)},
                "suggestions": ["Use field numbers instead of field names", "Check field names with yzcli help <type_key> --output json"],
            },
        }
    t2 = time.perf_counter()
    logger.info("[CLI] field_convert elapsed=%.0fms conversions=%d", (t2 - t1) * 1000, len(conversions))

    t3 = t2
    try:
        response = _dispatch_operation(client, type_key, operation, converted_input)
    except APIClientError as e:
        logger.info("[CLI] api_error elapsed=%.0fms", (time.perf_counter() - t0) * 1000)
        return {
            "success": False,
            "error": {
                "type": "api_error",
                "message": str(e),
                "details": {},
                "suggestions": ["Check ERP connection", "Verify credentials"],
            },
        }
    t4 = time.perf_counter()
    logger.info("[CLI] api_call_end service=%s.%s status=%s elapsed=%.0fms", type_key, operation, "ok" if response.success else "error", (t4 - t3) * 1000)

    # Use original user-facing operation name in response
    result = _build_response(response, type_key, raw_operation)

    if explain and result["success"]:
        result["explain"] = {
            "resolved": {
                "type_key": type_key,
                "operation": raw_operation,
                "routed_to": operation if operation != raw_operation else None,
                "service": f"{type_key}.{operation}",
            },
            "field_conversions": conversions,
            "equivalent_cli": _build_equivalent_cli(type_key, operation, converted_input),
        }

    logger.info("[CLI] request_end total=%.0fms success=%s", (time.perf_counter() - t0) * 1000, result.get("success"))
    return result


def _dispatch_operation(client: OpenAPIClient, type_key: str, operation: str, input_data: Dict[str, Any]) -> APIResponse:
    """Dispatch to appropriate client method"""
    if operation == "query":
        return client.query(
            type_key=type_key,
            conditions=input_data.get("conditions"),
            orders=input_data.get("orders"),
            page_no=input_data.get("page_no", 1),
            page_size=input_data.get("page_size", 20),
            query_type=input_data.get("query_type", "all"),
            use_has_next=input_data.get("use_has_next", True),
            load_data_browse_config=input_data.get("load_data_browse_config", False),
        )
    elif operation == "get":
        return client.get(type_key=type_key, datakeys=input_data["datakeys"], load_data_browse_config=input_data.get("load_data_browse_config", False))
    elif operation == "create":
        return client.create(type_key=type_key, cds_master=input_data["cdsMaster"])
    elif operation == "update":
        return client.update(type_key=type_key, cds_master=input_data["cdsMaster"])
    elif operation == "delete":
        return client.delete(type_key=type_key, datakeys=input_data["datakeys"])
    elif operation == "approve":
        return client.approve(type_key=type_key, datakeys=input_data["datakeys"])
    elif operation == "disapprove":
        return client.disapprove(type_key=type_key, datakeys=input_data["datakeys"])
    else:
        raise ValueError(f"Unsupported operation: {operation}")


def _build_response(response: APIResponse, type_key: str, operation: str) -> Dict[str, Any]:
    """Build unified response from APIResponse"""
    if response.success:
        return {
            "success": True,
            "type_key": type_key,
            "operation": operation,
            "result": response.data.get("result", {}),
            "raw": {"code": response.code, "message": response.message},
        }
    else:
        result = response.data.get("result", {})
        api_errors = result.get("error", [])
        return {
            "success": False,
            "type_key": type_key,
            "operation": operation,
            "error": {
                "type": "api_error",
                "message": response.message,
                "details": {
                    "code": response.code,
                    "api_errors": [{"message": e.get("message", ""), "data": e.get("data", {})} for e in api_errors],
                },
                "suggestions": ["Check input parameters", f"Use yzcli help {type_key} --output json to verify field names"],
            },
        }


def _build_equivalent_cli(type_key: str, operation: str, input_data: Dict[str, Any]) -> str:
    """Build equivalent CLI command string"""
    if operation == "query":
        return f"yzcli query {type_key} --condition '...'"
    elif operation == "get":
        return f"yzcli get {type_key} --key ..."
    elif operation == "create":
        return f"yzcli create {type_key} --json @..."
    elif operation == "update":
        return f"yzcli update {type_key} --json @..."
    elif operation == "delete":
        return f"yzcli delete {type_key} --key ..."
    elif operation == "approve":
        return f"yzcli approve {type_key} --key ..."
    elif operation == "disapprove":
        return f"yzcli disapprove {type_key} --key ..."
    return ""
