# Agent Swarm Coordinator

让 OpenClaw 能够管理一群 AI 编程代理，实现双层架构：OpenClaw（编排层）+ AI Agents（执行层）。

---

## 快速开始

### 1. 基础配置

修改 `config.example.json`：

```json
{
  "main_repo_path": "$HOME/Projects/my-project",
  "worktrees_path": "$HOME/Projects/.worktrees"
}
```

复制并重命名为 `config.json`

### 2. 启动第一个任务

```bash
# 修改脚本顶部的配置区域
# TASK_NAME="你的任务名称"
# PRIMARY_AGENT="claude"  # 或 codex/gemini

# 运行脚本
bash start-task.sh
```

### 3. 启动监控

```bash
# 在另一个终端运行
bash monitor.sh
```

---

## 核心概念

### 双层架构

| 层级 | 角色 | 功能 |
|------|------|------|
| **OpenClaw（编排层）** | 主厨 | 知道客人口味、食材库存、菜单定位 |
| **AI Agents（执行层）** | 专业厨师 | 专注做菜（写代码） |

### 代理类型

| 代理 | 类型 | 用途 | 适用场景 |
|------|------|------|----------|
| **Codex** | 主力 | 后端逻辑、复杂 bug、多文件重构、跨代码库推理 | 占 90% 任务 |
| **Claude Code** | 速度型 | 前端工作、git 操作、权限问题 | 速度快 |
| **Gemini** | 设计型 | UI/UX 优化、生成规范 | 漂亮 UI |

---

## 工作流示例

### 场景 1：功能开发

```
1. 用户: "帮我实现用户登录功能"
2. OpenClaw: 分析会议记录，理解需求
3. OpenClaw: 创建 worktree，安装依赖
4. OpenClaw: 选择 Claude Code（适合 git 操作）
5. OpenClaw: 启动后台代理
6. Claude Code: 开发功能、提交代码
7. OpenClaw: 检测到 PR 创建
8. OpenClaw: 触发自动 code review
9. Codex/Gemini/Claude Reviewer: 并行审查
10. OpenClaw: 通知用户 "PR 准备好了"
11. 用户: 人工 review（5-10 分钟）
12. OpenClaw: 合并 PR
```

### 场景 2：主动发现任务

```
早上:
1. OpenClaw: 扫描 Sentry
2. 发现 4 个错误
3. 启动 4 个 Agent 调查

晚上:
1. OpenClaw: 扫描会议记录
2. 发现 3 个需求
3. 启动 3 个 Codex
```

---

## 文件说明

### AGENT-SWARM-COORDINATOR.md
核心文档，包含：
- 功能特性
- 使用方法
- 配置建议
- 安全注意事项
- 故障排查

### config.example.json
配置文件模板，包含：
- 代理定义（Codex/Claude/Gemini）
- 工作空间配置
- 监控设置
- Code Review 设置

### start-task.sh
启动脚本，用于：
- 创建 git worktree
- 安装依赖
- 启动 tmux 会话和代理
- 记录任务信息

**配置方法：**
编辑脚本顶部的配置区域：
```bash
MAIN_REPO_PATH="$HOME/Projects/my-project"
TASK_NAME="feat-user-login"
PRIMARY_AGENT="claude"
```

### monitor.sh
监控脚本，功能：
- 每 10 分钟检查一次代理状态
- 检查 tmux 会话是否存活
- 失败自动重试（最多 3 次）
- 超过重试次数通知用户

---

## tmux 常用命令

### 基本操作

```bash
# 附加到会话
tmux attach-session -t agent-claude

# 发送命令到代理
tmux send-keys -t agent-claude "你的命令"

# 分离会话（代理继续运行）
tmux detach-client -s agent-claude

# 列出所有会话
tmux list-sessions

# 杀掉会话
tmux kill-session -t agent-claude
```

### 中途干预

```bash
# 代理走偏了，需要停下来
tmux send-keys -t agent-claude C-c

# 停一下，先看 API 别管 UI
tmux send-keys -t agent-claude "停一下。客户要的是 X，不是 Y"

# 类型定义再继续
tmux send-keys -t agent-claude "继续。重点做配置复用"
```

---

## 任务追踪

### 任务状态

- `running`: 正在运行
- `failed`: 失败
- `completed`: 已完成

### 任务信息

每个任务记录包含：
- `id`: 唯一标识
- `name`: 任务名称
- `agent`: 使用的代理
- `tmux_session`: tmux 会话名
- `timestamp`: 创建时间
- `status`: 当前状态
- `retry_count`: 重试次数

