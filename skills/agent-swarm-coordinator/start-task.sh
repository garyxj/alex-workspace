#!/bin/bash

# Agent Swarm Coordinator - 示例启动脚本
# 这个脚本展示如何创建 worktree 并启动后台代理

set -e

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Agent Swarm Coordinator ===${NC}"
echo ""

# ============================================
# 配置区域 - 修改这些值
# ============================================

# 主代码仓库路径
MAIN_REPO_PATH="$HOME/Projects/my-project"

# Worktrees 目录
WORKTREES_PATH="$MAIN_REPO_PATH/../.worktrees"

# 任务名称
TASK_NAME="feat-user-login"

# 选择的主力代理 (codex/claude/gemini)
PRIMARY_AGENT="claude"

# ============================================
# 辅助函数
# ============================================

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# ============================================
# 步骤 1: 创建 worktree
# ============================================

log_info "步骤 1: 创建独立的 git worktree"

WORKTREE_NAME="feat-$TASK_NAME"
WORKTREE_PATH="$WORKTREES_PATH/$WORKTREE_NAME"

# 检查是否已存在
if [ -d "$WORKTREE_PATH" ]; then
    log_warn "Worktree $WORKTREE_NAME 已存在，跳过创建"
else
    log_info "创建新 worktree: $WORKTREE_PATH"
    git worktree add "$MAIN_REPO_PATH" -b "$WORKTREE_NAME" -B
fi

# ============================================
# 步骤 2: 安装依赖（如果需要）
# ============================================

log_info "步骤 2: 安装项目依赖"

cd "$WORKTREE_PATH"

if [ -f "package.json" ]; then
    log_info "运行 pnpm install"
    pnpm install
else
    log_warn "未找到 package.json，跳过依赖安装"
fi

# ============================================
# 步骤 3: 启动 tmux 会话和代理
# ============================================

log_info "步骤 3: 启动后台代理会话"

TMUX_SESSION_NAME="agent-$PRIMARY_AGENT"

# 检查 tmux 会话是否已存在
if tmux has-session -t "$TMUX_SESSION_NAME" 2>/dev/null; then
    log_warn "Tmux 会话 $TMUX_SESSION_NAME 已存在"
    read -p "是否要附加到现有会话？(y/n): " ATTACH_CHOICE
    if [ "$ATTACH_CHOICE" = "y" ]; then
        tmux attach-session -t "$TMUX_SESSION_NAME"
        exit 0
    fi
fi

# 启动新的 tmux 会话
log_info "启动新的 tmux 会话: $TMUX_SESSION_NAME"

# 根据选择的代理启动对应的脚本
case "$PRIMARY_AGENT" in
    codex)
        log_info "启动 Codex Agent"
        tmux new-session -d -s "$TMUX_SESSION_NAME" \
            -c "$HOME/.codex-agent/run-agent.sh"
        ;;
    claude)
        log_info "启动 Claude Code Agent"
        tmux new-session -d -s "$TMUX_SESSION_NAME" \
            -c "$HOME/.claude-agent/run-agent.sh"
        ;;
    gemini)
        log_info "启动 Gemini Agent"
        tmux new-session -d -s "$TMUX_SESSION_NAME" \
            -c "$HOME/.gemini-agent/run-agent.sh"
        ;;
    *)
        log_error "未知的代理类型: $PRIMARY_AGENT"
        exit 1
        ;;
esac

# ============================================
# 步骤 4: 记录任务信息
# ============================================

log_info "步骤 4: 记录任务到跟踪文件"

TASK_ID="task-$(date +%s)"
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%S)

TASK_FILE="agent-tasks.json"

# 如果任务文件不存在，创建一个空的
if [ ! -f "$TASK_FILE" ]; then
    echo "[]" > "$TASK_FILE"
fi

# 添加新任务记录（使用 jq 更新 JSON）
jq --arg agent "$PRIMARY_AGENT" \
   --arg session "$TMUX_SESSION_NAME" \
   --arg name "$TASK_NAME" \
   --arg id "$TASK_ID" \
   --arg timestamp "$TIMESTAMP" \
   '. += [{
     "id": $id,
     "name": $name,
     "agent": $agent,
     "tmux_session": $session,
     "timestamp": $timestamp,
     "status": "running",
     "created_at": "'"$TIMESTAMP"'"
   }]' "$TASK_FILE" > "$TASK_FILE.tmp" && mv "$TASK_FILE.tmp" "$TASK_FILE"

log_info "任务已记录: $TASK_NAME (ID: $TASK_ID)"

# ============================================
# 步骤 5: 显示使用说明
# ============================================

echo ""
echo -e "${GREEN}=== 代理已启动 ===${NC}"
echo ""
log_info "Tmux 会话名称: $TMUX_SESSION_NAME"
log_info "Worktree 路径: $WORKTREE_PATH"
echo ""
log_info "常用命令："
echo "  附加到 tmux 会话:  tmux attach-session -t $TMUX_SESSION_NAME"
echo "  发送命令到代理:     tmux send-keys -t $TMUX_SESSION_NAME \"你的命令\""
echo "  分离 tmux 会话:     tmux detach-client -s $TMUX_SESSION_NAME"
echo "  杀掉 tmux 会话:      tmux kill-session -t $TMUX_SESSION_NAME"
echo ""
log_info "监控脚本（每 10 分钟检查一次）需要单独设置"
echo ""

# ============================================
# 可选：启动监控脚本
# ============================================

read -p "是否要启动监控脚本？(y/n): " START_MONITOR

if [ "$START_MONITOR" = "y" ]; then
    log_info "启动监控脚本（后台）"
    nohup bash "$HOME/agent-swarm-monitor.sh" > /dev/null 2>&1 &
    log_info "监控进程 ID: $!"
fi

echo -e "${GREEN}=== 完成 ===${NC}"
