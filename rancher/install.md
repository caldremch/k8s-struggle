# rancher 安装教程步骤简述

[rancher install](https://docs.rancher.cn/docs/rancher2/installation/install-rancher-on-k8s/_index/)

helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest


kubectl create namespace cattle-system


helm install rancher rancher-stable/rancher \
--namespace cattle-system \
--set hostname=<your-rancher-domain-name>


helm install rancher rancher-stable/rancher \
--namespace cattle-system \
--set hostname=localhost