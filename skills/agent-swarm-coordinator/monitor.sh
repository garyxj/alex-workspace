#!/bin/bash

# Agent Swarm Monitor - 监控代理状态
# 每 10 分钟检查一次所有代理状态

set -e

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ============================================
# 配置
# ============================================

TASK_FILE="$HOME/agent-tasks.json"
LOG_FILE="$HOME/agent-monitor.log"
CHECK_INTERVAL_MINUTES=10
MAX_RETRIES=3

# ============================================
# 辅助函数
# ============================================

log_info() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] [INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] [WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] [ERROR]${NC} $1"
}

send_notification() {
    # 这里可以集成 Telegram 发送
    # 示例: openclaw message "代理异常: $1"
    log_info "发送通知: $1"
}

# ============================================
# 核心监控逻辑
# ============================================

check_agent_status() {
    local TASK_ID="$1"
    local AGENT_NAME="$2"
    local SESSION_NAME="$3"

    # 从任务文件中获取任务信息
    local TASK_INFO=$(jq -r --arg id "$TASK_ID" '.[] | select(.id == $id)' "$TASK_FILE")

    if [ -z "$TASK_INFO" ]; then
        log_warn "未找到任务 $TASK_ID"
        return 1
    fi

    local STATUS=$(echo "$TASK_INFO" | jq -r '.status')
    local RETRY_COUNT=$(echo "$TASK_INFO" | jq -r '.retry_count // 0')

    # 检查 tmux 会话是否存活
    if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
        log_info "✓ Agent $AGENT_NAME (会话: $SESSION_NAME) 正在运行"
    else
        log_warn "✗ Agent $AGENT_NAME (会话: $SESSION_NAME) 未运行"

        # 增加重试计数
        RETRY_COUNT=$((RETRY_COUNT + 1))
        jq --arg id "$TASK_ID" --arg retries "$RETRY_COUNT" \
           '(.[] | select(.id == $id) | .status = "running"; .retry_count = $retries)' "$TASK_FILE" > "$TASK_FILE.tmp" && mv "$TASK_FILE.tmp" "$TASK_FILE"

        # 检查是否超过最大重试次数
        if [ "$RETRY_COUNT" -ge "$MAX_RETRIES" ]; then
            log_error "Agent $AGENT_NAME 失败 $MAX_RETRIES 次，需要人工介入"
            send_notification "Agent $AGENT_NAME 持续失败，请检查"
            return 1
        fi
    fi
}

check_all_tasks() {
    log_info "=== 开始检查所有任务 ==="

    # 获取所有运行中的任务
    jq -r '.[] | select(.status == "running")' "$TASK_FILE" | while read -r TASK_INFO; do
        TASK_ID=$(echo "$TASK_INFO" | jq -r '.id')
        AGENT=$(echo "$TASK_INFO" | jq -r '.agent')
        SESSION=$(echo "$TASK_INFO" | jq -r '.tmux_session')

        check_agent_status "$TASK_ID" "$AGENT" "$SESSION"
    done

    log_info "=== 检查完成 ==="
}

# ============================================
# 主循环
# ============================================

log_info "Agent Swarm Monitor 启动"
log_info "检查间隔: ${CHECK_INTERVAL_MINUTES} 分钟"
log_info "最大重试次数: $MAX_RETRIES"
log_info ""

# 等待检查间隔（转换为秒）
SLEEP_SECONDS=$((CHECK_INTERVAL_MINUTES * 60))

while true; do
    check_all_tasks
    sleep "$SLEEP_SECONDS"
done
