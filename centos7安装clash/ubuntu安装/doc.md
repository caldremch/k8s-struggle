
# 开机启动服务
```text
[Unit]
Description=Clash Daemon
After=network.target

[Service]
ExecStart=/data/clash/clash -d /data/clash

[Install]
WantedBy=default.target
```

```shell
sudo systemctl daemon-reload # 刷新配置
sudo systemctl start clash # 启动clash.service
sudo systemctl enable clash # 设置开机启动
sudo systemctl status clash # 查看clash.service的状态
```


``shell
# 添加ui
vim /data/clash/config.yaml
``

config.yaml配置如下:

```text

mixed-port: 7890
external-controller: 0.0.0.0:9090
allow-lan: false
mode: rule
log-level: warning
external-ui: /data/clash/clash-ui
```


# 临时取消代理

```shell
unset http_proxy
unset https_proxy
```

# 查看代理
```text
env | grep xxx
```


# 给clash添加订阅

```shell
wget -O config.yaml 订阅链接
```
这个操作把原来的config.yaml覆盖, 但是没有关系


# 节点选择
下载订阅后一般会自动选择

# 配置代理 , 这一步很重要

export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
export no_proxy="localhost, 127.0.0.1"


这回再执行
wget google.com ,就会发现可以了