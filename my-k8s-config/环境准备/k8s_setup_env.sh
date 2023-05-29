apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg gnupg2 software-properties-common lsb-release iputils-ping net-tools git zip unzip python3 python3-pip
curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
# 这一步可以弄成国内镜像源
echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install containerd.io -y
rm /etc/containerd/config.toml #???
systemctl restart containerd
sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab
swapoff -a
systemctl enable kubelet

#cat <<EOF>> /etc/hosts
#    192.168.80.31 mymaster
#    192.168.80.32 mywork1
#    192.168.80.33 mywork2
#    EOF


cat <<EOF>> /etc/hosts
    192.168.101.31 mymaster
    192.168.101.32 mywork1
    192.168.101.33 mywork2
    EOF