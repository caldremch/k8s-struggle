# 如何在 Ubuntu 22.04 LTS 中安装 Docker 和 Docker Compose

记录一下, 未了以后安装, 不用网上查找

sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version

# 参考

1. https://www.51cto.com/article/715086.html