同样的mysql连接,

在python上链接成功代码如下:
import MySQLdb

conn = MySQLdb.connect(
host="192.168.205.5",
port=32125,
db="digitization_dev",
user="root",
passwd="root")

cur = conn.cursor()
cur.execute('SELECT version()')

print(cur.fetchone()[0])

conn.close()

在go语言上连接成功,代码如下:

package main

import (
"database/sql"
"fmt"
_ "github.com/go-sql-driver/mysql"
)

func main() {
DB, err := sql.Open("mysql", "root:root@tcp(192.168.205.5:32125)/digitization_dev")
if err != nil {
panic(err)
return
}
//验证连接
if err := DB.Ping(); err != nil {
panic(err)
fmt.Println("open database fail")
return
}

	fmt.Println("connnect success")

}

在java上却连接失败,代码如下:
import java.sql.DriverManager

fun main(args: Array<String>) {
println("Hello World!")
val JDBC_DRIVER = "com.mysql.jdbc.Driver";
val DB_URL = "jdbc:mysql://10.233.50.105:32125/digitization_dev?useSSL=false";
val USER = "root";
val PASS = "root";//密码未贴出
Class.forName("com.mysql.cj.jdbc.Driver");
// 打开链接
System.out.println("连接数据库...");
val conn = DriverManager.getConnection(DB_URL,USER,PASS);
}

这是为什么呢? java报错: The last packet sent successfully to the server was 0 milliseconds ago. The driver has not
received any packets from the server.

我不理解

# 遇到问题 Can't connect to local MySQL server through socket '/opt/bitnami/mysql/tmp/mysql.sock' (2)

1. 莫名奇妙,
   删除命名空间mysql, 通过helm delete 删除mysql

然后重新安装 还是不行了, 然后只能修改了 mysql的版本

```text
global:
  storageClass: "nfs-client"
architecture: standalone
auth:
  rootPassword: "root"
#  database: "digitization_dev"

image:
  debug: true
  tag: 5.7.42
primary:
  name: primary
  service:
    type: NodePort
    nodePorts:
      mysql: "30362"

```

最终安装成功, 也可以用了