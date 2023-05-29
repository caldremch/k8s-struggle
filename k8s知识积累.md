#内容来源(ChatGPT)问答

# 理解Kubernetes中的PV和PVC

在Kubernetes中，持久卷（PV）是集群中由管理员或使用StorageClass动态分配的存储的一部分。PV是集群中的资源，就像节点或Pod一样。它是集群抽象物理存储并为应用程序提供统一接口的一种方式。

持久卷声明（PVC）是用户或Pod请求存储的一种方式。它是用户请求特定数量的存储和特定访问模式（例如ReadWriteOnce、ReadOnlyMany、ReadWriteMany）的一种方式。创建PVC时，Kubernetes将查找与请求匹配的可用PV并将两者绑定在一起。然后，用户可以在其Pod定义中使用PVC来挂载存储。

以下是在Kubernetes中创建PVC的示例：

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
name: my-pvc
spec:
accessModes:
- ReadWriteOnce
resources:
requests:
storage: 1Gi


此PVC请求1Gi的存储空间，具有ReadWriteOnce访问模式。Kubernetes将查找与此请求匹配的可用PV并将两者绑定在一起

# 污点和容忍度 的知识
https://kubernetes.io/zh-cn/docs/concepts/scheduling-eviction/taint-and-toleration/
https://www.cnblogs.com/rtnb/p/15595293.html

# Kubernetes中的ClusterIP、NodePort和LoadBalancer服务类型有什么区别？
https://www.qiniu.com/qfans/qnso-41509439

ClusterIP:在集群内部的IP上公开服务。选择这个值使服务只能从集群内部到达。这是默认的服务类型

NodePort:在每个Node的IP上以一个静态端口（Node端口）暴露服务。ClusterIP服务将被自动创建，Node端口服务将被路由到该服务。你将能够从集群外联系Node端口服务，通过请求<NodeIP>:<NodePort>.

负载平衡器:使用云提供商的负载平衡器将服务暴露在外部。Node端口和ClusterIP服务，外部负载平衡器将对其进行路由，这些服务被自动创建。


# 删除某个ns下的所有pvc
```shell
kubectl delete pvc --all -n harbor
```

kubectl delete pv --all -n harbor

# 某些pod无法被删除 ,强制删除
kubectl delete pod harbor-chartmuseum-66b79ff96f-5xknp --force --grace-period=0
kubectl delete pod harbor-jobservice-5f774478b6-zbfmm --force --grace-period=0
kubectl delete pod harbor-postgresql-0  --force --grace-period=0
kubectl delete pod harbor-redis-master-0  --force --grace-period=0
kubectl delete pod harbor-registry-76d9f8d46f-rrw9g --force --grace-period=0
kubectl delete pod harbor-trivy-0 --force --grace-period=0


# service绑定到deployment中, 这个在配置文件中是如何体现的?
在 Kubernetes 的 YAML 配置文件中，Service 和 Deployment 之间的关联通常是通过 Service 的 selector 字段来实现的。Deployment 中定义的 labels 将与 Service 中定义的 selector 匹配，从而将 Service 与 Deployment 关联起来。

例如，以下是一个简单的 Deployment YAML 配置文件：

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
name: my-app
spec:
replicas: 3
selector:
matchLabels:
app: my-app
template:
metadata:
labels:
app: my-app
spec:
containers:
- name: my-app-container
image: my-app-image:latest
```

在这个配置文件中，Deployment 使用 selector 字段来定义 app: my-app 标签，这个标签与 Service 中的 selector 字段进行匹配，从而将 Service 与 Deployment 关联起来。

例如，以下是一个简单的 Service YAML 配置文件：

```yaml
apiVersion: v1
kind: Service
metadata:
name: my-app-service
spec:
selector:
app: my-app
ports:
- name: http
port: 80
targetPort: 8080
type: ClusterIP
```
在这个配置文件中，Service 使用 selector 字段来定义 app: my-app 标签，与 Deployment 中的标签进行匹配。通过这种方式，Service 就能将流量转发到与 Deployment 相关联的 Pod 中。

# k8s中的spec代表什么意思? 全称是什么? 

在 Kubernetes 中，spec 是一个非常常用的字段，它是 “specification” 的缩写，代表着对象的规范（specification）。在 Kubernetes 中，几乎所有的 API 对象都有 spec 字段，用于描述该对象的规范。

spec 字段包含了该对象的所有规范信息，例如：该对象所需的资源（CPU、内存等），该对象如何运行，该对象依赖的其它对象，以及其他一些描述对象规范的信息。不同类型的对象的 spec 字段可能有所不同，但是它们都遵循相同的基本格式。

在 Kubernetes 中，当我们创建一个新的对象时，必须指定该对象的规范，即填写 spec 字段。Kubernetes 根据这些规范来创建和管理对象。

# deployment中,  spec里面的selector代表什么意思?  
在 Kubernetes 的 deployment 中，spec.selector 表示该 deployment 所需要控制的 pod 的标签选择器。在 deployment 的控制下，它会自动创建和更新一个或多个符合指定标签选择器的 pod。同时，该 deployment 会通过这个标签选择器来区分自己所控制的 pod 与其它的 pod。在实践中，通常会将 deployment 的 spec.selector 指定为 pod 的标签，以保证该 deployment 只控制指定的 pod。例如：

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
selector:
matchLabels:
app: nginx
template:
metadata:
labels:
app: nginx
spec:
containers:
  - name: nginx
image: nginx:latest
ports:
  - containerPort: 80
```

