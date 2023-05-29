# doc

1. https://github.com/harness/drone/issues/2881
2. https://hub.docker.com/r/drone/drone-runner-kube/tags
3. https://docs.drone.io/runner/kubernetes/installation/
4. https://cloud.tencent.com/developer/article/1955364

参考 https://wqblogs.com/2021/02/08/drone%E5%AE%9E%E7%8E%B0%E8%87%AA%E5%8A%A8%E5%8C%96/
来安装, 

drone/drone-runner-kube是runner的角色, 还需要安装server




# 镜像拉取凭证创建和查找

imagePullSecrets:
- name: harbor

您可以使用以下命令查看现有的 secret：

arduino
Copy code
kubectl get secrets
如果您使用的是 Harbor，您还可以通过在浏览器中打开 Harbor Web 界面并导航到您的项目的“凭证”部分来查看凭证。

要创建新的凭证，您可以使用以下命令：

php
Copy code
kubectl create secret docker-registry <SECRET_NAME> --docker-username=<USERNAME> --docker-password=<PASSWORD> --docker-email=<EMAIL> --namespace=<NAMESPACE>
请将 <SECRET_NAME> 替换为您希望创建的凭证的名称，<USERNAME>、<PASSWORD> 和 <EMAIL> 替换为您在注册表上使用的凭据的实际值，<NAMESPACE> 替换为要部署应用程序的名称空间。



# gogs万年的问题: 推送 URL 被解析到默认禁用的本地网络地址。


先将容器内的app.ini文件拉取出来, 进入容器内容, 复制app.ini(/data/gogs/conf/app.ini)文件内容, 在本地创建一个app.ini文件

然后在app.ini文件末尾添加
LOCAL_NETWORK_ALLOWLIST = *

*就是允许所有, 你也可以自己指定自己的ip地址


首先，创建一个 ConfigMap：

kubectl create configmap gogs-config --from-file=/usr/local/myconfig/app.ini -n gogs

这将使用本地的 app.ini 文件创建一个名为 gogs-config 的 ConfigMap 对象。


然后，在部署 Gogs 的 Deployment 配置文件中添加一个 volume：


```yaml
spec:
  containers:
    - name: gogs
      image: gogs/gogs
      volumeMounts:
        - name: config-volume
          mountPath: /app/gogs/custom/conf/app.ini
  volumes:
    - name: config-volume
      configMap:
        name: gogs-config

```
这将创建一个名为 config-volume 的卷，并将其挂载到容器的 /app/gogs/custom/conf/app.ini 目录下。此卷将从名为 gogs-config 的 ConfigMap 对象中获取数据。

现在，当你需要修改 app.ini 文件时，只需更新 ConfigMap：

kubectl create configmap gogs-config --from-file=app.ini --overwrite

这将使用新的 app.ini 文件更新 ConfigMap。Pod 将自动重启以应用新的配置。


根据上面的操作后: 报错:

```text

 Error: failed to create containerd task: failed to create shim task: OCI runtime create failed: runc create failed: 
 unable to start container process: error during container init: 
 error mounting "/var/lib/kubelet/pods/c020b112-9156-4ed4-ad80-cd122eb76f62/volumes/kubernetes.io~configmap/config-volume" to rootfs at "/data/gogs/conf/app.ini": 
 mount /var/lib/kubelet/pods/c020b112-9156-4ed4-ad80-cd122eb76f62/volumes/kubernetes.io~configmap/config-volume:/data/gogs/conf/app.ini (via /proc/self/fd/6), 
 flags: 0x5001: not a directory: unknown
  Warning  BackOff    29s (x10 over 2m11s)  kubelet            
  Back-off restarting failed container gogs in pod gogs-54dcc7f79-h8tt2_droneci(c020b112-9156-4ed4-ad80-cd122eb76f62)
```


大概的意思就是 k8s希望挂在的是一个目录, 却是一个文件
换成
```text
kubectl create configmap gogs-config --from-file=/usr/local/myconfig/gogs -n drone
```

删除deployment, 然后重新apply 


# gogs clone的时候 502, 但是网页却能访问
502 Bad Gateway是指错误网关，无效网关；在互联网中表示一种网络错误

我把.gitconfig中的代理关闭后, 就可以访问了
[https]
postBuffer = 4194304
# proxy = https://127.0.0.1:7890
[http]
postBuffer = 4194304
# proxy = http://127.0.0.1:7890



# 不要使用digit-ci实验, 因为它有android-sdk很慢


# 注意.drone.yml配置文件, 
# 参考:https://github.com/harness/drone/issues/3238
type: kubernetes

在k8s中部署的drone的不要设置为docker 不然会一直:
"manager: context canceled
"manager: request queue item"

日志为: 
```text
{"arch":"","kernel":"","kind":"pipeline","level":"debug","msg":"manager: context canceled","os":"","time":"2023-04-08T14:06:50Z","type":"kubernetes","variant":""}
{"arch":"","kernel":"","kind":"pipeline","level":"debug","msg":"manager: request queue item","os":"","time":"2023-04-08T14:06:55Z","type":"kubernetes","variant":""}
```

# drone构建报错: secrets is forbidden: User "system:serviceaccount:drone:default" cannot create resource "secrets" in API group "" in the namespace "default"


解释:
这个错误提示是因为当前使用的 ServiceAccount "drone" 没有足够的权限来创建名为 "secrets" 的 Kubernetes 资源。

默认情况下，ServiceAccount 不具备创建所有类型资源的权限。要创建一个 Secret 资源，你需要使用一个拥有相应权限的 ServiceAccount 来创建它，或者为现有 ServiceAccount 授予这些权限。在本例中，系统显示了尝试使用 "drone" ServiceAccount 创建 Secrets 资源的错误。

为了解决这个问题，你可以通过为 "drone" ServiceAccount 绑定适当的 ClusterRole 或 Role 来授予它创建 Secrets 资源的权限。或者，你可以使用具有足够权限的 ServiceAccount 来创建 Secrets 资源。






--------
kubectl describe secret drone-secrets -n drone

如果你要创建一个名为 drone-secrets 的 Secret 对象并添加敏感数据，你可以使用 kubectl create secret 命令。例如，下面是一个创建 Secret 对象的示例命令：

lua
Copy code
kubectl create secret generic drone-secrets --from-literal=DATABASE_PASSWORD=examplepassword -n drone
其中：

generic 是 Secret 对象的类型，可以存储任意类型的数据。
drone-secrets 是 Secret 对象的名称。
--from-literal 标志指定要添加的敏感数据。在此示例中，我们添加了一个名为 DATABASE_PASSWORD 的键和一个值 examplepassword。可以添加多个键值对，每个键值对之间使用空格分隔。
创建后，你可以使用 kubectl describe secret drone-secrets -n drone 命令来查看创建的 Secret 对象的详细信息。

kubectl create secret generic drone-secrets --from-literal=DRONE_RPC_SECRET=91d26c97f10cb4e0486eca27ec5f82fa -n drone
kubectl create secret generic drone-secrets --from-literal=DRONE_RPC_SECRET=91d26c97f10cb4e0486eca27ec5f82fa -n default

还是不行


**最终是将drone的角色, deployment, pvc**的namespace都改成default, 就解决了


# k8s里面的drone volume挂载, 参考 https://github.com/drone-runners/drone-runner-kube/blob/master/samples/volume_host.yml

这种挂在方式, 直接是挂在节点的目录下, 

我想的是挂在到pvc里面 , 

参考: https://github.com/drone-runners/drone-runner-kube/pull/28

还是失败了, 所以还是挂在节点(linux系统)下吧