# 实战教程：如何使用 AI Agent 调用易助 ERP CLI 命令

本教程旨在指导开发者或系统管理员，如何配置和引导 AI Agent（如 Manus、OpenClaw Agent 等）通过 CLI 适配器高效、准确地操作易助 ERP 系统。

---

## 1. 核心原理：Agent 如何思考？

AI Agent 并不直接操作 ERP 界面，而是通过以下逻辑闭环完成任务：
1.  **理解意图**：用户输入“帮我录入一张昨天的销售订单”。
2.  **数据准备**：Agent 检索基础资料（客户、物料），构建符合规格说明书的 JSON 数据。
3.  **执行命令**：Agent 调用 shell 命令执行 Python 适配器。
4.  **结果反馈**：Agent 解析 CLI 返回的 JSON 和退出码，告知用户成功或失败的原因。

---

## 2. 场景一：创建销售订单

### 用户指令示例
> “帮我给客户 C001 创建一张订单，包含 10 个 P001 商品，单价 100 元，明天交货。”

### Agent 执行步骤
1.  **生成数据文件**：Agent 会在本地创建一个 `order_request.json`：
    ```json
    {
      "order_no": "AUTO2026042901",
      "order_date": "20260429",
      "customer_id": "C001",
      "salesman_id": "S001",
      "currency": "CNY",
      "exchange_rate": 1.0,
      "lines": [
        {
          "line_no": "001",
          "sku": "P001",
          "unit": "PCS",
          "qty": 10.0,
          "price_tax": 100.0,
          "sum_tax": 1000.0,
          "delivery_date": "20260430"
        }
      ]
    }
    ```
2.  **调用 CLI**：
    ```bash
    python3 scripts/erp_generic_adapter.py --input order_request.json --json
    ```
3.  **解析结果**：如果返回 `code: "0"`，Agent 回复：“订单已成功创建，单号为 AUTO2026042901”。

---

## 3. 场景二：审批销售订单

### 用户指令示例
> “审批刚才那张单号为 AUTO2026042901 的订单，备注：Agent 自动核对无误。”

### Agent 执行步骤
1.  **直接调用命令**：
    ```bash
    python3 scripts/erp_generic_adapter.py --type-key "sales.order" --action "approve" --data '{"datakeys":[{"IBA001":"AUTO2026042901"}]}' --json
    ```
2.  **处理异常**：如果返回退出码 `7`（事务失败），Agent 会读取 `description` 并回复：“审批失败，原因是：该单据已被其他用户锁定或权限不足。”

---

## 4. 进阶：如何编写 Agent 的系统提示词 (System Prompt)？

为了让 Agent 更好地使用这些工具，建议在 OpenClaw 或其他平台配置以下提示词：

> **ERP 操作专家指令：**
> *   你拥有操作易助 ERP 的 CLI 工具：`erp_generic_adapter.py` (通用适配器，支持 create/getMultiple/approve/disapprove/delete/fastquery/update)。
> *   **数据对齐**：在创建订单前，必须确保 `customer_id` 和 `sku` 符合 ERP 编码规范。
> *   **安全第一**：所有创建操作必须包含 `order_no`。
> *   **静默执行**：始终使用 `--json` 参数以获取机器可读的反馈。
> *   **错误处理**：如果退出码非 0，请向用户解释具体的业务错误原因，不要直接展示 Python 堆栈信息。

---

## 5. 常见问题排查 (FAQ)

*   **Q: Agent 提示找不到命令？**
    *   A: 请检查 `openclaw_deployment_guide.md` 中的环境变量配置，确保 `python3` 在 PATH 中。
*   **Q: 订单创建成功但 ERP 里看不到？**
    *   A: 检查 `IBA022` 状态。新创建的订单默认为“未审批”(F)，需调用审批命令或在 ERP 界面手动审核。
*   **Q: Token 过期了怎么办？**
    *   A: 更新服务器的环境变量 `YZ_ERP_TOKEN` 并重启 Agent 服务。

---
*本教程配合 `erp-cli-refactor` 技能使用效果最佳。*
