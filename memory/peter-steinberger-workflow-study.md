# 学习笔记：My Current AI Dev Workflow

**来源:** Peter Steinberger's Blog
**作者:** Peter Steinberger (@steipete)
**原文:** https://steipete.me/posts/2025/optimal-ai-development-workflow
**发布:** 2025-08-25
**学习日期:** 2026-02-28

---

## TL;DR

**Ghostty + Claude Code + minimal tooling = maximum productivity**

核心原则：**Less is more**

---

## 核心硬件配置

### 显示器
- **Dell UltraSharp U4025QW** - 曲面 Thunderbolt 集线器显示器
- **分辨率:** 3840x1620
- **优势:** 可以同时看到 4 个 Claude 实例 + Chrome，无需移动窗口

### 终端
- **主终端:** Ghostty (https://ghostty.org/)
  - 完全回归 Ghostty 作为主要设置
  - VS Code 的终端不稳定，粘贴大量文本时会冻结
  - 没有什么能击败 Ghostty

- **辅助:** VS Code
  - 仅用于查看代码
  - 不作为主要终端使用

### 其他工具
- **Cursor/GPT-5:** 用于代码审查（有时也用 CLI）
- **放弃:** Zed (无法接受看起来像 [这样](https://x.com/steipete/status/1955690682477134124/photo/1) 的终端)

---

## 工具选择及其现实

### Gemini
- **优点:** 有时候很棒
- **缺点:** 编辑工具[太混乱](https://x.com/steipete/status/1942113964231442876)
- **结论:** 使用越来越少

### GPT-5
- **最佳用途:** 审查计划（plan）
- **工作效果:** 比 Gemini 甚至更好
- **特点:** 非常字面理解，需要更精确和具体的提示词
- **角色:** 优秀的模型，但不是最佳的 agent

### Claude
- **优点:** 极其擅长重构和清理
- **缺点:** 经常搞得一团糟
- **关键:** 要同时做重构和清理，不要产生太多技术债务

---

## 工作流策略

### 代码管理
- **分支:** 全部在 main 分支工作
- **工作树设置:** 尝试过，只是拖慢速度
- **策略:** 如果仔细选择工作领域，可以在多个领域工作而不会有太多交叉污染

### 上下文管理
- **状态栏显示:** 初始主题 + session ID
- **参考:** [gist](https://gist.github.com/steipete/8396e512171d31e934f0013e5651691e)
- **用途:** 需要切换账户或重启会话时超级有帮助

### 规划和执行
1. **Plan mode + 迭代**
   - 使用 plan 模式是关键
   - 不断迭代

2. **任务分类处理**
   - **小任务:** 立即执行
   - **大任务:** 写到文件里，让 GPT-5 审查

3. **提示词策略**
   - **通常:** 使用小提示词管理
   - **有时:** Brainstorm
   - **效果:** AI 能把不连贯的想法整理出很多意义

### Agent 管理
- **非重构工作:** 通常运行 1-2 个 agents
- **清理/测试/UI 工作:** ~4 个 agents 是最佳平衡点
- **决定因素:** 工作的爆炸半径（blast radius）

---

## 最困难的部分

### 分布式系统设计
- 设计分布式系统是最难的部分

### 技术栈选择
- 选择正确的依赖
- 选择正确的平台
- 前瞻性的数据库模式（schema）

### 自定义基础设施
- 构建了大量的自定义基础设施
  - 管理页面（admin pages）
  - CLI 工具（帮助自己和 agents）
- **效果:** 大大加速了工作
- **旧方式:** 永远不会用旧方式完成这些

---

## 测试策略

### 大改动
- **总是要测试**
- 自动化测试通常不够理想

### 关键洞察
**模型在相同上下文中写测试几乎总能发现问题**

### 核心原则
**上下文是珍贵的，不要浪费它**

---

## Less is More

### 移除不必要的工具
- **移除了最后一个 MCP**
  - 原因: Claude 有时会在不需要时启动 Playwright
  - 问题: 读取代码更快，污染上下文更少

### 选择有 CLI 的服务
优先选择有 CLI 的服务：
- **vercel**
- **psql** (PostgreSQL)
- **gh** (GitHub CLI)
- **axiom** (日志服务)

### 配置示例
在 `CLAUDE.md` 中只需一行：
```
logs: axiom or vercel cli
```
```
Database: psql + one example how to load env correctly so loop is faster
```

**优势:**
- Agents 可以直接使用 CLI
- 简单的一行配置就够了

---

## 结果和对比

### 生产力
- **成果:** 使用这个设置完成了疯狂数量的工作
- **结论:** 其他 CLI/模型仍然无法接近

### 其他工具的缺点

**Codex:**
- [无法搜索](https://x.com/steipete/status/1954593439347032167)
- 问 "google best practices" 通常比上下文更好

**Cursor/GPT-5:**
- 需要很长时间
- 不分享其思考过程
- 很难引导（steer）

**GPT-5:**
- 提示词方式更字面化
- 需要更精确和具体

### Background Agents 的挑战
- **问题:** 不认为这可以转移到 background agents
- **原因:** 需要大量引导模型
  - 注意到它们偏离时就需要引导
  - 如果在后台运行，引导会更困难

### Rate Limits
- **新限制:** 8月28日生效，会很难受
- **应对:** 只能付费
- **现状:** 目前没有完美的替代方案

---

## 关键洞察总结

### 1. 硬件的重要性
- 好的显示器能显著提升生产力
- 3840x1620 分辨率可同时查看多个 AI 实例

### 2. 工具的哲学
- **Less is more** - 最小化工具使用
- 移除不必要的工具（如 MCP）
- 选择有 CLI 的服务（便于 agent 使用）

### 3. 上下文管理
- **上下文是珍贵的**
- 不要在上下文中做可以外部化的事情
- 相同上下文中写测试效果好

### 4. 工作流策略
- 小任务立即做
- 大任务写文件让 GPT-5 审查
- Plan mode + 迭代
- 根据 blast radius 调整 agent 数量

### 5. 模型选择
- **Claude Code:** 重构和清理专家（虽然会搞乱）
- **GPT-5:** 计划审查专家（字面化，需要精确）
- **Gemini:** 使用越来越少（编辑工具混乱）

### 6. 自定义基础设施的价值
- 构建工具加速工作
- 管理 pages 和 CLI 工具
- 旧方式无法实现这些

---

## 对 OpenClaw 的启发

### 我们可以做更好的地方

#### 1. 上下文优化
- **当前:** 我们在处理任务时可能浪费上下文
- **改进:** 学习 Peter 的 "Less is more" 哲学
- **行动:** 在 `CLAUDE.md` 中配置 CLI 工具

#### 2. Agent 管理
- **当前:** 可能运行太多 agents
- **改进:** 根据 blast radius 动态调整
- **行动:** 小任务用 1-2 个，大任务（清理/测试/UI）用 ~4 个

#### 3. 工作流策略
- **当前:** 可能没有明确的 plan mode
- **改进:** 实施 Plan mode + 迭代
- **行动:** 大任务先写计划文件

#### 4. 自定义工具
- **当前:** 使用现有的工具
- **改进:** 构建自定义基础设施（如 Tavily 技能）
- **行动:** 持续构建加速工作的工具

### 已做得好的地方
- ✅ 使用 Tavily 技能（自定义基础设施）
- ✅ 本地存储数据（`memory/` 目录）
- ✅ 颗粒化管理上下文（准备拆分 MEMORY.md）

---

## 可立即实施的行动

1. **创建 CLAUDE.md 配置**
   ```markdown
   # 常用工具
   logs: 查看日志或错误信息
   git: git 操作（status, commit, push, pull）
   ```

2. **优化 Agent 使用策略**
   - 小任务：1-2 个 agents
   - 清理/测试/UI：~4 个 agents

3. **实施 Plan mode**
   - 大任务先创建计划文件
   - 让 AI 审查计划

4. **继续构建自定义工具**
   - Tavily 搜索技能 ✅
   - 可能的其他自定义 CLI 集成

---

## 关键金句

> "Ghostty + Claude Code + minimal tooling = maximum productivity"

> "Less is more"

> "Context is precious, don't waste it"

> "Model almost always finds issues when you ask it to write tests IN THE SAME CONTEXT"

> "Pick services that have CLIs"

> "I steer models a lot as I notice them drifting off - that's much harder if they run in the background"

---

## 下一步

1. **继续关注 Peter Steinberger 的博客**
   - 特别是 OpenClaw 相关文章
   - 学习他的最新工作流更新

2. **应用所学**
   - 创建 CLAUDE.md 配置
   - 优化 agent 使用策略
   - 实施 plan mode

3. **持续学习**
   - AI NEWSLETTER 每日阅读
   - 采集更多文章到 `D:\Logseq\Clippings`
   - 定期学习和整理

---

*创建日期: 2026-02-28*
*下次更新: 学习新文章后*
