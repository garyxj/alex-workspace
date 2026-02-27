# Agent Swarm Coordinator - OpenClaw Skill

**作者:** Alex (OpenClaw Agent)
**基于:** OpenClaw + Claude Code 强强联手实战案例
**版本:** 1.0.0

---

## 概述

这个 Skill 让 OpenClaw 能够管理一群 AI 编程代理（Codex、Claude Code、Gemini Code 等），实现一个完整的 Agent 集群系统。

**核心理念：**
- OpenClaw = 主厨（编排层，知道客人口味、食材库存、菜单定位）
- AI Agents = 专业厨师（专注做菜，写代码）

---

## 功能特性

### 1. 工作空间隔离
- 为每个任务创建独立的 git worktree
- 避免不同任务之间的干扰和冲突
- 支持并行处理多个项目

### 2. 后台代理管理
- 使用 tmux 创建持久化会话
- 代理在后台运行，OpenClaw 可以中途干预
- 支持启动/停止/重启特定代理

### 3. 自动监控
- 每 10 分钟检查一次所有代理状态
- 检查：tmux 会话状态、PR 创建情况、CI 状态
- 失败自动重启（最多重试 3 次）
- 只在需要人工介入时通知

### 4. 智能任务分配
- 根据任务类型自动选择合适的代理：
  - **Codex (gpt-5.3-codex):** 主力
    - 后端逻辑、复杂 bug、多文件重构、跨代码库推理
    - 占 90% 任务
  - **Claude Code (claude-opus-4.5):** 速度型
    - 前端工作、git 操作、权限问题
    - 速度快，适合 git 操作
  - **Gemini:** 设计型
    - 有设计审美
    - 漂亮 UI：先 Gemini 生成 HTML/CSS 规范，再交给 Claude Code 实现

### 5. 自动 Code Review
- 三个 AI reviewer 并行审查每个 PR：
  - **Codex Reviewer:** 边界情况、逻辑错误、错误处理、竞态条件
  - **Gemini Reviewer:** 安全问题、扩展性、具体修复建议
  - **Claude Code Reviewer:** 基本跳过（过度谨慎）

### 6. 任务记录
- 记录每个任务到 JSON 文件
- 包含：任务 ID、tmux 会话、使用的代理、开始时间、状态
- 支持 `tmux send-keys` 中途调整

---

## 使用方法

### 基础工作流

1. **理解需求**
   ```
   告诉 OpenClaw："帮我实现一个用户登录功能。需求在会议记录里。"
   ```

2. **分配任务**
   ```
   "基于这个需求，为这个任务创建 worktree，选择合适的代理开始开发。"
   ```

3. **监控进度**
   ```
   "每10分钟检查一次代理状态。失败了就调整 prompt 重试。"
   ```

4. **Code Review**
   ```
   "PR 创建后，让三个 AI reviewer 审查。都批准后通知我人工 review。"
   ```

5. **合并**
   ```
   "CI 通过、三个 reviewer 批准、有 UI 截图，就合并 PR。"
   ```

---

## 高级功能

### 动态 Prompt 学习

当 Agent 失败时，系统会分析失败原因并重写 prompt：

**坏例子（静态 prompt）：**
```
"实现自定义模板功能？"
```

**好例子（动态调整）：**
```
"停一下。客户要的是 X，不是 Y。这是他们在会议里的原话：
'我们希望保存现有配置，而不是从头创建新的。
重点是配置复用，不要做新建流程。'"
```

### 主动任务发现

系统会主动寻找工作：

**早上：**
- 扫描 Sentry 发现错误 → 启动 4 个 Agent 调查修复

**会议后：**
- 扫描会议记录发现需求 → 启动 3 个 Codex

**晚上：**
- 扫描 git log → 启动 Claude Code 更新文档

### 优先级系统

成功模式会被记录下来，用于未来的 prompt 优化：
- "这个 prompt 结构对账单功能很有效"
- "Codex 需要提前拿到类型定义"
- "总是要包含测试文件路径"

---

## 配置建议

### 环境要求

**必需：**
- Git 安装
- tmux 安装
- 至少一个 AI 编程 Agent API（Claude Code、Codex、Gemini）

**推荐：**
- Obsidian（存储会议记录）
- 独立的 git 仓库用于代码
- 16GB+ RAM（如果需要并行运行 5 个 Agent）

### 性能优化

**RAM 限制：**
- Mac Mini (16GB) = 最多 4-5 个 Agent
- Mac Studio M4 Max (128GB) = 可以运行更多

**建议：**
- 根据 RAM 选择同时运行的 Agent 数量
- 使用 `tmux` 代替多个终端会话

---

## 示例场景

### 场景 1：单个功能开发

