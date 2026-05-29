# MCP Server + Skill 包实现计划

> 基于已批准的设计规格：`docs/superpowers/specs/2026-05-27-mcp-skill-integration-design.md`

## Context

YZCLI 已完成 Phase A（通用 CLI + Agent 接口），包含 `yzcli agent run/validate/manifest/generate-map`，16 个单元测试全部通过，真实 ERP 联调（sales.order query → get）验证通过。

Phase B 目标：让外部 AI Agent（Claude Code、OpenClaw 等）通过 MCP 协议发现和调用 yzcli 工具，并通过可安装 Skill 包引导 Agent 正确理解自然语言意图、执行 ERP 操作。这是企业级 AI Agent 调用业务 CLI 的最终落地形态。

## 架构概览

```
AI Agent 平台（Claude Code / OpenClaw）
  ├─ Skill（知识层）：意图识别、路由决策、防幻觉规则、JSON 模板
  └─ MCP 工具层（yzcli-mcp，Node.js）
       └─ subprocess → yzcli CLI → ERP API
```

## 已确认设计决策

- MCP server：Node.js 独立项目 `yzcli-mcp/`，TypeScript，stdio transport
- 4 个通用 MCP 工具：`yzcli_manifest`、`yzcli_help`、`yzcli_run`、`yzcli_validate`
- Skill 包：`yzcli-agent-skill/`，SKILL.md 主文件 + references/ 深度参考 + platforms/ 平台适配
- 多平台支持：Claude Code（skill 自动加载）+ OpenClaw（system prompt 导入）优先
- subprocess 封装：MCP → spawn python -m yzcli → stdout JSON
- 全量 YAML：110 个 TypeKey，从 `docs/json节点对照/` 和 `docs/specs/` 自动生成
- 同机部署，Windows，客户有 Python 环境

---

## Phase 1: 全量 YAML 生成 + MCP Server

### 任务 1.1：生成全量 agent_typekey_map.yaml

**目标**：运行 `yzcli agent generate-map`，将 110 个 TypeKey 全部写入 `src/yzcli/data/agent_typekey_map.yaml`

**步骤**：
1. 在项目根目录运行 `python -m yzcli agent generate-map --pretty`
2. 验证生成的 YAML 包含 110 个 typekey 条目
3. 验证每个条目有 `type_key`、`title`、`dll`、`aliases`、`operations`、`operation_aliases`
4. 确认 `sales.order` 条目仍然完整（回归检查）

**验证标准**：
- YAML 文件包含 110 个 typekey
- `python -c "from yzcli.core.agent_mapping import load_builtin_agent_map; m=load_builtin_agent_map(); print(len(m['typekeys']))"` 输出 110
- 现有 16 个单元测试全部通过

---

### 任务 1.2：创建 yzcli-mcp Node.js 项目骨架

**目标**：在项目根目录下创建 `yzcli-mcp/` 目录，初始化 Node.js + TypeScript 项目

**新建文件**：
```
yzcli-mcp/
├── package.json
├── tsconfig.json
├── .gitignore
├── src/
│   └── index.ts              # MCP server 入口（空骨架）
└── README.md
```

**package.json 关键字段**：
- name: `yzcli-mcp`
- version: `0.1.0`
- type: `module`
- bin: `{ "yzcli-mcp": "./dist/index.js" }`
- dependencies: `@modelcontextprotocol/sdk`、`zod`
- devDependencies: `typescript`、`@types/node`
- scripts: `build`（tsc）、`start`（node dist/index.js）

**tsconfig.json**：
- target: ES2022, module: Node16, outDir: dist, rootDir: src, strict: true

**验证标准**：
- `npm install` 成功
- `npm run build` 成功（即使 index.ts 是空骨架）
- `node dist/index.js --help` 不崩溃

---

### 任务 1.3：实现 cli-executor.ts（subprocess 封装）

**目标**：实现统一的 Python CLI 子进程调用封装

**新建文件**：`yzcli-mcp/src/cli-executor.ts`