在这个例子中，deployment 会根据 spec.selector.matchLabels 中指定的 app=nginx 标签选择与其相关联的 pod，并对其进行创建和管理。同时，pod 的标签也必须包含 app=nginx，以便于 deployment 可以正确地控制它们。


总结: 
deployment的selector控制pod集合, service的selector控制pod或者是deployment的集合


# configmap和storageclass有什么区别?
ConfigMap和StorageClass是Kubernetes中两种不同的资源类型，用途也不同。

ConfigMap用于将配置数据以键值对的方式保存在Kubernetes中，并可用于传递配置文件、环境变量等信息到容器中，以便容器在运行时获取这些配置信息。

StorageClass用于定义动态存储卷的类型和属性。它定义了动态卷的名称、类型、大小、访问模式等属性，当使用PersistentVolumeClaim申请动态卷时，可以使用StorageClass来指定动态卷的属性，Kubernetes会根据StorageClass的定义动态地创建对应的卷。

因此，两者用途不同，ConfigMap用于保存配置信息，而StorageClass用于定义动态卷的属性

# 我看到deployment里面可以配置: containerPort,  那跟service里面的targetPort是不是重复配置了?
containerPort 和 targetPort 都涉及到容器内部的端口，但是它们的作用和配置方式不同。

containerPort 是定义在 Deployment/ReplicaSet/StatefulSet 等控制器的 Pod 模板中，表示容器中暴露的端口号。当 Pod 被创建时，Kubernetes 使用 containerPort 定义的端口号来创建 Pod 的容器。这个端口号只用于定义 Pod 容器内部的端口号，不涉及到 Pod 访问的端口。

targetPort 则是定义在 Service 资源中的，表示 Service 代理的后端 Pod 的端口号。当 Service 接收到请求时，会将请求转发到后端 Pod 上，根据 targetPort 所指定的端口号将请求转发到相应的 Pod 上。

虽然 containerPort 和 targetPort 都表示容器内部的端口号，但是它们的作用不同，因此需要分别进行配置。

# targetPort我能理解, 但是containerPort的作用和意义是什么?
containerPort 是 Deployment 中用来指定容器中开放的端口号，它的作用是让 Kubernetes 在启动容器时知道该容器会监听哪些端口，以便在后续的服务发现和网络代理操作中使用。容器中的应用程序通常需要监听一些端口，以提供服务或接受请求，而 containerPort 就是用来指定这些端口的。

与此相对应的是 targetPort，它是 Service 中用来指定后端 Pod 监听的端口号。当 Service 接收到请求时，会将流量转发到后端 Pod 的 targetPort 上，而该端口号对应了 Pod 内部容器中实际的 containerPort。

因此，虽然在 Service 和 Deployment 中都需要指定端口，但它们所代表的含义是不同的。


# 上面的容器指定是image运行起来的container吗? 还是k8s里面虚拟的容器概念?
container 指定的是一个在Kubernetes Pod 中实际运行的容器。Pod 是 Kubernetes 调度的最小单位，而一个 Pod 中可以包含一个或多个容器。在上面的例子中，Pod 包含一个容器，该容器使用 Docker 镜像 nginx:latest 创建。

容器是 Pod 中的一个运行实例，它是 Kubernetes 中的一个虚拟概念。Kubernetes 使用容器技术（如 Docker）来隔离和管理应用程序进程。每个容器都运行在自己的命名空间和进程空间内，与宿主机和其他容器隔离开来，因此容器内的应用程序可以在不受其他容器干扰的情况下运行。

