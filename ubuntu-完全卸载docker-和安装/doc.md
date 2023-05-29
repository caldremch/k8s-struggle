```shell
apt-get autoremove docker docker-ce docker-engine  docker.io  containerd runc
rm -rf /etc/systemd/system/docker.service.d
rm -rf /etc/systemd/system/docker.service
rm -rf /etc/systemd/system/docker.socker
rm -rf /var/lib/docker
```


# 重新安装
```shell
apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt-get update

# 仅安装containerd
sudo apt-get install containerd.io -y

# 安装docker+containerd
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```


# 修改containerd的存储目录 reference : https://blog.csdn.net/weixin_45447716/article/details/110170276

```shell
# 查看  path = "/opt/docker/containerd"  
containerd config default | grep path
sudo containerd config default > config_new.toml
sudo mv /etc/containerd/config.toml /etc/containerd/config_bak.toml
sudo mv config_new.toml /etc/containerd/config.toml
# 修改路径
vim /etc/containerd/config.toml
systemctl restart containerd.service
```