**实现要点**：
- 读取环境变量 `YZCLI_PYTHON`（默认 `python`）
- 读取环境变量 `YZCLI_ARGS`（可选，附加参数）
- `executeCli(args: string[]): Promise<string>` 函数
  - spawn(python, ['-m', 'yzcli', ...args])
  - 收集 stdout，超时 60s
  - 非零退出码抛出含 stderr 的异常
  - 返回 stdout 字符串
- `executeCliJson(args: string[]): Promise<any>` 辅助函数
  - 调用 executeCli 并 JSON.parse 结果
  - 解析失败时抛出含原始输出的异常

**验证标准**：
- 单独测试 `executeCli(['agent', 'manifest'])` 能返回 JSON 字符串
- 超时场景能正确抛出异常

---

### 任务 1.4：实现 4 个 MCP 工具

**目标**：实现 `yzcli_manifest`、`yzcli_help`、`yzcli_run`、`yzcli_validate`

**新建/修改文件**：
- `yzcli-mcp/src/index.ts` — MCP server 入口，注册 4 个工具
- `yzcli-mcp/src/tools/manifest.ts` — yzcli_manifest 工具
- `yzcli-mcp/src/tools/help.ts` — yzcli_help 工具
- `yzcli-mcp/src/tools/run.ts` — yzcli_run 工具
- `yzcli-mcp/src/tools/validate.ts` — yzcli_validate 工具

**工具定义**：

#### yzcli_manifest
- 输入：无
- 实现：调用 `executeCliJson(['agent', 'manifest'])`
- 输出：JSON（business_index + schema）

#### yzcli_help
- 输入：`{ type_key: string }`（zod 校验）
- 实现：调用 `executeCliJson(['help', type_key, '--output', 'json'])`
- 输出：JSON（字段列表）

#### yzcli_validate
- 输入：`{ request: object }`（zod 校验 request 为非空对象）
- 实现：将 request 写入临时文件，调用 `executeCliJson(['agent', 'validate', '@<tempfile>'])`
- 输出：`{ success: boolean, request?: object, error?: object }`

#### yzcli_run
- 输入：`{ request: object, explain?: boolean }`（zod 校验）
- 实现：将 request 写入临时文件，调用 `executeCliJson(['agent', 'run', '@<tempfile>', ...(explain ? ['--explain'] : [])])`
- 输出：`{ success: boolean, result?: object, error?: object }`

**MCP server 入口（index.ts）**：
```typescript
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";

const server = new McpServer({ name: "yzcli-mcp", version: "0.1.0" });

// 注册 4 个工具...
// 启动 stdio transport
```

**临时文件处理**：
- 使用 `os.tmpdir()` + `crypto.randomUUID()` 创建临时文件
- 写入 JSON → 调用 CLI → 删除临时文件（finally 块）

**验证标准**：
- `npm run build` 成功
- 4 个工具注册成功（server.listTools 返回 4 个）
- 每个工具的输入 schema 正确

---

### 任务 1.5：MCP Server 单元测试

**目标**：为 MCP Server 核心逻辑编写测试

**新建文件**：
- `yzcli-mcp/src/__tests__/cli-executor.test.ts`
- `yzcli-mcp/src/__tests__/tools.test.ts`

**测试框架**：vitest（与 TypeScript + ESM 兼容好）

**cli-executor 测试**：
- 正常调用返回 stdout
- 非零退出码抛出异常
- 超时抛出异常
- JSON 解析失败抛出异常

**tools 测试**：
- mock cli-executor，验证每个工具的输入校验和输出格式
- manifest 工具调用正确的 CLI args
- help 工具传入 type_key
- validate/run 工具正确写入临时文件

**验证标准**：
- `npm test` 全部通过
- 覆盖正常路径和错误路径

---

### 任务 1.6：MCP Server 集成测试

**目标**：验证 MCP server 通过 stdio 协议完整工作

**新建文件**：`yzcli-mcp/src/__tests__/integration.test.ts`

