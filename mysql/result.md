```text
** Please be patient while the chart is being deployed **

Tip:

  Watch the deployment status using the command: kubectl get pods -w --namespace mysql

Services:

  echo Primary: mysql-primary.mysql.svc.cluster.local:3306
  echo Secondary: mysql-secondary.mysql.svc.cluster.local:3306

Execute the following to get the administrator credentials:

  echo Username: root
  MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace mysql mysql -o jsonpath="{.data.mysql-root-password}" | base64 -d)

To connect to your database:

  1. Run a pod that you can use as a client:

      kubectl run mysql-client --rm --tty -i --restart='Never' --image  docker.io/bitnami/mysql:8.0.32-debian-11-r21 --namespace mysql --env MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --command -- bash

  2. To connect to primary service (read/write):

      mysql -h mysql-primary.mysql.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"

  3. To connect to secondary service (read-only):

      mysql -h mysql-secondary.mysql.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"
```

# springboot2 连接 集群mysql报错: The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.

真的很奇怪
1. 我通过python或者go写了连接数据库都是没问题, 但是在java端就是死活不行, 后面搜索各种查, 有说的mysql连接驱动的问题, 但是经过各种尝试后, 还是失败
2.尝试端口转发, 也试试失败的kubectl port-forward k8s-mysql-local-primary-0 23306:3306 -n mysql
3. 我的电脑是mac, 后面尝试在linux写了一段mysql连接, 也是成功的

所以不理解这种几种尝试下, 能总结出什么问题? 放弃了. 因为至少当发布程序到服务器(linux)也能连接通过



# 单实例安装结果

```text
** Please be patient while the chart is being deployed **

Tip:

  Watch the deployment status using the command: kubectl get pods -w --namespace mysql

Services:

  echo Primary: mysql.mysql.svc.cluster.local:3306

Execute the following to get the administrator credentials:

  echo Username: root
  MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace mysql mysql -o jsonpath="{.data.mysql-root-password}" | base64 -d)

To connect to your database:

  1. Run a pod that you can use as a client:

      kubectl run mysql-client --rm --tty -i --restart='Never' --image  docker.io/bitnami/mysql:5.7.42 --namespace mysql --env MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --command -- bash

  2. To connect to primary service (read/write):

      mysql -h mysql.mysql.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"




```