"""Agent CLI commands"""
import json
import sys
from pathlib import Path
from typing import Optional
import click
from ..core.agent_mapping import build_manifest, generate_agent_map_from_docs, write_builtin_agent_map
from ..core.agent_runner import run_agent_request


@click.group(name="agent")
def agent_cmd():
    """AI Agent 结构化接口"""
    pass


@agent_cmd.command(name="manifest")
@click.option("--pretty/--no-pretty", default=False, help="Pretty print JSON output")
def manifest_cmd(pretty: bool):
    """Get tool schema and business index"""
    manifest = build_manifest()
    indent = 2 if pretty else None
    click.echo(json.dumps(manifest, ensure_ascii=False, indent=indent))


@agent_cmd.command(name="validate")
@click.argument("json_source")
@click.option("--pretty/--no-pretty", default=False, help="Pretty print JSON output")
def validate_cmd(json_source: str, pretty: bool):
    """Validate agent request JSON"""
    from ..core.agent_models import validate_agent_request

    data = _read_json_source(json_source)
    if data is None:
        result = {
            "success": False,
            "error": {
                "type": "io_error",
                "message": f"Cannot read JSON from {json_source}",
                "details": {},
                "suggestions": ["Use @file.json or - for stdin"],
            },
        }
        _output_json(result, pretty, 1)
        return

    result = validate_agent_request(data)
    exit_code = 0 if result["success"] else 2
    _output_json(result, pretty, exit_code)


@agent_cmd.command(name="run")
@click.argument("json_source")
@click.option("--pretty/--no-pretty", default=False, help="Pretty print JSON output")
@click.option("--explain", is_flag=True, default=False, help="Include explanation in response")
def run_cmd(json_source: str, pretty: bool, explain: bool):
    """Execute agent request"""
    data = _read_json_source(json_source)
    if data is None:
        result = {
            "success": False,
            "error": {
                "type": "io_error",
                "message": f"Cannot read JSON from {json_source}",
                "details": {},
                "suggestions": ["Use @file.json or - for stdin"],
            },
        }
        _output_json(result, pretty, 1)
        return

    result = run_agent_request(data, explain=explain)
    exit_code = 0 if result.get("success", False) else 1
    _output_json(result, pretty, exit_code)


@agent_cmd.command(name="generate-map")
@click.option("--project-root", type=click.Path(exists=True, file_okay=False, dir_okay=True, resolve_path=True), help="Project root directory")
@click.option("--pretty/--no-pretty", default=False, help="Pretty print JSON output")
def generate_map_cmd(project_root: Optional[str], pretty: bool):
    """Generate agent mapping from docs"""
    try:
        root_path = Path(project_root) if project_root else None
        mapping = generate_agent_map_from_docs(root_path)
        target = write_builtin_agent_map(mapping)
        result = {
            "success": True,
            "message": f"Generated {len(mapping.get('typekeys', []))} typekeys",
            "path": str(target),
        }
        _output_json(result, pretty, 0)
    except (PermissionError, OSError) as e:
        result = {
            "success": False,
            "error": {
                "type": "mapping_error",
                "message": f"Cannot write builtin YAML: {e}",
                "details": {"error": str(e)},
                "suggestions": ["Run in source checkout", "Check write permissions"],
            },
        }
        _output_json(result, pretty, 1)


def _read_json_source(source: str) -> Optional[dict]:
    """Read JSON from @file or stdin (-)"""
    try:
        if source == "-":
            return json.load(sys.stdin)
        elif source.startswith("@"):
            with open(source[1:], encoding="utf-8") as f:
                return json.load(f)
        else:
            return json.loads(source)
    except (json.JSONDecodeError, FileNotFoundError, IOError):
        return None


def _output_json(data: dict, pretty: bool, exit_code: int):
    """Output JSON and exit"""
    indent = 2 if pretty else None
    click.echo(json.dumps(data, ensure_ascii=False, indent=indent))
    if exit_code != 0:
        sys.exit(exit_code)
