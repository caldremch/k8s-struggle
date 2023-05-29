1. https://ranchermanager.docs.rancher.com/pages-for-subheaders/install-upgrade-on-a-kubernetes-cluster#4-install-cert-manager
   如果您只在本地安装了Rancher，那么您可以使用Rancher来添加其他主机的集群。但是，您需要确保您的主机可以与其他主机通信，并且您已经在其他主机上安装了所需的集群软件。例如，如果您要添加Kubernetes集群，则需要在每个节点上安装Kubernetes组件。

要将其他主机添加到Rancher中，请按照以下步骤操作：

在Rancher控制台中，点击左侧导航栏中的“主机”。
点击“添加主机”按钮，然后选择您要添加的主机类型。例如，您可以选择Linux主机或Windows主机。
根据您选择的主机类型，填写相关信息。例如，如果您选择的是Linux主机，则需要提供SSH凭据和主机名称或IP地址等。
根据需要，配置其他选项，例如代理设置和标签等。
点击“创建”按钮以添加主机。
一旦您已经将其他主机添加到Rancher中，您就可以使用Rancher来管理和监视这些主机上的集群了。请注意，添加主机需要一定的时间来完成，并且您需要确保您已经正确地配置了主机和集群软件。