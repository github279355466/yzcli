# Claude Code 安装与配置指南

## 快速安装

### 1. 安装 yzcli（Python CLI）

```bash
# 在 yzcli 项目根目录
pip install -e .
```

验证：
```bash
yzcli --help
python -m yzcli agent manifest --pretty
```

### 2. 安装 yzcli-mcp（MCP Server）

```bash
# 方式一：全局安装（推荐）
npm install -g yzcli-mcp

# 方式二：在项目中安装
cd your-project
npm install yzcli-mcp
```

验证：
```bash
yzcli-mcp --help
```

### 3. 安装 Skill

将 `SKILL.md` 复制到 Claude Code 的 skills 目录：

```bash
# 创建 skills 目录（如不存在）
mkdir -p ~/.claude/skills/

# 复制 SKILL.md
cp yzcli-agent-skill/SKILL.md ~/.claude/skills/yzcli-erp.md
```

### 4. 配置 MCP Server

在 Claude Code 的 `settings.json` 中添加 MCP server 配置：

**项目级配置**（推荐）：
在项目根目录创建 `.claude/settings.json`：
```json
{
  "mcpServers": {
    "yzcli": {
      "command": "yzcli-mcp",
      "env": {
        "YZCLI_PYTHON": "python"
      }
    }
  }
}
```

**全局配置**：
编辑 `~/.claude/settings.json`，添加相同的 `mcpServers` 配置。

### 5. 验证集成

在 Claude Code 中输入：
```
请调用 yzcli_manifest 工具，查看可用的 ERP 业务类型。
```

预期：Agent 调用 `yzcli_manifest` 工具，返回包含 110 个 TypeKey 的业务索引。

## 高级配置

### 自定义 Python 路径

如果 Python 不在系统 PATH 中：
```json
{
  "mcpServers": {
    "yzcli": {
      "command": "yzcli-mcp",
      "env": {
        "YZCLI_PYTHON": "C:\\Python312\\python.exe"
      }
    }
  }
}
```

### 附加参数

通过 `YZCLI_ARGS` 环境变量传递额外参数：
```json
{
  "env": {
    "YZCLI_PYTHON": "python",
    "YZCLI_ARGS": "--config /path/to/config.yaml"
  }
}
```

## 故障排查

| 问题 | 解决方案 |
|------|---------|
| MCP 工具不可用 | 检查 settings.json 配置是否正确，重启 Claude Code |
| Python 找不到 | 设置 `YZCLI_PYTHON` 为完整 Python 路径 |
| ERP 连接失败 | 检查 yzcli config.yaml 中的 token 和 URL 配置 |
| Skill 未加载 | 确认 SKILL.md 已复制到 `~/.claude/skills/` |
