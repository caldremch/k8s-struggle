# 开启root登录
[Ubuntu 22.04 LTS root登录、修改当前用户名和主机名](https://blog.csdn.net/sedbz/article/details/125488527)


# k8s安装步骤

1. apt-get install -y apt-transport-https ca-certificates curl
2. sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
3. echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
4. apt-get update
5. apt-get install -y kubelet kubeadm kubectl
6. apt-get install \
   ca-certificates \
   curl \
   gnupg \
   lsb-release -y
7. mkdir -p /etc/apt/keyrings
8. echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
9. apt update
10. apt install containerd.io -y
11. rm /etc/containerd/config.toml
12. systemctl restart containerd
13. sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab
14. swapoff -a
15. systemctl enable kubelet
16. hostnamectl set-hostname master.kubernetes.lab
17. cat <<EOF>> /etc/hosts
    10.211.55.4 master.kubernetes.lab
    10.211.55.3 wrk-01.kubernetes.lab
    10.211.55.2 wrk-02.kubernetes.lab
    EOF
18. modprobe br_netfilter
19. echo 1 > /proc/sys/net/ipv4/ip_forward
20. echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables

```text
解决： 解决方法bridge-nf-call-iptables: No such file or directory
https://blog.csdn.net/xufengduo/article/details/100735468

```

[//]: # (20. kubeadm init --v=5 \)

[//]: # (    --upload-certs \)

[//]: # (    --control-plane-endpoint master.kubernetes.lab:6443 \)

[//]: # (    --pod-network-cidr=10.244.0.0/16 \)

[//]: # (    --ignore-preflight-errors=NumCPU)


20. kubeadm init --v=5 \
    --control-plane-endpoint=mymaster:6443 \
    --pod-network-cidr=10.244.0.0/16 \
    --ignore-preflight-errors=NumCPU
21. 成功后， 需要按照succesful后面的操作，将配置文件放到指定的地方， 这样才能结束
也就是以下命令：
```text
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  export KUBECONFIG=/etc/kubernetes/admin.conf
```


报错：1

rpc error: code = Unknown desc = malformed header: missing HTTP content-type


报错2：
Waited for 177.106564ms due to client-side throttling, not priority and fairness, request: POST:https://master.kubernetes.lab:6443/api/v1/namespaces/kube-system/configmaps?timeout=10s
I0330 14:57:31.157240    2226 request.go:622] Waited for 181.653331ms due to client-side throttling, not priority and fairness, request: POST:https://master.kubernetes.lab:6443/api/v1/namespaces/kube-system/serviceaccounts?timeout=10s
Post "https://master.kubernetes.lab:6443/api/v1/namespaces/kube-system/serviceaccounts?timeout=10s": dial tcp 192.168.101.4:6443: connect: connection


解决办法： 
去掉 --upload-certs

执行：

hostnamectl set-hostname mymaster

kubeadm init --v=5 \
--control-plane-endpoint=mymaster:6443 \
--pod-network-cidr=10.244.0.0/16 \
--ignore-preflight-errors=NumCPU


kubeadm init --v=5 \
--control-plane-endpoint=mywork1:6443 \
--pod-network-cidr=10.244.0.0/16 \
--ignore-preflight-errors=NumCPU

结果发现： pulling: registry.k8s.io/kube-apiserver:v1.26.3 拉取不下来或者太慢了

执行： kubeadm config images list查看所有要拉取的镜像
然后执行： kubeadm config images pull --v=5
日志如下：
```text

I0402 15:08:29.198305    8107 initconfiguration.go:116] detected and using CRI socket: unix:///var/run/containerd/containerd.sock
I0402 15:08:29.198456    8107 interface.go:432] Looking for default routes with IPv4 addresses
I0402 15:08:29.198463    8107 interface.go:437] Default route transits interface "enp0s5"
I0402 15:08:29.198504    8107 interface.go:209] Interface enp0s5 is up
I0402 15:08:29.198531    8107 interface.go:257] Interface "enp0s5" has 2 addresses :[192.168.101.32/24 fe80::21c:42ff:fe26:acd0/64].
I0402 15:08:29.198543    8107 interface.go:224] Checking addr  192.168.101.32/24.
I0402 15:08:29.198547    8107 interface.go:231] IP found 192.168.101.32
I0402 15:08:29.198551    8107 interface.go:263] Found valid IPv4 address 192.168.101.32 for interface "enp0s5".
I0402 15:08:29.198554    8107 interface.go:443] Found active IP 192.168.101.32 
I0402 15:08:29.198565    8107 kubelet.go:196] the value of KubeletConfiguration.cgroupDriver is empty; setting it to "systemd"
I0402 15:08:29.202146    8107 version.go:187] fetching Kubernetes version from URL: https://dl.k8s.io/release/stable-1.txt
```

我不理解， 因为我们容器运行时就是cri-containerd， 而不是systemd， 而kubelet配置这里竟然显示cgroup-driver是systemd， 

重新配置kubelet的cgroup-driver为cri-containerd， 但其实也不用配置，因为systemd确实是符合当前系统，也能工作的， 只不过：

```text
我使用的是containerd作为容器运行时， 那我是不是应该使用cri-containerd？

是的，如果你使用的是 containerd 作为容器运行时，建议使用 cri-containerd 作为 cgroup driver。这是因为 cri-containerd 是专门为 containerd 设计的 Kubernetes CRI 插件，它可以提供更好的性能和资源管理。同时，cri-containerd 也可以更好地支持 Kubernetes 中的一些高级功能，如 Pod 安全策略、动态 PVC 等。
```


执行脚本： [kube_images_resolve.sh](..%2F..%2Fkube_images_resolve.sh)解决



# 终于看到成功信息了

```text
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join mymaster:6443 --token iue8ci.386k3p7m34vvvnlh \
        --discovery-token-ca-cert-hash sha256:b852803f80a1b648240a624aad46ad471bb65b493306f36f111840b4988fa1f9 \
        --control-plane 

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join mymaster:6443 --token iue8ci.386k3p7m34vvvnlh \
        --discovery-token-ca-cert-hash sha256:b852803f80a1b648240a624aad46ad471bb65b493306f36f111840b4988fa1f9



```

安装 flannel网络插件，：
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml


介绍
```text
Flannel 是 Kubernetes 集群中的一个网络插件，它提供了一个可扩展的虚拟网络，可以为 Pod 提供通信支持。Kubernetes 通过 Flannel 插件来实现容器网络的配置。Flannel 使用了一组覆盖整个集群的虚拟网络，为 Kubernetes 集群中的所有节点提供了一个全局唯一的 IP 地址段。Flannel 还提供了一些其他功能，比如网络安全性和负载均衡等。
```

```text
Caldremch
flannel能覆盖到其他虚拟机的 节点吗？ 比如我有3台虚拟机， 1台master， 2台worker， flannel网络插件是如何做到位所有的阶段提供唯一的ip地址呢？
是的，Flannel可以覆盖到Kubernetes集群中所有节点，包括Master和Worker节点。在Kubernetes集群中，每个节点都被分配了一个唯一的IP地址，并且可以通过这个IP地址相互通信。

在Flannel中，每个节点都会被分配一个子网，所有节点都在同一个大的虚拟网络中。当Pod需要与其他节点上的Pod通信时，Flannel会负责将源和目标IP地址转换为它们在虚拟网络中的IP地址。因此，Flannel确保了Kubernetes集群中所有Pod的IP地址都是唯一的，并且可以在集群中的任何节点之间进行通信。
```


但是我执行kubectl， 报错： 

```text
couldn't get current server API group list: Get "https://mymaster:6443/api?timeout=32s": net/http: TLS handshake timeout
```


这不是完犊子了吗？

经过各种查询，确定是了网络相关的问题， 执行iptables -L 发现确实
有错误：

```text
k8s REJECT     tcp  --  anywhere             10.96.0.10           /* kube-system/kube-dns:dns-tcp has no endpoints */ tcp dpt:domain reject-with icmp-port-unreachable
```

解决参考：https://discuss.kubernetes.io/t/coredns-not-working/9796/5
执行： iptables -A INPUT -p tcp -m tcp --dport 6443 -j ACCEPT

随后我又重新init了一遍， kubeadm reset , kubeadm init(之前的配置)， 成功后也是按照步骤执行完毕后， 
再次执行
```text
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```

成功了
```text
root@master:~# kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
namespace/kube-flannel created
serviceaccount/flannel created
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
configmap/kube-flannel-cfg created
daemonset.apps/kube-flannel-ds created
```

sudo docker run -d --restart=unless-stopped -p 10080:80 -p 10443:443 --privileged rancher/rancher

docker logs  3aa57912771bdb0f46615fb92cfed2f661fa6f2123f79b8bb60f6b9f1cca56bd  2>&1 | grep "Bootstrap Password:"
docker logs  d71f41f45c9309b8fa7a03cb1dbb0b784b432e4edb0bced81bc9707b1a632df4  2>&1 | grep "Bootstrap Password:"
参考：
https://www.jianshu.com/p/520d6414a4ab

flannel是什么？它是一个专门为 k8s 设置的网络规划服务，可以让集群中的不同节点主机创建的 docker 容器都具有全集群唯一的虚拟IP地址。想要部署flannel的话直接执行下述命令即可：

# kubeadm init成功+网络插件flannel成功后， 

执行 kubectl， 还是报错： Get "https://mymaster:6443/api/v1/namespaces/default/pods?limit=500": dial tcp 192.168.101.31:6443: connect: connection refused -

# 经过网上查阅， 有可能是cgroupdriver的原因：

kubelet需要指定driver， 默认是systemd， 但是我们的容器运行时是containerd，为了能能k8s更好的管理
容器进程和资源等， 我们需要制定--cgroup-driver=cri-containerd
--cgroup-driver=cri-containerd