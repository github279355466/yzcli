from pathlib import Path

from yzcli.core.agent_mapping import generate_agent_map_from_docs, write_builtin_agent_map


def test_generated_map_is_sorted_and_contains_common_operation_aliases():
    mapping = generate_agent_map_from_docs()

    type_keys = [item["type_key"] for item in mapping["typekeys"]]
    assert type_keys == sorted(type_keys)
    sales_order = next(item for item in mapping["typekeys"] if item["type_key"] == "sales.order")
    assert "查询" in sales_order["operation_aliases"]["fastquery"]
    assert "撤审" in sales_order["operation_aliases"]["disapprove"]


def test_write_builtin_agent_map_writes_yaml(tmp_path):
    target = tmp_path / "agent_typekey_map.yaml"
    result = write_builtin_agent_map(
        {"version": 1, "generated_from": [], "typekeys": []},
        target_path=target,
    )

    assert result == target
    assert "typekeys:" in Path(target).read_text(encoding="utf-8")
