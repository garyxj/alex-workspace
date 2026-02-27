# OpenClaw Tools + 53 Skills 完整指南

## 文章来源
- **路径:** D:\Logseq\02_Area领域\X6_AI\如何用openclaw工作挣钱\OpenClaw 周报W25 25个工具 + 53个技能 更新指南.md
- **作者:** Wenhao Yu
- **发布时间:** 2026-02-05

---

## 核心概念：Tools vs Skills

### Tools（器具器）
决定 OpenClaw「能不能」做某件事：
- `read` / `write`：读写文件
- `exec`：执行系统命令
- `web_search`：Google 一样搜索
- `web_fetch`：点进网页读内容
- `browser`：操作网页（点按钮、填表单、截图）

**没有 Tool，就像没有手，什么都做不了**

### Skills（教科书）
教 OpenClaw「怎么组合 Tools」来完成任务：
- `gog`：教它怎么用 Google Workspace 收发 Email 和管行事历
- `obsidian`：教它怎么整理笔记
- `github`：教它怎么操作 repo
- `slack`：教它怎么发讯息到频道

**关键：**
- Skill 只会说教，能不能做到要看三个条件：
  1. **设定**：系统允许 OpenClaw 执行命令吗？（没开 `exec` 连启动程序都做不到）
  2. **安装**：电脑上有安装对应的连接工具吗？（没装的化 OpenClaw 知道怎么做但连不到 Google）
  3. **授权**：你有登录 Google 帐户并允许存取吗？（没授权，Google 不会让它进来）

三个条件缺一不可！

---

## 同心圆架构：从核心到外围

### Layer 1：核心能力（8 Tools）
几乎每个人都会开：
- 档案操作：read、write、edit、apply_patch
- 命令与程序管理：exec、process
- 网络存取：web_search、web_fetch

**真正让 OpenClaw 变成「助理」而不是「聊天机器人」的：Layer 2**

### Layer 2：进阶能力（7 Tools）
浏览器、记忆、多 Session、自动化。按需开启：
- 浏览器：browser、canvas、image
- Session 管理：sessions_list、sessions_history、sessions_send、sessions_spawn、session_status
- 讯息：message
- 硬体控制：nodes
- 自动化：cron、gateway

### Layer 3：知识层（53 Skills）
教 OpenClaw 操作 Google、Obsidian、Slack 等服务。用什么装什么？

---

## 详细工具列表（25 Tools）

### 档案操作（4）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| read | 读取档案 | 🟢 低 |
| write | 写入档案 | 🟡 中 |
| edit | 结构化编辑 | 🟡 中 |
| apply_patch | 套用补丁代码 | 🟡 中 |

### 命令与程序管理（2）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| exec | 执行命令 | 🔴 极高 |
| process | 管理程序 | 🟡 中 |

### 网络访问（2）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| web_search | 搜寻 | 🟢 低 |
| web_fetch | 抓取网页内容 | 🟡 中 |

### 浏览器（3）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| browser | 浏览器操作 | 🟠 中 |
| canvas | 视觉化工作区 | 🟢 低 |
| image | 图片分析 | 🟢 低 |

### 记忆（2）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| memory_search | 搜寻记忆 | 🟢 低 |
| memory_get | 取得记忆 | 🟢 低 |

### Session 管理（5）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| sessions_list | 列出 session | 🟢 低 |
| sessions_history | 对话历史 | 🟢 低 |
| sessions_send | 发送讯息 | 🟠 中 |
| sessions_spawn | 启动 Agent | 🟠 中 |
| session_status | 状态检视 | 🟢 低 |

### 讯息（1）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| message | 跨平台讯息 | 🔴 高 |

### 硬体控制（1）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| nodes | 跨设备控制 | 🔴 极高 |

### 自动化（2）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| cron | 排程任务 | 🟠 中 |
| gateway | Gateway 管理 | 🟡 中 |

### Agent 通讯（1）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| agents_list | 列出可用 Agent | 🟢 低 |

### 扩展 Tools（2）
| Tool | 功能 | 风险 |
| --- | --- | --- |
| llm_task | 工作流 LLM 步骤 | 🟢 低 |
| lobster | 工作流引擎 | 🟢 低 |

