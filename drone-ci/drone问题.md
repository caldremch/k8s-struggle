
```text
Unable to attach or mount volumes: unmounted volumes=[drone-ns0zrmhwzcf5jxu25ygc], 
unattached volumes=[kube-api-access-mvlgl drone-ns0zrmhwzcf5jxu25ygc drone-4afzp8scu8mmrf7l0t5v drone-5vmhb8zyos0ao6a79eo4]: 
timed out waiting for the condition
```

```text
这个错误通常意味着 Kubernetes 无法在 Pod 中挂载指定的卷。具体来说，它显示了未挂载的卷列表和未附加的卷列表，以及一个超时错误。

这种错误可能有多种原因，例如：

卷配置错误：检查您的 YAML 文件中的 volumes 和 volumeMounts 字段是否正确配置。确保卷名称和容器中挂载卷的路径正确匹配。另外，如果您使用了存储类或持久卷，还需要确保它们已正确配置。
容器镜像问题：有时，容器镜像中缺少必要的工具或文件，导致无法挂载卷。如果您使用自定义容器镜像，请确保它包含所需的工具和文件。
存储问题：如果使用持久卷，还需要检查存储后端是否正常运行。如果存储后端故障，可能会导致挂载失败。
此外，这个错误可能也与 Kubernetes 群集的网络设置有关，例如网络延迟、DNS 配置等。您可以通过查看 Kubernetes 的事件日志和日志文件来获取更多信息，以确定问题的原因。

如果您无法确定问题的原因，建议您检查 Kubernetes 的文档、社区论坛或通过 Kubernetes 支持通道获取帮助。
```


其实也没啥, 就是.drone.yml文件配置出错了, 没正确挂载, 可以一个一个step去排查阿解决




# kubernetes has failed: container failed to start: id=drone-mnochi0a8n20et0nc4di exitcode=2 reason=Error image=docker.io/library/golang:1.19

遇到这个样的问题, 都是因为 .drone.yml配置有问题, 好好检查一下


# kubernetes has failed: container failed to start: id=drone-rx09vxt5drctw8utchms exitcode=2 reason=Error image=docker.io/library/golang:1.19

这他妈又是什么问题?


配置问题

# Unable to attach or mount volumes: unmounted volumes=[drone-fspji0pzh3wpj8rekisg], unattached volumes=[drone-fspji0pzh3wpj8rekisg drone-4fdy1ivxcmab9hukfiyr drone-qu6qr9kkygobh0uf9fy6 kube-api-access-p5q9g]: timed out waiting for the condition

这个就是说明, 挂载的方式有问题, 更换!!!

drone 不能挂在文件, 只能挂在目录!!


# 想通过.kube/config文件挂载的方式 + kubectl apply -f k8s/logs-pvc.yml

# error: error loading config file "/.kube/config": open /.kube/config: permission denied

直接  chmod 777 config

还是没有用, 只能更换kubectl插件 

使用 sinlead/drone-kubectl  https://github.com/sinlead/drone-kubectl

```shell
kubectl config view -o jsonpath='{range .clusters[*]}{.name}{"\t"}{.cluster.server}{"\n"}{end}'
kubectl get secret deploy-token-xxxx -o jsonpath='{.data.ca\.crt}' && echo
kubectl get secret deploy-token-xxxx -o jsonpath='{.data.token}' | base64 --decode && echo
```

# 背景
```text
在使用启用了基于角色的访问控制（RBAC）的 Kubernetes 版本时，您将无法使用默认的服务账户，因为它没有更新部署的访问权限。相反，您需要创建一个自定义的服务账户，并授予相应的权限（如果您需要使用相同的服务账户跨命名空间访问，则需要使用 Role 和 RoleBinding 或 ClusterRole 和 ClusterRoleBinding）。

```


