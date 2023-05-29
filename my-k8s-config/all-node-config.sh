
# 配置固定IP地址
#vi /etc/sysconfig/network-scripts/ifcfg-ens33
#vi /etc/udev/rules.d/70-persistent-net.rules
#systemctl restart network

# 关闭并禁用防火墙
systemctl stop firewalld
systemctl disable firewalld

# 关闭 selinux
# 临时关闭【立即生效】告警，不启用，Permissive，查看使用 getenforce 命令
setenforce 0
# 永久关闭【重启生效】
sed -i 's/SELINUX=enforcing/\SELINUX=disabled/' /etc/selinux/config

# 关闭 swap
# 临时关闭【立即生效】查看使用 free 命令
swapoff -a
# 永久关闭【重启生效】
sed -ri 's/.*swap.*/#&/' /etc/fstab

# 在主机名静态查询表中添加 3 台主机
#cat >> /etc/hosts << EOF
#192.168.20.150 k8sappmaster
#192.168.80.113 k8sappworker1
#EOF


# 在主机名静态查询表中添加 3 台主机
cat >> /etc/hosts << EOF
192.168.20.150 k8sappmaster
192.168.80.113 k8sappworker1
EOF

# 将桥接的 IPv4 流量传递到 iptables 的链
cat > /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
# 使 k8s 配置生效
sysctl --system

# 时间同步
yum install ntpdate -y
ntpdate time.windows.com

# 根据规划设置主机名【k8smaster  节点上操作】
hostnamectl set-hostname k8sappmaster
## 根据规划设置主机名【k8snode1 节点上操作】
#hostnamectl set-hostname k8snode1
## 根据规划设置主机名【k8snode2 节点操作】
#hostnamectl set-hostname k8snode2

## 访问github
#echo "
#140.82.114.3 github.com
#185.199.108.153 assets-cdn.github.com
#199.232.69.194  github.global.ssl.fastly.net
#185.199.108.133 raw.githubusercontent.com
#185.199.108.154 github.githubassets.com
#" >> /etc/hosts
