# MCP Server 配置说明

## 概述

yzcli-mcp 是一个符合 MCP (Model Context Protocol) 标准的服务器，支持两种传输模式：
- **stdio**（本地模式）：MCP Server 在本机运行，通过 stdin/stdout JSON-RPC 通信
- **HTTP**（集中式网关）：MCP Server 部署在 ERP 服务器，Agent 通过 HTTP 连接

yzcli-mcp v0.2.0 使用 yzcli-sdk TypeScript SDK 直接调用 ERP API，不再依赖 Python CLI。

## 环境要求

### 本地 stdio 模式
- **Node.js**: >= 18.0.0
- **yzcli-mcp**: 已构建（`cd packages/yzcli-mcp && npm install && npm run build`）

### 集中式 HTTP 网关模式
- **Node.js**: >= 18.0.0（仅 ERP 服务器需要）
- **Agent 客户端**：仅需支持 MCP HTTP 传输的 Agent 平台

## 环境变量

| 变量 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| `ERP_BASE_URL` | 否 | `http://172.16.6.22:8103` | ERP API 地址 |
| `ERP_TOKEN` | 否 | （从 config.yaml 读取） | ERP 认证 Token |
| `MCP_PORT` | 否 | `3000` | HTTP 网关监听端口 |

## 安装与构建

```bash
cd yzcli/packages/yzcli-mcp
npm install
npm run build
```

## 启动方式

### stdio 模式（默认）
```bash
node dist/index.js
# 或
yzcli-mcp
```

### HTTP 网关模式
```bash
node dist/index.js --http --port 3000
```

### 帮助
```bash
node dist/index.js --help
node dist/index.js --version
```

## 各平台配置示例

### Claude Code — stdio 模式

`.claude/settings.json`：
```json
{
  "mcpServers": {
    "yzcli": {
      "command": "yzcli-mcp"
    }
  }
}
```

### Claude Code — HTTP 网关模式

`.claude/settings.json`：
```json
{
  "mcpServers": {
    "yzcli": {
      "url": "http://erp-server:3000/mcp"
    }
  }
}
```

### Codex — stdio 模式

`~/.codex/.mcp.json`：
```json
{
  "yzcli": {
    "command": "yzcli-mcp"
  }
}
```

### Codex — HTTP 网关模式

`~/.codex/.mcp.json`：
```json
{
  "yzcli": {
    "url": "http://erp-server:3000/mcp"
  }
}
```

### 通用 MCP 客户端

任何支持 MCP stdio 传输的客户端，启动命令为：
```
yzcli-mcp
```

任何支持 MCP StreamableHTTP 传输的客户端，连接 URL 为：
```
http://erp-server:3000/mcp
```

## 提供的工具

| 工具名 | 输入 | 输出 |
|--------|------|------|
| `yzcli_manifest` | 无 | JSON: 业务索引 + schema（110 个 TypeKey） |
| `yzcli_help` | `{ type_key: string }` | JSON: TypeKey 详情（别名、支持的操作） |
| `yzcli_validate` | `{ request: object }` | JSON: 校验结果 |
| `yzcli_run` | `{ request: object, explain?: boolean }` | JSON: 执行结果 |
| `yzcli_skill_version` | 无 | JSON: Skill 版本号 |

## Token 传递

### stdio 模式
Token 从本机 `~/.yzcli/config.yaml` 的 `erp.user_token` 字段读取。

### HTTP 网关模式
Token 通过 HTTP `Authorization: Bearer <token>` Header 传递。MCP 网关从 Header 提取 Token，用于调用 ERP API。

## 安全注意事项

- stdio 模式下 MCP server 不暴露网络端口
- HTTP 模式下建议使用 HTTPS + 内网部署
- Token 通过 HTTP Header 传递，不在 URL 中暴露
- 配置文件中的 `user_token` 不要提交到版本控制
- 临时文件在操作完成后自动清理

## 故障排查

### Server 无响应（stdio）
```bash
# 手动测试 server 是否能启动
yzcli-mcp --help
```

### HTTP 网关连接失败
```bash
# 检查服务是否启动
curl -s http://erp-server:3000/mcp -X POST \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test","version":"0.1"}}}'
```

### ERP 连接失败
```bash
# 检查配置
cat ~/.yzcli/config.yaml
# 确认 base_url 和 user_token 正确
```
