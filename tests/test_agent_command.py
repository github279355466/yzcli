import json

from click.testing import CliRunner

from yzcli.__main__ import cli
from yzcli.core.api_client import APIResponse


class FakeClient:
    def query(self, **kwargs):
        return APIResponse(
            success=True,
            code="0",
            message="ok",
            data={"result": {"success": [{"cdsMaster": [{"IBA001": "SO1"}]}], "error": []}},
            raw_response={},
        )


class FakeMapper:
    def convert_field_name(self, field_name, target_mode=None):
        return {"docNo": "IBA001"}.get(field_name, field_name)


def test_agent_manifest_outputs_json():
    result = CliRunner().invoke(cli, ["agent", "manifest", "--pretty"])

    assert result.exit_code == 0
    data = json.loads(result.output)
    assert data["tool"]["name"] == "yzcli.agent"
    assert "business_index" in data


def test_agent_validate_stdin_rejects_missing_datakeys():
    result = CliRunner().invoke(
        cli,
        ["agent", "validate", "-", "--pretty"],
        input=json.dumps({"type_key": "sales.order", "operation": "get", "input": {}}),
    )

    assert result.exit_code == 2
    data = json.loads(result.output)
    assert data["success"] is False
    assert data["error"]["type"] == "validation_error"


def test_agent_run_stdin_uses_core_runner(monkeypatch):
    monkeypatch.setattr("yzcli.core.agent_runner.get_client", lambda: FakeClient())
    monkeypatch.setattr("yzcli.core.agent_runner.get_mapper", lambda type_key: FakeMapper())

    result = CliRunner().invoke(
        cli,
        ["agent", "run", "-", "--pretty", "--explain"],
        input=json.dumps({"type_key": "sales.order", "operation": "query", "input": {"page_size": 1}}),
    )

    assert result.exit_code == 0
    data = json.loads(result.output)
    assert data["success"] is True
    assert data["explain"]["resolved"]["service"] == "sales.order.query"