```text
我怎么知道我使用的版本是不是: 基于角色的访问控制（RBAC）
您可以通过执行以下命令来检查 Kubernetes 是否启用了 RBAC：

perl
Copy code
kubectl api-versions | grep rbac
如果此命令返回以下输出，则表示您正在使用启用了 RBAC 的 Kubernetes 版本：

bash
Copy code
rbac.authorization.k8s.io/v1
rbac.authorization.k8s.io/v1beta1
如果此命令未返回任何输出，则表示您的 Kubernetes 版本未启用 RBAC。

另外，从 Kubernetes 1.19 版本开始，RBAC 已成为默认的授权模型，因此如果您的 Kubernetes 版本是 1.19 及更高版本，则应默认启用 RBAC。
```

创建一个具有一定权限的service账号, 这样可以让远程的kubectl操作, 参考: [app-kubectl-deploy-service-account.yml](app-service-account%2Fapp-kubectl-deploy-service-account.yml)[app-kubectl-deploy-service-account.yml](app-service-account%2Fapp-kubectl-deploy-service-account.yml)

rbac.authorization.k8s.io/v1 和 rbac.authorization.k8s.io/v1beta1 都是 Kubernetes 中的 RBAC API 版本。其中 v1 是 v1beta1 的继承者，它包括了更多功能和更强的权限控制。

从 Kubernetes 1.22 开始，rbac.authorization.k8s.io/v1 成为默认的 API 版本，rbac.authorization.k8s.io/v1beta1 仍然可以使用，但在使用时需要显式地声明。如果您的 Kubernetes 版本较旧，则只能使用 v1beta1。

建议使用最新的 v1 版本来获取更多功能和更强的权限控制，同时确保您的 Kubernetes 版本支持该版本的 API。


创建完service账户后:
```shell
kubectl get secret drone-deploy-app -o jsonpath='{.data.ca\.crt}' && echo
kubectl get secret drone-deploy-app -o jsonpath='{.data.token}' | base64 --decode && echo
```


```shell
kubectl -n default get sa drone-deploy-app -o jsonpath='{.secrets[0].name}'
SECRET_NAME=$(kubectl get sa drone-deploy-app -o jsonpath='{.secrets[0].name}')
TOKEN=$(kubectl get secret ${SECRET_NAME} -o jsonpath='{.data.token}' | base64 -d)
echo ${TOKEN}

```



但是新生成的service account 并没有secrets, 

```text
一些可能导致 Secret 没有生成的原因如下：

服务帐户没有被使用，因此 Kubernetes 系统没有为它生成一个令牌。

服务帐户已被使用，但是 Pod 没有成功启动，因此 Kubernetes 系统没有机会将令牌注入容器中。

在 ServiceAccount 中未定义任何权限，因此不需要将令牌提供给任何容器。
```


当前账户没有别使用

deployment使用serviceAcount
```text
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  selector:
    matchLabels:
      app: my-app
  replicas: 1
  template:
    metadata:
      labels:
        app: my-app
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/path: /actuator/prometheus
    spec:
      serviceAccountName: my-service-account
      containers:
      - name: my-container
        image: my-image

```



如果一开始就没有使用, 但是想要自动生成: 
```text
除了将 Service Account 绑定到 Pod 或 Deployment 之外，还可以在创建 Service Account 时添加一些注释来触发自动创建对应的 Secrets。这些注释需要添加在 Service Account 的 metadata.annotations 字段中，如下所示：

yaml
Copy code
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-service-account
  annotations:
    kubernetes.io/service-account.name: my-service-account
    kubernetes.io/service-account.uid: d2d70ff3-3215-4050-88b8-9f9e06d384f
```


# 报错
```text
(base) ➜  k8s git:(master) kubectl apply -f deployment.yml
Error from server (BadRequest): error when creating "deployment.yml": Deployment in version "v1" cannot be handled as a Deployment: strict decoding error: unknown field "spec.template.spec.containers[0].imagePullSecrets"

```

解决: 注释掉imagePullSecrets


# Error from server (Forbidden): deployments.apps "digit-ci" is forbidden: User "system:serviceaccount:default:default" cannot get resource "deployments" in API group "apps" in the namespace "app"


最终还是使用了bitnami/kubectl的挂载, 然后只挂载目录

