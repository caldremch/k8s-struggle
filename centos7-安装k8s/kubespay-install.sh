cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(120.78.137.197)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
vim inventory/mycluster/group_vars/all/all.yml
vim inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml


