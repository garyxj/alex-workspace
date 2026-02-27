# 安全政策 - 敏感信息保护

## Git 忽略策略

### 必须忽略的文件类型
- **API Keys:** api-keys.md, *_api_key*, *_apikey*, *_token*
- **密码和凭证:** passwords.md, accounts.md, secrets.md, *_credentials.md, *_secrets.md
- **环境配置:** .env, .env.local, .envrc, .env.production, .env.staging
- **临时文件:** *.tmp, *.bak, *.swp

### 当前忽略的文件
- memory/agent-credentials.md (已从 git 历史中移除)

## 敏感信息存储策略

### 本地存储（不提交到 Git）
- 账户凭证：`memory/agent-credentials.md`
- API 密钥：环境变量文件或专用密钥文件
- 服务密码：加密存储或密码管理器

### 云端备份（可选）
- 使用密码管理器（如 1Password、Bitwarden）
- 加密的云端存储
- 专用密钥管理服务

## 最佳实践

1. **永远不要在聊天中明文传输密码**
   - 使用文件存储
   - 或使用密码管理器分享

2. **定期轮换密钥和密码**
   - API 密钥
   - 服务凭证
   - 访问令牌

3. **最小权限原则**
   - 只给代理必要的权限
   - 使用临时凭证而非长期凭证
   - 及时撤销不再需要的访问

4. **审计和监控**
   - 定期检查已提交的文件
   - 使用 `git log --all --full-history -- "*password*"` 搜索敏感信息
   - 如发现泄露，立即撤销相关密钥

## 已采取的行动

### 2026-02-27
- 创建 .gitignore 文件
- 从 git 历史中移除 `memory/agent-credentials.md`
- 提交到 GitHub (commit 49b00aa)

## 紧急处理流程

如果发现敏感信息泄露：
1. 立即撤销/轮换相关密钥
2. 使用 `git filter-branch` 或 BFG 清理历史
3. 强制推送到远程仓库
4. 通知可能受影响的用户

---

*最后更新: 2026-02-27*
*状态: 已实施*
