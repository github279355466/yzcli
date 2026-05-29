# MCP Server + Skill 集成设计

> 版本: 1.0 | 日期: 2026-05-27

## 1. 目标

让外部 AI Agent（Claude Code、OpenClaw 等）能够：
- 自动发现 yzcli 工具（通过 MCP 协议）
- 正确地将自然语言转化为 ERP 操作（通过可安装 Skill）
- 安全、准确地执行查询和写入操作

## 2. 约束

- 同机部署：Agent 和 CLI 在同一台 Windows 服务器
- 多平台：Claude Code + OpenClaw 优先，其他 MCP 兼容平台后续适配
- 自然语言理解：依赖 Agent 平台的 LLM，不内置 LLM
- 跨表查询：Skill 引导多步查询，不内置解析工具
- 部署：pip install + npm install，客户服务器有 Python 环境

## 3. 架构

### 3.1 分层模型

```
客户服务器（Windows）
┌─────────────────────────────────────────────────────┐
│  AI Agent 平台（Claude Code / OpenClaw / 其他）       │
│  ┌─────────────────────────────────────────────┐     │
│  │  LLM + Skill（知识层）                       │     │
│  │    - 意图分类 → TypeKey + Operation          │     │
│  │    - 防幻觉规则 → 白名单、先查后写          │     │
│  │    - 跨表查询引导 → 客户名→编号              │     │
│  │    - 自检清单 → 日期、字段、格式             │     │
│  └──────────────────┬──────────────────────────┘     │
│                     │ MCP 协议（stdio）               │
│  ┌──────────────────▼──────────────────────────┐     │
│  │  yzcli-mcp-server（Node.js，工具层）          │     │
│  │    yzcli_manifest()   → subprocess           │     │
│  │    yzcli_help(key)    → subprocess            │     │
│  │    yzcli_run(request) → subprocess            │     │
│  │    yzcli_validate(req) → subprocess           │     │
│  └──────────────────┬──────────────────────────┘     │
│                     │ subprocess                       │
│  ┌──────────────────▼──────────────────────────┐     │
│  │  yzcli（Python CLI）                         │     │
│  │    yzcli agent manifest/validate/run          │     │
│  │    yzcli help <type_key> --output json        │     │
│  └──────────────────┬──────────────────────────┘     │
│                     │ HTTP API                         │
│  ┌──────────────────▼──────────────────────────┐     │
│  │  易助 ERP OpenAPI 服务器                       │     │
│  └─────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────┘
```

### 3.2 Skill 与 MCP 的职责分工

| 层次 | 职责 | 解决什么问题 |
|------|------|-------------|
| Skill（知识层） | 意图识别、路由决策、防幻觉规则、组装模板、错误诊断 | Agent 什么时候用、怎么用 |
| MCP（工具层） | 工具发现、参数校验、执行调用、结果返回 | Agent 调用什么、怎么调 |

### 3.3 数据流示例

用户输入："查询鼎捷最近1个月的销售订单"

```
Skill 引导 Agent 思考：
  ① "销售订单" → sales.order（服务查找表）
  ② "查询" → query 操作（操作别名）
  ③ "鼎捷" → 客户名，需先查编号（先查后写规则）
  ④ "最近1个月" → 日期 > 2026/04/27（日期转换规则）

Agent 调用 MCP 工具：
  ⑤ yzcli_manifest() → 确认 sales.order 和 customer 存在
  ⑥ yzcli_help("customer") → 获取客户字段 DFA003（全名）
  ⑦ yzcli_run({customer query, DFA003 like 鼎捷}) → C0092
  ⑧ yzcli_help("sales.order") → 获取订单字段
  ⑨ yzcli_run({sales.order query, IBA004=C0092, IBA003>=2026/04/27})

Agent 格式化结果返回用户
```

## 4. MCP Server 设计

### 4.1 项目结构

