使用阿里镜像安装

# 配置源

```shell
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
```

# 安装

$ yum install -y kubelet kubeadm kubectl

ipvsadm

作者：GoGooGooo
链接：https://www.jianshu.com/p/31bee0cecaf2
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

yum install -y kubelet kubeadm kubectl

# Kubeadm初始化报错：[ERROR CRI]: container runtime is not running:

https://www.cnblogs.com/ztxd/articles/16505585.html

# kubeadm init 报错：

	[ERROR FileAvailable--etc-kubernetes-manifests-kube-apiserver.yaml]: /etc/kubernetes/manifests/kube-apiserver.yaml already exists
	[ERROR FileAvailable--etc-kubernetes-manifests-kube-controller-manager.yaml]: /etc/kubernetes/manifests/kube-controller-manager.yaml already exists
	[ERROR FileAvailable--etc-kubernetes-manifests-kube-scheduler.yaml]: /etc/kubernetes/manifests/kube-scheduler.yaml already exists
	[ERROR FileAvailable--etc-kubernetes-manifests-etcd.yaml]: /etc/kubernetes/manifests/etcd.yaml already exists
	[ERROR Port-10250]: Port 10250 is in use
	[ERROR Port-2379]: Port 2379 is in use
	[ERROR Port-2380]: Port 2380 is in use
	[ERROR DirAvailable--var-lib-etcd]: /var/lib/etcd is not empty

————————————————
版权声明：本文为CSDN博主「Tz.」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/weixin_42551369/article/details/89213629

kubeadm reset

kubeadm init --apiserver-advertise-address=120.78.137.197   \
--image-repository registry.aliyuncs.com/google_containers  \
--pod-network-cidr=10.244.0.0/16

kubeadm init --image-repository=registry.aliyuncs.com/google_containers --kubernetes-version=1.26.3 \
--control-plane-endpoint==172.18.213.88:6443 \
--pod-network-cidr=10.244.0.0/16 \
--skip-phases=addon/kube-proxy \
-v=5

kubeadm init --image-repository=registry.aliyuncs.com/google_containers --kubernetes-version=1.26.3 \
--control-plane-endpoint=120.78.137.197:6443 \
--pod-network-cidr=10.244.0.0/16 \
--skip-phases=addon/kube-proxy \
-v=5

kubeadm init --image-repository=registry.aliyuncs.com/google_containers --kubernetes-version=1.26.3 \
--apiserver-advertise-address=120.78.137.197 \
--pod-network-cidr=10.244.0.0/16 \
-v=5

```shell
kubeadm init --image-repository=registry.aliyuncs.com/google_containers  --kubernetes-version=1.26.3 \
--pod-network-cidr=10.244.0.0/16 \
-v=5
```

kubeadm init --apiserver-advertise-address=192.168.20.150 --image-repository=registry.aliyuncs.com/google_containers \
--pod-network-cidr=10.244.0.0/16 \
-v=5

kubeadm init --image-repository=registry.aliyuncs.com/google_containers \
--pod-network-cidr=10.244.0.0/16 \
-v=5

报错:

```text
[preflight] Some fatal errors occurred:
        [ERROR CRI]: container runtime is not running: output: E0411 21:22:46.358738    5715 remote_runtime.go:616] "Status from runtime service failed" err="rpc error: code = Unavailable desc = connection error: desc = \"transport: Error while dialing dial unix /var/run/containerd/containerd.sock: connect: no such file or directory\""
time="2023-04-11T21:22:46+08:00" level=fatal msg="getting status of runtime: rpc error: code = Unavailable desc = connection error: desc = \"transport: Error while dialing dial unix /var/run/containerd/containerd.sock: connect: no such file or directory\""
, error: exit status 1
        [ERROR FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
        [ERROR FileContent--proc-sys-net-ipv4-ip_forward]: /proc/sys/net/ipv4/ip_forward contents are not set to 1
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
error execution phase preflight
```

# 解决

```shell
modprobe br_netfilter
echo 1 > /proc/sys/net/ipv4/ip_forward
```

# 然后继续报错

```text
[preflight] Some fatal errors occurred:
        [ERROR CRI]: container runtime is not running: output: E0411 21:29:49.692306    6430 remote_runtime.go:616] "Status from runtime service failed" err="rpc error: code = Unavailable desc = connection error: desc = \"transport: Error while dialing dial unix /var/run/containerd/containerd.sock: connect: no such file or directory\""
time="2023-04-11T21:29:49+08:00" level=fatal msg="getting status of runtime: rpc error: code = Unavailable desc = connection error: desc = \"transport: Error while dialing dial unix /var/run/containerd/containerd.sock: connect: no such file or directory\""
, error: exit status 1
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
error execution phase preflight
k8s.io/kubernetes/cmd/kubeadm/app/cmd/phases/workflow.(*Runner).Run.func1
        cmd/kubeadm/app/cmd/phases/workflow/runner.go:260
k8s.io/kubernetes/cmd/kubeadm/app/cmd/phases/workflow.(*Runner).visitAll
        cmd/kubeadm/app/cmd/phases/workflow/runner.go:446
k8s.io/kubernetes/cmd/kubeadm/app/cmd/phases/workflow.(*Runner).Run
        cmd/kubeadm/app/cmd/phases/workflow/runner.go:232
k8s.io/kubernetes/cmd/kubeadm/app/cmd.newCmdInit.func1
        cmd/kubeadm/app/cmd/init.go:112
github.com/spf13/cobra.(*Command).execute
        vendor/github.com/spf13/cobra/command.go:916
github.com/spf13/cobra.(*Command).ExecuteC
        vendor/github.com/spf13/cobra/command.go:1040
github.com/spf13/cobra.(*Command).Execute
        vendor/github.com/spf13/cobra/command.go:968
k8s.io/kubernetes/cmd/kubeadm/app.Run
        cmd/kubeadm/app/kubeadm.go:50
main.main
        cmd/kubeadm/kubeadm.go:25
runtime.main
        /usr/local/go/src/runtime/proc.go:250
runtime.goexit
        /usr/local/go/src/runtime/asm_amd64.s:1594
```

# 检查了一下 ctr

```shell
ctr image list
```

结果

```text
ctr: failed to dial "/run/containerd/containerd.sock": context deadline exceeded: connection error:
 desc = "transport: error while dialing: dial unix:///run/containerd/containerd.sock: timeout"
```

果然没报错, 就是没启动起来(if you has not install , install it)
systemctl restart contained

最终执行还是报错:

```text
validate service connection: CRI v1 runtime API is not implemented for endpoint \"unix:///var/run/containerd/containerd.sock
```

参考: https://github.com/containerd/containerd/issues/8139 解决

# 解决办法

please go to /etc/containerd/config.toml
change disabled_plugin to enabled_plugin

#  

kubelet日志可以查看是因为镜像拉不下来导致kubeadm失败， 参考：
[记录一次kubeadm安装失败]（https://juejin.cn/post/7214286192761782333）

docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.6 registry.k8s.io/pause:3.6
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.26.3 registry.k8s.io/kube-apiserver:
v1.26.3
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.26.3
registry.k8s.io/kube-controller-manager:v1.26.3
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.26.3 registry.k8s.io/kube-scheduler:
v1.26.3
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.26.3 registry.k8s.io/kube-proxy:v1.26.3
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.9 registry.k8s.io/pause:3.9
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.5.6-0 registry.k8s.io/etcd:3.5.6-0
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:v1.9.3 registry.k8s.io/coredns/coredns:v1.9.3

