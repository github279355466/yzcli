# 易助ERP OpenAPI CLI 工具

类似 cli-anything 的通用 ERP 命令行工具，基于易助 OpenAPI 接口。

## ✨ 特性

- 🧠 **通用架构** - 一次编码，支持所有单据类型（通过 help 服务动态发现
- 🔄 **字段双向映射** - 支持字段编号 (RCA001) 和英文节点名 (category) 切换
- 📊 **多种输出格式** - Table/JSON/CSV
- ⚡ **智能缓存** - TypeKey 元数据自动缓存
- 🔍 **丰富查询语法** - 支持 AND/OR 组合查询
- 📝 **结构化日志** - 记录 API 请求、响应、错误和调试信息
- 🤖 **AI Agent 接口** - 结构化 JSON 入口，供外部 AI Agent 直接调用（manifest/validate/run）
- 🔌 **MCP Server** - Node.js MCP 服务器，AI Agent 通过标准协议发现和调用 ERP 工具
- 📚 **Agent Skill** - 可安装的知识包，引导 AI Agent 正确理解自然语言并执行 ERP 操作

## 🚀 快速开始

### 安装

```bash
pip install -e .
```

### 配置

复制配置文件到 `~/.yzcli/config.yaml`：

```yaml
erp:
  base_url: http://172.16.6.22:8103
  user_token: your_token_here
  timeout: 30

field_mode: english_name  # 或 field_number

output:
  format: table
  page_size: 20
  pretty_print: true

cache:
  enabled: true
  ttl: 86400

log:
  enabled: true
  level: INFO
  dir: ""        # 空则使用 ~/.yzcli/logs/
  max_days: 7
  console: false
```

### 或使用命令行参数覆盖：
```bash
yzcli config set base_url http://192.168.1.100:8103
```

## 📖 使用示例

### 发现所有可用单据类型
```bash
yzcli discover
```

### 查询销售订单
```bash
# 基本查询
yzcli query sales.order --customer 000002 --page-size 10

# 复杂条件
yzcli query sales.order \
  --condition "customer like KH000%" \
  --condition "qty > 10" \
  --order-by date:desc
```

### 新增单据
```bash
# 从 JSON 文件创建
yzcli create sales.order --json @new_order.json

# 交互模式（引导式输入）
yzcli create sales.order --interactive
```

### 读取单据
```bash
yzcli get wo.stock.in --docNo 20250218000001 --category 84
```

### 审核/撤审
```bash
yzcli approve wo.stock.in --docNo 20250218000001 --category 84
yzcli disapprove wo.stock.in --docNo 20250218000001 --category 84
```

### 更新/删除
```bash
yzcli update sales.order --json @update.json
yzcli delete sales.order --docNo 20250218000001
```

### 查看单据字段帮助
```bash
yzcli help sales.order
yzcli help sales.order --required-only
```

### 日志与排错
```bash
# 查看日志配置
yzcli config show

# 开启 DEBUG 日志级别
yzcli config set log.level DEBUG

# 禁用日志
yzcli config set log.enabled false
```

默认日志文件位于 `~/.yzcli/logs/yzcli_YYYYMMDD.log`，记录 API 请求、响应、错误和 `--debug` 调试信息。日志默认保留 7 天；命令带 `--debug` 时，本次执行会临时切换为 DEBUG 级别。

### AI Agent 集成

`yzcli agent` 提供结构化 JSON 接口，外部 AI Agent 无需解析人类文本即可调用 ERP：

```bash
# 1. 获取工具 schema 和业务索引
yzcli agent manifest --pretty

# 2. 校验请求 JSON
yzcli agent validate @request.json --pretty

# 3. 执行请求
yzcli agent run @request.json --pretty

# 4. 执行并附带路由解释
yzcli agent run @request.json --pretty --explain
```

支持从文件（`@request.json`）和 stdin（`-`）读取 JSON 输入。请求格式示例：

```json
{
  "type_key": "sales.order",
  "operation": "fastquery",
  "input": {
    "page_no": 1,
    "page_size": 10
  }
}
```

支持 7 种操作：`fastquery`、`getMultiple`、`create`、`update`、`delete`、`approve`、`disapprove`。

