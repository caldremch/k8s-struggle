```shell
host=192.168.20.150
scp -r /data/clash/ root@192.168.20.151:/data/clash/
scp -r /data/clash/ root@192.168.20.152:/data/clash/
scp  /etc/systemd/system/clash.service root@192.168.20.151:/etc/systemd/system/clash.service
scp  /etc/systemd/system/clash.service root@192.168.20.152:/etc/systemd/system/clash.service
```