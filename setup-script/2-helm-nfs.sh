# 通过helm安装nfs
helm install -n kube-system nfs-client nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=192.168.20.150 \
--set nfs.path=/data/nfsdata \
--set storageClass.defaultClass=true