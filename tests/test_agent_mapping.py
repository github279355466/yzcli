from yzcli.core.agent_mapping import build_manifest, generate_agent_map_from_docs, load_builtin_agent_map


def test_builtin_mapping_contains_sales_order():
    mapping = load_builtin_agent_map()

    typekeys = {item["type_key"]: item for item in mapping["typekeys"]}
    assert "sales.order" in typekeys
    assert "订单" in typekeys["sales.order"]["aliases"]


def test_manifest_exposes_tool_schema_and_business_index_without_fields():
    manifest = build_manifest()

    assert manifest["tool"]["name"] == "yzcli.agent"
    assert "request_schema" in manifest
    sales_order = next(item for item in manifest["business_index"] if item["type_key"] == "sales.order")
    assert sales_order["field_help"] == "yzcli help sales.order --output json"
    assert "fields" not in sales_order


def test_generate_map_from_docs_parses_sales_order():
    mapping = generate_agent_map_from_docs()

    sales_order = next(item for item in mapping["typekeys"] if item["type_key"] == "sales.order")
    assert sales_order["title"] == "订单"
    assert sales_order["dll"] == "COPDC02"
    assert "sales order" in sales_order["aliases"]
    assert "fastquery" in sales_order["operations"]
    assert "getMultiple" in sales_order["operations"]
