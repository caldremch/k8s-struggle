#设置网卡

#最好也设置 sudo用户
#echo "caldremch ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/caldremch

#先设置权限， 否则远程指令无法覆盖或者操作
#sudo chmod 777 /etc/netplan/00-installer-config.yaml


scp /Users/caldremch/work/code/docker-code/caldremch-k8s/my-k8s-config/配置局域网代理访问外网/master/00-installer-config.yaml caldremch@192.168.80.125:/etc/netplan
scp /Users/caldremch/work/code/docker-code/caldremch-k8s/my-k8s-config/配置局域网代理访问外网/worker1/00-installer-config.yaml caldremch@192.168.80.171:/etc/netplan
scp /Users/caldremch/work/code/docker-code/caldremch-k8s/my-k8s-config/配置局域网代理访问外网/worker2/00-installer-config.yaml caldremch@192.168.80.176:/etc/netplan

# 更新
sudo netplan apply

ssh caldremch@192.168.80.31 "netplan apply"
ssh caldremch@192.168.80.32 "netplan apply"
ssh caldremch@192.168.80.33 "netplan apply"

# set proxy
ssh caldremch@192.168.80.31 "echo 'export http_proxy=http://192.168.80.30:7890' >> ~/.bashrc; echo 'export https_proxy=http://192.168.80.30:7890' >> ~/.bashrc; source ~/.bashrc; cat ~/.bashrc"
ssh caldremch@192.168.80.32 "echo 'export http_proxy=http://192.168.80.30:7890' >> ~/.bashrc; echo 'export https_proxy=http://192.168.80.30:7890' >> ~/.bashrc; source ~/.bashrc; cat ~/.bashrc"
ssh caldremch@192.168.80.33 "echo 'export http_proxy=http://192.168.80.30:7890' >> ~/.bashrc; echo 'export https_proxy=http://192.168.80.30:7890' >> ~/.bashrc; source ~/.bashrc; cat ~/.bashrc"

#查看代理
env | grep - proxy
ssh caldremch@192.168.80.31 "env | grep - proxy"
ssh caldremch@192.168.80.32 "env | grep - proxy"
ssh caldremch@192.168.80.33 "env | grep - proxy"

export http_proxy=http://192.168.80.30:7890
export https_proxy=http://192.168.80.30:7890
# 测试链接外网
wget google.com
