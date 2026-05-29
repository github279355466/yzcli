# YZCLI 项目指南

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
npm install           # 安装依赖
npm run build         # 全量构建
npm test              # 全量测试
```

## AI Agent 接口

> **唯一入口是 MCP 工具**，Agent 不应直接调用 yzcli CLI 命令。

MCP 工具（通过 yzcli-mcp 调用）：
- `yzcli_run(request)`：执行 ERP 操作
- `yzcli_help(type_key)`：获取 TypeKey 信息
- `yzcli_manifest()`：获取业务索引（110 个 TypeKey）
- `yzcli_validate(request)`：校验请求 JSON
- `yzcli_skill_version()`：查询 Skill 版本

传输模式：stdio（本地）或 HTTP（集中式网关，`http://erp-server:3000/mcp`）

详细部署见 `docs/agent-deployment-guide.md`。