Kubernetes和Docker在容器云生态中霸主地位相争由来已久。其争斗的结果之一：自Kubernetes1.24以后，K8S就不再原生支持docker

【K8S 八】使用containerd作为CRI https://blog.csdn.net/avatar_2009/article/details/126020671

[kubernetes 集群部署问题点统计](https://www.cnblogs.com/yangzp/p/16380803.html)

# centos7 安装 阿里云 k8s 参考: https://www.vpssw.com/83.html

1. kubeadm init --config=kubeadm-config.yaml | tee kubeadm-init.log

```text
registry.k8s.io/kube-apiserver:v1.26.3
registry.k8s.io/kube-controller-manager:v1.26.3
registry.k8s.io/kube-scheduler:v1.26.3
registry.k8s.io/kube-proxy:v1.26.3
registry.k8s.io/pause:
registry.k8s.io/etcd:3.5.6-0
registry.k8s.io/coredns/coredns:v1.9.3
```

# 牛逼, 真像大白了

kubeadm config images pull 报错:

```text
I0416 14:18:24.961054   24963 version.go:256] remote version is much newer: v1.27.1; falling back to: stable-1.26
failed to pull image "registry.k8s.io/kube-apiserver:v1.26.4": output: E0416 14:20:56.239362   25098 remote_image.go:171] 
"PullImage from image service failed" err="rpc error: code = DeadlineExceeded desc = failed to pull and unpack image \"registry.k8s.io/kube-apiserver:v1.26.4\": failed to resolve reference \"registry.k8s.io/kube-apiserver:v1.26.4\": failed to do request: Head \"https://asia-east1-docker.pkg.dev/v2/k8s-artifacts-prod/images/kube-apiserver/manifests/v1.26.4\": dial tcp 64.233.188.82:443: i/o timeout" image="registry.k8s.io/kube-apiserver:v1.26.4"
time="2023-04-16T14:20:56+08:00" level=fatal msg="pulling image: rpc error: code = DeadlineExceeded desc = failed to pull and unpack image \"registry.k8s.io/kube-apiserver:v1.26.4\": failed to resolve reference \"registry.k8s.io/kube-apiserver:v1.26.4\": failed to do request: Head \"https://asia-east1-docker.pkg.dev/v2/k8s-artifacts-prod/images/kube-apiserver/manifests/v1.26.4\": dial tcp 64.233.188.82:443: i/o timeout"
, error: exit status 1
To see the stack trace of this error execute with --v=5 or higher
```

kubeadm config images pull 命令默认使用 crictl 命令行工具来拉取 Kubernetes 组件镜像，而不是 containerd。 crictl 是
CRI（Container Runtime Interface）的命令行工具，而 containerd 则是 CRI 的一种实现。但是，您可以通过修改 kubeadm 的配置来使用
containerd。

如果您想检查镜像是否已经成功拉取，可以运行以下命令查看本地镜像列表：

Copy code
crictl images
这将显示所有在本地注册的镜像列表，您应该可以在其中看到拉取的 Kubernetes 组件镜像。 如果您使用 containerd 代替 crictl
来拉取镜像，则可以使用以下命令来检查镜像是否存在于本地存储中：

Copy code
containerd ctr images list
这将显示在本地存储中注册的所有镜像列表，您应该可以在其中看到拉取的 Kubernetes 组件镜像。

kubeadm config images pull | tee kubeadm-images-pull.log

# 问题, 我已经通过crictl将image-end-point设置为了containerd, 但是当我执行

2个images查看的时候, ctr的images跟 crictl的images不一致, 这让我很疑惑, 为什么呢?

namespace不一样, 这是什么意思?

ctr namespace ls

```text
default        
k8s.io         
moby   
```

重新指定namespace 打一个tag看看

```shell
# -n表示指定命名空间, i表示镜像操作
ctr -n k8s.io i tag registry.aliyuncs.com/google_containers/kube-apiserver:v1.26.3 registry.k8s.io/kube-apiserver:v1.26.3
```

这个时候, 就出现了
crictl image ls, 就可以看到镜像了:  registry.k8s.io/kube-apiserver:v1.26.3

在打tag的时候, 需要指定命名空间, 这个主要是因为存在OCI运行时, 不同容器可以根据命名空间来做逻辑隔离

# kubeadm config

cat >> /etc/hosts << EOF
192.168.20.150 k8s-master
EOF

# 以下参考来自: https://www.lixueduan.com/posts/kubernetes/01-install/

# 一条条分析失败原因

```text
root@k8s-master:~# kubeadm init --config=kubeadm.yml --upload-certs | tee kubeadm-init.log
[init] Using Kubernetes version: v1.27.1
[preflight] Running pre-flight checks
        [WARNING HTTPProxy]: Connection to "https://192.168.20.150" uses proxy "http://127.0.0.1:7890". If that is not intended, adjust your proxy settings
        [WARNING HTTPProxyCIDR]: connection to "10.96.0.0/12" uses proxy "http://127.0.0.1:7890". This may lead to malfunctional cluster setup. Make sure that Pod and Services IP ranges specified correctly as exceptions in proxy configuration
        [WARNING HTTPProxyCIDR]: connection to "192.168.0.0/16" uses proxy "http://127.0.0.1:7890". This may lead to malfunctional cluster setup. Make sure that Pod and Services IP ranges specified correctly as exceptions in proxy configuration
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
W0419 01:33:59.288000    3896 images.go:80] could not find officially supported version of etcd for Kubernetes v1.27.1, falling back to the nearest etcd version (3.5.7-0)
W0419 01:33:59.375564    3896 checks.go:835] detected that the sandbox image "registry.k8s.io/pause:3.6" of the container runtime is inconsistent with that used by kubeadm. It is recommended that using "registry.aliyuncs.com/google_containers/pause:3.9" as the CRI sandbox image.
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [k8s-master kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.20.150]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [k8s-master localhost] and IPs [192.168.20.150 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [k8s-master localhost] and IPs [192.168.20.150 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
W0419 01:34:01.605669    3896 images.go:80] could not find officially supported version of etcd for Kubernetes v1.27.1, falling back to the nearest etcd version (3.5.7-0)
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[kubelet-check] Initial timeout of 40s passed.

Unfortunately, an error has occurred:
        timed out waiting for the condition

This error is likely caused by:
        - The kubelet is not running
        - The kubelet is unhealthy due to a misconfiguration of the node in some way (required cgroups disabled)

If you are on a systemd-powered system, you can try to troubleshoot the error with the following commands:
        - 'systemctl status kubelet'
        - 'journalctl -xeu kubelet'

Additionally, a control plane component may have crashed or exited when started by the container runtime.
To troubleshoot, list all containers using your preferred container runtimes CLI.
Here is one example how you may list all running Kubernetes containers by using crictl:
        - 'crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock ps -a | grep kube | grep -v pause'
        Once you have found the failing container, you can inspect its logs with:
        - 'crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock logs CONTAINERID'
error execution phase wait-control-plane: couldn't initialize a Kubernetes cluster
To see the stack trace of this error execute with --v=5 or higher
```

1. detected that the sandbox image "registry.k8s.io/pause:3.6" of the container runtime is inconsistent with that used
   by kubeadm. It is recommended that using "registry.aliyuncs.com/google_containers/pause:3.9" as the CRI sandbox
   image.

```text
#一键替换
sed 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
用国内源替换 containerd 默认的 sand_box 镜像，编辑 /etc/containerd/config.toml

[plugins]
  .....
  [plugins."io.containerd.grpc.v1.cri"]
  	...
	sandbox_image = "registry.aliyuncs.com/google_containers/pause:3.5"
```

```shell
systemctl daemon-reload
systemctl enable containerd --now
```

修改完后重新执行:

```shell
kubeadm reset
kubeadm init --config=kubeadm.yml --upload-certs | tee kubeadm-init.log --v=5
```

接下来报错的是:
error execution phase addon/kube-proxy: error when creating kube-proxy service account: unable to create serviceaccount:
the server was unable to return a response in the time allotted, but may still be processing the request (post
serviceaccounts)
To see the stack trace of this error execute with --v=5 or higher

尝试一下先去掉 --upload-certs

```shell
kubeadm reset
kubeadm init --config=kubeadm.yml --v=5 | tee kubeadm-init.log 
```

结果成功了

```text


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

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.20.150:6443 --token abcdef.0123456789abcdef \
        --discovery-token-ca-cert-hash sha256:6e0d9e36a91ad049a7aaf8cb89655969ea49bdc4f7c6b3d050a999ff69f8e180
```

执行成功后的提示操作, 不然你执行kubectl get nodes会报错:

```shell
kubectl get node
E0419 01:53:34.362622    8375 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
The connection to the server localhost:8080 was refused - did you specify the right host or port?
```

```shell
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
```

然后执行 kubectl get namespace 验证安装结果

报错:

```shell
Get "https://192.168.20.150:6443/api/v1/namespaces?limit=500": read tcp 127.0.0.1:54612->127.0.0.1:7890: read: connection reset by peer - error from a previous attempt: read tcp 127.0.0.1:54578->127.0.0.1:7890: read: connection reset by peer
```

尝试把代理关闭掉(临时)

```text
systemctl stop clash
unset http_proxy && unset https_proxy
```

再次验证命令, 成功了

```text
root@k8s-master:~# kubectl get namespace
NAME              STATUS   AGE
default           Active   7m4s
kube-node-lease   Active   7m4s
kube-public       Active   7m4s
kube-system       Active   7m4s
```

没过多久(重新连接了ssh)执行 kubectl命令, 又报错

```text
The connection to the server 192.168.20.150:6443 was refused - did you specify the right host or port?
```

查看代理

```shell
echo $http_proxy
http://127.0.0.1:7890
```

发现代理还在
是因为自己在/etc/profile里面设置了代理

```shell
vim /etc/profile
# export http_proxy="http://127.0.0.1:7890"
# export https_proxy="http://127.0.0.1:7890"
# export no_proxy="localhost, 127.0.0.1"
```

将代理注释掉,

```shell
source /etc/profile
unset http_proxy && unset https_proxy
```

还是一样报错:

```text
The connection to the server 192.168.20.150:6443 was refused - did you specify the right host or port?
```

查看kubelet的日志:看到有

```text
"Container runtime network not ready" networkReady="NetworkReady=false reason:NetworkPluginNotReady
```

安装插件, 之前指定的calico

```shell
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.1/manifests/tigera-operator.yaml
```

还是报错:

```text
The connection to the server 192.168.20.150:6443 was refused - did you specify the right host or port?
```

kubelet的日志详情如下:

```text
root@k8s-master:~# systemctl status kubelet >> kubelet-status.log
root@k8s-master:~# cat kubelet-status.log 
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /etc/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Wed 2023-04-19 02:30:13 UTC; 1min 7s ago
       Docs: https://kubernetes.io/docs/home/
   Main PID: 18393 (kubelet)
      Tasks: 15 (limit: 18868)
     Memory: 33.0M
        CPU: 4.045s
     CGroup: /system.slice/kubelet.service
             └─18393 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock --pod-infra-container-image=registry.aliyuncs.com/google_containers/pause:3.9

Apr 19 02:30:59 k8s-master kubelet[18393]: I0419 02:30:59.266857   18393 status_manager.go:809] "Failed to get status for pod" podUID=221c9b312c7e445f789c9747e27948d7 pod="kube-system/kube-apiserver-k8s-master" err="Get \"https://192.168.20.150:6443/api/v1/namespaces/kube-system/pods/kube-apiserver-k8s-master\": dial tcp 192.168.20.150:6443: connect: connection refused"
Apr 19 02:30:59 k8s-master kubelet[18393]: I0419 02:30:59.266948   18393 status_manager.go:809] "Failed to get status for pod" podUID=b82ad40b-58f1-4cbb-b86f-d83c4e1a0466 pod="kube-system/kube-proxy-7tdvt" err="Get \"https://192.168.20.150:6443/api/v1/namespaces/kube-system/pods/kube-proxy-7tdvt\": dial tcp 192.168.20.150:6443: connect: connection refused"
Apr 19 02:30:59 k8s-master kubelet[18393]: I0419 02:30:59.267082   18393 status_manager.go:809] "Failed to get status for pod" podUID=3b7ba1f2e8760903ae6130df6b3ac925 pod="kube-system/kube-controller-manager-k8s-master" err="Get \"https://192.168.20.150:6443/api/v1/namespaces/kube-system/pods/kube-controller-manager-k8s-master\": dial tcp 192.168.20.150:6443: connect: connection refused"
Apr 19 02:31:00 k8s-master kubelet[18393]: E0419 02:31:00.682433   18393 controller.go:146] "Failed to ensure lease exists, will retry" err="Get \"https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-node-lease/leases/k8s-master?timeout=10s\": dial tcp 192.168.20.150:6443: connect: connection refused" interval="7s"
Apr 19 02:31:02 k8s-master kubelet[18393]: I0419 02:31:02.618747   18393 scope.go:115] "RemoveContainer" containerID="13e848826fe3fd76643bfbe0b81292aff84cde93292559b1790c51894d389a9c"
Apr 19 02:31:02 k8s-master kubelet[18393]: I0419 02:31:02.799631   18393 status_manager.go:809] "Failed to get status for pod" podUID=3b7ba1f2e8760903ae6130df6b3ac925 pod="kube-system/kube-controller-manager-k8s-master" err="Get \"https://192.168.20.150:6443/api/v1/namespaces/kube-system/pods/kube-controller-manager-k8s-master\": dial tcp 192.168.20.150:6443: connect: connection refused"
Apr 19 02:31:02 k8s-master kubelet[18393]: I0419 02:31:02.800040   18393 status_manager.go:809] "Failed to get status for pod" podUID=859e90723142b3e20eb076abe67c95bf pod="kube-system/kube-scheduler-k8s-master" err="Get \"https://192.168.20.150:6443/api/v1/namespaces/kube-system/pods/kube-scheduler-k8s-master\": dial tcp 192.168.20.150:6443: connect: connection refused"
Apr 19 02:31:02 k8s-master kubelet[18393]: I0419 02:31:02.800460   18393 status_manager.go:809] "Failed to get status for pod" podUID=8bb16157bca99ebb8a72cafaf9ca65a6 pod="kube-system/etcd-k8s-master" err="Get \"https://192.168.20.150:6443/api/v1/namespaces/kube-system/pods/etcd-k8s-master\": dial tcp 192.168.20.150:6443: connect: connection refused"
Apr 19 02:31:02 k8s-master kubelet[18393]: I0419 02:31:02.800842   18393 status_manager.go:809] "Failed to get status for pod" podUID=221c9b312c7e445f789c9747e27948d7 pod="kube-system/kube-apiserver-k8s-master" err="Get \"https://192.168.20.150:6443/api/v1/namespaces/kube-system/pods/kube-apiserver-k8s-master\": dial tcp 192.168.20.150:6443: connect: connection refused"
Apr 19 02:31:02 k8s-master kubelet[18393]: I0419 02:31:02.801150   18393 status_manager.go:809] "Failed to get status for pod" podUID=b82ad40b-58f1-4cbb-b86f-d83c4e1a0466 pod="kube-system/kube-proxy-7tdvt" err="Get \"https://192.168.20.150:6443/api/v1/namespaces/kube-system/pods/kube-proxy-7tdvt\": dial tcp 192.168.20.150:6443: connect: connection refused"
```

分析: 这个到底是什么原因呢?

经过各种尝试

```shell
iptables -A INPUT -p tcp -m tcp --dport 6443 -j ACCEPT
systemctl restart kubelet
```

systemctl restart kubelet 只有有一个短暂的时间,是可以正常使用kubectl的, 但是过一会又不行了

```text
root@k8s-master:~# kubectl get ns
NAME              STATUS   AGE
default           Active   72m
kube-node-lease   Active   72m
kube-public       Active   72m
kube-system       Active   72m
root@k8s-master:~# kubectl get ns
NAME              STATUS   AGE
default           Active   72m
kube-node-lease   Active   72m
kube-public       Active   72m
kube-system       Active   72m
root@k8s-master:~# kubectl get nodes
NAME         STATUS     ROLES           AGE   VERSION
k8s-master   NotReady   control-plane   72m   v1.27.1
root@k8s-master:~# kubectl get nodes
NAME         STATUS     ROLES           AGE   VERSION
k8s-master   NotReady   control-plane   72m   v1.27.1
root@k8s-master:~# kubectl get nodes
The connection to the server 192.168.20.150:6443 was refused - did you specify the right host or port?
root@k8s-master:~# kubectl get nodes
The connection to the server 192.168.20.150:6443 was refused - did you specify the right host or port?
```

所以看看能不能趁它生效的时候, 先把网络插件安装上

```shell
wget -O calico.yaml https://raw.githubusercontent.com/projectcalico/calico/v3.25.1/manifests/tigera-operator.yaml
kubectl create -f calico.yaml
```

# 算了重新来一次安装

```text
kubeadm reset
rm -rf $HOME/.kube
# 此时加上了--upload-certs
 kubeadm init --config=kubeadm.yml --upload-certs --v=5 | tee kubeadm-init.log
 kubeadm init --config=kubeadm.yml --v=5 | tee kubeadm-init.log
```

安装成功后, 此时没啥问题
执行命令验证

```shell
root@k8s-master:~# kubectl get nodes
NAME         STATUS     ROLES           AGE    VERSION
k8s-master   NotReady   control-plane   3m8s   v1.27.1
```

在没有安装网络插件的时候, node的状态是NotReady

# 然后这次自己将网络插件改成了flannel

```shell
wget -O flannel.yaml https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
kubectl apply -f flannel.yaml
```

安装网络插件后,

```shell
root@k8s-master:~# kubectl get pods -A
NAMESPACE      NAME                                 READY   STATUS    RESTARTS         AGE
kube-flannel   kube-flannel-ds-6wlln                1/1     Running   0                38s
kube-system    coredns-7bdc4cb885-gk2bm             1/1     Running   0                5m26s
kube-system    coredns-7bdc4cb885-q9wnc             1/1     Running   0                5m26s
kube-system    etcd-k8s-master                      1/1     Running   43 (5m12s ago)   2m22s
kube-system    kube-apiserver-k8s-master            1/1     Running   2 (3m26s ago)    6m31s
kube-system    kube-controller-manager-k8s-master   1/1     Running   5 (2m27s ago)    6m31s
kube-system    kube-scheduler-k8s-master            1/1     Running   3 (3m24s ago)    3m24s
root@k8s-master:~# kubectl get ns- A
error: the server doesn't have a resource type "ns-"
root@k8s-master:~# kubectl get ns -A
NAME              STATUS   AGE
default           Active   6m45s
kube-flannel      Active   88s
kube-node-lease   Active   6m45s
kube-public       Active   6m45s
kube-system       Active   6m45s
root@k8s-master:~# kubectl get node
NAME         STATUS   ROLES           AGE     VERSION
k8s-master   Ready    control-plane   6m57s   v1.27.1
```

过了一会查看, pods的详情

```text
root@k8s-master:~# kubectl get pods -A
NAMESPACE      NAME                                 READY   STATUS             RESTARTS         AGE
kube-flannel   kube-flannel-ds-6wlln                1/1     Running            0                3m23s
kube-system    coredns-7bdc4cb885-gk2bm             1/1     Running            0                8m11s
kube-system    coredns-7bdc4cb885-q9wnc             1/1     Running            0                8m11s
kube-system    etcd-k8s-master                      1/1     Running            43 (7m57s ago)   5m7s
kube-system    kube-apiserver-k8s-master            1/1     Running            3 (98s ago)      9m16s
kube-system    kube-controller-manager-k8s-master   0/1     CrashLoopBackOff   5 (118s ago)     9m16s
kube-system    kube-scheduler-k8s-master            1/1     Running            4 (117s ago)     6m9s
```

发现:
kube-system kube-controller-manager-k8s-master 0/1 CrashLoopBackOff 5 (118s ago)     9m16s

这个是什么问题呢? 这个pod要是挂了, 就会引发 The connection to the server 192.168.20.150:6443 was refused - did you specify
the right host or port? 问题

最终确实挂了

```text
 37994 pod_workers.go:1281] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"kube-controller-manager\" with CrashLoopBackOff: \"back-off 5m0s restarting failed container=kube-controller-manager pod=kube-controller-manager-k8s-m>
```

然后kubectl命令又无法使用了
但是没关系, 由于 kube-controller-manager-k8s-master会一直restartd, 过一会又可以了, 只不过又过一会, 它就会又重启

问题是: kube-controller-manager-k8s-master 为什么会CrashLoopBackOff?
查看日志:

```text
root@k8s-master:~/.kube# kubectl logs kube-controller-manager-k8s-master -n kube-system
I0419 03:39:15.326987       1 serving.go:348] Generated self-signed cert in-memory
I0419 03:39:15.683692       1 controllermanager.go:187] "Starting" version="v1.27.1"
I0419 03:39:15.683703       1 controllermanager.go:189] "Golang settings" GOGC="" GOMAXPROCS="" GOTRACEBACK=""
I0419 03:39:15.684521       1 dynamic_cafile_content.go:157] "Starting controller" name="request-header::/etc/kubernetes/pki/front-proxy-ca.crt"
I0419 03:39:15.684601       1 dynamic_cafile_content.go:157] "Starting controller" name="client-ca-bundle::/etc/kubernetes/pki/ca.crt"
I0419 03:39:15.685048       1 secure_serving.go:210] Serving securely on 127.0.0.1:10257
I0419 03:39:15.685107       1 tlsconfig.go:240] "Starting DynamicServingCertificateController"
I0419 03:39:15.685214       1 leaderelection.go:245] attempting to acquire leader lease kube-system/kube-controller-manager...
E0419 03:39:15.685579       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
E0419 03:39:18.793239       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
E0419 03:39:21.714914       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
E0419 03:39:23.763733       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
E0419 03:39:27.159533       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
E0419 03:39:30.009160       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
E0419 03:39:33.938360       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
E0419 03:39:38.225152       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
E0419 03:39:41.804911       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
E0419 03:39:45.522200       1 leaderelection.go:327] error retrieving resource lock kube-system/kube-controller-manager: Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s": dial tcp 192.168.20.150:6443: connect: connection refused
I0419 03:40:05.246561       1 leaderelection.go:255] successfully acquired lease kube-system/kube-controller-manager
I0419 03:40:05.246728       1 event.go:307] "Event occurred" object="kube-system/kube-controller-manager" fieldPath="" kind="Lease" apiVersion="coordination.k8s.io/v1" type="Normal" reason="LeaderElection" message="k8s-master_4ef662ff-b160-4128-be2b-29f8667dcdd6 became leader"
I0419 03:40:05.265450       1 shared_informer.go:311] Waiting for caches to sync for tokens
I0419 03:40:05.270866       1 controllermanager.go:638] "Started controller" controller="pvc-protection"
I0419 03:40:05.271228       1 pvc_protection_controller.go:102] "Starting PVC protection controller"
I0419 03:40:05.271256       1 shared_informer.go:311] Waiting for caches to sync for PVC protection
I0419 03:40:05.276421       1 controllermanager.go:638] "Started controller" controller="endpointslice"
I0419 03:40:05.276565       1 endpointslice_controller.go:252] Starting endpoint slice controller
I0419 03:40:05.276595       1 shared_informer.go:311] Waiting for caches to sync for endpoint_slice
I0419 03:40:05.283153       1 controllermanager.go:638] "Started controller" controller="podgc"
I0419 03:40:05.283407       1 gc_controller.go:103] Starting GC controller
I0419 03:40:05.283440       1 shared_informer.go:311] Waiting for caches to sync for GC
I0419 03:40:05.327709       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="deployments.apps"
I0419 03:40:05.327812       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="podtemplates"
I0419 03:40:05.327900       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="statefulsets.apps"
I0419 03:40:05.327970       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="networkpolicies.networking.k8s.io"
I0419 03:40:05.328021       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="ingresses.networking.k8s.io"
I0419 03:40:05.328100       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="rolebindings.rbac.authorization.k8s.io"
I0419 03:40:05.328146       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="endpoints"
I0419 03:40:05.328196       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="roles.rbac.authorization.k8s.io"
W0419 03:40:05.328242       1 shared_informer.go:592] resyncPeriod 12h26m42.09564184s is smaller than resyncCheckPeriod 17h26m41.631248005s and the informer has already started. Changing it to 17h26m41.631248005s
I0419 03:40:05.328353       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="cronjobs.batch"
I0419 03:40:05.328404       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="jobs.batch"
I0419 03:40:05.328456       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="csistoragecapacities.storage.k8s.io"
I0419 03:40:05.328504       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="daemonsets.apps"
I0419 03:40:05.328616       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="controllerrevisions.apps"
I0419 03:40:05.328678       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="limitranges"
I0419 03:40:05.328723       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="replicasets.apps"
I0419 03:40:05.328771       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="horizontalpodautoscalers.autoscaling"
I0419 03:40:05.328818       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="poddisruptionbudgets.policy"
I0419 03:40:05.328856       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="endpointslices.discovery.k8s.io"
W0419 03:40:05.328905       1 shared_informer.go:592] resyncPeriod 13h48m49.282335488s is smaller than resyncCheckPeriod 17h26m41.631248005s and the informer has already started. Changing it to 17h26m41.631248005s
I0419 03:40:05.329024       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="serviceaccounts"
I0419 03:40:05.329079       1 resource_quota_monitor.go:223] "QuotaMonitor created object count evaluator" resource="leases.coordination.k8s.io"
I0419 03:40:05.329138       1 controllermanager.go:638] "Started controller" controller="resourcequota"
I0419 03:40:05.329219       1 resource_quota_controller.go:295] "Starting resource quota controller"
I0419 03:40:05.329256       1 shared_informer.go:311] Waiting for caches to sync for resource quota
I0419 03:40:05.329324       1 resource_quota_monitor.go:304] "QuotaMonitor running"
I0419 03:40:05.336341       1 certificate_controller.go:112] Starting certificate controller "csrsigning-kubelet-serving"
I0419 03:40:05.336377       1 shared_informer.go:311] Waiting for caches to sync for certificate-csrsigning-kubelet-serving
I0419 03:40:05.336436       1 dynamic_serving_content.go:132] "Starting controller" name="csr-controller::/etc/kubernetes/pki/ca.crt::/etc/kubernetes/pki/ca.key"
I0419 03:40:05.338855       1 certificate_controller.go:112] Starting certificate controller "csrsigning-kubelet-client"
I0419 03:40:05.338892       1 shared_informer.go:311] Waiting for caches to sync for certificate-csrsigning-kubelet-client
I0419 03:40:05.338892       1 dynamic_serving_content.go:132] "Starting controller" name="csr-controller::/etc/kubernetes/pki/ca.crt::/etc/kubernetes/pki/ca.key"
I0419 03:40:05.341291       1 certificate_controller.go:112] Starting certificate controller "csrsigning-kube-apiserver-client"
I0419 03:40:05.341324       1 shared_informer.go:311] Waiting for caches to sync for certificate-csrsigning-kube-apiserver-client
I0419 03:40:05.341375       1 dynamic_serving_content.go:132] "Starting controller" name="csr-controller::/etc/kubernetes/pki/ca.crt::/etc/kubernetes/pki/ca.key"
I0419 03:40:05.343618       1 controllermanager.go:638] "Started controller" controller="csrsigning"
I0419 03:40:05.343789       1 certificate_controller.go:112] Starting certificate controller "csrsigning-legacy-unknown"
I0419 03:40:05.343822       1 shared_informer.go:311] Waiting for caches to sync for certificate-csrsigning-legacy-unknown
I0419 03:40:05.343877       1 dynamic_serving_content.go:132] "Starting controller" name="csr-controller::/etc/kubernetes/pki/ca.crt::/etc/kubernetes/pki/ca.key"
I0419 03:40:05.348364       1 node_lifecycle_controller.go:431] "Controller will reconcile labels"
I0419 03:40:05.348430       1 controllermanager.go:638] "Started controller" controller="nodelifecycle"
I0419 03:40:05.348634       1 node_lifecycle_controller.go:465] "Sending events to api server"
I0419 03:40:05.348691       1 node_lifecycle_controller.go:476] "Starting node controller"
I0419 03:40:05.348706       1 shared_informer.go:311] Waiting for caches to sync for taint
I0419 03:40:05.353195       1 controllermanager.go:638] "Started controller" controller="persistentvolume-expander"
I0419 03:40:05.353325       1 expand_controller.go:339] "Starting expand controller"
I0419 03:40:05.353360       1 shared_informer.go:311] Waiting for caches to sync for expand
I0419 03:40:05.357694       1 controllermanager.go:638] "Started controller" controller="clusterrole-aggregation"
I0419 03:40:05.357857       1 clusterroleaggregation_controller.go:189] "Starting ClusterRoleAggregator controller"
I0419 03:40:05.357894       1 shared_informer.go:311] Waiting for caches to sync for ClusterRoleAggregator
I0419 03:40:05.362313       1 controllermanager.go:638] "Started controller" controller="endpoint"
I0419 03:40:05.362589       1 endpoints_controller.go:172] Starting endpoint controller
I0419 03:40:05.362617       1 shared_informer.go:311] Waiting for caches to sync for endpoint
I0419 03:40:05.365952       1 shared_informer.go:318] Caches are synced for tokens
I0419 03:40:05.366813       1 controllermanager.go:638] "Started controller" controller="serviceaccount"
I0419 03:40:05.366897       1 serviceaccounts_controller.go:111] "Starting service account controller"
I0419 03:40:05.366922       1 shared_informer.go:311] Waiting for caches to sync for service account
I0419 03:40:05.371563       1 controllermanager.go:638] "Started controller" controller="job"
I0419 03:40:05.371917       1 job_controller.go:202] Starting job controller
I0419 03:40:05.371947       1 shared_informer.go:311] Waiting for caches to sync for job
I0419 03:40:05.376281       1 controllermanager.go:638] "Started controller" controller="cronjob"
I0419 03:40:05.376361       1 cronjob_controllerv2.go:139] "Starting cronjob controller v2"
I0419 03:40:05.376388       1 shared_informer.go:311] Waiting for caches to sync for cronjob
I0419 03:40:05.380577       1 controllermanager.go:638] "Started controller" controller="csrcleaner"
I0419 03:40:05.380720       1 cleaner.go:82] Starting CSR cleaner controller
I0419 03:40:05.385076       1 controllermanager.go:638] "Started controller" controller="bootstrapsigner"
I0419 03:40:05.385115       1 shared_informer.go:311] Waiting for caches to sync for bootstrap_signer
E0419 03:40:05.392771       1 core.go:92] "Failed to start service controller" err="WARNING: no cloud provider provided, services of type LoadBalancer will fail"
I0419 03:40:05.392962       1 controllermanager.go:616] "Warning: skipping controller" controller="service"
I0419 03:40:05.400417       1 controllermanager.go:638] "Started controller" controller="ttl-after-finished"
I0419 03:40:05.400743       1 ttlafterfinished_controller.go:109] "Starting TTL after finished controller"
I0419 03:40:05.400878       1 shared_informer.go:311] Waiting for caches to sync for TTL after finished
I0419 03:40:05.428149       1 controllermanager.go:638] "Started controller" controller="namespace"
I0419 03:40:05.428229       1 namespace_controller.go:197] "Starting namespace controller"
I0419 03:40:05.428258       1 shared_informer.go:311] Waiting for caches to sync for namespace
I0419 03:40:05.432745       1 controllermanager.go:638] "Started controller" controller="deployment"
I0419 03:40:05.432921       1 deployment_controller.go:168] "Starting controller" controller="deployment"
I0419 03:40:05.432960       1 shared_informer.go:311] Waiting for caches to sync for deployment
I0419 03:40:05.437098       1 controllermanager.go:638] "Started controller" controller="replicaset"
I0419 03:40:05.437241       1 replica_set.go:201] "Starting controller" name="replicaset"
I0419 03:40:05.437269       1 shared_informer.go:311] Waiting for caches to sync for ReplicaSet
I0419 03:40:05.453470       1 controllermanager.go:638] "Started controller" controller="horizontalpodautoscaling"
I0419 03:40:05.453535       1 horizontal.go:200] "Starting HPA controller"
I0419 03:40:05.453563       1 shared_informer.go:311] Waiting for caches to sync for HPA
I0419 03:40:15.483139       1 range_allocator.go:111] "No Secondary Service CIDR provided. Skipping filtering out secondary service addresses"
I0419 03:40:15.483248       1 controllermanager.go:638] "Started controller" controller="nodeipam"
I0419 03:40:15.483600       1 node_ipam_controller.go:162] "Starting ipam controller"
I0419 03:40:15.483638       1 shared_informer.go:311] Waiting for caches to sync for node
I0419 03:40:15.488496       1 controllermanager.go:638] "Started controller" controller="persistentvolume-binder"
I0419 03:40:15.488653       1 pv_controller_base.go:323] "Starting persistent volume controller"
I0419 03:40:15.488691       1 shared_informer.go:311] Waiting for caches to sync for persistent volume
I0419 03:40:15.493425       1 controllermanager.go:638] "Started controller" controller="daemonset"
I0419 03:40:15.493724       1 daemon_controller.go:291] "Starting daemon sets controller"
I0419 03:40:15.493766       1 shared_informer.go:311] Waiting for caches to sync for daemon sets
I0419 03:40:15.498455       1 controllermanager.go:638] "Started controller" controller="statefulset"
I0419 03:40:15.498584       1 stateful_set.go:161] "Starting stateful set controller"
I0419 03:40:15.498617       1 shared_informer.go:311] Waiting for caches to sync for stateful set
E0419 03:40:15.503169       1 core.go:213] "Failed to start cloud node lifecycle controller" err="no cloud provider provided"
I0419 03:40:15.503217       1 controllermanager.go:616] "Warning: skipping controller" controller="cloud-node-lifecycle"
I0419 03:40:15.508398       1 controllermanager.go:638] "Started controller" controller="pv-protection"
I0419 03:40:15.508515       1 pv_protection_controller.go:78] "Starting PV protection controller"
I0419 03:40:15.508554       1 shared_informer.go:311] Waiting for caches to sync for PV protection
I0419 03:40:15.513379       1 controllermanager.go:638] "Started controller" controller="replicationcontroller"
I0419 03:40:15.513535       1 replica_set.go:201] "Starting controller" name="replicationcontroller"
I0419 03:40:15.513573       1 shared_informer.go:311] Waiting for caches to sync for ReplicationController
I0419 03:40:15.518041       1 controllermanager.go:638] "Started controller" controller="csrapproving"
I0419 03:40:15.518213       1 certificate_controller.go:112] Starting certificate controller "csrapproving"
I0419 03:40:15.518247       1 shared_informer.go:311] Waiting for caches to sync for certificate-csrapproving
I0419 03:40:15.522821       1 controllermanager.go:638] "Started controller" controller="ttl"
I0419 03:40:15.522985       1 ttl_controller.go:124] "Starting TTL controller"
I0419 03:40:15.523022       1 shared_informer.go:311] Waiting for caches to sync for TTL
I0419 03:40:15.527717       1 controllermanager.go:638] "Started controller" controller="tokencleaner"
I0419 03:40:15.527770       1 core.go:228] "Warning: configure-cloud-routes is set, but no cloud provider specified. Will not configure cloud provider routes."
I0419 03:40:15.527780       1 tokencleaner.go:112] "Starting token cleaner controller"
I0419 03:40:15.527800       1 controllermanager.go:616] "Warning: skipping controller" controller="route"
I0419 03:40:15.527813       1 shared_informer.go:311] Waiting for caches to sync for token_cleaner
I0419 03:40:15.527836       1 shared_informer.go:318] Caches are synced for token_cleaner
I0419 03:40:15.532833       1 controllermanager.go:638] "Started controller" controller="ephemeral-volume"
I0419 03:40:15.532981       1 controller.go:169] "Starting ephemeral volume controller"
I0419 03:40:15.533017       1 shared_informer.go:311] Waiting for caches to sync for ephemeral
I0419 03:40:15.537786       1 controllermanager.go:638] "Started controller" controller="endpointslicemirroring"
I0419 03:40:15.538019       1 endpointslicemirroring_controller.go:211] Starting EndpointSliceMirroring controller
I0419 03:40:15.538050       1 shared_informer.go:311] Waiting for caches to sync for endpoint_slice_mirroring
I0419 03:40:15.551031       1 garbagecollector.go:155] "Starting controller" controller="garbagecollector"
I0419 03:40:15.551068       1 shared_informer.go:311] Waiting for caches to sync for garbage collector
I0419 03:40:15.551119       1 graph_builder.go:294] "Running" component="GraphBuilder"
I0419 03:40:15.551180       1 controllermanager.go:638] "Started controller" controller="garbagecollector"
I0419 03:40:15.559708       1 controllermanager.go:638] "Started controller" controller="disruption"
I0419 03:40:15.559831       1 disruption.go:423] Sending events to api server.
I0419 03:40:15.559995       1 disruption.go:434] Starting disruption controller
I0419 03:40:15.560012       1 shared_informer.go:311] Waiting for caches to sync for disruption
I0419 03:40:15.564930       1 controllermanager.go:638] "Started controller" controller="attachdetach"
I0419 03:40:15.565217       1 attach_detach_controller.go:343] "Starting attach detach controller"
I0419 03:40:15.565245       1 shared_informer.go:311] Waiting for caches to sync for attach detach
I0419 03:40:15.569752       1 controllermanager.go:638] "Started controller" controller="root-ca-cert-publisher"
I0419 03:40:15.569786       1 publisher.go:101] Starting root CA certificate configmap publisher
I0419 03:40:15.569805       1 shared_informer.go:311] Waiting for caches to sync for crt configmap
I0419 03:40:15.573734       1 shared_informer.go:311] Waiting for caches to sync for resource quota
I0419 03:40:15.597772       1 actual_state_of_world.go:547] "Failed to update statusUpdateNeeded field in actual state of world" err="Failed to set statusUpdateNeeded to needed true, because nodeName=\"k8s-master\" does not exist"
I0419 03:40:15.601153       1 shared_informer.go:318] Caches are synced for TTL after finished
I0419 03:40:15.602612       1 shared_informer.go:311] Waiting for caches to sync for garbage collector
I0419 03:40:15.609083       1 shared_informer.go:318] Caches are synced for PV protection
I0419 03:40:15.614457       1 shared_informer.go:318] Caches are synced for ReplicationController
I0419 03:40:15.618760       1 shared_informer.go:318] Caches are synced for certificate-csrapproving
I0419 03:40:15.624138       1 shared_informer.go:318] Caches are synced for TTL
I0419 03:40:15.629166       1 shared_informer.go:318] Caches are synced for namespace
I0419 03:40:15.633672       1 shared_informer.go:318] Caches are synced for deployment
I0419 03:40:15.637084       1 shared_informer.go:318] Caches are synced for certificate-csrsigning-kubelet-serving
I0419 03:40:15.638285       1 shared_informer.go:318] Caches are synced for endpoint_slice_mirroring
I0419 03:40:15.638370       1 shared_informer.go:318] Caches are synced for ReplicaSet
I0419 03:40:15.639451       1 shared_informer.go:318] Caches are synced for certificate-csrsigning-kubelet-client
I0419 03:40:15.641651       1 shared_informer.go:318] Caches are synced for certificate-csrsigning-kube-apiserver-client
I0419 03:40:15.644980       1 shared_informer.go:318] Caches are synced for certificate-csrsigning-legacy-unknown
I0419 03:40:15.649318       1 shared_informer.go:318] Caches are synced for taint
I0419 03:40:15.649390       1 taint_manager.go:206] "Starting NoExecuteTaintManager"
I0419 03:40:15.649384       1 node_lifecycle_controller.go:1223] "Initializing eviction metric for zone" zone=""
I0419 03:40:15.649435       1 taint_manager.go:211] "Sending events to api server"
I0419 03:40:15.649488       1 node_lifecycle_controller.go:875] "Missing timestamp for Node. Assuming now as a timestamp" node="k8s-master"
I0419 03:40:15.649531       1 node_lifecycle_controller.go:1069] "Controller detected that zone is now in new state" zone="" newState=Normal
I0419 03:40:15.649664       1 event.go:307] "Event occurred" object="k8s-master" fieldPath="" kind="Node" apiVersion="v1" type="Normal" reason="RegisteredNode" message="Node k8s-master event: Registered Node k8s-master in Controller"
I0419 03:40:15.654237       1 shared_informer.go:318] Caches are synced for HPA
I0419 03:40:15.658816       1 shared_informer.go:318] Caches are synced for ClusterRoleAggregator
I0419 03:40:15.660160       1 shared_informer.go:318] Caches are synced for disruption
I0419 03:40:15.663521       1 shared_informer.go:318] Caches are synced for endpoint
I0419 03:40:15.667093       1 shared_informer.go:318] Caches are synced for service account
I0419 03:40:15.670458       1 shared_informer.go:318] Caches are synced for crt configmap
I0419 03:40:15.672954       1 shared_informer.go:318] Caches are synced for job
I0419 03:40:15.676476       1 shared_informer.go:318] Caches are synced for cronjob
I0419 03:40:15.676673       1 shared_informer.go:318] Caches are synced for endpoint_slice
I0419 03:40:15.683622       1 shared_informer.go:318] Caches are synced for GC
I0419 03:40:15.683842       1 shared_informer.go:318] Caches are synced for node
I0419 03:40:15.683995       1 range_allocator.go:174] "Sending events to api server"
I0419 03:40:15.684074       1 range_allocator.go:178] "Starting range CIDR allocator"
I0419 03:40:15.684090       1 shared_informer.go:311] Waiting for caches to sync for cidrallocator
I0419 03:40:15.684108       1 shared_informer.go:318] Caches are synced for cidrallocator
I0419 03:40:15.686200       1 shared_informer.go:318] Caches are synced for bootstrap_signer
I0419 03:40:15.694353       1 shared_informer.go:318] Caches are synced for daemon sets
E0419 03:40:15.730671       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:15.730863       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
E0419 03:40:15.731005       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:15.733347       1 shared_informer.go:318] Caches are synced for ephemeral
E0419 03:40:15.744834       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:15.744943       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:15.745016       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
I0419 03:40:15.753889       1 shared_informer.go:318] Caches are synced for expand
E0419 03:40:15.763864       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:15.763991       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
E0419 03:40:15.764023       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:15.765322       1 shared_informer.go:318] Caches are synced for attach detach
I0419 03:40:15.771712       1 shared_informer.go:318] Caches are synced for PVC protection
I0419 03:40:15.789042       1 shared_informer.go:318] Caches are synced for persistent volume
E0419 03:40:15.792917       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:15.793044       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:15.793055       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
I0419 03:40:15.799481       1 shared_informer.go:318] Caches are synced for stateful set
I0419 03:40:15.829617       1 shared_informer.go:318] Caches are synced for resource quota
E0419 03:40:15.842642       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:15.842789       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:15.842863       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
I0419 03:40:15.874549       1 shared_informer.go:318] Caches are synced for resource quota
E0419 03:40:15.931924       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:15.932044       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:15.932078       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
E0419 03:40:16.103356       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:16.103542       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:16.103618       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
I0419 03:40:16.203954       1 shared_informer.go:318] Caches are synced for garbage collector
I0419 03:40:16.251255       1 shared_informer.go:318] Caches are synced for garbage collector
I0419 03:40:16.251309       1 garbagecollector.go:166] "All resource monitors have synced. Proceeding to collect garbage"
E0419 03:40:16.427568       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:16.427607       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:16.427649       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
E0419 03:40:17.077418       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:17.077570       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:17.077586       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
E0419 03:40:18.367457       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:18.367582       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:18.367620       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
E0419 03:40:20.937719       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:20.937865       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:20.937861       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
E0419 03:40:26.070048       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:26.070199       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:26.070226       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
E0419 03:40:36.321965       1 daemon_controller.go:1056] pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
E0419 03:40:36.322091       1 daemon_controller.go:326] kube-system/kube-proxy failed with : pods "kube-proxy-" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount "kube-proxy" not found
I0419 03:40:36.322101       1 event.go:307] "Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning" reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"
```

我查看了日志, 你能帮我看看是哪里出了问题了吗? , 日志如下:  
error retrieving resource lock kube-system/kube-controller-manager:
Get "https://192.168.20.150:6443/apis/coordination.k8s.io/v1/namespaces/kube-system/leases/kube-controller-manager?timeout=5s":
dial tcp 192.168.20.150:6443: connect: connection refused
"Event occurred" object="k8s-master" fieldPath="" kind="Node" apiVersion="v1" type="Normal" reason="RegisteredNode"
message="Node k8s-master event: Registered Node k8s-master in Controller"
"Failed to start service controller" err="WARNING: no cloud provider provided, services of type LoadBalancer will fail"
"Event occurred" object="kube-system/kube-proxy" fieldPath="" kind="DaemonSet" apiVersion="apps/v1" type="Warning"
reason="FailedCreate" message="Error creating: pods \"kube-proxy-\" is forbidden: error looking up service account
kube-system/kube-proxy: serviceaccount \"kube-proxy\" not found"

还是不行, 重新reset 重装

```shell
# 算了重新来一次安装
```text
kubeadm reset
rm -rf $HOME/.kube
#将环境变量KUBECONFIG 去掉, 删除文件
rm -rf /etc/kubernetes/admin.conf
# 去掉--upload-certs
 kubeadm init --config=kubeadm.yml --v=5 | tee kubeadm-init.log
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
   kubectl apply -f flannel.yaml 
```


发现2个一直在重启:
```shell
kube-system    kube-controller-manager-k8s-master   1/1     Running   14 (84s ago)   85s
kube-system    kube-proxy-mrx2b                     1/1     Running   2 (19s ago)    22s
```
草...


# 通过命令 journalctl -u kubelet 查看日志
Apr 18 09:53:34 node1 systemd[1]: Started kubelet: The Kubernetes Node Agent.
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.419648 1554024 server.go:415] "Kubelet version" kubeletVersion="v1.27.1"
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.419772 1554024 server.go:417] "Golang settings" GOGC="" GOMAXPROCS="" GOTRACEBACK=""
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.420480 1554024 server.go:578] "Standalone mode, no API client"
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.457668 1554024 server.go:466] "No api server defined - no events will be sent to API server"
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.457710 1554024 server.go:662] "--cgroups-per-qos enabled, but --cgroup-root was not specified.  defaulting to /"
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.458072 1554024 container_manager_linux.go:266] "Container manager verified user specified cgroup-root exists" cgroupRoot=[]
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.458141 1554024 container_manager_linux.go:271] "Creating Container Manager object based on Node Config" nodeConfig={RuntimeCgroupsName: SystemCgroupsName: KubeletCgroupsName: KubeletOOMScoreAdj:-999 ContainerRuntime: CgroupsPerQOS:true CgroupRoot:/ CgroupDriv>
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.458181 1554024 topology_manager.go:136] "Creating topology manager with policy per scope" topologyPolicyName="none" topologyScopeName="container"
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.458201 1554024 container_manager_linux.go:302] "Creating device plugin manager"
Apr 18 09:53:34 node1 kubelet[1554024]: I0418 09:53:34.458314 1554024 state_mem.go:36] "Initialized new in-memory state store"
Apr 18 09:53:34 node1 kubelet[1554024]: W0418 09:53:34.458994 1554024 logging.go:59] [core] [Channel #1 SubChannel #2] grpc: addrConn.createTransport failed to connect to {
Apr 18 09:53:34 node1 kubelet[1554024]:   "Addr": "/run/containerd/containerd.sock",
Apr 18 09:53:34 node1 kubelet[1554024]:   "ServerName": "/run/containerd/containerd.sock",
Apr 18 09:53:34 node1 kubelet[1554024]:   "Attributes": null,
Apr 18 09:53:34 node1 kubelet[1554024]:   "BalancerAttributes": null,
Apr 18 09:53:34 node1 kubelet[1554024]:   "Type": 0,
Apr 18 09:53:34 node1 kubelet[1554024]:   "Metadata": null
Apr 18 09:53:34 node1 kubelet[1554024]: }. Err: connection error: desc = "transport: Error while dialing dial unix /run/containerd/containerd.sock: connect: no such file or directory"
Apr 18 09:53:34 node1 kubelet[1554024]: E0418 09:53:34.460176 1554024 run.go:74] "command failed" err="failed to run Kubelet: validate service connection: validate CRI v1 runtime API for endpoint \"unix:///run/containerd/containerd.sock\": rpc error: code = Unavailable desc = connection error: desc = \"transport:>
Apr 18 09:53:34 node1 systemd[1]: kubelet.service: Current command vanished from the unit file, execution of the command list won't be resumed.
Apr 18 09:53:34 node1 systemd[1]: kubelet.service: Main process exited, code=exited, status=1/FAILURE
Apr 18 09:53:34 node1 systemd[1]: kubelet.service: Failed with result 'exit-code'.
Apr 18 09:53:34 node1 systemd[1]: Stopped kubelet: The Kubernetes Node Agent.
Apr 18 09:53:34 node1 systemd[1]: Started kubelet: The Kubernetes Node Agent.
Apr 18 09:53:34 node1 kubelet[1554071]: E0418 09:53:34.707045 1554071 run.go:74] "command failed" err="failed to load kubelet config file, error: failed to load Kubelet config file /var/lib/kubelet/config.yaml, error failed to read kubelet config file \"/var/lib/kubelet/config.yaml\", error: open /var/lib/kubelet>
Apr 18 09:53:34 node1 systemd[1]: kubelet.service: Main process exited, code=exited, status=1/FAILURE
Apr 18 09:53:34 node1 systemd[1]: kubelet.service: Failed with result 'exit-code'.
Apr 18 09:53:44 node1 systemd[1]: kubelet.service: Scheduled restart job, restart counter is at 1.
Apr 18 09:53:44 node1 systemd[1]: Stopped kubelet: The Kubernetes Node Agent.
Apr 18 09:53:44 node1 systemd[1]: Started kubelet: The Kubernetes Node Agent.
Apr 18 09:53:45 node1 kubelet[1554131]: E0418 09:53:45.009268 1554131 run.go:74] "command failed" err="failed to load kubelet config file, error: failed to load Kubelet config file /var/lib/kubelet/config.yaml, error failed to read kubelet config file \"/var/lib/kubelet/config.yaml\", error: open /var/lib/kubelet>
Apr 18 09:53:45 node1 systemd[1]: kubelet.service: Main process exited, code=exited, status=1/FAILURE
Apr 18 09:53:45 node1 systemd[1]: kubelet.service: Failed with result 'exit-code'.
Apr 18 09:53:55 node1 systemd[1]: kubelet.service: Scheduled restart job, restart counter is at 2.
Apr 18 09:53:55 node1 systemd[1]: Stopped kubelet: The Kubernetes Node Agent.
Apr 18 09:53:55 node1 systemd[1]: Started kubelet: The Kubernetes Node Agent.
Apr 18 09:53:55 node1 kubelet[1554259]: E0418 09:53:55.276003 1554259 run.go:74] "command failed" err="failed to load kubelet config file, error: failed to load Kubelet config file /var/lib/kubelet/config.yaml, error failed to read kubelet config file \"/var/lib/kubelet/config.yaml\", error: open /var/lib/kubelet>
lines 1-38

# 无解了
最终还是通过kubespray来安装成功了 但是需要再all.yml中配置代理

# 在文件中配置http（s）代理
vim inventory/mycluster/group_vars/all/all.yml