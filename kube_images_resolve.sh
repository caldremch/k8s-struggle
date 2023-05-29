# 国内镜像解决, 但是还是建议通过 安装代理去解决吧, 可以参考github/caldremch/clash-proxy去配置

ctr image pull registry.aliyuncs.com/google_containers/kube-apiserver:v1.26.3
ctr image pull registry.aliyuncs.com/google_containers/kube-controller-manager:v1.26.3
ctr image pull registry.aliyuncs.com/google_containers/kube-scheduler:v1.26.3
ctr image pull registry.aliyuncs.com/google_containers/kube-proxy:v1.26.3
ctr image pull registry.aliyuncs.com/google_containers/pause:3.9
ctr image pull registry.aliyuncs.com/google_containers/etcd:3.5.6-0
ctr image pull registry.aliyuncs.com/google_containers/coredns:v1.9.3

ctr image tag registry.aliyuncs.com/google_containers/kube-apiserver:v1.26.3                    registry.k8s.io/kube-apiserver:v1.26.3
ctr image tag registry.aliyuncs.com/google_containers/kube-controller-manager:v1.26.3           registry.k8s.io/kube-controller-manager:v1.26.3
ctr image tag registry.aliyuncs.com/google_containers/kube-scheduler:v1.26.3                    registry.k8s.io/kube-scheduler:v1.26.3
ctr image tag registry.aliyuncs.com/google_containers/pause:3.9                                 registry.k8s.io/pause:3.9
ctr image tag registry.aliyuncs.com/google_containers/etcd:3.5.6-0                              registry.k8s.io/etcd:3.5.6-0
ctr image tag registry.aliyuncs.com/google_containers/kube-proxy:v1.26.3                        registry.k8s.io/kube-proxy:v1.26.3
ctr image tag registry.aliyuncs.com/google_containers/coredns:v1.9.3                            registry.k8s.io/coredns/coredns:v1.9.3
