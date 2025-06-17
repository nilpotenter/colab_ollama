#!/bin/bash

echo -e "\033[31m账号：cloudstudio\033[0m"
echo -e "\033[31m密码：12345678\033[0m"

# 容器名称
CONTAINER_NAME="open-webui"

# 检查容器是否存在
if [ $(docker ps -aq -f name=$CONTAINER_NAME | wc -l) -gt 0 ]; then
    echo "容器 $CONTAINER_NAME 存在，正在删除..."
    docker rm -f $CONTAINER_NAME
    echo "容器 $CONTAINER_NAME 已删除"
else
    echo "容器 $CONTAINER_NAME 不存在，跳过删除步骤"
fi

# 启动新容器
echo "正在启动新容器 $CONTAINER_NAME..."
docker run -d -p 3000:8080 --gpus all \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name $CONTAINER_NAME \
  --restart always \
  ghcr.io/open-webui/open-webui:cuda

# 验证容器是否成功启动
echo "验证容器状态..."
docker ps -f name=$CONTAINER_NAME



#-d：后台运行容器。
#-p 3000:8080：将容器的 8080 端口映射到主机的 3000 端口。
#--add-host=host.docker.internal:host-gateway：添加主机映射，使容器能够访问主机服务。
#-v open-webui:/app/backend/data：将 Open WebUI 的数据目录挂载到 Docker 卷 open-webui。
#--name open-webui：为容器命名。
#--restart always：设置容器始终自动重启。
#ghcr.io/open-webui/open-webui:main：使用的 Docker 镜像。</li></ul>