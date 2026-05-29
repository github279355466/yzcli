from yzcli.core.agent_runner import convert_agent_fields, run_agent_request
from yzcli.core.api_client import APIResponse


class FakeMapper:
    def convert_field_name(self, field_name, target_mode=None):
        mapping = {
            "docNo": "IBA001",
            "cust": "IBA004",
            "date": "IBA003",
            "itemNo": "IBB003",
        }
        return mapping.get(field_name, field_name)


class FakeClient:
    def __init__(self, response=None):
        self.calls = []
        self.response = response or APIResponse(
            success=True,
            code="0",
            message="ok",
            data={"result": {"success": [{"cdsMaster": [{"IBA001": "SO1"}]}], "error": []}},
            raw_response={},
        )

    def query(self, **kwargs):
        self.calls.append(("query", kwargs))
        return self.response

    def get(self, **kwargs):
        self.calls.append(("get", kwargs))
        return self.response

    def create(self, **kwargs):
        self.calls.append(("create", kwargs))
        return self.response


def test_convert_agent_fields_converts_all_supported_locations():
    converted, conversions = convert_agent_fields(
        {
            "datakeys": [{"docNo": "SO1", "unknown": "x"}],
            "conditions": [{"groups": [{"fields": [{"field_name": "cust", "operator": "=", "value": "C1"}]}]}],
            "orders": [{"field_name": "date", "order_type": "DESC"}],
            "cdsMaster": [{"docNo": "SO1", "cdsDetail": [{"itemNo": "A1"}]}],
        },
        FakeMapper(),
    )

    assert converted["datakeys"][0]["IBA001"] == "SO1"
    assert converted["datakeys"][0]["unknown"] == "x"
    assert converted["conditions"][0]["groups"][0]["fields"][0]["field_name"] == "IBA004"
    assert converted["orders"][0]["field_name"] == "IBA003"
    assert converted["cdsMaster"][0]["IBA001"] == "SO1"
    assert converted["cdsMaster"][0]["cdsDetail"][0]["IBB003"] == "A1"
    assert {item["to"] for item in conversions} >= {"IBA001", "IBA004", "IBA003", "IBB003"}


def test_run_query_calls_client_and_returns_direct_result_with_explain():
    client = FakeClient()

    result = run_agent_request(
        {
            "type_key": "sales.order",
            "operation": "query",
            "input": {"conditions": [{"groups": [{"fields": [{"field_name": "cust", "operator": "=", "value": "C1"}]}]}]},
        },
        client=client,
        mapper_factory=lambda type_key: FakeMapper(),
        explain=True,
    )

    assert result["success"] is True
    assert client.calls[0][0] == "query"
    assert client.calls[0][1]["conditions"][0]["groups"][0]["fields"][0]["field_name"] == "IBA004"
    assert result["result"] == client.response.data["result"]
    assert result["explain"]["resolved"]["service"] == "sales.order.query"


def test_run_get_wraps_api_error_detail():
    response = APIResponse(
        success=False,
        code="-1",
        message="yz.oapi.sales.order.get服务执行失败",
        data={"result": {"success": [], "error": [{"message": "数据未找到，无法读取", "data": {"IBA001": "SO404"}}]}},
        raw_response={},
    )
    client = FakeClient(response=response)

    result = run_agent_request(
        {"type_key": "sales.order", "operation": "get", "input": {"datakeys": [{"docNo": "SO404"}]}},
        client=client,
        mapper_factory=lambda type_key: FakeMapper(),
    )

    assert result["success"] is False
    assert result["error"]["type"] == "api_error"
    assert "数据未找到，无法读取" in result["error"]["details"]["api_errors"][0]["message"]
