```yaml
network:
  ethernets:
    enp1s0:
      dhcp4: false
      addresses: [192.168.20.150/24]
      routes:
        - to: default
          via: 192.168.20.1
      nameservers:
        addresses: [202.96.134.133, 114.114.114.114]
      dhcp6: false
  version: 2
```