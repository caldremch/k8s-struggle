```shell
# 安装最新的 release 版本
curl -sfL https://oss.kubeclipper.io/get-kubeclipper.sh | bash -
# 如果你在中国，你可以在安装时使用 cn 环境变量, 此时我们会使用 registry.aliyuncs.com/google_containers 代替 k8s.gcr.io
curl -sfL https://oss.kubeclipper.io/get-kubeclipper.sh | KC_REGION=cn bash -
# 默认会下载最新版本，你可以通过指定 KC_VERSION 下载所需版本. 比如指定安装 master 开发版本
curl -sfL https://oss.kubeclipper.io/get-kubeclipper.sh | KC_REGION=cn KC_VERSION=master bash -
```
kcctl login -H http://192.168.20.150:8080 -u admin -p Thinkbig1


NODE=$(kcctl get node -o yaml|grep ipv4DefaultIP:|sed 's/ipv4DefaultIP: //')

kcctl create cluster --master $NODE --name app-k8s --untaint-master