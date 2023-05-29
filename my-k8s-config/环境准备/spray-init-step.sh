sudo apt update
#每个节点都要执行
echo "caldremch ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/caldremch


#所有节点需要先执行 安装包的更新,
# 例如: Ubuntu
sudo apt update


sudo apt install git python3 python3-pip -y
git clone https://github.com/kubernetes-incubator/kubespray.git
cd kubespray
pip install -r requirements.txt
pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/

# 不知道为啥， 安装成功后， 但是在caldremch用户下无法使用， 只能切换到root用户再重新装一次， 然后再root和caldremch用户都可以执行了
# sudo su -
# pip install -r requirements.txt

ansible --version

cp -rfp inventory/sample inventory/mycluster
#declare -a IPS=(10.211.55.4 10.211.55.5 10.211.55.6)
declare -a IPS=(192.168.20.150 192.168.20.151 192.168.20.152)
declare -a IPS=(192.168.80.31 192.168.80.31 192.168.80.32 192.168.80.33)
declare -a IPS=(192.168.205.5 192.168.205.6 192.168.205.7)
#declare -a IPS=(10.211.55.7 10.211.55.7 10.211.55.8 10.211.55.9)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
#ssh-keygen
#ssh-copy-id caldremch@10.211.55.7
#ssh-copy-id caldremch@10.211.55.8
#ssh-copy-id caldremch@10.211.55.9



###### 第2次测试
#cp -rfp inventory/sample inventory/mycluster
#declare -a IPS=(10.211.55.4 10.211.55.4 10.211.55.6)
#CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

ssh-keygen
#ssh-copy-id root@10.211.55.4
#ssh-copy-id root@10.211.55.5
#ssh-copy-id root@10.211.55.6

ssh-copy-id root@192.168.205.8


ssh-copy-id root@192.168.20.150
ssh-copy-id root@192.168.20.151
ssh-copy-id root@192.168.20.152

ssh-copy-id caldremch@192.168.80.31
ssh-copy-id caldremch@192.168.80.32
ssh-copy-id caldremch@192.168.80.33

ssh-copy-id caldremch@192.168.205.5
ssh-copy-id caldremch@192.168.205.6
ssh-copy-id caldremch@192.168.205.7


# ubuntu 关闭防火墙的办法. 这个很重要, 如果这操作这个命令, 会导致虚拟机之间的端口无法访问到
sudo ufw disable

# 操作所有的节点
cd kubespray
ansible all -i inventory/mycluster/hosts.yaml -m shell -a "sudo ufw disable"


cd kubespray
ansible all -i inventory/mycluster/hosts.yaml -m shell -a "sudo systemctl stop firewalld && sudo systemctl disable firewalld"
ansible all -i inventory/mycluster/hosts.yaml -m shell -a "echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf"
ansible all -i inventory/mycluster/hosts.yaml -m shell -a "sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab && sudo swapoff -a"

cd /root/kubespray
vim inventory/mycluster/hosts.yaml
vim inventory/mycluster/group_vars/k8s_cluster/addons.yml
vim inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml




# 在文件中配置http（s）代理
vim inventory/mycluster/group_vars/all/all.yml


# 查看 inventory/mycluster/hosts.ini


ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root cluster.yml


#在安装过程如果出现以下下载失败，可能是代理线路的问题， 网络的问题。切换一下就好了


# 这里必须要切换到root用户， 否则会提示 The connection to the server localhost:8080 was refused - did you specify the right host or port?
sudo su -
kubectl get nodes
kubectl get pods -A