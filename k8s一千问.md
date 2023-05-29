# modprobe overlay 是什么意思?
```text

modprobe是一个Linux命令，用于动态加载内核模块。overlay是一种文件系统技术，允许在现有文件系统之上创建一个叠加层，以便更改文件系统而无需修改底层文件系统。因此，执行命令"modprobe overlay"是在Linux内核中加载overlay模块，以便在文件系统上使用overlay技术。




Caldremch
这个叠加层是用来干什么的? 解决了什么问题? 
叠加层（Overlay）是容器镜像的一种构建方式，可以将多个只读镜像叠加在一起，形成一个新的可读写的容器文件系统。使用叠加层技术，可以实现镜像的快速构建和高效存储。

传统的容器镜像构建方式是每次构建都会生成一个新的完整的镜像，这样会占用大量的磁盘空间，并且在镜像的版本控制和分发上也存在一些问题。使用叠加层技术，则可以将不同版本的镜像叠加在一起，只存储变化的部分，从而节省了磁盘空间。此外，镜像的版本控制和分发也变得更加灵活和高效。

在Kubernetes中，使用叠加层技术可以让Pod之间共享相同的只读镜像层，从而提高资源利用率和容器启动速度。而在调度器中使用叠加层则可以让不同节点上的容器可以共享相同的只读镜像层，从而减少网络传输和磁盘空间的使用。modprobe overlay命令则是加载Overlay内核模块，使得容器可以使用Overlay叠加层技术。
```

# modprobe br_netfilter 是什么意思? 
```text
modprobe 是一个命令行工具，用于向 Linux 内核动态加载模块。br_netfilter 是一个 Linux 内核模块，它提供了一种在桥接网络上启用网络地址转换（NAT）功能的方法。

当你在 Kubernetes 集群中使用网络插件（如 Calico 或 Flannel）时，通常需要启用 br_netfilter 模块。它可以确保 Kubernetes 节点之间的网络流量正常传递，并使网络策略（Network Policies）能够正常工作。具体来说，它可以让 Kubernetes 以正确的方式设置 iptables 规则，以确保 Kubernetes 网络中的各种组件（如 Pod、Service 等）能够相互通信。
```

# /etc/sysctl.d/99-kubernetes-cri.conf  这个文件是用来干什么的? 
```text
/etc/sysctl.d/99-kubernetes-cri.conf 文件是用于配置 Linux 内核参数的文件，其目的是为了满足 CRI（Container Runtime Interface）运行时的需求。CRI是一种Kubernetes API，用于与容器运行时进行交互，以管理容器的生命周期。在运行 CRI 容器运行时之前，需要设置一些内核参数，以确保容器可以正常运行和网络可以正常通信。例如，该文件中可能会设置一些网络参数、内存参数、文件描述符限制等等。在Kubernetes集群中，这些内核参数的设置通常会由初始化脚本完成。
```

# 分别解释一下, 这几个值 设置的意义:  net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1


```text
net.bridge.bridge-nf-call-iptables = 1 用于开启桥接包的iptables过滤功能，当它为1时，Linux内核会在网络接口处进行流量控制，以便在跨容器通信时执行iptables过滤规则。如果没有打开此选项，iptables规则将不能控制容器间的流量。
net.ipv4.ip_forward = 1 用于开启IP转发功能，当它为1时，Linux内核会将传入的数据包转发到另一个网络接口，这在网络中间件或路由器方案中经常使用。
net.bridge.bridge-nf-call-ip6tables = 1 用于开启桥接包的ip6tables过滤功能，当它为1时，Linux内核会在网络接口处进行流量控制，以便在跨容器通信时执行ip6tables过滤规则。如果没有打开此选项，ip6tables规则将不能控制容器间的流量。
```
