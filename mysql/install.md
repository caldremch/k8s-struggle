# https://github.com/bitnami/charts/tree/main/bitnami/mysql

# set namespace
kubectl config set-context --current --namespace=kube-system


```text
"primary.service.ports.mysql"属性是指MySQL数据库的主端口号，它是一个Kubernetes Service类型的ClusterIP端口。
"primary.service.nodePorts.mysql"属性是指MySQL数据库的主端口号，它是一个Kubernetes Service类型的NodePort端口。

如果您在Kubernetes集群中使用的是LoadBalancer类型的服务来访问MySQL数据库，则应该使用"primary.service.ports.mysql"属性来定义MySQL数据库的主端口号。这是因为LoadBalancer类型的服务会自动将其所代表的端口暴露给集群外部，因此您不需要使用NodePort端口来访问MySQL数据库。相反，您可以使用LoadBalancer服务的IP地址和端口号来访问MySQL数据库。
```

# first install nfs , and create pv and pvc, 主服务器+从服务器
```shell
helm install mysql \
  --set image.tag=5.7.41-debian-11-r22 \
  --set primary.service.type=NodePort \
  --set secondary.service.type=NodePort \
  --set primary.persistence.existingClaim=db-pvc1 \
  --set secondary.persistence.existingClaim=db-pvc2 \
  --set volumePermissions.enabled=true \
  --set auth.rootPassword=root,auth.database=app_database,architecture=replication \
  --set secondary.replicaCount=3 \
bitnami/mysql
```


# no secondary
```shell
helm install mysql \
  --set image.tag=8.0.32 \
  --set primary.service.type=NodePort \
  --set primary.persistence.storageClass=nfs-client \
  --set volumePermissions.enabled=true \
  --set auth.rootPassword=root,auth.database=setup-db \
bitnami/mysql
```

kubectl get secret mysql-0 -o jsonpath="{.data.mysql-root-password}" | base64 --decode

# 查看pod详情 
```text
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
```

上面的Tolerations 是mysql pod的容忍度, 
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s   # 当节点宕机不可用，驱逐等待时常
node.kubernetes.io/unreachable:NoExecute op=Exists for 300s  # 当节点无法访问驱逐时常

现在情况就是在master 节点上, 成功安装了mysql pod, 但是在其他2个节点,并没有成功运行节点, 

根据查看master mysql pod节点详情发现 容忍度是这样配置的, 估计是

其他2个节点都无法使用还是异常之类的, 不知道怎么怎么回事, 

测试:
随便部署一个简单的pod, 看看能不能同时在3个节点中运行;

后面多查看了一下资料发现是配置的额问题:

添加: architecture=replication 多节点模式
添加: secondary.persistence.existingClaim=mysql-pvc 就是除了primary节点(master)之外的work节点进运行

helm delete my-release


# --set volumePermissions.enabled=true \  # otherwise  mkdir: cannot create directory '/bitnami/mysql/data': Permission denied


# exec inner mysql
kubectl exec -it <mysql-pod-name> -- mysql -uroot -proot
kubectl exec -it my-release-mysql-0 -- mysql -uroot -proot
kubectl exec -it my-release-mysql-primary-0 -- mysql -uroot -proot
kubectl exec -it my-release-mysql-secondary-0 -- mysql -uroot -proot
kubectl exec -it my-release-mysql-secondary-1 -- mysql -uroot -proot


# force delete pv
kubectl delete persistentvolume my-pv --force --grace-period=0




# 遇到问题:



## Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely. persistentvolume "my-pv" force delete

先查看这个pv还有没有关联其他pvc
kubectl get pvc --all-namespaces | grep my-pv(pv name)

## Warning  FailedScheduling  21s (x3 over 10m)  default-scheduler  0/3 nodes are available: pod has unbound immediate PersistentVolumeClaims. preemption: 0/3 nodes are available: 3 No preemption victims found for incoming pod.

通过查看pvc
```text
NAME         STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mysql-pvc    Bound     my-pv    3Gi        RWX            nfs            98m
mysql-pvc2   Pending                                      nfs            13m
```
mysql-pvc2是pending状态, 再次查看详情kubectl describe pvc mysql-pvc2
```text
Events:
  Type     Reason              Age                 From                         Message
  ----     ------              ----                ----                         -------
  Warning  ProvisioningFailed  13s (x62 over 15m)  persistentvolume-controller  storageclass.storage.k8s.io "nfs" not found
```



# k8s中, replicas的数量需要小于等于当前的节点数量吗? replicas的数量会分布在各个节点运行吗?还是在同一个节点也可以运行多个副本?
```text
在Kubernetes中，ReplicaSet控制器用于管理Pod的副本数量。ReplicaSet控制器可以确保在任何给定时间内，指定数量的Pod副本正在运行。

ReplicaSet的副本数量不需要小于等于当前节点的数量。在Kubernetes中，Pod是可以在任何节点上运行的，而不是限定在特定的节点上。因此，即使有更多的节点可用，也可以在单个节点上运行多个副本。

当您创建一个ReplicaSet时，它会在您的集群中选择一个或多个节点来运行Pod副本。选择节点的过程是由调度器（Scheduler）执行的，默认情况下，调度器会尝试将Pod均匀地分配到所有可用节点上。

如果您希望将Pod限制在特定的节点上运行，您可以使用节点亲和性（Node Affinity）或节点选择器（Node Selector）来实现。这些机制可以帮助您将Pod限制在特定的节点上运行，并确保在节点故障时将其重新调度到其他节点上。


总之，ReplicaSet的副本数量不需要小于等于当前节点的数量，并且可以在同一节点上运行多个副本。调度器会尝试将Pod均匀地分配到所有可用节点上，但如果需要，可以使用节点亲和性或节点选择器来将Pod限制在特定的节点上运行。
```

# 那么ReplicaSet的意义和作用是什么?  因为它可以在当个节点上运行多份
```text
ReplicaSet是Kubernetes中的一种控制器，用于管理Pod的副本数量。它确保在任何给定时间内，指定数量的Pod副本正在运行，并且可以自动地创建或删除Pod副本以适应应用程序的需求。

ReplicaSet的主要作用是保证应用程序的高可用性和可扩展性。通过运行多个Pod副本，ReplicaSet可以确保即使在节点故障或维护期间也可以继续提供服务。如果某个节点上的Pod副本出现故障，ReplicaSet会自动创建新的Pod副本来替换它。

此外，ReplicaSet还可以用于实现应用程序的水平扩展。通过增加Pod副本的数量，ReplicaSet可以提高应用程序的吞吐量和处理能力，以满足不断增长的流量需求。当流量减少时，ReplicaSet会自动删除多余的Pod副本，以节省资源。

虽然ReplicaSet可以在同一节点上运行多个Pod副本，但这并不是它的主要目的。相反，ReplicaSet的重点是确保指定数量的Pod副本正在运行，并且可以自动地创建或删除Pod副本以适应应用程序的需求。
```