# 所以containerPort和service里面的targetPort ,可以一样, 也可以不一样是吧
是的，containerPort 和 targetPort 可以一样，也可以不一样。containerPort 是指在容器内部运行的应用程序所监听的端口，而 targetPort 是指 Service 要转发到哪个容器的 containerPort。因此，它们可以是同一个端口，也可以是不同的端口。

#  k8s中的pod 删除后又自动重建了, 这是什么原因呢? 怎么删除掉?
**删除掉deployment就好了**

当一个 Pod 被删除时，kubelet 会检测到这个 Pod 的丢失，并重新启动一个新的 Pod 来替代它。这是 Kubernetes 的预期行为，保证了系统的可靠性和容错能力。

如果您想完全删除 Pod，需要使用 kubectl delete pod 命令，并确保删除的 Pod 不是由任何控制器（比如 Deployment、StatefulSet 等）创建的。如果 Pod 是由某个控制器创建的，则需要先删除该控制器，然后再删除 Pod。例如，如果您的 Pod 是由 Deployment 创建的，可以使用 kubectl delete deployment 命令删除 Deployment，这会自动删除所有相关的 Pod。

如果您不想自动重启 Pod，可以将 Pod 的重启策略设置为 Never。在 Pod 的 YAML 文件中，可以通过 spec.restartPolicy 字段来指定重启策略，将其设置为 Never 即可。例如：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  restartPolicy: Never
  containers:
    - name: my-container
      image: my-image
      command: [ "sh", "-c", "echo Hello, Kubernetes! && sleep 3600" ]
```
  这样，当该 Pod 被删除后，就不会自动重启了。


# 如何修改deployment或者 pod容器内的配置?

## 修改deployment方式:
1. kubectl get deployment gogs -o yaml > gogs.yaml
2. kubectl apply -f gogs.yaml

## 修改deployment里面容器的配置

除了在容器内部手动修改配置文件外，另一种方法是使用 ConfigMap。你可以将应用程序的配置文件打包成一个 ConfigMap 对象，
然后将其挂载到 Pod 中。这样，当你需要修改配置文件时，只需要更新 ConfigMap，Pod 将自动重启以应用新的配置。

LOCAL_NETWORK_ALLOWLIST = *


# ServiceAcount无法被删除
kubectl -n droneci get pods,deployments,services -o json | jq '.items[] | select(.spec.serviceAccountName=="default") | .metadata.name'

kubectl get all -n droneci | grep -i controller
kubectl get all -n kube-system | grep -i controller

kubectl delete serviceaccount --all -n droneci --force --grace-period=0

kubectl delete serviceaccount <serviceaccount-name> -n <namespace> --force --grace-period=0
kubectl delete ns droneci --force --grace-period=0


# volumeMode: Filesystem 是什么意思?
volumeMode: Filesystem 是指定义持久卷（Persistent Volume）或持久卷声明（Persistent Volume Claim）时，
指定卷类型为文件系统。这是 Kubernetes 默认的卷类型，
也是使用最广泛的一种卷类型。在文件系统卷中，卷中的数据存储在目录中，
可以使用标准文件系统的方式进行读取和写入操作
。与之对应的是块设备卷，数据存储在块设备中，
需要通过文件系统才能读取和写入，通常用于需要直接访问块设备的应用程序。



# : Error updating Endpoint Slices for Service app/my-server: failed to update my-server-wpkhb EndpointSlice for Service app/my-server: Unauthorized
这个错误提示是授权认证失败的意思，说明当前用户没有足够的权限去更新Service的Endpoint Slices。

可能的原因是当前用户没有访问或更新Service的权限，或者没有配置正确的认证信息。

您可以检查用户的RBAC权限，确保该用户拥有Service的更新权限，并且使用正确的认证信息进行访问。如果仍然有问题，您可以查看Kubernetes集群的API Server的认证日志，以获取更详细的错误信息。


# 确保该用户拥有Service的更新权限 , 我怎么确认是否有更新权限?

要检查用户是否拥有更新Service的权限，可以执行以下命令：
```shell
kubectl auth can-i update services --as <user-name>
```
将 <user-name> 替换为要检查的用户的名称。该命令将返回 yes 或 no 来指示该用户是否有权限更新Service。

如果用户没有权限更新Service，则需要将权限授予该用户或使用拥有更新Service权限的其他用户来更新Service。可以通过修改Role或ClusterRole和RoleBinding或ClusterRoleBinding来授予用户权限。

kubectl delete pod calico-kube-controllers-6dfcdfb99-cwxcd --force --grace-period=0 -n kube-system