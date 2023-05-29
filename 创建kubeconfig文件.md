创建 kubeconfig 文件
使用以下命令创建 kubeconfig 文件：

```shell
kubectl config set-credentials <credential-name> --token=<token-value>
kubectl config set-context <context-name> --user=<credential-name>
kubectl config use-context <context-name>
```

其中，<credential-name> 可以为任意名称，用于标识这个 credential；<token-value> 是您的 token 值；<context-name> 也可以为任意名称，用于标识这个 context。

将 kubeconfig 文件存储到本地
使用以下命令将 kubeconfig 文件存储到本地：

```shell
mkdir ~/.kube
cp <kubeconfig-file> ~/.kube/config
```

其中，<kubeconfig-file> 是您刚才创建的 kubeconfig 文件。

使用 kubectl 命令进行登录
使用以下命令进行登录：

```shell
kubectl proxy
```
然后，在浏览器中输入 http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/ 访问 Kubernetes Dashboard，即可自动使用 kubeconfig 文件中存储的 token 进行登录。