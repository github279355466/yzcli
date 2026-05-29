# AI Agent 部署指南

> 本指南覆盖两种部署模式：
> - **模式 A（集中式网关）**：MCP Server 部署在 ERP 服务器，Agent 客户端通过 HTTP 连接 — **推荐**
> - **模式 B（本地 stdio）**：MCP Server 在每台 Agent 客户端本地运行 — 传统方式

## 架构概览

### 模式 A：集中式 MCP 网关（推荐）

```
┌──────────────────────────────────────────────────┐
│  AI Agent 客户端 (Claude Code / Codex)             │
│  ├── SKILL.md (操作指引)                           │
│  ├── MCP Client → HTTP ──────────────────────┐    │
│  └── ~/.yzcli/config.yaml (Token)            │    │
└──────────────────────────────────────────────┼────┘
                                               │ HTTP (StreamableHTTP)
┌──────────────────────────────────────────────▼────┐
│  ERP 服务器：集中式 MCP 网关                          │
│  ├── yzcli-mcp --http --port 3000                  │
│  │   └── Tools 层 → yzcli-sdk → ERP API (本机<1ms) │
│  └── yzcli-cli (管理员调试用)                        │
└────────────────────────────────────────────────────┘
```

**优势**：
- 客户端零安装（无需 Python、无需 Node.js）
- Token 通过 HTTP Header 传递，MCP 网关统一管理 ERP 连接
- 仅 ERP 服务器需部署和维护

### 模式 B：本地 stdio（传统）

```
Agent 客户端
  ├── yzcli-mcp (Node.js，stdio JSON-RPC)
  │   └── yzcli-sdk → HTTP → ERP API
  └── ~/.yzcli/config.yaml (Token + ERP URL)
```

## 环境要求

### 模式 A（集中式网关）

| 组件 | 位置 | 版本要求 | 说明 |
|------|------|---------|------|
| Node.js | ERP 服务器 | >= 18.0.0 | yzcli-mcp 运行环境 |
| yzcli-mcp | ERP 服务器 | >= 0.2.0 | SDK-based MCP Server |
| AI Agent | 客户端 | Claude Code / Codex | 仅需 HTTP 连接 |

### 模式 B（本地 stdio）

| 组件 | 位置 | 版本要求 | 说明 |
|------|------|---------|------|
| Node.js | 客户端 | >= 18.0.0 | yzcli-mcp 运行环境 |
| yzcli-mcp | 客户端 | >= 0.2.0 | SDK-based MCP Server |
| AI Agent | 客户端 | Claude Code / Codex | stdio 通信 |

> **注意**：新版本 yzcli-mcp v0.2.0 使用 TypeScript SDK 直接调用 ERP API，不再依赖 Python CLI。

---

## 模式 A 部署：集中式 MCP 网关

### Step 1：在 ERP 服务器安装 yzcli-mcp

```bash
cd yzcli/packages/yzcli-mcp
npm install
npm run build
```

### Step 2：配置 ERP 连接

```bash
# 在 ERP 服务器上创建配置
mkdir -p ~/.yzcli
cat > ~/.yzcli/config.yaml << 'EOF'
erp:
  base_url: "http://localhost:8103"    # ERP API 地址（本机用 localhost）
  user_token: "your-erp-token"
  timeout: 30
EOF
```

### Step 3：启动 MCP 网关

```bash
# 前台运行（调试用）
node packages/yzcli-mcp/dist/index.js --http --port 3000

# 生产环境用 PM2 或 systemd
pm2 start "node /opt/yzcli/packages/yzcli-mcp/dist/index.js --http --port 3000" --name yzcli-mcp
```

验证：
```bash
# 检查服务是否启动
curl -s http://localhost:3000/mcp -X POST \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"test","version":"0.1"}}}'
```

### Step 4：Agent 客户端配置

#### Claude Code

在项目根目录创建 `.claude/settings.json`：
```json
{
  "mcpServers": {
    "yzcli": {
      "url": "http://erp-server:3000/mcp"
    }
  }
}
```

#### Codex

创建 `~/.codex/.mcp.json`：
```json
{
  "yzcli": {
    "url": "http://erp-server:3000/mcp"
  }
}
```

### Step 5：Token 传递

Agent 在 MCP 请求中携带 ERP Token（通过 HTTP Authorization Header）。MCP 网关从 Header 提取 Token，用于调用 ERP API。

**Token 配置方式**（按优先级）：
1. Agent 客户端的 `~/.yzcli/config.yaml` 中的 `erp.user_token`
2. 环境变量 `ERP_TOKEN`

---

## 模式 B 部署：本地 stdio（传统）

### Step 1：安装 yzcli-mcp

```bash
cd yzcli/packages/yzcli-mcp
npm install && npm run build
# 或全局安装
npm install -g yzcli-mcp
```

### Step 2：配置 ERP 连接

```bash
mkdir -p ~/.yzcli
cat > ~/.yzcli/config.yaml << 'EOF'
erp:
  base_url: "http://your-erp-server:8103"
  user_token: "your-erp-token"
  timeout: 30
EOF
```

### Step 3：配置 MCP Server

