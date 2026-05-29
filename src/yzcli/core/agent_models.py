"""Agent request models and validation"""
from typing import Any, Dict, Literal
from pydantic import BaseModel, Field, ValidationError

Operation = Literal["fastquery", "getMultiple", "query", "get", "create", "update", "delete", "approve", "disapprove"]

# New operation names → legacy names for internal routing
_OPERATION_ALIASES: Dict[str, str] = {
    "fastquery": "query",
    "getMultiple": "get",
}

OPERATION_SCHEMAS: Dict[str, Dict[str, Any]] = {
    "fastquery": {
        "description": "Search records with conditions (header-level, fastquery)",
        "required": [],
        "properties": {
            "conditions": {"type": "array", "description": "Query conditions"},
            "orders": {"type": "array", "description": "Sort orders"},
            "page_no": {"type": "integer", "default": 1, "description": "Page number"},
            "page_size": {"type": "integer", "default": 20, "description": "Page size"},
            "query_type": {"type": "string", "default": "all", "description": "Query type: all or key"},
            "use_has_next": {"type": "boolean", "default": True, "description": "Use pagination"},
            "load_data_browse_config": {"type": "boolean", "default": False, "description": "Load browse config"},
        },
    },
    "query": {
        "description": "Legacy alias for fastquery",
        "required": [],
        "properties": {
            "conditions": {"type": "array", "description": "Query conditions"},
            "orders": {"type": "array", "description": "Sort orders"},
            "page_no": {"type": "integer", "default": 1, "description": "Page number"},
            "page_size": {"type": "integer", "default": 20, "description": "Page size"},
            "query_type": {"type": "string", "default": "all", "description": "Query type: all or key"},
            "use_has_next": {"type": "boolean", "default": True, "description": "Use pagination"},
            "load_data_browse_config": {"type": "boolean", "default": False, "description": "Load browse config"},
        },
    },
    "getMultiple": {
        "description": "Get records by primary keys (header + detail, getMultiple)",
        "required": ["datakeys"],
        "properties": {
            "datakeys": {"type": "array", "minItems": 1, "description": "List of primary key dictionaries"},
            "load_data_browse_config": {"type": "boolean", "default": False, "description": "Load browse config"},
        },
    },
    "get": {
        "description": "Legacy alias for getMultiple",
        "required": ["datakeys"],
        "properties": {
            "datakeys": {"type": "array", "minItems": 1, "description": "List of primary key dictionaries"},
            "load_data_browse_config": {"type": "boolean", "default": False, "description": "Load browse config"},
        },
    },
    "create": {
        "description": "Create new records",
        "required": ["cdsMaster"],
        "properties": {
            "cdsMaster": {"type": "array", "minItems": 1, "description": "List of master record dictionaries"},
        },
    },
    "update": {
        "description": "Update existing records",
        "required": ["cdsMaster"],
        "properties": {
            "cdsMaster": {"type": "array", "minItems": 1, "description": "List of master record dictionaries"},
        },
    },
    "delete": {
        "description": "Delete records",
        "required": ["datakeys"],
        "properties": {
            "datakeys": {"type": "array", "minItems": 1, "description": "List of primary key dictionaries"},
        },
    },
    "approve": {
        "description": "Approve records",
        "required": ["datakeys"],
        "properties": {
            "datakeys": {"type": "array", "minItems": 1, "description": "List of primary key dictionaries"},
        },
    },
    "disapprove": {
        "description": "Disapprove records",
        "required": ["datakeys"],
        "properties": {
            "datakeys": {"type": "array", "minItems": 1, "description": "List of primary key dictionaries"},
        },
    },
}


class AgentRequest(BaseModel):
    """Agent request model"""
    type_key: str = Field(..., description="TypeKey for the operation")
    operation: Operation = Field(..., description="Operation to perform")
    input: Dict[str, Any] = Field(default_factory=dict, description="Operation-specific input")


def build_request_schema() -> Dict[str, Any]:
    """Build JSON schema for agent requests"""
    return {
        "type": "object",
        "required": ["type_key", "operation"],
        "properties": {
            "type_key": {"type": "string", "description": "TypeKey for the operation"},
            "operation": {
                "type": "string",
                "enum": list(OPERATION_SCHEMAS.keys()),
                "description": "Operation to perform",
            },
            "input": {"type": "object", "description": "Operation-specific input parameters"},
        },
        "operation_schemas": OPERATION_SCHEMAS,
    }


def validate_agent_request(data: Dict[str, Any]) -> Dict[str, Any]:
    """Validate agent request and return normalized result"""
    try:
        request = AgentRequest(**data)
    except ValidationError as e:
        return {
            "success": False,
            "error": {
                "type": "validation_error",
                "message": f"Request validation failed: {e}",
                "details": {"errors": e.errors()},
                "suggestions": ["Check required fields: type_key, operation", "Verify operation is one of: fastquery, getMultiple, create, update, delete, approve, disapprove"],
            },
        }

    op_schema = OPERATION_SCHEMAS.get(request.operation, {})
    required_fields = op_schema.get("required", [])

    for field in required_fields:
        if field not in request.input:
            return {
                "success": False,
                "error": {
                    "type": "validation_error",
                    "message": f"Missing required field '{field}' for operation '{request.operation}'",
                    "details": {"operation": request.operation, "missing_field": field},
                    "suggestions": [f"Add '{field}' to input parameters"],
                },
            }

    if request.operation == "query":
        defaults = {
            "page_no": 1,
            "page_size": 20,
            "query_type": "all",
            "use_has_next": True,
            "load_data_browse_config": False,
        }
        for key, value in defaults.items():
            if key not in request.input:
                request.input[key] = value

    return {"success": True, "request": request.model_dump()}
