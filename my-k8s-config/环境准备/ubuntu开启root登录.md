# 如果虚拟机复制不了可以这样解决

先以安装虚拟机的用户登录到 远程ssh工具， 然后执行一下命令结束后， 再以远程连接root

# 以普通用户登录系统，创建root用户的密码
opt@opt:~# sudo passwd root

注意： 以下命令行再当前用户下执行， 而不是在root用户下执行

# SSH 放行
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;

# 重启服务
sudo service sshd restart