#### Claude Code — `.claude/settings.json`

```json
{
  "mcpServers": {
    "yzcli": {
      "command": "yzcli-mcp"
    }
  }
}
```

#### Codex — `~/.codex/.mcp.json`

```json
{
  "yzcli": {
    "command": "yzcli-mcp"
  }
}
```

### Step 4：安装 Skill

#### Claude Code 用户

```bash
# 创建 Skill 目录
mkdir -p ~/.claude/skills/yzcli-erp/

# 复制 SKILL.md（唯一入口文件）
cp yzcli-agent-skill/SKILL.md ~/.claude/skills/yzcli-erp/

# 复制 references/ 目录（完整 TypeKey 索引、字段映射等）
cp -r yzcli-agent-skill/references/ ~/.claude/skills/yzcli-erp/references/
```

#### Codex 用户

```bash
mkdir -p ~/.codex/skills/yzcli-erp/
cp yzcli-agent-skill/SKILL.md ~/.codex/skills/yzcli-erp/
cp -r yzcli-agent-skill/references/ ~/.codex/skills/yzcli-erp/references/
```

### Step 5（可选）：复制 docs/ 参考文档

如果希望 Agent 通过本地文件读取替代 MCP 调用以加速：
```bash
mkdir -p docs/
cp -r yzcli/docs/ServiceNameList.md docs/
cp -r yzcli/docs/field-mapping/ docs/field-mapping/
cp -r yzcli/docs/specs/ docs/specs/
```

**不复制 docs/ 也能正常工作**：SKILL.md 已内嵌 Top 15 TypeKey 的操作速查，完整 110 个 TypeKey 在 references/typekey-full-list.md 中。

---

## 验证部署

### 冒烟测试 1：MCP 工具可用

在 Claude Code 中输入：
```
调用 yzcli_manifest 工具
```

预期：返回包含 110 个 TypeKey 的 JSON 索引。

### 冒烟测试 2：执行查询

在 Claude Code 中输入：
```
查询最近的销售订单（只要1条）
```

预期：Agent 自动调用 yzcli_run 执行查询，返回订单数据。

### 冒烟测试 3：防幻觉验证

在 Claude Code 中输入：
```
帮我建一个给鼎捷的销售订单
```

预期：
1. Agent 不猜测客户编码
2. Agent 先查询 customer 获取鼎捷的编码
3. Agent 询问缺失的必填信息（品号、数量、单价等）

---

## 故障排查

| 问题 | 可能原因 | 解决方案 |
|------|---------|---------|
| MCP 工具不可用 | settings.json 配置错误 | 检查 JSON 格式，重启 Agent |
| HTTP 网关连接失败 | 端口未开放或服务未启动 | 检查 `curl http://erp-server:3000/mcp` |
| ERP 连接失败 | Token 过期或 URL 错误 | 更新 `~/.yzcli/config.yaml` |
| Skill 未加载 | SKILL.md 未复制 | 确认文件在 ~/.claude/skills/yzcli-erp/ |
| Node.js 找不到 | 未安装 Node.js | 安装 Node.js >= 18.0.0 |

---

## 目录结构

### 模式 A（集中式网关）— ERP 服务器

```
ERP 服务器/
├── yzcli/                              # 源码仓库
│   ├── packages/
│   │   ├── yzcli-sdk/                  # 共享 SDK
│   │   ├── yzcli-mcp/                  # MCP Server（SDK-based）
│   │   └── yzcli-cli/                  # TypeScript CLI
│   └── ~/.yzcli/config.yaml            # ERP 连接配置
└── pm2 start yzcli-mcp --http          # HTTP 网关进程
```

### 模式 A — Agent 客户端

```
Agent 客户端/
├── ~/.claude/skills/yzcli-erp/
│   ├── SKILL.md                        # 操作指引
│   └── references/                     # 扩展文档
└── .claude/settings.json               # MCP URL 配置
    { "mcpServers": { "yzcli": { "url": "http://erp-server:3000/mcp" } } }
```

### 模式 B（本地 stdio）— Agent 客户端

```
Agent 客户端/
├── yzcli/                              # 源码仓库
│   └── packages/yzcli-mcp/             # MCP Server（本地）
├── ~/.yzcli/config.yaml                # ERP 连接配置
├── ~/.claude/skills/yzcli-erp/
│   ├── SKILL.md
│   └── references/
└── .claude/settings.json               # MCP stdio 配置
    { "mcpServers": { "yzcli": { "command": "yzcli-mcp" } } }
```

---

## 维护说明

### 更新 yzcli-mcp（集中式网关）
```bash
cd yzcli && git pull
cd packages/yzcli-mcp && npm run build
# 重启 MCP 网关
pm2 restart yzcli-mcp
```

### 更新 yzcli-mcp（本地 stdio）
```bash
cd yzcli && git pull
cd packages/yzcli-mcp && npm install && npm run build
```

### 更新 Skill
```bash
cp yzcli-agent-skill/SKILL.md ~/.claude/skills/yzcli-erp/
cp -r yzcli-agent-skill/references/ ~/.claude/skills/yzcli-erp/references/
```
