https://goharbor.io/docs/2.7.0/install-config/harbor-ha-helm/

参考:
https://www.cnblogs.com/cerberus43/p/15881258.html


# because the official don't support arm64 harbor , we install by bitami/harbor 
# reference https://artifacthub.io/packages/helm/bitnami/harbor
# https://github.com/bitnami/charts/tree/main/bitnami/harbor

helm pull bitami/harbor 

extra the archive file and get the values.yaml

helm repo add harbor https://helm.goharbor.io
helm fetch harbor/harbor --untar

kubectl create namespace harbor
helm install harbor harbor/harbor -f harbor-config.yaml -n harbor

# by bitami 
helm install harbor bitnami/harbor -f bitami-harbor-config.yaml -n harbor

kubectl get pods harbor-core-67fdfc4db5-68s9r -o jsonpath='{.spec.securityContext}'

# no config yml 
helm install harbor \
--set global.storageClass=nfs-client \
--set service.type=NodePort \
-n harbor \
bitnami/harbor



# 报错;waiting for postgres://postgres:not-secure-database-password@harbor-postgresql:5432/notarysigner?sslmode=disable to come up.
# error: dial tcp 10.233.44.57:5432: connect: connection refused
 参考: https://github.com/goharbor/harbor/issues/10206

最终查看到的时候, notary-singer并不能成功链接上postgre



helm repo add bitnami https://charts.bitnami.com/bitnami


### install command
```shell
helm install harbor bitnami/harbor -f bitami-harbor-config-103020150.yaml -n harbor
```

```text
helm install harbor \
  --set global.storageClass=nfs-client \
  --set adminPassword=123456Cdm \
  --set externalURL=http://192.168.20.150:30014 \
  --set service.type=NodePort \
  --set service.nodePorts.http=30014 \
  --set nginx.tls.enabled=false \
    bitnami/harbor
```


# https://bitnami.com/stack/harbor/helm
# https://github.com/bitnami/charts/tree/main/bitnami/harbor/#installing-the-chart


helm delete --purge harbor -n harbor


# 遇到无法安装成功, 我吐了, 只能使用harbor/harbor 来安装,而不是使用bitnami

# 安装harbor/harbor的
admin/Harbor12345
helm install harbor harbor/harbor -f values-harbor-103020160.yaml -n harbor

docker login --username=admin --password=Harbor12345 192.168.20.150:30014