### 查看任务

```bash
# 使用 jq 查看所有任务
cat $HOME/agent-tasks.json | jq '.[]'

# 查看运行中的任务
cat $HOME/agent-tasks.json | jq '.[] | select(.status == "running")'

# 查看特定任务
cat $HOME/agent-tasks.json | jq '.[] | select(.id == "task-xxx")'
```

---

## 动态 Prompt 学习

系统会根据失败原因调整 prompt：

### 失败场景

1. **API 配额用完**
   - 调整：等待重置，或切换到另一个代理

2. **类型错误**
   - 调整：添加类型定义文件路径，让 agent 先读取类型

3. **依赖冲突**
   - 调整：先清理 node_modules，再重新安装

4. **超时**
   - 调整：简化任务描述，分批执行

### 成功模式

系统会记录成功的 prompt 模式：
- "这个 prompt 结构对账单功能很有效"
- "Codex 需要提前拿到类型定义"
- "总是要包含测试文件路径"

这些记录用于未来的 prompt 优化。

---

## 性能优化

### RAM 限制

| RAM | 最大并行 Agents |
|-----|---------------|
| 8GB  | 2-3            |
| 16GB | 4-5            |
| 32GB | 6-8            |
| 64GB | 10-12          |

### 优化建议

1. **根据 RAM 选择 Agent 数量**
2. **使用更轻量的代理（优先 Claude Code）**
3. **使用 tmux 代替多个终端会话**
4. **定期清理已完成的工作空间**

---

## 故障排查

### 问题：Agent 不响应

```bash
# 检查 tmux 会话状态
tmux list-sessions

# 查看 agent 输出日志
# 检查 tmux 会话的 pane
tmux capture-pane -p agent-claude -t agent-claude

# 发送中断信号
tmux send-keys -t agent-claude C-c
```

### 问题：CI 一直失败

```bash
# 检查是否是语法错误（先运行 lint）
# 查看 CI 日志中的具体错误信息
# 生成错误日志供 agent 分析
```

### 问题：RAM 不足

```bash
# 减少同时运行的 Agent 数量
# 使用更轻量的代理
# 重启 OpenClaw 释放内存
```

---

## 与 OpenClaw 集成

### 给 OpenClaw 的提示

你可以这样告诉 OpenClaw：

```
"我需要实现一个新功能。请使用 agent-swarm-coordinator skill 来：

1. 为这个功能创建一个新的 worktree
2. 选择 Claude Code 作为主力代理（这个功能需要大量 git 操作）
3. 启动后台代理会话
4. 生成包含完整需求的 prompt
5. 启动监控脚本"
```

### 期望的响应

OpenClaw 应该：
1. 创建独立的 worktree
2. 启动 tmux 会话
3. 运行 Claude Code
4. 每 10 分钟监控状态
5. 失败时调整 prompt 重试
6. 完成后通知你进行人工 review

---

## 高级功能

### 主动任务发现

系统会主动寻找工作：

**早上：**
- 扫描 Sentry（或你的错误监控服务）
- 发现错误 → 启动 Agent 调查

**会议后：**
- 扫描会议记录（需要 obsidian skill）
- 发现需求 → 启动 Codex

**晚上：**
- 扫描 git log
- 启动 Claude Code 更新文档

### Code Review 自动化

每个 PR 会被三个 AI reviewer 审查：

1. **Codex Reviewer**
   - 边界情况
   - 逻辑错误
   - 错误处理

2. **Gemini Reviewer**
   - 安全问题
   - 扩展性
   - 具体修复建议

3. **Claude Code Reviewer**
   - 基本跳过（过度谨慎）

都批准后才通知你进行人工 review（5-10 分钟）。

---

## 安全最佳实践

### 1. 最小权限原则

每个 Agent 只获得必要的权限：
- 只读权限优先
- 不给 Agent 直接写入权限（除非必要）

### 2. 敏感信息隔离

- 编排层（OpenClaw）访问所有业务上下文
- 执行层（Agents）只看到代码和测试环境
- Agents 不接触生产数据库

### 3. 人工审批关键操作

以下操作需要人工确认：
- 创建 PR
- 合并到主分支
- 部署到生产环境

### 4. 定期清理

- 每天清理孤立的 worktree
- 归档完成的任务
- 保留重要的失败案例用于学习

---

## 参考

**基础文章：** memory/openclaw-claude-code-integration.md
**实战用例：** memory/openclaw-10-insane-use-cases.md

---

## 许可

MIT License - 自由使用、修改和分发
