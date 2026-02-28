# MEMORY.md - 长期记忆

## 持续学习资源

### 学习博客
1. **Peter Steinberger** - https://steipete.me/
   - 专注于 AI 工具和开发工作流
   - 特别关注：OpenClaw、Claude Code、AI 开发工作流
   - 学习笔记：`memory/peter-steinberger-workflow-study.md`

2. **AI NEWSLETTER** - https://www.latent.space/s/ainews
   - Latent Space 的每日（工作日）AI 工程新闻
   - 人工精选 + AI 总结

### 学习文章存放
- 用户采集的文章 → `D:\Logseq\Clippings`
- OpenClaw 商业化主题 → `D:\Logseq\02_Area领域\X6_AI\如何用openclaw工作挣钱`
- 学习笔记 → `memory/*-study.md`
- 每日记录 → `memory/YYYY-MM-DD.md`

### 重要技术解决方案

**微信文章自动访问：**
- **Playwright Scraper** - 成功的解决方案
- 技能位置：`~/.openclaw/skills/playwright-scraper-skill`
- 支持 3 种模式：web_fetch、Playwright Simple、Playwright Stealth
- Playwright Stealth 在复杂网站上表现最好（100% 成功率）
- **配置：** 已安装并测试成功

**其他尝试过的方案：**
- ❌ web_fetch - 不支持 JS 渲染
- ❌ browser - 需要手动附加扩展
- ❌ Firecrawl - 微信返回"环境异常"（反爬虫）
- ❌ Jina Crawler - 微信返回"环境异常"（反爬虫）
- ❌ Tavily - 中文搜索有编码问题

**PDF2Skills 概念（来自微信文章学习）：**
- **知识榨汁机** - 从 PDF 中提取结构化知识
- **无限流侦探游戏** - 将静态内容转化为可玩的互动游戏
- **探索者心态** - 验证想法、获得经验，而非结果导向
- **AI 辅助角色** - 地基挖掘（AI）+ 游戏机制设计（人）
- **流程验证重要性** - 确保 AI 能"操作"，而人负责设计

### OpenClaw 商业化
**核心模式：** Wrapper Business Model
- 配置 OpenClaw 用于特定用例
- 包装成易于使用的解决方案
- 出售给不想自己设置的人

**已研究的 5 个高价值 Wrapper:**
1. The Content Machine（内容机器）
2. The Health & Accountability Coach（健康教练）
3. The RPG Life System（RPG 生活系统）
4. The Autonomous Dev Team（自主开发团队）
5. The SEO Empire Builder（SEO 帝国建设者）

**详细笔记：** `memory/monetization-study.md`
4. The Autonomous Dev Team（自主开发团队）
5. The SEO Empire Builder（SEO 帝国建设者）

**详细笔记：** `memory/monetization-study.md`

**关键洞察：**
- 目标客户不是开发者，而是需要结果的业务用户
- 理解客户日常工作流程比成为最好的工程师更重要
- 先进入市场的人将拥有这个类别

## 重要资源

### 搜索工具
1. **Tavily 搜索** - 优先使用
   - 工具：`tavily_search`
   - 配置：环境变量 `TAVILY_API_KEY`
   - 技能位置：`~/.openclaw/skills/tavily-search/`

2. **web_search** - 备用（仅当 Tavily 不可用时使用）
   - 支持：Brave、Perplexity
   - 当前：未配置 API key

### OpenClaw Skills 仓库
- **地址:** https://github.com/VoltAgent/awesome-openclaw-skills
- **描述:** 2868个社区技能的精选集合，按分类组织
- **用途:** 当需要技能完成任务时，可以在这里查找学习
- **分类示例:**
  - Coding Agents & IDEs (133)
  - Marketing & Sales (143)
  - Communication (132)
  - Git & GitHub (66)
  - Productivity & Tasks (135)
  - Web & Frontend Development (202)
  - DevOps & Cloud (212)
  - Search & Research (253)
  - Browser & Automation (139)
  - ... 等更多

### 安装方式
- ClawHub CLI: `npx clawhub@latest install <skill-slug>`
- 手动安装: 复制到 `~/.openclaw/skills/` 或 `<project>/skills/`
- 或者直接把 GitHub 链接发给我，我自动处理

## 用户信息

- **姓名:** gary
- **职位:** AI产品总监
- **工作日:** 周一至周五 9:00-19:00
- **时区:** GMT+8 (Asia/Shanghai)
- **沟通偏好:** 残洁回复，中文交流

## 核心工作原则

### 主动使用原则
- **优先使用现有工具和技能：** 在开始新项目或功能开发前，先搜索和评估已有的解决方案
  - ClawHub Skills 仓库：2868个社区技能
  - OpenClaw Skills 资源和最佳实践
  - 代理间的技能可以互相借鉴
- **避免重复造轮：** 除非现有工具无法满足需求，否则利用已有资源
- **持续优化：** 定期回顾和优化使用的工作流，记录有效的工具组合和技巧

### 持续学习理念
- **记录和总结：** 每次学习后记录经验（成功/失败/洞察/技术细节）
- **形成可复用的模式：** 将有效的提示语法、工作流程、工具组合整理成模式库
- **迭代优化：** 基于经验教训调整策略，避免重复错误
- **分享和交流：** 与社区分享最佳实践，获取反馈和新思路

### AI 原生工作流原则（来自 Teresa Torres）
1. **数据本地化：** 所有数据都是本地 Markdown 文件
2. **颗粒化上下文：** 用小文件而非大文件喂给 AI
3. **自动标签化：** AI 根据内容自动分类
4. **增强型写作：** AI 作为伙伴而非代写
5. **复盘机制：** 让 AI 更新自己的"大脑"

### Less is More 哲学（来自 Peter Steinberger）
1. **最小化工具：** Ghostty + Claude Code + minimal tooling = maximum productivity
2. **移除不必要的工具：** 如 MCP（如果污染上下文）
3. **上下文珍贵：** 不要在上下文中做可以外部化的事情
4. **选择有 CLI 的服务：** 便于 agent 使用
5. **动态调整 agent 数量：** 根据 blast radius（小任务 1-2 个，大任务 ~4 个）

## 待实施改进

### 高优先级
- [ ] 创建 CLAUDE.md 配置常用 CLI 工具
- [ ] 将 MEMORY.md 拆分为颗粒化文件
- [ ] 创建自定义指令（/status, /memory-scan, /digest）
- [ ] 建立对话后复盘机制

### 中优先级
- [ ] 优化 agent 使用策略（根据 blast radius 动态调整）
- [ ] 实施 plan mode（大任务先写计划文件）
- [ ] 学习用户写作风格，提供增强型写作支持
- [ ] 定期检查 `D:\Logseq\Clippings` 中的新文章

### 低优先级
- [ ] 探索更多自定义工具集成
- [ ] 考虑添加学术研究支持（arXiv、Google Scholar）
- [ ] 建立每日学习 digest 流程
