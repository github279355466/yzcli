from yzcli.core.agent_models import (
    OPERATION_SCHEMAS,
    build_request_schema,
    validate_agent_request,
)


def test_validate_query_request_applies_defaults():
    result = validate_agent_request({
        "type_key": "sales.order",
        "operation": "query",
        "input": {},
    })

    assert result["success"] is True
    request = result["request"]
    assert request["type_key"] == "sales.order"
    assert request["operation"] == "query"
    assert request["input"]["page_no"] == 1
    assert request["input"]["page_size"] == 20
    assert request["input"]["query_type"] == "all"


def test_validate_get_requires_datakeys():
    result = validate_agent_request({
        "type_key": "sales.order",
        "operation": "get",
        "input": {},
    })

    assert result["success"] is False
    assert result["error"]["type"] == "validation_error"
    assert "datakeys" in result["error"]["message"]


def test_request_schema_lists_all_operations():
    schema = build_request_schema()

    for operation in OPERATION_SCHEMAS:
        assert operation in schema["properties"]["operation"]["enum"]
