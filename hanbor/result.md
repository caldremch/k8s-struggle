* Please be patient while the chart is being deployed **

1. Get the Harbor URL:

NOTE: It may take a few minutes for the LoadBalancer IP to be available.
Watch the status with: 'kubectl get svc --namespace harbor -w harbor'
export SERVICE_IP=$(kubectl get svc --namespace harbor harbor --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
echo "Harbor URL: http://$SERVICE_IP/"

2. Login with the following credentials to see your Harbor application

echo Username: "admin"
echo Password: $(kubectl get secret --namespace harbor harbor-core-envvars -o jsonpath="{.data.HARBOR_ADMIN_PASSWORD}" | base64 -d)


export NODE_PORT=$(kubectl get --namespace harbor -o jsonpath="{.spec.ports[0].nodePort}" services harbor)
export NODE_IP=$(kubectl get nodes --namespace harbor -o jsonpath="{.items[0].status.addresses[0].address}")
echo "Harbor URL: http://$NODE_IP:$NODE_PORT/"




# 结论

经验证: http协议无法访问
http://192.168.205.5:30014/

但是
https://192.168.205.5:30015/  可以访问

## 但是 但是 docker无法登录

#如果是本地安装, 关闭https, 不然登录不了, 或者只能https/ip的形式来访问, 你docker也无法通过 https://ip形式来登录, 会报错:Error response from daemon: Get "https://192.168.205.5:30015/v2/": x509: cannot validate certificate for 192.168.205.5 because it doesn't contain any IP SANs


### 解决办法
1. 配置里面关闭nginx的tls, 真的栓Q这个nginx配置了, 让我一直百思不得其解, 藏得太深了


#刷新浏览器或者换一个浏览器打开
http://192.168.205.5:30014

终于看到登录界面

查看登录用户和密码, 参考helm 安装完毕后的提示即可

```text
1. Get the Harbor URL:

    export NODE_PORT=$(kubectl get --namespace harbor -o jsonpath="{.spec.ports[0].nodePort}" services harbor)
    export NODE_IP=$(kubectl get nodes --namespace harbor -o jsonpath="{.items[0].status.addresses[0].address}")
    echo "Harbor URL: http://$NODE_IP:$NODE_PORT/"

2. Login with the following credentials to see your Harbor application

  echo Username: "admin"
  echo Password: $(kubectl get secret --namespace harbor harbor-core-envvars -o jsonpath="{.data.HARBOR_ADMIN_PASSWORD}" | base64 -d)
```


将 192.168.205.5:30014 配置到 docker insecure-registries里面, 就可以通过docker login登录了, 一定要配置, 不然登录会提示错误, 比如:
Error response from daemon: Get "https://192.168.205.7:30014/v2/": http: server gave HTTP response to HTTPS client
