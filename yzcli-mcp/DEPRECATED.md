# ⚠️ DEPRECATED — 已迁移

本目录 (`yzcli-mcp/`) 是旧版 MCP Server，通过 Python subprocess 调用 yzcli CLI。

## 新版本位置

**`packages/yzcli-mcp/`** — SDK-based MCP Server (v0.2.0)

新版本改进：
- 直接调用 `yzcli-sdk` TypeScript SDK，不再依赖 Python CLI
- 支持双传输模式：stdio + HTTP（StreamableHTTP）
- 零 Python 依赖，部署更简单

## 迁移步骤

1. 使用 `packages/yzcli-mcp/` 替代本目录
2. 更新 MCP 配置指向新路径
3. 本目录将在未来版本中移除

## 迁移日期

2026-05-29