**测试内容**：
- 启动 MCP server 进程
- 通过 stdin 发送 `tools/list` 请求，验证返回 4 个工具
- 通过 stdin 发送 `tools/call` 请求（manifest），验证返回有效 JSON
- 验证错误输入返回正确错误格式

**验证标准**：
- 集成测试通过
- server 进程正确启动和关闭

---

## Phase 2: Skill 包

### 任务 2.1：创建 Skill 包目录结构

**目标**：创建 `yzcli-agent-skill/` 目录结构

**新建文件**：
```
yzcli-agent-skill/
├── SKILL.md                    # 主文件
├── references/
│   ├── field-mapping-matrix.md
│   ├── routing-decision-tree.md
│   ├── json-construction-examples.md
│   └── hallucination-cases.md
├── platforms/
│   ├── claude-code.md
│   ├── openclaw/
│   │   ├── system-prompt.md
│   │   └── skill-import.md
│   └── mcp-config.md
└── README.md
```

---

### 任务 2.2：编写 SKILL.md（核心知识文件）

**目标**：融合 7 个参考文件的核心知识，编写完整的 SKILL.md

**内容来源融合**：

| 来源 | 提取到 SKILL.md 的内容 |
|------|----------------------|
| soul.md | 角色设定、服务查找表（18+ TypeKey）、快速匹配规则、11 条严苛执行准则、自检清单、错误诊断表 |
| skill_routing_architecture.md | 路由决策流程（5 步决策树）、意图分类（5 类）、防上下文泄漏规则 |
| erp_agent_hallucination_defense.md | 5 类幻觉防御规则、白名单约束、先查后写、错误不修代码 |
| erp_json_construction_prompts.md | JSON 组装模板（create/update/query/get/approve）、操作类型字段规则 |
| openclaw_defense_integration_guide.md | 防御性指令块、强制查询流 |
| openclaw_prompt_integration_guide.md | 双管齐下策略 |
| ai_agent_erp_usage_tutorial.md | Agent 思考逻辑闭环 |

**SKILL.md 核心结构**：

```markdown
# yzcli Agent Skill — 易助 ERP AI 助手

## 角色
你是易助 ERP 自动化助手，通过 MCP 工具操作 ERP 系统。

## 可用工具（MCP）
- yzcli_manifest() → 获取业务索引和工具 schema
- yzcli_help(type_key) → 获取指定 TypeKey 的字段明细
- yzcli_validate(request) → 校验请求 JSON 结构
- yzcli_run(request) → 执行 ERP 操作

## 工作流程
### Step 1: 意图识别
### Step 2: 确认 TypeKey（先查 manifest 或用服务查找表）
### Step 3: 获取字段信息（help）
### Step 4: 组装请求 JSON
### Step 5: 校验（validate）
### Step 6: 执行（run）
### Step 7: 格式化结果返回用户

## 服务查找表
（110 个 TypeKey 的别名→TypeKey 映射表，来源 manifest）

## 路由决策流程
（5 步决策树：单据操作→基础资料→数据统计→库存财务→合规检查）

## 快速匹配规则
（纯数字→编号精确匹配，含中文→名称模糊匹配）

## 防幻觉规则（11 条严苛执行准则）
1. 日期格式 YYYYMMDD
2. 禁止添加多余字段
3. 禁止猜测编码（先查后写）
4. 字段白名单（禁止别名）
5. 结构完整性（cdsMaster + cdsDetail）
6. 数据格式化（纯数字，税率小数）
7. 信息缺失必须询问
8. 乱码不猜测
9. 错误不修代码
10. 切换单据重新读取规格
11. 字段不存在强制处理流程

## JSON 组装模板
（各操作的 JSON 结构模板，适配 yzcli agent run 的 request 格式）

## 自检清单
（9 项，提交前逐项检查）

## 错误诊断表
（常见错误 → 原因 → 修复方法）

## 重要说明
- 每次切换单据类型必须重新调用 yzcli_help 获取字段
- 禁止在未确认编码的情况下直接创建单据
- 所有写操作必须先 validate 再 run
```

