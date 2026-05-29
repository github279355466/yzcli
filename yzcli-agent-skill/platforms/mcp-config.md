# MCP Server 通用配置说明

## 概述

yzcli-mcp 是一个符合 MCP (Model Context Protocol) 标准的服务器，通过 stdio 传输与 AI Agent 通信。任何支持 MCP 协议的 Agent 平台都可以接入。

## 环境要求

- **Node.js**: >= 18.0.0
- **Python**: >= 3.8（yzcli CLI 依赖）
- **yzcli**: 已安装并可正常运行（`pip install -e .`）

## 环境变量

| 变量 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| `YZCLI_PYTHON` | 否 | `python` | Python 可执行文件路径 |
| `YZCLI_ARGS` | 否 | （空） | 附加给 yzcli 的额外参数，空格分隔 |

### 示例：自定义 Python 路径

```bash
# Linux/Mac
export YZCLI_PYTHON=/usr/bin/python3.12
yzcli-mcp

# Windows
set YZCLI_PYTHON=C:\Python312\python.exe
yzcli-mcp
```

## 安装方式

### 方式一：全局安装
```bash
npm install -g yzcli-mcp
```

### 方式二：npx 直接运行（免安装）
```bash
npx yzcli-mcp
```

### 方式三：源码安装
```bash
git clone <repo>
cd yzcli-mcp
npm install
npm run build
node dist/index.js
```

## 各平台配置示例

### Claude Code

项目级 `.claude/settings.json`：
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

### OpenClaw

在 Agent 的 MCP 配置中添加：
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

### 通用 MCP 客户端

任何支持 MCP stdio 传输的客户端，启动命令为：
```
yzcli-mcp
```

服务器通过 stdin/stdout 与客户端通信，无需额外端口配置。

## 提供的工具

| 工具名 | 输入 | 输出 |
|--------|------|------|
| `yzcli_manifest` | 无 | JSON: 业务索引 + schema |
| `yzcli_help` | `{ type_key: string }` | JSON: 字段列表 |
| `yzcli_validate` | `{ request: object }` | JSON: 校验结果 |
| `yzcli_run` | `{ request: object, explain?: boolean }` | JSON: 执行结果 |

## 安全注意事项

- MCP server 通过 stdio 通信，不暴露网络端口
- 所有 ERP 操作通过 yzcli CLI 代理，受 yzcli 的认证和权限控制
- 临时文件在操作完成后自动清理
- 不要在配置文件中明文存储 token（使用 yzcli config 管理）

## 故障排查

### Server 无响应
```bash
# 手动测试 server 是否能启动
yzcli-mcp

# 应该等待 stdin 输入，不会立即退出
# Ctrl+C 退出
```

### CLI 调用失败
```bash
# 验证 yzcli 可正常运行
python -m yzcli --help
python -m yzcli agent manifest --pretty
```

### 权限问题
```bash
# 检查 yzcli 配置
python -m yzcli config show
```
