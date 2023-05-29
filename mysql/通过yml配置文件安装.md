

```shell
kubectl create ns mysql
helm -n mysql install mysql bitnami/mysql -f mysql-config.yaml
```
helm -n database install mysql bitnami/mysql -f mysql-config.yaml

helm -n mysql install mysql -f mysql-config-single.yaml bitnami/mysql 