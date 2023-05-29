-- 重置
echo "Y" | kubeadm reset
rm -fr ~/.kube/  /etc/kubernetes/* var/lib/etcd/*

-- 初始化
kubeadm init --apiserver-advertise-address=192.168.20.150 \
--image-repository registry.aliyuncs.com/google_containers \
--kubernetes-version v1.26.3 \
--service-cidr=10.96.0.0/16  \
--pod-network-cidr=10.244.0.0/16  \
--v=5