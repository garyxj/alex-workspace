# 代理自动化系统 - 测试和启用指南

## 已完成的配置

### ✅ A. 数字永生（GitHub集成）
- 配置文件：`digital-immortality.md`
- Cron Job：GitHub Memory Backup（ID: f813adc2）
- 时间：每天 20:00
- 功能：自动备份记忆到GitHub

### ✅ B. 每日站会（经验总结）
- 配置文件：`daily-standup.md`
- Cron Job：Daily Standup - Lessons Learned（ID: e8cd42ef）
- 时间：每天 22:00
- 功能：总结经验教训，积累知识资产

### ✅ C. 心跳检查（漂移监控）
- 配置文件：`heartbeat-monitor.md`
- Cron Job：Heartbeat Check（ID: 4b65e24a）
- 时间：每30分钟
- 功能：防止代理漂移，自动纠正

### ✅ 配置文档
- 完整总结：`agent-automation-summary.md`
- 本文件：`automation-test-guide.md`

---

## Cron Jobs 状态

所有Cron Job都已创建但**未启用**（等待测试通过）：

| ID | 名称 | 时间 | 状态 |
|----|------|------|------|
| fb267139 | Daily Autonomous Tasks | 每天 8:00 | ⏸️ 已禁用 |
| f813adc2 | GitHub Memory Backup | 每天 20:00 | ⏸️ 已禁用 |
| e8cd42ef | Daily Standup - Lessons Learned | 每天 22:00 | ⏸️ 已禁用 |
| 4b65e24a | Heartbeat Check | 每30分钟 | ⏸️ 已禁用 |

---

## 测试步骤

### 测试1：GitHub Memory Backup（推荐先测试）

**命令：**
```
"测试 GitHub Memory Backup Cron Job：
1. 检查 workspace-work 中的记忆文件变化
2. 添加所有新文件和修改文件到git
3. 提交并推送到远程仓库
4. 在 Telegram 报告备份状态"
```

**预期结果：**
- Git 操作成功
- 文件推送到远程仓库
- Telegram 收到备份状态报告

---

### 测试2：Daily Standup（经验总结）

**命令：**
```
"测试 Daily Standup Cron Job：
1. 读取今天的记忆日志
2. 总结技术、流程、决策经验
3. 记录改进建议
4. 写入 memory/YYYY-MM-DD.md
5. 在 Telegram 报告总结要点"
```

**预期结果：**
- 生成经验总结
- 写入记忆文件
- Telegram 收到总结报告

---

### 测试3：Heartbeat Check（心跳检查）

**命令：**
```
"测试 Heartbeat Check Cron Job：
1. 读取 TASKS.md 查看当前任务
2. 检查是否有卡住的任务
3. 读取 GOALS.md 确认目标一致性
4. 自我反思当前状态
5. 在 Telegram 报告（如果在工作时间）"
```

**预期结果：**
- 生成心跳报告
- 自我反思完成
- Telegram 收到状态报告（工作时间）

---

### 测试4：Daily Autonomous Tasks（可选）

**命令：**
```
"测试 Daily Autonomous Tasks Cron Job：
1. 读取 GOALS.md
2. 生成 4-5 个自主完成的任务
3. 执行其中一个任务
4. 更新 TASKS.md
5. 在 Telegram 报告结果"
```

**预期结果：**
- 生成并执行任务
- 更新任务看板
- Telegram 收到完成报告

---

## 启用顺序（生产环境）

### 第一阶段：数据安全（第1周）
1. ✅ 测试 GitHub Memory Backup
2. ✅ 启用 GitHub Memory Backup
3. 观察备份稳定性

### 第二阶段：经验积累（第2周）
4. ✅ 测试 Daily Standup
5. ✅ 启用 Daily Standup
6. 观察经验记录质量

### 第三阶段：自主工作（第3周）
7. ✅ 测试 Daily Autonomous Tasks
8. ✅ 启用 Daily Autonomous Tasks
9. 观察任务完成质量

### 第四阶段：状态监控（第4周）
10. ✅ 测试 Heartbeat Check
11. ✅ 启用 Heartbeat Check
12. 观察监控效果

---

## 启用命令

### 启用单个 Cron Job

**GitHub Memory Backup:**
```
"启用 Cron Job: f813adc2 (GitHub Memory Backup)"
```

**Daily Standup:**
```
"启用 Cron Job: e8cd42ef (Daily Standup)"
```

**Heartbeat Check:**
```
"启用 Cron Job: 4b65e24a (Heartbeat Check)"
```

**Daily Autonomous Tasks:**
```
"启用 Cron Job: fb267139 (Daily Autonomous Tasks)"
```

### 启用所有 Cron Jobs
```
"启用所有已创建的 Cron Jobs"
```

---

## 监控和调整

### 监控指标
- Cron Job 运行频率
- 任务完成质量
- 备份成功率
- 心跳报告频率

### 调整策略
- 如果心跳太频繁 → 调整为每60分钟
- 如果站会太晚 → 改为 21:00
- 如果备份太早 → 改为 23:00
- 如果任务太少/太多 → 调整生成数量

---

## 故障排查

### Cron Job 未运行
1. 检查 Cron Job 状态：`cron list`
2. 确认是否已启用
3. 查看日志：`cron runs <jobId>`

### Git Push 失败
1. 检查远程仓库访问权限
2. 确认网络连接
3. 查看git错误信息

### Telegram 报告未发送
1. 确认 Telegram channel 配置
2. 检查消息格式
3. 查看 agent 日志

---

## 紧急停止

### 停止单个 Cron Job
```
"禁用 Cron Job: <jobId>"
```

### 停止所有 Cron Jobs
```
"禁用所有 Cron Jobs"
```

---

## 联系方式

- Telegram: @ymyryl (id: 8573621851)
- 工作区: C:\Users\jia.xu\.openclaw\workspace-work

---

## 下一步行动

**现在：**
1. 选择一个 Cron Job 进行测试
2. 观察测试结果
3. 根据结果调整配置

**今天：**
4. 完成 GitHub Memory Backup 测试
5. 如果成功，启用它

**本周：**
6. 逐个测试其他 Cron Jobs
7. 完成后逐步启用

---

_配置完成: 2026-02-28_
_准备好测试 ✅_