```
用户："帮我实现用户自定义邮件模板功能"

OpenClaw:
1. 创建 worktree: git worktree add ../feat-email-templates -b feat/email-templates origin/main
2. 启动 tmux 会话
3. 选择 Codex 作为主力代理
4. 生成 prompt（包含会议记录中的需求）
5. 启动代理
6. 每 10 分钟监控状态
7. Agent 创建 PR
8. 三个 AI reviewer 审查
9. 人工 review (5-10 分钟)
10. 合并 PR
```

### 场景 2：主动工作发现

```
OpenClaw (早上):
1. 扫描 Sentry
2. 发现 4 个新错误
3. 为每个错误启动一个 Agent 调查

OpenClaw (晚上):
1. 扫描会议记录
2. 发现 3 个新功能需求
3. 启动 3 个 Codex 开发
```

---

## 监控和报告

### 状态检查要点

每 10 分钟检查：
- ✅ tmux 会话是否存活
- ✅ 是否有新 PR 创建
- ✅ CI 状态（lint、测试、E2E）
- ✅ Code reviewer 是否完成

### 失败处理

- 第一次失败：增加详细上下文到 prompt
- 第二次失败：简化任务描述
- 第三次失败：通知用户介入

### 通知时机

**需要通知用户的情况：**
- Agent 持续失败超过 3 次
- CI 失败且无法自动修复
- 发现安全风险
- 需要人工决策的边界情况

---

## 安全注意事项

1. **执行层 Agent 不接触生产数据库**
   - 只拿到"完成这个任务需要知道的最小上下文"

2. **敏感信息隔离**
   - 客户数据、会议记录等只被编排层访问
   - Agent 只看到代码和测试环境

3. **最小权限原则**
   - 每个 Agent 只获得必要的权限
   - 不给 Agent 直接写入权限（除非必要）

4. **人工审批关键操作**
   - 创建 PR
   - 合并到主分支
   - 部署到生产环境

---

## 与其他 Skill 配合使用

### 推荐 Skills

1. **obsidian** - 存储和检索会议记录
2. **github** - 创建 PR 和管理仓库
3. **session-logs** - 搜索和分析历史对话

### 工作流示例

```
用户 → "查看昨天的会议记录"
OpenClaw → obsidian 查找会议 → 总结需求

用户 → "开发这个功能"
OpenClaw → agent-swarm-coordinator 创建 worktree → 启动代理 → 监控 → code review → 通知合并

用户 → "部署到生产"
OpenClaw → github 创建部署 PR → 等待 CI 通过 → 合并
```

---

## 性能指标（参考）

根据作者的实战数据（4 周）：

**每周：**
- 最多 94 次提交
- 平均 50 次提交/天
- 30 分钟内完成 7 个 PR

**效率：**
- 从需求到 PR 合并：1-2 小时
- 实际人工时间：10 分钟

**成本：**
- Claude Code $100/月 + Codex $90/月 = $190/月
- 新手起步 $20/月

---

## 故障排查

### 常见问题

**Q: Agent 不响应**
```
A: 检查 tmux 会话状态
A: 查看 agent 输出日志
A: 尝试发送中断信号重新启动
```

**Q: CI 一直失败**
```
A: 检查是否是语法错误（先 lint）
A: 查看 CI 日志中的具体错误信息
A: 生成错误日志供 agent 分析
```

**Q: RAM 不足**
```
A: 减少同时运行的 Agent 数量
A: 使用更轻量的代理（优先 Claude Code）
A: 重启 OpenClaw 释放内存
```

---

## 最佳实践

### 1. 开始小，逐步扩展
- 先用一个代理（Claude Code）
- 熟悉工作流后再添加更多
- 理解每个代理的优缺点

### 2. 保持上下文专业
- 每个任务有独立的 worktree
- 任务描述简洁但包含所有必要信息
- 失败经验记录用于学习

### 3. 定期清理
- 每天清理孤立的 worktree
- 归档完成的任务记录
- 保留重要的失败案例用于学习

### 4. 人工保持控制
- 关键操作（合并 PR、部署）需要人工确认
- 不要让 Agent 自动执行这些操作
- 遇到边界情况时主动询问

---

## 更新日志

### v1.0.0 (2026-02-28)
- 初始版本
- 实现双层架构（编排层 + 执行层）
- 支持多代理管理（Codex、Claude Code、Gemini）
- 自动监控和 code review
- 动态 prompt 学习
- 主动任务发现

---

## 相关资源

**基础文章：** memory/openclaw-claude-code-integration.md
**实战用例：** memory/openclaw-10-insane-use-cases.md

---

## 许可

这个 Skill 可以自由使用、修改和分发。
