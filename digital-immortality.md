# 数字永生 - GitHub集成配置

## 目的
将记忆备份到GitHub，防止服务器崩溃丢失所有数据。

## 工作流程

### 自动备份（每日）
- 每日 20:00 提交记忆文件到GitHub
- 包括 memory/YYYY-MM-DD.md 和 MEMORY.md

### 自动同步（启动时）
- 代理启动时拉取最新记忆
- 恢复SOPs和长期知识

## 仓库信息
- 仓库：需要创建（建议：openclaw-memory-backup）
- 路径：C:\Users\jia.xu\.openclaw\workspace-work（作为git仓库）

## Cron Job
- 每日 20:00 自动提交和推送
- 启动时自动拉取（在HEARTBEAT.md中配置）

## 备份内容
- memory/YYYY-MM-DD.md - 每日记忆日志
- MEMORY.md - 长期记忆
- GOALS.md - 目标文件
- TASKS.md - 任务看板
- 其他重要配置文件