**验证标准**：
- SKILL.md 内容完整覆盖上述所有章节
- 引用了 yzcli_manifest/help/validate/run 四个工具
- 防幻觉规则完整（11 条）
- 包含可执行的工作流程（非纯理论）

---

### 任务 2.3：编写 references/ 深度参考文档

**目标**：从 7 个参考文件提取深度知识，创建按需引用的参考文档

**新建文件**：

#### references/field-mapping-matrix.md
- 来源：`skill_routing_architecture.md` 的字段映射矩阵
- 内容：TypeKey 前缀→业务含义映射（IBA=单头、IBB=单身、DFA=客户、DEA=商品...）
- 核心字段速查：sales.order、customer、item 的关键字段

#### references/routing-decision-tree.md
- 来源：`skill_routing_architecture.md` 的完整决策树
- 内容：5 层路由、意图分类器、每个分支的详细处理逻辑
- 含数据分析路由规则（API vs DB 直连）

#### references/json-construction-examples.md
- 来源：`erp_json_construction_prompts.md`
- 内容：各操作类型（create/update/query/get/approve）的 JSON 模板
- 含完整示例和字段命名规则
- 适配为 yzcli agent run 的 request 格式

#### references/hallucination-cases.md
- 来源：`erp_agent_hallucination_defense.md`
- 内容：5 类幻觉的典型案例和防御措施
- 含负面测试场景

**验证标准**：
- 每个文件内容准确、无矛盾
- 与 SKILL.md 中的简要规则一致但更详细
- 示例使用 yzcli agent run 格式（非旧的 erp_generic_adapter 格式）

---

### 任务 2.4：编写 platforms/ 平台适配文档

**目标**：为各 Agent 平台提供安装和配置说明

**新建文件**：

#### platforms/claude-code.md
- 安装：将 SKILL.md 复制到 `.claude/skills/`
- MCP 配置：在 `settings.json` 中添加 mcpServers.yzcli
- 验证步骤

#### platforms/openclaw/system-prompt.md
- 来源：融合 `openclaw_defense_integration_guide.md` + `openclaw_prompt_integration_guide.md`
- System Prompt 模板（防御性指令块 + 工具约束）
- 知识库配置说明

#### platforms/openclaw/skill-import.md
- OpenClaw Skill 导入步骤
- 知识库上传说明（service_registry.json + cli_contract.md + SKILL.md）

#### platforms/mcp-config.md
- 通用 MCP server 配置说明
- 环境变量配置（YZCLI_PYTHON）
- 跨平台配置示例（Claude Code / OpenClaw / 其他）

**验证标准**：
- Claude Code 安装步骤可执行
- OpenClaw 配置示例完整
- MCP 配置 JSON 格式正确

---

### 任务 2.5：编写 Skill 包 README.md

**目标**：Skill 包的使用说明

**内容**：
- 项目介绍（MCP + Skill 双层架构）
- 快速安装（Claude Code / OpenClaw）
- 工具列表和用法
- 常见问题
- 版本历史

---

## Phase 3: 文档 + 验收

### 任务 3.1：编写部署指南

**目标**：编写客户服务器部署文档

**新建文件**：`docs/agent-deployment-guide.md`

**内容**：
- 环境要求（Python 3.8+、Node.js 18+、yzcli 已安装）
- yzcli-mcp 安装（npm install -g yzcli-mcp 或 npx）
- yzcli-agent-skill 安装（按平台复制文件）
- Claude Code 配置（settings.json + skill 安装）
- OpenClaw 配置（system prompt + 知识库）
- 验证命令（端到端冒烟测试）
- 故障排查

---

### 任务 3.2：Claude Code 端到端验收

**目标**：在 Claude Code 中完成完整 E2E 验证

**验收场景 1：跨表查询**
```
用户输入："查询鼎捷最近1个月的销售订单"
期望流程：
  Agent 识别"鼎捷"→ customer 表 → 获取编号 → sales.order 查询 → 返回结果
```

