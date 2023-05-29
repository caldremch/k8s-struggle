kubernetes配置安装nfs: https://juejin.cn/post/7109646185924657188

1. 选择单独一台(或者选择其中一个节点)作为nfs服务器
2. 其他节点都安装nfs客户端


# helm install nfs reference : https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/ 
# https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install -n kube-system nfs-client nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=192.168.205.4 \
--set nfs.path=/data/nfs \
--set storageClass.defaultClass=true


```shell
helm install -n kube-system nfs-client nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=192.168.20.150 \
--set nfs.path=/data/nfsdata \
--set storageClass.defaultClass=true
```

# in localhost

helm install -n kube-system nfs-client nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=192.168.205.4 \
--set nfs.path=/data/nfs \
--set storageClass.defaultClass=true


# install in 192.1168.205.8
```shell

helm install -n kube-system nfs-client nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=192.168.205.8 \
--set nfs.path=/nfsdata \
--set storageClass.defaultClass=true
```



