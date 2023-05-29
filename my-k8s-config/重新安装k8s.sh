kubeadm reset
kubeadm init --v=5 \
--control-plane-endpoint=mymaster:6443 \
--pod-network-cidr=10.244.0.0/16 \
--ignore-preflight-errors=NumCPU