```shell
scp root@192.168.205.5:~/.kube/config ~/.kube/config-remote-1921682055
```


如果您想在本地电脑使用kubectl命令控制云服务器上的Kubernetes集群，可以使用以下步骤：

从云服务器上复制 .kube/config 文件到本地电脑中的某个目录中，比如 ~/.kube/remote-config。

注意: 如果不是域名, 需要修改具体的server为远端的ip地址, 因为配置文件有可能是127.0.0.1

修改本地电脑的 ~/.kube/config 文件，添加一个新的 context，指向远程Kubernetes集群。例如，您可以运行以下命令：

```shell
kubectl config set-context kubernetes-admin@cluster.local --cluster=cluster.local --user=kubernetes-admin --kubeconfig=$HOME/.kube/config-remote-1921682055
```

kubernetes-admin@cluster.local: context的名字, 在配置文件中
cluster.local: 集群
kubernetes-admin: 用户名
这里假设您将远程的 .kube/config 文件保存在了 $HOME/.kube/remote-config，并且该文件包含了 remote-cluster 集群的配置和 remote-user 用户的认证信息。

设置 kubectl 默认使用刚才新创建的 context：

```shell
kubectl config use-context remote-cluster
```

这样，您就可以在本地电脑上使用 kubectl 命令控制云服务器上的 Kubernetes 集群了。

需要注意的是，上述操作会修改本地电脑上的 .kube/config 文件，如果您需要使用本地电脑上的 Kubernetes 集群，可以再次运行 kubectl config use-context 命令切换回本地集群的 context。

# 获取当前所有的context
kubectl config get-contexts --kubeconfig=$HOME/.kube/config-remote-1921682055

发现每次都要指定 --kubeconfig=$HOME/.kube/config-remote-1921682055才可以正确获取到远端集群的信息,

然后通过kubectl config use-context remote-cluster也是不行的, 因为默认的配置文件读取是config, 
所以, 解决办法是将 $HOME/.kube/config-remote-1921682055文件中的集群配置 配置到 config文件, 这样就可以获取到获取到本地和远端的集群, 同时也可以use-context远端的集群

