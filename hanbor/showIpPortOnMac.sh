export NODE_PORT=$(kubectl get --namespace harbor -o jsonpath="{.spec.ports[0].nodePort}" services harbor)
export NODE_IP=$(kubectl get nodes --namespace harbor -o jsonpath="{.items[0].status.addresses[0].address}")
echo "Harbor URL: http://$NODE_IP:$NODE_PORT/"

echo Username: "admin"
echo Password: $(kubectl get secret --namespace harbor harbor-core-envvars -o jsonpath="{.data.HARBOR_ADMIN_PASSWORD}" | base64 -d)