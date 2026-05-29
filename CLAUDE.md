# YZCLI 项目指南

## 红线（Agent 必须遵守）

1. **禁止直接执行 yzcli CLI 命令**：ERP 操作必须通过 MCP 工具（`yzcli_run` / `yzcli_help` / `yzcli_manifest` / `yzcli_validate`）。禁止执行 `yzcli query`、`yzcli create`、`python -m yzcli` 等命令。
2. **禁止修改 packages/ 下的源码**：`packages/yzcli-sdk/src/`、`packages/yzcli-mcp/src/`、`packages/yzcli-cli/src/` 是核心代码，禁止直接修改。如需修改，必须经过人工审批。
3. **禁止修改 SKILL.md**：`yzcli-agent-skill/SKILL.md` 是部署文档，禁止 Agent 自行修改。

## 项目概览

TypeScript monorepo（npm workspaces），为 AI Agent 提供 ERP 操作能力。

```
packages/
├── yzcli-sdk/     # 共享 SDK（ErpClient + 字段映射 + 配置）
├── yzcli-mcp/     # MCP Server（stdio + HTTP 网关模式）
└── yzcli-cli/     # TypeScript CLI（commander.js）
src/yzcli/         # Python CLI（deprecated，保留过渡）
```

## 常用命令

```bash
# 安装依赖
npm install

# 全量构建
npm run build

# 全量测试
npm test

# 单包操作
cd packages/yzcli-sdk && npm run build
cd packages/yzcli-mcp && npm test
cd packages/yzcli-cli && npm test
```

## AI Agent 接口

> **唯一入口是 MCP 工具**，Agent 不应直接调用 yzcli CLI 命令。

MCP 工具（通过 yzcli-mcp 调用）：
- `yzcli_run(request)`：执行 ERP 操作（query / get / create / update / delete / approve / disapprove）
- `yzcli_help(type_key)`：获取 TypeKey 信息（别名、支持的操作）
- `yzcli_manifest()`：获取业务索引（110 个 TypeKey）
- `yzcli_validate(request)`：校验请求 JSON
- `yzcli_skill_version()`：查询 Skill 版本

传输模式：
- **stdio**（本地）：`{ "command": "yzcli-mcp" }`
- **HTTP**（集中式网关）：`{ "url": "http://erp-server:3000/mcp" }`

详细部署见 `docs/agent-deployment-guide.md`。

## 日志功能

日志配置位于 `~/.yzcli/config.yaml`。

默认日志文件为 `~/.yzcli/logs/yzcli_YYYYMMDD.log`。

## 文档结构

- `README.md`：面向使用者的安装、配置、命令说明
- `docs/agent-deployment-guide.md`：AI Agent 部署指南（集中式网关 + 本地 stdio）
- `docs/agent-cli-integration.md`：AI Agent CLI 集成协议文档
- `docs/specs/`：各 TypeKey 的 CLI 操作规格
- `docs/field-mapping/`：字段编号和节点名对照
- `docs/ServiceNameList.md`：ServiceName 清单
