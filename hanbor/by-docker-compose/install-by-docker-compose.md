https://hub.docker.com/r/bitnami/harbor-core

curl -LO https://raw.githubusercontent.com/bitnami/containers/main/bitnami/harbor-portal/docker-compose.yml
curl -L https://github.com/bitnami/containers/archive/main.tar.gz | tar xz --strip=2 containers-main/bitnami/harbor-portal && cp -RL harbor-portal/config . && rm -rf harbor-portal
docker-compose up

# 启动镜像
docker run -d -p 9000:9000 --restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
--name portainer portainer/portainer-ce


# 默认的初始化用户名和密码
用户名: admin
密码: 根据compose的配置, 当前配置采用默认是 bitnami, 如果有修改就按照自己的修改

docker login --username=admin 192.168.205.8:30002 --password=bitnami
docker login --username=caldremch 192.168.205.8:30002 --password=123456Cdm
docker login --username=admin 192.168.205.8:30002 --password=Harbor123
docker login --username=admin --password=123456Cdm 192.168.205.6:30014
docker login --username=admin --password=123456Cdm 192.168.205.7:30014
docker login --username=admin --password=123456Cdm 192.168.205.5:30014
docker tag localhost:15000/yourNamespaceservice/my-server:latest 192.168.205.8:30002/app/my-server:latest
docker tag localhost:15000/yourNamespaceservice/my-server:latest 192.168.205.5:30014/app/my-server:latest
docker tag 192.168.205.5:30014/app/my-server:latest 192.168.20.150:30014/app/my-server:0.0.1
docker tag caldremch/android-sdk:latest 192.168.20.150:30014/app/android-sdk:latest
docker login --username=admin --password=123456Cdm 192.168.20.150:30014
docker push 192.168.205.8:30002/app/my-server:latest
docker pull 192.168.205.8:30002/app/my-server
docker push 192.168.20.150:30014/app/my-server:0.0.1


# docker login 私有仓库harbor 502 Bad Gateway
https://www.jianshu.com/p/1aa78a50c571

1. 将bitnami修改为 符合要求的密码比如Harbor123(大小写+数字)
2. 修改 [docker-compose.yml](docker-compose.yml) core下的EXT_ENDPOINT为具体的ip+端口或者是自己的域名,中的 http://192.168.205.8:30002
再次执行登录, docker login --username=admin 192.168.205.8:30002 --password=Harbor123, 这个时候就可以看到成功了

192.168.205.1 - - [07/Apr/2023:17:30:38 +0000] "GET /api/v2.0/systeminfo HTTP/1.1" 200 398 "http://192.168.205.8:30002/harbor/projects/2/helm-charts" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
192.168.205.1 - - [07/Apr/2023:17:30:38 +0000] "GET /api/chartrepo/app/charts HTTP/1.1" 200 2 "http://192.168.205.8:30002/harbor/projects/2/helm-charts" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
192.168.205.1 - - [07/Apr/2023:17:30:36 +0000] "GET /api/v2.0/labels?sort=-creation_time&scope=p&project_id=2&page_size=15&page=1 HTTP/1.1" 200 3 "http://192.168.205.8:30002/harbor/projects/2/labels" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
192.168.205.1 - - [07/Apr/2023:17:30:24 +0000] "\x16\x03\x01\x00\xDA\x01\x00\x00\xD6\x03\x03\x10g\x9DF\xDEp,\xAE\x96\xF9\xB0\x8A\xD0\x8C\xA0\x082\x8E\xFC?\x04*\x85f\x15%\xC8\xAE\x06p\xE9, $T\xF61\x13f\xC9\xDF\x93_\xB6\xF0q\x87\x0E\xE0\x0B\x92B\x11\xB7I9h\xDE\xD0\xD9\xE3\x1EA\xEA?\x00\x16\xC0+\xC0/\xC0,\xC00\xC0\x09\xC0\x13\xC0" 400 150 "-" "-"
192.168.205.1 - - [07/Apr/2023:17:30:24 +0000] "GET /v2/ HTTP/1.1" 401 76 "-" "docker/20.10.23 go/go1.18.10 git-commit/6051f14 kernel/5.15.49-linuxkit os/linux arch/arm64 UpstreamClient(Docker-Client/23.0.1-rd \x5C(darwin\x5C))"
192.168.205.1 - - [07/Apr/2023:17:30:05 +0000] "GET /api/v2.0/projects/2/members?page_size=15&page=1&entityname= HTTP/1.1" 200 237 "http://192.168.205.8:30002/harbor/projects/2/members" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
192.168.205.1 - - [07/Apr/2023:17:31:20 +0000] "\x16\x03\x01\x00\xDA\x01\x00\x00\xD6\x03\x03u=\xFE?\xFF-\xB3\x1DC\xC3r\x1C\xC8u\x12\x89\x1D\xFF|bCB\xE0\xCBz\xC3\xD9?\x9E\xDB\xF0\xD1 \xFAyfR^\xC9\xE2\x10\xD3Wb\x92p2M\xFA\x105\x97=\x19\xF2\x07\x14\xD6v`\xB5\xD11\x0Co\x00\x16\xC0+\xC0/\xC0,\xC00\xC0\x09\xC0\x13\xC0" 400 150 "-" "-"