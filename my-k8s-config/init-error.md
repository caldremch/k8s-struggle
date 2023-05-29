初始化集群报错： 

sg="validate service connection: 
CRI v1 runtime API is not implemented for endpoint \"unix:///var/run/containerd/containerd.sock\": 
rpc error: 
code = Unimplemented 
desc = unknown service runtime.v1.RuntimeService


执行命令： crictl ps， 发现错误：
FATA[0000] validate service connection: CRI v1 runtime API is not implemented for endpoint "unix:///run/containerd/containerd.sock": rpc error: code = Unimplemented desc = unknown service runtime.v1.RuntimeService

解决办法参考：[kubernetes 集群部署问题点统计](https://www.cnblogs.com/yangzp/p/16380803.html)


执行以下命令解决：
crictl config runtime-endpoint unix:///run/containerd/containerd.sock
crictl config image-endpoint unix:///run/containerd/containerd.sock


cat <<EOF>> /etc/hosts
10.211.55.4 master.kubernetes.lab
10.211.55.3 wrk-01.kubernetes.lab
10.211.55.2 wrk-02.kubernetes.lab
EOF


# 报错

执行k8s初始化

kubeadm init --v=5 \
--upload-certs \
--control-plane-endpoint master.kubernetes.lab:6443 \
--pod-network-cidr=10.244.0.0/16 \
--ignore-preflight-errors=NumCPU

[preflight] Some fatal errors occurred:
[ERROR FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
[ERROR FileContent--proc-sys-net-ipv4-ip_forward]: /proc/sys/net/ipv4/ip_forward contents are not set to 1
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`

解决: 
```shell
modprobe br_netfilter
echo 1 > /proc/sys/net/ipv4/ip_forward
```