#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 日志目录
LOG_DIR="/workspace/logs"
LOG_FILE="$LOG_DIR/ollama.log"

# 创建日志目录
echo "Creating log directory..."
mkdir -p "$LOG_DIR"
if [ ! -d "$LOG_DIR" ]; then
    echo -e "${RED}Failed to create log directory: $LOG_DIR${NC}"
    exit 1
fi

# 设置 Ollama 监听地址
export OLLAMA_HOST=0.0.0.0

# 启动 Ollama 服务
echo "Starting Ollama service..."
nohup ollama serve > "$LOG_FILE" 2>&1 &

# 等待服务启动
sleep 2

# 检查进程是否在运行
if pgrep -x "ollama" > /dev/null; then
    echo -e "${GREEN}Ollama service is running${NC}"
    echo -e "Log file: $LOG_FILE"
    echo -e "Recent logs:"
    tail -n 5 "$LOG_FILE"
else
    echo -e "${RED}Failed to start Ollama service${NC}"
    echo -e "Check logs for details: $LOG_FILE"
    exit 1
fi