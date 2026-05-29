# AI Agent 部署指南

> 在客户服务器上部署 yzcli + yzcli-mcp + Skill，供 AI Agent 调用

## 环境要求

| 组件 | 版本要求 | 说明 |
|------|---------|------|
| Python | >= 3.8 | yzcli CLI 运行环境 |
| Node.js | >= 18.0.0 | yzcli-mcp 运行环境 |
| yzcli | 最新版本 | ERP CLI 工具 |
| AI Agent 平台 | Claude Code / Codex / OpenClaw | 用户交互界面 |

## 部署步骤

### Step 1: 安装 yzcli

```bash
# 方式一：从源码安装（推荐，便于开发维护）
cd yzcli
pip install -e .

# 方式二：从 PyPI 安装（正式发布后）
pip install yzcli
```

验证：
```bash
yzcli --help
yzcli config show
```

### Step 2: 配置 yzcli

```bash
# 设置 ERP 连接信息
yzcli config set erp.url "http://your-erp-server/api"
yzcli config set erp.token "your-auth-token"

# 验证连接
yzcli config show
```

### Step 3: 安装 yzcli-mcp

```bash
# 方式一：全局安装（推荐）
npm install -g yzcli-mcp

# 方式二：npx 免安装运行
npx yzcli-mcp
```

验证：
```bash
yzcli-mcp --help
```

### Step 4: 安装 Skill

#### Claude Code 用户

```bash
# 创建 Skill 目录
mkdir -p ~/.claude/skills/yzcli-erp/

# 复制 SKILL.md（唯一入口文件）
cp yzcli-agent-skill/SKILL.md ~/.claude/skills/yzcli-erp/

# 复制 references/ 目录（完整 TypeKey 索引、字段映射等）
cp -r yzcli-agent-skill/references/ ~/.claude/skills/yzcli-erp/references/

# 或使用 zip 分发包一步完成
unzip yzcli-agent-skill-v1.0.zip -d ~/.claude/skills/yzcli-erp/
```

> **SKILL.md 内嵌 Top 15 高频 TypeKey 的完整操作速查**（含字段编号+英文节点名双格式），
> 覆盖销售订单、采购单、客户、商品等最常用业务。完整 110 个 TypeKey 在 references/typekey-full-list.md 中，Agent 按需读取。

#### OpenClaw 用户

参见 `yzcli-agent-skill/platforms/openclaw/skill-import.md`

### Step 5: 配置 MCP Server

#### Claude Code

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

如果 Python 不在 PATH 中：
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

#### OpenClaw

参见 OpenClaw 平台文档配置 MCP server。

#### Codex（OpenAI）

创建 `~/.codex/.mcp.json`：
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

> Codex 使用与 Claude Code 相同的 **stdio** 传输协议，yzcli-mcp 无需任何修改即可兼容。

### 架构说明：配置链路

MCP Server **本身不需要 ERP API 地址**。调用链路如下：

```
Claude Code
  └─ yzcli-mcp（Node.js，stdio JSON-RPC）
       └─ subprocess → yzcli CLI（Python）
            └─ 读取 ~/.yzcli/config.yaml → ERP API
```

| 组件 | 配置位置 | 内容 |
|------|---------|------|
| MCP Server | `.claude/settings.json` | `command` + `YZCLI_PYTHON`（不需要 API 地址） |
| yzcli CLI | `~/.yzcli/config.yaml` | `erp.url` + `erp.token`（ERP 连接信息） |

**关键点**：yzcli 的配置文件路径是 `~/.yzcli/config.yaml`（用户 home 目录），无论 yzcli-mcp 的工作目录在哪里，yzcli 都能自动找到配置。

### Cowork 环境配置注意事项

在 cowork（多人协作的 Claude Code 环境）中部署时，需注意以下差异：

#### 1. YZCLI_PYTHON 环境变量

cowork 环境中，Claude Code 启动 MCP Server 时使用 `settings.json` 中定义的环境变量。`YZCLI_PYTHON` 必须指向 **cowork 服务器上实际安装了 yzcli 的 Python 解释器**：

```json
{
  "mcpServers": {
    "yzcli": {
      "command": "yzcli-mcp",
      "env": {
        "YZCLI_PYTHON": "/usr/bin/python3"
      }
    }
  }
}
```

