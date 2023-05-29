registry.k8s.io/kube-apiserver:v1.26.4
registry.k8s.io/kube-controller-manager:v1.26.4
registry.k8s.io/kube-scheduler:v1.26.4
registry.k8s.io/kube-proxy:v1.26.4

registry.k8s.io/pause:3.9
registry.k8s.io/etcd:3.5.6-0


ctr image pull registry.aliyuncs.com/google_containers/kube-apiserver:v1.26.3 && \
ctr -n k8s.io i tag registry.aliyuncs.com/google_containers/kube-apiserver:v1.26.3 registry.k8s.io/kube-apiserver:v1.26.3



ctr image pull registry.aliyuncs.com/google_containers/kube-controller-manager:v1.26.3 && \
ctr -n k8s.io i tag registry.aliyuncs.com/google_containers/kube-controller-manager:v1.26.3 registry.k8s.io/kube-controller-manager:v1.26.3


ctr image pull registry.aliyuncs.com/google_containers/kube-scheduler:v1.26.3 && \
ctr -n k8s.io i tag registry.aliyuncs.com/google_containers/kube-scheduler:v1.26.3 registry.k8s.io/kube-scheduler:v1.26.3


ctr image pull registry.aliyuncs.com/google_containers/kube-proxy:v1.26.3 && \
ctr -n k8s.io i tag registry.aliyuncs.com/google_containers/kube-proxy:v1.26.3 registry.k8s.io/kube-proxy:v1.26.3



ctr -n k8s.io i pull registry.aliyuncs.com/google_containers/kube-apiserver:v1.26.4 && \
ctr -n k8s.io i tag registry.aliyuncs.com/google_containers/kube-apiserver:v1.26.4 registry.k8s.io/kube-apiserver:v1.26.4

ctr -n k8s.io i pull registry.aliyuncs.com/google_containers/kube-controller-manager:v1.26.4 && \
ctr -n k8s.io i tag registry.aliyuncs.com/google_containers/kube-controller-manager:v1.26.4 registry.k8s.io/kube-controller-manager:v1.26.4

ctr -n k8s.io i pull registry.aliyuncs.com/google_containers/kube-scheduler:v1.26.4 && \
ctr -n k8s.io i tag registry.aliyuncs.com/google_containers/kube-scheduler:v1.26.4 registry.k8s.io/kube-scheduler:v1.26.4

ctr -n k8s.io i pull registry.aliyuncs.com/google_containers/kube-proxy:v1.26.4 && \
ctr -n k8s.io i tag registry.aliyuncs.com/google_containers/kube-proxy:v1.26.4 registry.k8s.io/kube-proxy:v1.26.4


remote version is much newer: v1.27.1; falling back to: stable-1.26
failed to pull image "registry.k8s.io/kube-apiserver:v1.26.4": output: E0416 16:04:15.276194   31420 remote_image.go:171]
"PullImage from image service failed"
err="rpc error: code = DeadlineExceeded desc =
failed to pull and unpack image \"registry.k8s.io/kube-apiserver:v1.26.4\":
failed to resolve reference \"registry.k8s.io/kube-apiserver:v1.26.4\":
failed to do request: Head \"https://asia-east1-docker.pkg.dev/v2/k8s-artifacts-prod/images/kube-apiserver/manifests/v1.26.4\":
dial tcp 64.233.188.82:443: i/o timeout"
image="registry.k8s.io/kube-apiserver:v1.26.4"
time="2023-04-16T16:04:15+08:00"
level=fatal msg="pulling image: rpc error: code = DeadlineExceeded desc =
failed to pull and unpack image \"registry.k8s.io/kube-apiserver:v1.26.4\":
failed to resolve reference \"registry.k8s.io/kube-apiserver:v1.26.4\":
failed to do request: Head \"https://asia-east1-docker.pkg.dev/v2/k8s-artifacts-prod/images/kube-apiserver/manifests/v1.26.4\":
dial tcp 64.233.188.82:443: i/o timeout"



kubeadm init --kubernetes-version=v1.26.3 --pod-network-cidr=10.224.0.0/16 --apiserver-advertise-address=172.18.213.88 --cri-socket unix:///var/run/containerd/containerd.sock --image-repository=registry.aliyuncs.com/google_containers