完整协议、schema、错误对象和联调流程见 [AI Agent CLI 集成文档](docs/agent-cli-integration.md)。

### MCP Server + Skill（AI Agent 自动调用）

通过 MCP 协议和可安装 Skill，AI Agent（Claude Code、Codex 等）可以自动发现和调用 yzcli 工具。

**新架构（推荐）**：MCP Server 使用 TypeScript SDK 直接调用 ERP API，不再依赖 Python CLI。

```bash
# 构建 MCP Server（SDK-based）
cd packages/yzcli-mcp && npm install && npm run build

# 安装 Skill（Claude Code）
cp yzcli-agent-skill/SKILL.md ~/.claude/skills/yzcli-erp/SKILL.md
cp -r yzcli-agent-skill/references/ ~/.claude/skills/yzcli-erp/references/
```

**模式 A — 集中式 HTTP 网关（推荐）**：
```bash
# ERP 服务器启动 MCP 网关
node packages/yzcli-mcp/dist/index.js --http --port 3000
```
```json
// 客户端 .claude/settings.json
{ "mcpServers": { "yzcli": { "url": "http://erp-server:3000/mcp" } } }
```

**模式 B — 本地 stdio**：
```json
// .claude/settings.json
{ "mcpServers": { "yzcli": { "command": "yzcli-mcp" } } }
```

然后在 Claude Code 中直接用自然语言操作 ERP：
- "查询鼎捷最近1个月的销售订单"
- "看看订单 SO20260525007 的详情"
- "帮我建一个给鼎捷的销售订单"

详细部署指南见 [AI Agent 部署指南](docs/agent-deployment-guide.md)。

## 🔧 配置项

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| field_mode | 字段模式: english_name 或 field_number | english_name |
| output.format | 输出格式: table/json/csv | table |
| output.page_size | 默认分页大小 | 20 |
| cache.enabled | 是否启用缓存 | true |
| cache.ttl | 缓存过期时间 (秒) | 86400 |
| log.enabled | 是否启用日志 | true |
| log.level | 日志级别: DEBUG/INFO/WARNING/ERROR | INFO |
| log.dir | 日志目录（空则 ~/.yzcli/logs/） | "" |
| log.max_days | 日志保留天数 | 7 |
| log.console | 是否同时输出到控制台 | false |

## 📁 参考文档

`docs/` 目录包含完整的 OpenAPI 参考文档和字段映射资料：

| 目录/文件 | 说明 |
|-----------|------|
| `docs/agent-cli-integration.md` | AI Agent CLI 集成协议文档 |
| `docs/agent-deployment-guide.md` | AI Agent 部署指南（MCP + Skill） |
| `docs/易助OpenAPI使用说明/` | OpenAPI 官方使用说明，包含安装部署、服务说明、范例等 |
| `docs/specs/` | 各单据类型的 CLI 操作规格说明（100+ 单据） |
| `docs/field-mapping/` | 字段编号与英文节点名（jsonName）的对照表，按单据类型分文件 |
| `docs/ServiceNameList.md` | 所有可用的 ServiceName 列表 |
| `docs/delphiprg/` | Delphi 程序参考源码 |

> **提示**：当服务器未开启英文节点配置时，`jsonName` 返回的是字段编号（如 IBA001）而非英文名（如 docNo）。
> 此时可通过 `docs/json节点对照/` 目录下的对照文档查找字段编号与英文名的对应关系。

## 📝 项目结构

```
yzcli/
├── packages/
│   ├── yzcli-sdk/              # TypeScript SDK（共享库）
│   ├── yzcli-mcp/              # MCP Server（stdio + HTTP 网关）
│   └── yzcli-cli/              # TypeScript CLI（commander.js）
├── src/yzcli/                  # Python CLI（deprecated）
├── yzcli-agent-skill/          # AI Agent Skill 包
├── tests/                      # Python 测试
├── docs/                       # 文档
├── package.json                # npm workspaces 根配置
└── README.md
```

## 🔐 安全建议

- 将 `user_token` 存储在安全位置，配置文件中，不要提交到版本控制
- 建议使用测试环境先验证所有操作
- 生产环境操作前先使用 `--dry-run` 选项验证

## 📄 License

MIT