```
yzcli-mcp/
├── package.json
├── tsconfig.json
├── src/
│   ├── index.ts              # MCP server 入口（stdio transport）
│   ├── tools/
│   │   ├── manifest.ts       # yzcli_manifest 工具
│   │   ├── help.ts           # yzcli_help 工具
│   │   ├── run.ts            # yzcli_run 工具
│   │   └── validate.ts       # yzcli_validate 工具
│   └── cli-executor.ts       # 统一 subprocess 封装
└── README.md
```

### 4.2 工具定义

| 工具 | 输入 | 输出 | 描述 |
|------|------|------|------|
| `yzcli_manifest` | 无 | JSON（业务索引 + schema） | 获取所有可用 TypeKey 和操作 |
| `yzcli_help` | `type_key: string` | JSON（字段列表） | 获取指定 TypeKey 的字段明细 |
| `yzcli_validate` | `request: object` | `{success, request/error}` | 校验请求结构 |
| `yzcli_run` | `request: object`, `explain?: boolean` | `{success, result/error}` | 执行 ERP 操作 |

### 4.3 cli-executor 封装

```typescript
async function executeCli(args: string[]): Promise<string> {
  // 1. 通过环境变量 YZCLI_PYTHON 获取 Python 路径（默认 python）
  // 2. spawn(python, ['-m', 'yzcli', ...args])
  // 3. 收集 stdout，超时 60s
  // 4. 返回 stdout 字符串
  // 5. 非零退出码时抛出含 stderr 的异常
}
```

### 4.4 配置方式

Claude Code settings.json:
```json
{
  "mcpServers": {
    "yzcli": {
      "command": "npx",
      "args": ["-y", "yzcli-mcp"],
      "env": {
        "YZCLI_PYTHON": "python"
      }
    }
  }
}
```

## 5. Skill 设计

### 5.1 核心来源

Skill 内容从 7 个参考文件中提取核心知识，适配新的 MCP 工具调用方式：

| 来源文件 | 提取内容 |
|---------|---------|
| soul.md | 角色设定、服务查找表、快速匹配规则、11 条严苛执行准则、自检清单 |
| skill_routing_architecture.md | 4 层路由模型、意图分类器、决策树、字段映射矩阵、防上下文泄漏 |
| erp_agent_hallucination_defense.md | 5 类幻觉防御、白名单约束、先查后写、错误不修代码 |
| erp_json_construction_prompts.md | JSON 组装模板、操作类型字段规则、强制校验逻辑 |
| openclaw_defense_integration_guide.md | 防御性 System Prompt 模板 |
| openclaw_prompt_integration_guide.md | 双管齐下策略（提示词+知识库） |
| ai_agent_erp_usage_tutorial.md | Agent 思考逻辑闭环 |

### 5.2 Skill 包结构

```
yzcli-agent-skill/
├── SKILL.md                    # 主文件（Claude Code 自动加载）
├── references/
│   ├── field-mapping-matrix.md
│   ├── routing-decision-tree.md
│   ├── json-construction-examples.md
│   └── hallucination-cases.md
├── platforms/
│   ├── claude-code.md          # Claude Code 安装说明
│   ├── openclaw/
│   │   ├── system-prompt.md    # OpenClaw System Prompt 模板
│   │   └── skill-import.md     # OpenClaw Skill 导入说明
│   └── mcp-config.md           # MCP server 配置说明
└── README.md
```

### 5.3 SKILL.md 核心结构

