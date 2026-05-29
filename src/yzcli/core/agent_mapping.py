"""Agent mapping: load builtin YAML, build manifest, generate from docs"""
import importlib.resources
from pathlib import Path
from typing import Any, Dict, List
import yaml


def load_builtin_agent_map() -> Dict[str, Any]:
    """Load builtin agent mapping from package data"""
    try:
        files = importlib.resources.files("yzcli.data")
        yaml_path = files / "agent_typekey_map.yaml"
        with open(yaml_path, encoding="utf-8") as f:
            return yaml.safe_load(f)
    except (FileNotFoundError, yaml.YAMLError) as e:
        return {"error": str(e), "typekeys": []}


def build_manifest() -> Dict[str, Any]:
    """Build manifest with tool schema and business index"""
    mapping = load_builtin_agent_map()
    from .agent_models import build_request_schema

    business_index = []
    for item in mapping.get("typekeys", []):
        business_index.append({
            "type_key": item["type_key"],
            "title": item.get("title", ""),
            "dll": item.get("dll", ""),
            "aliases": item.get("aliases", []),
            "operations": item.get("operations", []),
            "operation_aliases": item.get("operation_aliases", {}),
            "field_help": f"yzcli help {item['type_key']} --output json",
        })

    return {
        "schema_version": "1",
        "tool": {
            "name": "yzcli.agent",
            "commands": ["manifest", "validate", "run", "generate-map"],
            "operations": list(OPERATION_ALIASES.keys()),
        },
        "request_schema": build_request_schema(),
        "business_index": business_index,
    }


OPERATION_ALIASES = {
    "fastquery": ["查询", "列表", "搜索"],
    "getMultiple": ["读取", "详情", "查看"],
    "create": ["新增", "创建"],
    "update": ["更新", "修改"],
    "delete": ["删除"],
    "approve": ["审核"],
    "disapprove": ["撤审", "取消审核"],
}

ALL_OPERATIONS = ["fastquery", "getMultiple", "create", "update", "delete", "approve", "disapprove"]


def generate_agent_map_from_docs(project_root: Path = None) -> Dict[str, Any]:
    """Generate agent mapping from offline docs"""
    if project_root is None:
        project_root = Path(__file__).parent.parent.parent.parent

    json_mapping_dir = project_root / "docs" / "field-mapping"
    specs_dir = project_root / "docs" / "specs"

    typekeys = []

    if json_mapping_dir.exists():
        for md_file in sorted(json_mapping_dir.glob("*.md")):
            filename = md_file.stem
            parts = filename.split("_")
            if len(parts) >= 3:
                type_key = parts[0]
                title = parts[1]
                dll = parts[2]

                aliases = [title, type_key, dll]
                if "." in type_key:
                    aliases.append(type_key.replace(".", " "))

                operations = _infer_operations_from_specs(specs_dir, type_key)
                if not operations:
                    operations = ALL_OPERATIONS.copy()

                typekeys.append({
                    "type_key": type_key,
                    "title": title,
                    "dll": dll,
                    "aliases": aliases,
                    "operations": operations,
                    "operation_aliases": {op: OPERATION_ALIASES[op] for op in operations if op in OPERATION_ALIASES},
                })

    typekeys.sort(key=lambda x: x["type_key"])

    return {
        "version": 1,
        "generated_from": ["docs/field-mapping", "docs/specs"],
        "typekeys": typekeys,
    }


def _infer_operations_from_specs(specs_dir: Path, type_key: str) -> List[str]:
    """Infer operations from specs file"""
    if not specs_dir.exists():
        return []

    spec_file = specs_dir / f"{type_key.replace('.', '_')}_cli_spec.md"
    if not spec_file.exists():
        return []

    try:
        content = spec_file.read_text(encoding="utf-8")
        for line in content.split("\n"):
            if "支持的操作" in line:
                op_str = line.split("|")[-2].strip()
                ops = [op.strip().strip("`").strip() for op in op_str.split(",")]
                normalized = []
                for op in ops:
                    normalized.append(op)
                return normalized
    except Exception:
        pass

    return []


def write_builtin_agent_map(mapping: Dict[str, Any], target_path: Path = None) -> Path:
    """Write mapping to builtin YAML path"""
    if target_path is None:
        target_path = Path(__file__).parent.parent / "data" / "agent_typekey_map.yaml"

    target_path.parent.mkdir(parents=True, exist_ok=True)

    with open(target_path, "w", encoding="utf-8") as f:
        yaml.dump(mapping, f, allow_unicode=True, sort_keys=False)

    return target_path