---

## 技能分类（53 Skills）

### 📝 笔记管理（4 Skills）
- `obsidian`：Obsidian
- `notion`：Notion
- `apple-notes`：Apple Notes
- `bear-notes`：Bear

**能不能用取决于你的部署方式**
- `apple-notes` / `bear-notes`：只能在 Mac 本地跑
- `obsidian`：操作的是本地档案
- `notion`：云端服务，不受部署位置限制，最没有障碍

### 📧 工作生产（2 Skills）
- `gog`：Google Workspace（Gmail、Calendar、Tasks、Drive、Docs、Sheets）
- `himalaya`：IMAP/SMTP，只管收发信

**作者开了 `gog`，因为工作上都用得到**

### 💬 即时通訊 & 社群媒体（5 Skills）
- `wacli`（WhatsApp）
- `imsg`（iMessage）
- `bird`（X/Twitter）
- `slack`
- `discord`

**区别于 `message` tool：**
- 装了这些等于让 OpenClaw 深度操作各平台
- 包括搜寻历史讯息、同步对话记录、管理频道等

### 🐙 开发者工具（5 Skills）
- `github`：通过 `gh` CLI 操作 GitHub，需要 OAuth
- `tmux`：管理多个终端 session
- `session-logs`：搜寻和分析过去的对话记录
- `coding-agent`：在背景呼叫其他 AI 编程助手（Codex、Claude Code 等）

### 🔐 密码管理（1 Skill）
- `1password`：OpenClaw 读取你的 1Password 密码库

**权限模式：**
- 一旦授权，整个密码库都能存取
- 没办法只开放某组密码

**作者选没装：建立「AI 专用 vault」只放可以给 AI 存取的密码**

### 🎨 其他场景
- 音乐：`spotify-player`、`sonoscli`、`blucli`
- 家居：`openhue`、`eightctl`
- 外送：`food-order`、`ordercli`
- 创作：`openai-image-gen`、`video-frames`、`gifgrep`
- 语音：`sag`（ElevenLabs TTS）、`openai-whisper`（语音转文字）
- 系统：`clawhub`（Skill 管理）、`skill-creator`（建立 Skill）、`healthcheck`（安全检视）
- 地点：`goplaces`、`local-places`
- 监控：`blogwatcher`（RSS 监控）
- 文件：`nano-pdf`（PDF 编辑）
- 流量：`model-usage`（用量追踪）
- UI：`peekaboo`（macOS UI）
- 通讯：`voice-call`（语音通话）
- 操作：`canvas`

---

## 作者的 OpenClaw 配置

### Tools（25 个开启，21 个拒绝）

**判断原则：**
**想不到使用场景的就不开**

```json
{
  "tools": {
    "allow": [
      "read", "write", "edit", "apply_patch",
      "exec", "process",
      "web_search", "web_fetch",
      "browser", "image",
      "memory_search", "memory_get",
      "sessions_list", "sessions_history", "sessions_send", "sessions_spawn", "session_status",
      "message", "cron", "gateway", "agents_list"
    ],
    "deny": ["nodes", "canvas", "llm_task", "lobster"]
  },
  "approvals": {
    "exec": { "enabled": true }
  }
}
```

**开了 25 个，关了 4 个：**
- `nodes`（想不到场景）
- `canvas`（用不到）
- `llm_task` / `lobster`（没有用工作流引擎）

**安全措施：**
- `exec` 开启审批：每个命令执行前先显示，确认了才执行
- `message` 只用来传给自己：不代替我跟任何人沟通

### Skills（3 个只开，9 个白名单）

**Bundled Skills 全开策略：**
官方 Skills 预设全部自动载入——只要对应的 CLI 工具已安装在系统上，Skill 就会自动启用。

**用 `allowBundled` 白名单限制：**
只保留需要的。

```json
{
  "skills": {
    "allowBundled": [
      "gog", "github", "tmux", "session-logs",
      "weather", "summarize", "clawhub",
      "healthcheck", "skill-creator"
    ]
  }
}
```

**说明：**
- `gog`：Email 和行事历
- `github`：repo
- 其余：Daily Brief 和系统管理用

---

## 三项基本原则

