1. 参考 ： https://www.cnblogs.com/liujiaxin2018/p/16287463.html

2. 文件路径：/etc/netplan/00-installer-config.yaml
```text
# This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s5:
      dhcp4: no
      addresses:
        - 192.168.80.31/24
      routes:
        - to: default
          via: 192.168.80.1
      nameservers:
        addresses:
          - 114.114.114.114
          - 202.96.134.133
  version: 2

```

3. 更新网卡：sudo netplan apply
