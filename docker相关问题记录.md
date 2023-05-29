

# 使用Helm安装harbor
https://www.cnblogs.com/cerberus43/p/15881258.html

# docker login and push

docker login -u USERNAME -p PASSWORD REGISTRY_URL
docker push REGISTRY_URL/IMAGE_NAME:TAG

docker login -u admin -p Harbor123456 localhost:30002

# 检查pod的详细信息 ，包括容器状态、事件和日志。您可以使用此信息来诊断问题并解决问题

kubectl describe pod <pod-name>


可以删除deployment和service还有job


# linux ssh/config 密码配置（不用每次都输入密码）



# 删除无名镜像




# Kubeadm初始化报错：[ERROR CRI]: container runtime is not running

https://blog.csdn.net/qq_43580215/article/details/125153959

# Docker Desktop (桌面) 对企业收费，Mac下的docker替代方案 - containerd 与 Lima(保姆级安装教程M1可用)
https://zhuanlan.zhihu.com/p/476240258


# 

使用 K3s 配置私有镜像仓库


K3s 镜像仓库配置文件由两大部分组成：mirrors 和 configs:



Mirrors 是一个用于定义专用镜像仓库的名称和 endpoint 的指令

Configs 部分定义了每个 mirror 的 TLS 和证书配置。对于每个 mirror，你可以定义 auth 和/或 tls


# 配置 containerd 镜像仓库完全攻略
https://www.infoq.cn/article/jizyup2sl30kkfqjfblw
containerd 使用了类似 K8S 中 svc 与 endpoint 的概念，svc 可以理解为访问名称，这个名称会解析到对应的 endpoint 上。也可以理解 mirror 配置就是一个反向代理，它把客户端的请求代理到 endpoint 配置的后端镜像仓库。mirror 名称可以随意填写，但是必须符合 IP 或域名的定义规则。并且可以配置多个 endpoint，默认解析到第一个 endpoint，如果第一个 endpoint 没有返回数据，则自动切换到第二个 endpoint，以此类推。

# Install Kubernetes 1.26 on Ubuntu 20.04 or 22.04 LTS
https://akyriako.medium.com/install-kubernetes-on-ubuntu-20-04-f1791e8cf799


# kubeadm config images list
kubeadm config images list



# Ubuntu 22.04 停止显示 Daemons using outdated libraries
https://d.cellmean.com/p/4cb49cd6ab01con


# [Centos7修改Docker默认存储位置](https://cloud.tencent.com/developer/article/1860479)