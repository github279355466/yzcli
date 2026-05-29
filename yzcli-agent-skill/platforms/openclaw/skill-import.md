# OpenClaw Skill 导入指南

## 方式一：知识库导入（推荐）

### 步骤

1. **创建知识库**
   - 进入 OpenClaw **知识库管理**
   - 创建名为 `易助ERP集成规范` 的知识库

2. **上传文件**
   - `SKILL.md` — 核心规则和工作流程
   - `references/field-mapping-matrix.md` — 字段映射参考
   - `references/json-construction-examples.md` — JSON 组装示例
   - `references/hallucination-cases.md` — 幻觉防御案例

3. **关联 Agent**
   - 在 Agent 配置中关联该知识库
   - Agent 会根据需要自动检索知识库内容

### 优势
- System Prompt 保持精简
- 详细参考按需加载，节省 token
- 知识库内容可独立更新

## 方式二：System Prompt 直接导入

### 步骤

1. 进入 OpenClaw **Agent 设置**
2. 将 `SKILL.md` 全文粘贴到 **System Prompt** 区域
3. 保存配置

### 注意事项
- 如果 SKILL.md 内容超过 System Prompt 限制，建议使用方式一
- 可以精简 SKILL.md，只保留核心规则和工具说明
- 详细参考（references/）放入知识库

## 方式三：混合方式

### 推荐策略

**System Prompt 中保留**：
- 角色设定
- 可用工具列表（4 个 MCP 工具）
- 7 步工作流程
- 11 条防幻觉规则（简要版）
- 服务查找表

**知识库中存放**：
- SKILL.md 完整内容
- references/ 全部文件
- 深度参考文档

### System Prompt 精简版

```markdown
# 角色
你是易助 ERP 自动化助手，通过 MCP 工具操作 ERP 系统。

## 工具
yzcli_manifest / yzcli_help / yzcli_validate / yzcli_run

## 流程
意图识别 → 确定TypeKey → help获取字段 → 组装JSON → validate → run → 格式化

## 关键规则
1. 日期 YYYYMMDD，不含横线斜杠
2. 写入用字段编号(IBAxxx)，不用别名
3. 猜不到编码就先查，不编造
4. 创建订单必须有 cdsDetail
5. 缺信息问用户，不设默认值
6. 报错只改 JSON，不改代码
7. 换单据重新 help

详细规则和 JSON 模板见知识库。
```

## MCP Server 配置

OpenClaw 的 MCP 配置方式取决于平台版本。通常在 Agent 的 MCP 设置中：

```json
{
  "yzcli": {
    "command": "yzcli-mcp",
    "env": {
      "YZCLI_PYTHON": "python"
    }
  }
}
```

具体配置位置请参考 OpenClaw 官方文档。