可以这样做, 新增一个目录, 然后将目录赋予777权限, 然后将.kube/config文件复制过去, 然后挂在这个新增的目录即可



但是还是遇到RABC的问题
from server for: "k8s/deployment.yml": deployments.apps "drone-ci-k8s-demo" is forbidden: User "system:serviceaccount:default:default" cannot get resource "deployments" in API group "apps" in the namespace "app"

# 解释一下, 大概意思就是
默认的账户没有 deployment的权限  



# 解决办法:  参考: https://stackoverflow.com/questions/49173838/deployments-apps-is-forbidden-user-systemserviceaccountdefaultdefault-cann
```text
You could:

Create a Cluster role with the resource you need, in this case in the app resource group.
Bind it to your service account.
Example:

kubectl create clusterrole deployer --verb=get,list,watch,create,delete,patch,update --resource=deployments.apps
kubectl create clusterrolebinding deployer-srvacct-default-binding --clusterrole=deployer --serviceaccount=default:default
```

所以要发布这个deployment指定一个service account, 然后这个service account是具有 deployment权限的就可以

然后现在我们在远端的执行的时候, 都默认使用default(命名空间):defa`   ult(默认service account),  但是这个default账户却没有deployment权限, 就会导致: forbidden: User "system:serviceaccount:default:default"

然后我们创建一个 clusterrole, 并赋予它deployments权限, 

通过 --serviceaccount=default:default, 将这个用于deployment权限的clusterrole 通过clusterrolebinding 绑定到default命名空间的default账户上, 


kubectl create clusterrolebinding deployer-srvacct-default-binding --clusterrole=deployer --serviceaccount=default:default, 从而赋予这个default ServiceAccount 使用 deployer 权限的能力


# 由于自己的应用都是在app命名空间,  所以在app命名空间创建的拥有deployment权限的角色, 也需要赋予default:default, 不然当你的deployment不是default命名空间的时候, 也会出现forbidden, 

拨错:  Error from server (Forbidden): pods is forbidden: User "system:serviceaccount:default:default" cannot list resource "pods" in API group "" in the namespace "app": RBAC: clusterrole.rbac.authorization.k8s.io "drone-deploy-app" not found

没有正确的创建clusterrole, 使用
```text
kubectl create clusterrole drone-app-deployer --verb=get,list,watch,create,delete,patch,update --resource=deployments.apps -n app
kubectl create clusterrolebinding drone-app-srvacct-default-binding --clusterrole=drone-app-deployer --serviceaccount=default:default  -n app
```


# 报错: 
```text
Error from server (Forbidden): pods is forbidden: User "system:serviceaccount:default:default" cannot list resource "pods" in API group "" in the namespace "app"
```

注意看, 这个是pod, 不是
注意:
而 ClusterRole 是针对整个集群的资源权限控制，不能用于控制单个 Namespace 内的资源权限。
如果想要控制 Namespace 内的资源权限，
需要使用 Role 或 RoleBinding，
例如以下命令可以授予某个 ServiceAccount 在指定 Namespace 内对 Deployments 的 get、list、watch、create、delete、patch、update 操作权限：
```shell
kubectl create role deployer --verb=get,list,watch,create,delete,patch,update --resource=deployments.apps -n <namespace>
kubectl create rolebinding deployer --role=deployer --serviceaccount=<serviceaccount> -n <namespace>

```
其中，<namespace> 为指定的 Namespace，<serviceaccount> 为指定的 ServiceAccount。这里创建了一个名为 deployer 的 Role，然后通过 deployer RoleBinding 绑定到指定的 ServiceAccount 上，使其具有对该 Namespace 内的 Deployments 资源的指定权限。

上面我们创建的是clusterrole, 和 clusterrolebinding, 这个是针对针对集群的资源权限控制, 比如可以操作deployment等, 但是具体到namespace上的资源, 就需需要创建role和roleBinding
```shell
kubectl create role deployer --verb=get,list,watch,create,delete,patch,update --resource=deployments.apps -n yourNamespace
kubectl create rolebinding deployer --role=deployer --serviceaccount=default:default -n yourNamespace
```

完成操作