应用配置保存失败：open /data/gogs/conf/app.ini: read-only file system
我们可以先不用挂载configMap, 等安装成功后, 再挂载configMap

当我们安装gogs成功后, 就可以进入pod容器内部, 把配置文件app.ini给copy出来

kubectl create configmap gogs-config --from-file=/data/configMap/app.ini -n gogs

然后修改挂载出来的文件, 
执行:
kubectl create configmap --overwrite gogs-config --from-file=/data/configMap/app.ini -n gogs
这将使用新的 app.ini 文件更新 ConfigMap。Pod 将自动重启以应用新的配置。

如果保存的时候, 提示permission deny啥的

就去到pvc对应的目录下去赋予读写权限


# Delivery: Post "http://192.168.20.150:30021/hook": read tcp 10.233.102.163:52386->192.168.20.150:30021: i/o timeout

 我就不理解了, 为啥会webhook推送失败?

很莫名其妙, 因为之前没有遇到过这样的情况, 怀疑过pod之间的通信问题, 但是其他pod都是正常

通过尝试一下办法解决: 

1. 仓库删除了重新推送, 
2. drone, runner重新部署

经过上面两个步骤的尝试, 可以了
 