```markdown
# yzcli Agent Skill — 易助 ERP AI 助手

## 角色
你是易助 ERP 自动化助手，通过 MCP 工具操作 ERP 系统。

## 可用工具（MCP）
- yzcli_manifest() → 获取业务索引
- yzcli_help(type_key) → 获取字段明细
- yzcli_validate(request) → 校验请求
- yzcli_run(request) → 执行操作

## 服务查找表
| 用户说 | TypeKey |
|--------|---------|
| 销售订单、订单 | sales.order |
| 客户 | customer |
| ... | ... |
（动态来源：yzcli_manifest() 的 business_index）

## 路由决策流程
（来自 skill_routing_architecture.md 的决策树）

## 快速匹配规则
（来自 soul.md：纯数字→编号精确匹配，含中文→名称模糊匹配）

## 防幻觉规则
1. 禁止脑补字段名
2. 先查后写（客户名→编号）
3. 日期格式 YYYYMMDD
4. 禁止猜测编码
5. 缺失信息必须询问
6. 错误不修代码
7. 不猜乱码
（来自 hallucination_defense.md 的 5 类防御）

## JSON 组装模板
（来自 construction_prompts.md 的各操作模板，
  适配为 yzcli agent run 的 request 格式）

## 自检清单
（11 条，来自 soul.md，适配 MCP 工具调用）

## 错误诊断表
（来自 soul.md + hallucination_defense.md）
```

### 5.4 安装方式

| 平台 | 安装 | 效果 |
|------|------|------|
| Claude Code | 复制 SKILL.md 到 `.claude/skills/` | Agent 自动加载 |
| OpenClaw | 导入 Skill 包或粘贴 System Prompt | Agent 配置中生效 |
| 其他 MCP 平台 | 配置 MCP server + 粘贴提示词 | 手动配置 |

## 6. 全量 YAML 生成

运行 `yzcli agent generate-map` 从 `docs/json节点对照/` 和 `docs/specs/` 生成全量 `agent_typekey_map.yaml`，覆盖 100+ TypeKey。

## 7. 实施顺序

### Phase 1: 基础闭环
1. 运行 generate-map 生成全量 YAML
2. 创建 yzcli-mcp Node.js 项目骨架
3. 实现 cli-executor.ts（subprocess 封装）
4. 实现 4 个 MCP 工具
5. 单元测试 + 集成测试

### Phase 2: Skill 包
6. 编写 SKILL.md（融合 7 个参考文件核心知识）
7. 编写 references/（深度参考文档）
8. 编写 platforms/（Claude Code + OpenClaw 适配）

### Phase 3: 文档 + 验收
9. 编写 docs/agent-deployment-guide.md
10. Claude Code 端到端验收（安装 MCP + Skill → 用户输入 → Agent 调用 → 结果）
11. OpenClaw 端到端验收

## 8. 端到端验收场景

### 场景 1：查询（含跨表）
用户："查询鼎捷最近1个月的销售订单"

期望：
- Agent 识别"鼎捷"是客户名 → 先查 customer 表
- 获取客户编号后构造订单查询条件
- 日期格式正确（YYYYMMDD 或 YYYY/MM/DD）
- 返回结果用中文格式化

### 场景 2：查询（简单）
用户："看看订单 SO20260525007 的详情"

期望：
- 直接调用 yzcli_run(sales.order get)
- 返回单头 + 明细

### 场景 3：创建（含防幻觉）
用户："帮我建一个给鼎捷的销售订单"

期望：
- Agent 不猜测客户编号 → 先查 customer
- Agent 不编造商品和单价 → 询问用户
- 询问必填缺失字段

### 场景 4：审核
用户："审核订单 SO20260525007"

期望：
- 调用 yzcli_run(sales.order approve)
- 返回审核结果

## 9. 风险控制

| 风险 | 措施 |
|------|------|
| MCP subprocess 开销 | ERP API 本身耗时数百毫秒，subprocess 开销可忽略 |
| Skill 内容过长超出 LLM 上下文 | 核心规则放 SKILL.md，深度参考放 references/ 按需引用 |
| 不同 Agent 平台 LLM 能力差异 | 通过 validate 工具做结构校验兜底 |
| generate-map 覆盖不全 | 当前只生成有文档的 TypeKey，缺失的后续补充文档 |
| 旧 Skill 与新 MCP 工具的字段格式差异 | 新 Skill 统一使用 yzcli agent run 的 request 格式 |