**验收场景 2：简单查询**
```
用户输入："看看订单 SO20260525007 的详情"
期望流程：
  Agent 直接 yzcli_run(sales.order get) → 返回详情
```

**验收场景 3：创建（含防幻觉）**
```
用户输入："帮我建一个给鼎捷的销售订单"
期望行为：
  Agent 不猜测客户编号 → 先查 customer
  Agent 不编造商品和单价 → 询问用户
  询问必填缺失字段
```

**验收场景 4：审核**
```
用户输入："审核订单 SO20260525007"
期望流程：
  Agent yzcli_run(sales.order approve) → 返回审核结果
```

---

### 任务 3.3：OpenClaw 端到端验收

**目标**：在 OpenClaw 中完成 E2E 验证（与 3.2 相同场景）

**前置条件**：
- OpenClaw 平台可访问
- MCP server 已配置
- Skill 已导入

---

### 任务 3.4：更新项目文档

**目标**：更新 YZCLI 项目根目录文档

**修改文件**：
- `README.md` — 新增 MCP Server 和 Skill 包说明
- `CLAUDE.md` — 新增 MCP/Skill 相关路径和命令

---

## 实施顺序（推荐）

| 顺序 | 任务 | 依赖 | 预估 |
|------|------|------|------|
| 1 | 1.1 全量 YAML 生成 | 无 | 5 min |
| 2 | 1.2 Node.js 项目骨架 | 无 | 15 min |
| 3 | 1.3 cli-executor.ts | 1.2 | 20 min |
| 4 | 1.4 四个 MCP 工具 | 1.3 | 40 min |
| 5 | 1.5 单元测试 | 1.4 | 30 min |
| 6 | 1.6 集成测试 | 1.4 | 20 min |
| 7 | 2.1 Skill 目录结构 | 无 | 5 min |
| 8 | 2.2 SKILL.md 核心文件 | 2.1 | 60 min |
| 9 | 2.3 references/ 文档 | 2.1 | 40 min |
| 10 | 2.4 platforms/ 文档 | 2.1 | 30 min |
| 11 | 2.5 Skill README | 2.2-2.4 | 10 min |
| 12 | 3.1 部署指南 | 1.4, 2.2 | 30 min |
| 13 | 3.2 Claude Code E2E | 1.4, 2.2 | 30 min |
| 14 | 3.3 OpenClaw E2E | 1.4, 2.4 | 30 min |
| 15 | 3.4 更新项目文档 | 全部 | 15 min |

**可并行**：任务 1.1-1.6（MCP）与任务 2.1-2.5（Skill）可并行开发

---

## 风险控制

| 风险 | 措施 |
|------|------|
| MCP subprocess 开销 | ERP API 本身耗时数百毫秒，subprocess 开销可忽略 |
| Skill 内容过长超出 LLM 上下文 | 核心规则放 SKILL.md，深度参考放 references/ 按需引用 |
| 不同 Agent 平台 LLM 能力差异 | 通过 validate 工具做结构校验兜底 |
| generate-map 覆盖不全 | 当前 110 个 TypeKey 已有完整文档，缺失的后续补充 |
| Node.js 环境差异 | 通过 npx 免安装运行，减少环境依赖 |
| 临时文件清理 | MCP tools 在 finally 块中确保删除临时文件 |

## 测试计划

### MCP Server 测试
```bash
cd yzcli-mcp
npm test                    # vitest 单元测试
npm run build               # TypeScript 编译
node dist/index.js --help   # 冒烟测试
```

### Skill 包验证
- SKILL.md 内容完整性检查
- references/ 交叉引用一致性检查
- platforms/ 配置示例 JSON 格式验证

### 端到端验收
- Claude Code：安装 MCP + Skill → 用户输入 → Agent 调用 → 结果
- OpenClaw：配置 System Prompt + 知识库 → 用户输入 → Agent 调用 → 结果
