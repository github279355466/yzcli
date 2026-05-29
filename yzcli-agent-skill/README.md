# yzcli-agent-skill

> 易助 ERP AI Agent Skill — 让 AI Agent 通过 MCP 工具安全、准确地操作 ERP 系统

## 快速安装

将 `SKILL.md` 和 `references/` 目录复制到 Agent 的 skills 目录：

```bash
# Claude Code
mkdir -p ~/.claude/skills/yzcli-erp/
cp yzcli-agent-skill/SKILL.md ~/.claude/skills/yzcli-erp/
cp -r yzcli-agent-skill/references/ ~/.claude/skills/yzcli-erp/references/

# 或者使用 zip 分发包
unzip yzcli-agent-skill-v1.0.zip -d ~/.claude/skills/yzcli-erp/
```

> **SKILL.md 为唯一入口文件**，已内嵌 Top 15 高频 TypeKey 的完整操作速查（含字段编号+英文节点名双格式）。
> references/ 目录包含完整 110 个 TypeKey 索引，Agent 按需读取。

## 架构

```
AI Agent 平台（Claude Code / OpenClaw）
  ├─ SKILL.md（知识层）：意图识别、路由决策、Top 15 操作速查、防幻觉规则
  ├─ references/（扩展层）：完整 TypeKey 列表、字段映射矩阵、JSON 示例
  └─ MCP 工具层（yzcli-mcp）
       └─ subprocess → yzcli CLI → ERP API
```

## 文件结构

```
yzcli-agent-skill/
├── SKILL.md                         # 核心知识文件（唯一入口，~20KB）
├── references/                      # 按需读取的扩展文档
│   ├── typekey-full-list.md         # 完整 110 个 TypeKey 索引
│   ├── field-mapping-matrix.md      # 字段映射矩阵
│   ├── routing-decision-tree.md     # 路由决策树
│   ├── json-construction-examples.md # JSON 组装示例
│   └── hallucination-cases.md       # 幻觉防御案例
├── README.md                        # 本文件
└── yzcli-agent-skill-v1.0.zip       # 分发包
```

## 核心规则摘要

1. **Top 15 TypeKey 内嵌**：SKILL.md 内嵌 15 个最高频 TypeKey 的字段速查，无需 MCP 调用即可组装 JSON
2. **双格式字段**：`docNo (IBA001)` — 英文节点名和字段编号同时标注，ERP OpenAPI 均可接受
3. **日期格式**：一律 YYYYMMDD（无横线斜杠）
4. **字段白名单**：写入用字段编号（IBAxxx），不用别名
5. **先查后写**：猜不到编码就先查询，不编造
6. **结构完整**：创建订单必须有 cdsDetail
7. **缺信息问用户**：不设默认值，不编造数据
8. **错误不改代码**：只调整请求 JSON
9. **换单据重新查**：切换 TypeKey 时重新获取字段

## 两种工作模式

- **自包含模式（默认）**：Agent 在任意目录下工作，TypeKey 从 SKILL 内嵌列表获取，字段从操作速查获取，仅需调用 `yzcli_run`
- **项目目录模式**：Agent 在 YZCLI 项目目录内工作，可读取 `docs/field-mapping/` 和 `docs/specs/` 本地文件，进一步减少 MCP 调用

## 版本

- v2.0 (2026-05-28) — 精简架构：单一 SKILL.md + references/ 按需读取，Top 15 内嵌操作速查
- v1.0 (2026-05-28) — 初始版本（已废弃独立版）
