# GPT 问答记录

# 单位说明
在 Kubernetes（K8s）中，Pod 的资源规格是使用 Resource Units 来表示的。958Mi 是一种表示内存资源的单位，其中 Mi 是 mebibyte 的缩写，等于 2^20 字节，即 1,048,576 字节。

所以，958Mi 表示分配给 Pod 的内存资源为 958 mebibytes。换算成字节：

958 * 1,048,576 = 1,005,068,288 字节
以兆字节（MB）为单位表示：

1,005,068,288 字节 / 1,048,576 = 958 MB
K8s 中的 Pod 资源规格 958Mi 意味着为 Pod 分配 958 mebibytes（大约 958 MB）的内存资源。

# 我如何查看节点上 剩余可以使用内存资源和CPU资源?


可以使用kubectl命令行工具来查看节点上可用的CPU和内存资源。

要查看节点的资源使用情况和可用资源，您可以使用以下命令：

kubectl describe node <node-name>
将"<node-name>"替换为您要查看的节点的名称。此命令将输出节点的详细信息，包括其资源使用情况和可用资源。

例如，要查看节点"node-1"上可用的CPU和内存资源，您可以运行以下命令：


kubectl describe node node-1
输出结果中会包含以下信息：

yaml
Copy code
Allocatable:
cpu:                 4
memory:              15791980Ki
pods:                110
其中，"Allocatable"表示节点上可用的资源量。在这个例子中，节点"node-1"可用的CPU资源是4个CPU核心，可用的内存资源是15791980Ki（即约15.07GiB）。

您也可以使用以下命令来输出节点的资源使用情况和可用资源：


kubectl top node <node-name>
将"<node-name>"替换为您要查看的节点的名称。此命令将输出节点上每个容器的资源使用情况和总体资源使用情况。

例如，要查看节点"node-1"上的资源使用情况，您可以运行以下命令：


kubectl top node node-1
输出结果中会包含每个容器的CPU和内存使用情况，以及节点的总体CPU和内存使用情况。