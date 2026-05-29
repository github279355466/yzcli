# OpenClaw 平台：易助 ERP JSON 组装提示词集成指南

本指南将指导你如何将《易助 ERP JSON 组装专家提示词》集成到 OpenClaw 平台，使你的 AI Agent 能够精准地将自然语言转化为 ERP 报文。

---

## 1. 集成策略：双管齐下

在 OpenClaw 中，我们推荐通过 **“系统提示词 (System Prompt)”** 和 **“知识库 (Knowledge)”** 结合的方式进行集成。

### 策略 A：注入系统提示词 (推荐)
系统提示词具有最高优先级，能直接约束 Agent 的思考逻辑。

1.  登录 OpenClaw 管理后台，进入 **Agent 设置**。
2.  找到 **System Prompt / 角色设定** 区域。
3.  将 `erp_json_construction_prompts.md` 中的核心内容复制并粘贴进去。
4.  **关键点**：确保包含“强制校验逻辑”部分，这能显著降低 Agent 的幻觉。

### 策略 B：挂载知识库
如果提示词内容较长，或者你有很多单据的详细字段映射，建议使用知识库。

1.  在 OpenClaw 的 **知识库管理** 中创建一个名为 `易助ERP集成规范` 的库。
2.  上传以下文件：
    - `service_registry.json` (元数据)
    - `cli_contract.md` (字段映射)
    - `erp_json_construction_prompts.md` (组装逻辑)
3.  在 Agent 配置中关联该知识库。

---

## 2. OpenClaw 配置示例

在 OpenClaw 的 Agent 配置界面，你可以这样设置：

### 角色描述 (Role)
> 你是一个易助 ERP 自动化专家，负责通过调用 `erp_generic_adapter.py` 来处理业务单据。

### 技能约束 (Constraints)
> 1. 在执行任何操作前，必须检索知识库中的 `service_registry.json` 确认 TypeKey。
> 2. 必须严格遵守 `erp_json_construction_prompts.md` 中的 JSON 组装规范。
> 3. 所有的日期必须转换为 YYYYMMDD 格式。
> 4. 必须使用 `--json` 参数调用适配器，并解析返回的 `execution.code`。

---

## 3. 调试与验证 (Debugging)

在 OpenClaw 的调试控制台中，你可以通过以下步骤验证集成效果：

### 测试 1：意图识别测试
- **输入**：“帮我审一下单号为 SO123 的订单。”
- **预期输出**：Agent 应显示其正在调用 `erp_generic_adapter.py --type-key sales.order --action approve --data '{"std_data": {"parameter": {"datakeys": [{"docNo": "SO123"}]}}}' --json`。

### 测试 2：数据清洗测试
- **输入**：“给客户 C01 录入一张今天的订单，买 5 个 P01，单价 10 元。”
- **预期输出**：Agent 应能自动将“今天”转换为当前日期（如 `20260429`），并将“5个”转换为数字 `5.0`。

---

## 4. 常见问题处理

*   **问题：Agent 还是会生成错误的字段名。**
    - **对策**：在 OpenClaw 的 System Prompt 中加入：`“严禁使用任何未在 cli_contract.md 中定义的字段名，违者将导致系统崩溃。”`（适当的强力约束有助于 LLM 遵守规则）。
*   **问题：Agent 忘记传 --type-key。**
    - **对策**：在 OpenClaw 的工具调用配置中，将 `--type-key` 和 `--action` 设为必填参数。
