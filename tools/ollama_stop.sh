#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 检查 ollama 进程
OLLAMA_PID=$(pgrep -x "ollama")

if [ -z "$OLLAMA_PID" ]; then
    echo -e "${RED}Ollama is not running${NC}"
    exit 0
fi

echo "Found Ollama process (PID: $OLLAMA_PID)"
echo "Stopping Ollama service..."

# 尝试正常终止进程
kill $OLLAMA_PID

# 等待进程终止
sleep 2

# 检查进程是否已经停止
if pgrep -x "ollama" > /dev/null; then
    echo -e "${RED}Failed to stop Ollama service gracefully, attempting force stop...${NC}"
    # 强制终止进程
    kill -9 $OLLAMA_PID
    sleep 1
    
    if pgrep -x "ollama" > /dev/null; then
        echo -e "${RED}Failed to stop Ollama service${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}Ollama service has been stopped successfully${NC}"