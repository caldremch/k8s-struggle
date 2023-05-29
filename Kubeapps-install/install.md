https://kubeapps.dev/

```shell
 helm install -n kubeapps --create-namespace kubeapps bitnami/kubeapps
kubectl create --namespace default serviceaccount kubeapps-operator
kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator
kubectl apply -f secret.yaml
kubectl get --namespace default secret kubeapps-operator-token -o go-template='{{.data.token | base64decode}}'
kubectl port-forward -n kubeapps svc/kubeapps 8080:80
        
```