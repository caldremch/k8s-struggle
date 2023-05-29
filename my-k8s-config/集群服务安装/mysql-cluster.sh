#[MySQL Operator for Kubernetes](https://github.com/mysql/mysql-operator)

kubectl apply -f https://raw.githubusercontent.com/mysql/mysql-operator/trunk/deploy/deploy-crds.yaml
kubectl apply -f https://raw.githubusercontent.com/mysql/mysql-operator/trunk/deploy/deploy-operator.yaml
kubectl get deployment -n mysql-operator mysql-operator
kubectl create secret generic mypwds \
        --from-literal=rootUser=root \
        --from-literal=rootHost=% \
        --from-literal=rootPassword="root"


kubectl create namespace mycluster
scp /Users/caldremch/work/code/docker-code/caldremch-k8s/my-k8s-config/集群服务安装/mysql-cluster.yaml root@10.211.55.7:/root

kubectl apply -f mysql-cluster.yaml

# set current namespace
kubectl config set-context --current --namespace=mysql-operator

# delete ns
kubectl delete namespace <namespace-name>

# get the ns relative pod, deployment &
kubectl get all -n <namespace-name>

您可以使用以下命令删除pod、deployment和replicaset：

删除pod：kubectl delete pod <pod_name> -n <namespace_name>

删除deployment：kubectl delete deployment <deployment_name> -n <namespace_name>

删除replicaset：kubectl delete replicaset <replicaset_name> -n <namespace_name>

请将<pod_name>, <deployment_name>, <replicaset_name> 和 <namespace_name> 替换为实际的名称。

kubectl describe pod <podname>
 <NameSpace>
kubectl get pods -n <NameSpace>

#Helm
helm install mysql-operator mysql-operator/mysql-operator --namespace mysql-operator --create-namespace



helm install mycluster mysql-operator/mysql-innodbcluster \
        --namespace mynamespace \
        --create-namespace \
        --set tls.useSelfSigned=true \
        --set credentials.root.user='root' \
        --set credentials.root.password='root' \
        --set credentials.root.host='%' \
        --set serverInstances=3 \
        --set routerInstances=1



# 通过helm安装结束后，发现有错误： 我再k8s中安装了mysql/mysql-operator集群， 但是安装成功后， mysql-operator一直CrashLoopBackOff， 我改怎么排查和解决？

kubectl logs mysql-operator-cc9796cb8-qg2tw -c mysql-operator -n mysql-operator

#查看日志发现：exec /usr/bin/mysqlsh: exec format error


因为我的系统是arm64的， 可能不支持

