$ sudo apt install software-properties-common
# 添加并信任APT证书
$ curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -
# 添加源地址
$ sudo add-apt-repository "deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main"
# 更新源并安装最新版 kubenetes 三大组件
$ sudo apt update && sudo apt install kubelet kubeadm kubectl
# 验证是否安装成功
$ kubeadm version
$ kubectl version
$ kubelet --version点击复制复制失败已复制