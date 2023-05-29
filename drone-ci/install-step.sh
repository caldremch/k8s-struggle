kubectl create namespace gogs
kubectl apply -f gogs-pvc.yml
kubectl apply -f gogs-service.yml
kubectl apply -f gogs-deployment.yml
kubectl create configmap gogs-config --from-file=/data/configMap/app-103020150.ini -n gogs