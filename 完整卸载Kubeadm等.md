```shell
apt remove --purge kubelet -y
apt remove --purge containerd func -y
apt remove --purge containerd.io -y
apt remove --purge crictl -y
rm -rf /usr/local/bin/crictl
rm -rf /etc/containerdls
apt remove --purge kubelet kubeadm kubectl -y
```

sudo rm -rf /etc/cni/net.d/
rm -rf /etc/systemd/system/kube*
service network restart
kubeadm reset -f
rm -rf ~/.kube/
rm -rf /etc/kubernetes/
rm -rf /etc/systemd/system/kubelet.service.d
rm -rf /etc/systemd/system/kubelet.service
rm -rf /usr/bin/kube*
rm -rf /etc/cni
rm -rf /opt/cni
rm -rf /var/lib/etcd
rm -rf /var/etcd
apt clean all
apt remove kube*
