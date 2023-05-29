if grep "SystemdCgroup = true"  /etc/containerd/config.toml &> /dev/nul; then
  driver=systemd
else
  driver=cgroupfs
fi
echo "driver is ${driver}"