> ⚠️ **常见错误**：cowork 服务器上的 Python 路径可能与本地不同。
> 用 `which python3` 确认实际路径。

#### 2. yzcli 安装位置

cowork 环境中 yzcli 必须安装为**系统级**或**该用户级**，不能只装在某人的 home 目录下：

```bash
# 确认 yzcli 可全局访问
which yzcli
yzcli --help
```

#### 3. ERP 配置文件权限

`~/.yzcli/config.yaml` 包含 ERP Token（敏感信息）。cowork 环境中需确保：
- 配置文件权限为 `600`（仅所有者可读写）
- Token 不要提交到版本控制
- 多用户共享同一服务器时，每个用户需要独立的 `~/.yzcli/config.yaml`

```bash
# 设置配置文件权限
chmod 600 ~/.yzcli/config.yaml
```

#### 4. npm 全局安装路径

cowork 服务器上 `npm install -g yzcli-mcp` 后，需确认 `yzcli-mcp` 在 PATH 中：

```bash
# 确认 yzcli-mcp 可全局访问
which yzcli-mcp
yzcli-mcp --help
```

如果不在 PATH 中，在 `settings.json` 中使用完整路径：
```json
{
  "mcpServers": {
    "yzcli": {
      "command": "/usr/local/bin/yzcli-mcp",
      "env": {
        "YZCLI_PYTHON": "/usr/bin/python3"
      }
    }
  }
}
```

#### 5. 验证 cowork 部署

```bash
# 1. 确认 yzcli 可用
yzcli config show

# 2. 确认 yzcli-mcp 可用
yzcli-mcp --help

# 3. 确认 ERP 连接正常
yzcli agent run '{"type_key":"customer","operation":"fastquery","input":{"page_no":1,"page_size":1}}' --pretty
```

### Step 6（可选）：复制 docs/ 参考文档

如果希望 Agent 使用「模式 B（项目目录模式）」——通过本地文件读取替代 MCP 调用以加速——需要将 `docs/` 目录复制到 Agent 工作目录下：

```bash
# 在 Agent 工作的项目目录中
mkdir -p docs/
cp -r yzcli/docs/ServiceNameList.md docs/
cp -r yzcli/docs/field-mapping/ docs/field-mapping/
cp -r yzcli/docs/specs/ docs/specs/
```

**不复制 docs/ 也能正常工作**：SKILL.md 已内嵌 Top 15 TypeKey 的操作速查，完整 110 个 TypeKey 在 references/typekey-full-list.md 中。复制 docs/ 只是减少 MCP 调用次数的加速手段。

## 验证部署

### 冒烟测试 1：MCP 工具可用

在 Claude Code 中输入：
```
调用 yzcli_manifest 工具
```

预期：返回包含 110 个 TypeKey 的 JSON 索引。

### 冒烟测试 2：TypeKey 查找（无需 MCP）

在 Claude Code 中输入：
```
报价单的 TypeKey 是什么？
```

预期：Agent 从 references/typekey-full-list.md 中找到 `quotation`，无需调用 MCP。

### 冒烟测试 3：Top 15 TypeKey 快速操作

在 Claude Code 中输入：
```
销售订单的主键字段是什么？
```

预期：Agent 从 SKILL.md 内嵌的操作速查中直接回答 `docNo (IBA001)`，无需调用 MCP。

### 冒烟测试 4：字段查询

在 Claude Code 中输入：
```
调用 yzcli_help 工具，查询 sales.order 的字段
```

预期：返回销售订单的所有字段编号和名称。

### 冒烟测试 5：执行查询

在 Claude Code 中输入：
```
查询最近的销售订单（只要1条）
```

预期：Agent 自动调用 yzcli_run 执行查询，返回订单数据。

### 冒烟测试 6：防幻觉验证

在 Claude Code 中输入：
```
帮我建一个给鼎捷的销售订单
```

预期：
1. Agent 不猜测客户编码
2. Agent 先查询 customer 获取鼎捷的编码
3. Agent 询问缺失的必填信息（品号、数量、单价等）

## 故障排查

