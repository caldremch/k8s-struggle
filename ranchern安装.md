# rancher k8s管理, docker启动方式

sudo docker run -d --restart=unless-stopped -p 30080:80 -p 30443:443 --privileged rancher/rancher