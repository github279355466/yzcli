# YZCLI 项目指南

## 项目概览

这是一个 Python CLI 项目，包名为 `yzcli`，入口命令为 `yzcli` / `python -m yzcli`。源码位于 `src/yzcli/`，配置示例为 `config.example.yaml`。

## 常用命令

- 安装开发包：`pip install -e .`
- Lint：`ruff check .`
- 导入冒烟：`python test_import.py`
- CLI 帮助：`python -m yzcli --help`
- 配置查看：`python -m yzcli config show`
- 测试命令：`python -m pytest -v`

当前有 16 个测试用例（6 个测试文件，均在 `tests/` 下），`python -m pytest -v` 应全部通过。

## AI Agent 接口

`yzcli agent` 子命令提供结构化 JSON 接口，供外部 AI Agent 直接调用：

- `yzcli agent manifest --pretty`：获取工具 schema 和业务索引
- `yzcli agent validate @request.json --pretty`：校验请求 JSON
- `yzcli agent run @request.json --pretty --explain`：执行请求
- `yzcli agent generate-map`：从离线文档重新生成内置 YAML 映射

详细协议见 `docs/agent-cli-integration.md`。

## MCP Server + Skill

`yzcli-mcp/` 是 Node.js MCP Server，通过 stdio 协议为 AI Agent 提供 4 个 ERP 工具。`yzcli-agent-skill/` 是可安装的知识包，引导 Agent 正确使用工具。

```bash
# MCP Server（Node.js）
cd yzcli-mcp && npm install && npm run build && npm test

# Skill 包
cp yzcli-agent-skill/SKILL.md ~/.claude/skills/yzcli-erp.md
```

MCP 工具：`yzcli_manifest` / `yzcli_help` / `yzcli_validate` / `yzcli_run`
详细部署见 `docs/agent-deployment-guide.md`。

## 日志功能

日志配置位于 `AppConfig.log`，可通过 `yzcli config get/set log.*` 管理：

- `log.enabled`：是否启用日志，默认 `true`
- `log.level`：`DEBUG` / `INFO` / `WARNING` / `ERROR`，默认 `INFO`
- `log.dir`：日志目录，空值使用 `~/.yzcli/logs/`
- `log.max_days`：日志保留天数，默认 `7`
- `log.console`：是否同时输出到控制台，默认 `false`

默认日志文件为 `~/.yzcli/logs/yzcli_YYYYMMDD.log`。`--debug` 会在本次命令执行中把 logger 和 handler 切到 DEBUG。

## 文档结构

- `README.md`：面向使用者的安装、配置、命令和日志说明
- `docs/易助OpenAPI使用说明/`：官方 OpenAPI 参考资料
- `docs/specs/`：各 TypeKey 的 CLI 操作规格
- `docs/field-mapping/`：字段编号和节点名对照
- `docs/agent-cli-integration.md`：AI Agent CLI 集成协议文档
- `docs/agent-deployment-guide.md`：AI Agent 部署指南（MCP + Skill）
- `docs/ServiceNameList.md`：ServiceName 清单
