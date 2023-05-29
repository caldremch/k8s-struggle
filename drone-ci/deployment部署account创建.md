
```shell
kubectl create sa deploy-sa
kubectl create clusterrole deploy-cr --verb=get,list,watch,create,update,patch,delete --resource=deployments
kubectl create clusterrolebinding deploy-crb --clusterrole=deploy-cr --serviceaccount=default:deploy-sa
kubectl describe secret $(kubectl get secrets -n default | grep deploy-sa-token | awk '{print $1}') -n default | grep token: | awk '{print $2}'
kubectl get secret $(kubectl get serviceaccount deploy-sa -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.ca\.crt}' | base64 --decode

```