from click.testing import CliRunner

from yzcli.commands.get import get_cmd
from yzcli.core.api_client import APIResponse


class FakeClient:
    def get(self, type_key, datakeys):
        return APIResponse(
            success=False,
            code='-1',
            message='yz.oapi.sales.order.get服务执行失败',
            data={
                'result': {
                    'success': [],
                    'error': [
                        {
                            'message': '数据未找到，无法读取',
                            'data': {'IBA001': 'SO202605250001'},
                        }
                    ],
                }
            },
            raw_response={},
        )


def test_get_failure_displays_api_error_detail(monkeypatch):
    monkeypatch.setattr('yzcli.core.api_client._default_client', FakeClient())

    result = CliRunner().invoke(
        get_cmd,
        ['sales.order', '--key', 'IBA001=SO202605250001'],
    )

    assert result.exit_code == 0
    assert '执行失败: yz.oapi.sales.order.get服务执行失败' in result.output
    assert '数据未找到，无法读取' in result.output