| 问题 | 可能原因 | 解决方案 |
|------|---------|---------|
| MCP 工具不可用 | settings.json 配置错误 | 检查 JSON 格式，重启 Claude Code |
| Python 找不到 | PATH 未配置 | 设置 YZCLI_PYTHON 完整路径 |
| ERP 连接失败 | Token 过期或 URL 错误 | `yzcli config set erp.token <new-token>` |
| Skill 未加载 | SKILL.md 未复制 | 确认文件在 ~/.claude/skills/yzcli-erp/ 目录 |
| references/ 找不到 | 未复制 references 目录 | 确认 ~/.claude/skills/yzcli-erp/references/ 存在 |
| Node.js 找不到 | 未安装 Node.js | 安装 Node.js >= 18.0.0 |
| npm install 失败 | 网络问题 | 检查代理设置或使用离线包 |
| Agent 用 curl 调 MCP | 误以为 MCP 是 HTTP API | MCP 使用 stdio 协议，通过 MCP 工具调用，不能用 curl |
| `localhost:8080` 连接失败 | MCP 不监听任何端口 | MCP 通过 stdin/stdout 通信，不开放 HTTP 端口 |
| `ParserError: @ 不能用于表达式` | PowerShell 将 `@` 解析为 Splatting 运算符 | 用单引号包裹：`--json '@file.json'`，或用反引号转义：`` --json `@file.json `` |

### PowerShell `@filename` 语法兼容

yzcli CLI 支持 `@filename` 语法从文件读取 JSON，但 **PowerShell** 会将 `@` 解析为 Splatting 运算符。

| Shell | 正确写法 | 错误写法 |
|-------|---------|---------|
| cmd | `yzcli create sales.order --json @new_order.json` | — |
| bash/zsh | `yzcli create sales.order --json @new_order.json` | — |
| **PowerShell** | `yzcli create sales.order --json '@new_order.json'` | `--json @new_order.json` ❌ |

PowerShell 三种绕过方式：
```powershell
# 方式1：单引号包裹
yzcli create sales.order --json '@new_order.json'

# 方式2：反引号转义
yzcli create sales.order --json `@new_order.json

# 方式3：管道传入
Get-Content new_order.json -Raw | yzcli create sales.order --json -
```

## 目录结构（部署后）

```
客户服务器/
├── yzcli/                          # Python CLI（源码或 pip 安装）
│   ├── src/yzcli/
│   ├── docs/                       # 参考文档（可选复制到 Agent 工作目录）
│   │   ├── ServiceNameList.md      # 110 个 TypeKey 索引
│   │   ├── field-mapping/          # 110 个字段编号↔别名对照
│   │   └── specs/                  # 110 个 CLI 操作规格
│   ├── config.yaml                 # ERP 连接配置
│   └── ...
├── yzcli-mcp/                      # Node.js MCP Server（npm 全局安装）
├── yzcli-agent-skill/              # Skill 包
│   ├── SKILL.md                    # 核心知识文件（唯一入口）
│   ├── references/                 # 扩展文档（按需读取）
│   │   ├── typekey-full-list.md    # 完整 110 个 TypeKey 索引
│   │   ├── field-mapping-matrix.md # 字段映射矩阵
│   │   └── ...
│   └── platforms/                  # 平台适配文档
├── ~/.claude/skills/yzcli-erp/
│   ├── SKILL.md                    # Claude Code Skill（复制自 yzcli-agent-skill/SKILL.md）
│   └── references/                 # 扩展文档（复制自 yzcli-agent-skill/references/）
└── .claude/settings.json           # Claude Code MCP 配置
```

> **关键点**：
> - **SKILL.md 是唯一入口文件**，内嵌 Top 15 TypeKey 操作速查，覆盖最常用业务场景
> - **references/ 目录按需读取**，包含完整 110 个 TypeKey 索引和字段映射
> - **docs/ 目录是否复制取决于使用场景**：
>   - **自包含模式（默认）**：不需要复制 docs/，SKILL + references 已足够
>   - **项目目录模式（加速）**：将 docs/ 复制到 Agent 工作目录下，Agent 可通过本地文件读取替代 MCP 调用

## 维护说明

### 更新 yzcli
```bash
cd yzcli && git pull && pip install -e .
```

### 更新 yzcli-mcp
```bash
npm update -g yzcli-mcp
```

### 更新 Skill
```bash
cp yzcli-agent-skill/SKILL.md ~/.claude/skills/yzcli-erp/
cp -r yzcli-agent-skill/references/ ~/.claude/skills/yzcli-erp/references/
```

### 重新生成 TypeKey 映射
```bash
yzcli agent generate-map
```