1. **想不到使用场景的就不开**
2. **能力越大，管控越严**
   - `exec` 开启审批
   - `message` 只传给自己
3. **最后一哩自己来**
   - 结账、发讯息、发文，收不回来的操作不交给 AI

---

## 常见问题 FAQ

### Skills 安装后权限会改变吗？
不会。Skills 只是说明书，真正控制能力的是 `tools.allow`

### 1password Skill 能读取所有密码吗？
是的。一旦授权，整个密码库都能存取

### 如何撤销 gog / Google 存取权限？
[Google 帐户](https://myaccount.google.com/) 找到第三方应用程式存取权，找到 gog 移除

### ClawHub 的第三方 Skills 安全吗？
不能预设安全。安装前必须审查 GitHub repo。详细的审查方法见安全指南

---

## Tool Groups 快捷方式

| Group | 包含 |
| --- | --- |
| group:fs | read, write, edit, apply_patch |
| group:web | web_search, web_fetch |
| group:ui | browser, canvas |
| group:memory | memory_search, memory_get |
| group:sessions | sessions_list, sessions_history, sessions_send, sessions_spawn, session_status |
| group:messaging | message |
| group:nodes | nodes |
| group:automation | cron, gateway |

---

## OpenClaw vs ChatGPT

**ChatGPT：** 聊天工具
- 讨论完，你要手动复制内容、贴到别的地方
- 只能跟你聊天

**OpenClaw：** Agent
- 讨论完，它可以接着帮你做事
- 上网查资料、读写文件、操作日历、读你的 Gmail 并草稿回覆、自动同步到电脑
- 连接 Claude Code 接手执行

**同步的意义都不同：**
- LLM App 的同步是你在手机和电脑都能看到对话记录
- OpenClaw 的同步是对话记录直接变成电脑资料夹里的文件，其他工具可以直接读取、接手工作

---

## OpenClaw 可以自动化哪些任务？

搭配 `cron`（排程）+ `message`（讯息推送），常见自动化场景：
- 每日 Daily Brief：整理今天要做什么、有哪些待回覆的讯息、天气预报
- 定期整理 Email 并摘要重点
- 监控 CI/CD 状态
- 定时收集特定主题的热门讨论整理成写作素材
- 追踪产品动态并摘要重点

**只要能拆成「触发条件 + 执行步骤」的任务，OpenClaw 都能自动化**

---

## 不会写程式也能用 OpenClaw 吗？

日常使用完全不需要写程式——你用自然语言跟它对话就好。

「帮我看今天有什么 Email？」
「帮我排一个明天早上 9 点的提醒」

但安装和设定有门槛。如果已装了像 Claude Code 之类的 AI CLI 工具，可以让它协助你完成设定，会省很多摸索的时间。

---

## 相关文章链接

- [OpenClaw 安全吗？5 个必做的安全设定](https://yu-wenhao.com/zh-TW/blog/2026-02-04-is-openclaw-safe-security-guide)
- [OpenClaw 部署成本全攻略：$0.8/月打造你的私域 AI 助理](https://yu-wenhao.com/zh-TW/blog/2026-02-01-openclaw-deploy-cost-guide)
- [Claude Code 教学：完成安装与第一个任务](https://yu-wenhao.com/zh-TW/blog/claude-code-tutorial)

---

## 关键洞察

### 1. Tools 是能力，Skills 是知识
- Tools 决定"能不能"
- Skills 教"怎么做"
- Skill 必须配合 Tool 才能发挥作用

### 2. 安全优先
- `exec` 是最高风险工具，必须开启审批
- `message` 用途要明确，只传给自己
- 外送、付款、发文的"最后一哩"不交给 AI

### 3. 部署方式影响可用性
- 本地安装：Apple Notes、Bear 只能在本地跑
- 云端服务：Notion 不受限制
- Obsidian：如果是本地 vault 且 OpenClaw 在 VM，需要额外处理

### 4. 杠杆巨大
- 一套配置能让一个人完成整个团队的事
- 关键是"组合"和"编排"而不是单点能力

---

**完整清單见文章原文**
- 25 Tools 完整表格
- 53 Skills 完整表格
- 按 Tool Groups 快捷调用
