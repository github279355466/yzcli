from pathlib import Path


def test_pyproject_includes_agent_yaml_package_data():
    pyproject = Path("pyproject.toml").read_text(encoding="utf-8")

    assert "[tool.setuptools.package-data]" in pyproject
    assert 'yzcli = ["data/*.yaml"]' in pyproject
