# reference https://segmentfault.com/a/1190000040364886
helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace redis
helm install -f redis-config.yaml redis bitnami/redis --namespace redis