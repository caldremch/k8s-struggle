sudo apt-get install nfs-kernel-server -y
#tee 命令 “-a” 选项的作用等同于 “>>” 命令，如果去除该选项，那么 tee 命令的作用就等同于 “>” 命令。
echo "/data/nfsdata  *(rw,sync,no_root_squash)" | sudo tee -a /etc/exports
#echo "/data/nfs  *(rw,sync,no_root_squash)" | sudo tee -a /etc/exports
sudo mkdir /data/nfsdata
sudo chmod -R 777 /data/nfsdata
#sudo chown caldremch:caldremch /data/nfsdata -R
sudo /etc/init.d/nfs-kernel-server start
sudo /etc/init.d/nfs-kernel-server restart
showmount -e