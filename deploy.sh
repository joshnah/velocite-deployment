echo "#################### Deployment of k8s resources #################### "

echo "-------------------- Deleting ressources of namespace -------------------- "

kubectl delete --all --namespace=default pods,services,deployments,configmaps,secrets,ingress
kubectl delete all --all -n spark-operator
kubectl delete namespace spark-operator
kubectl delete sparkapplication --all -n default

echo "-------------------- Deployment of secret -------------------- "

kubectl apply -f secret.yaml

echo "-------------------- Deployment of Kafka -------------------- "

kubectl apply -f kafka/k8s/services/kafka_service.yaml
kubectl apply -f kafka/k8s/pods/kafka_pod.yaml

echo "-------------------- Deployment of Kowl -------------------- "

kubectl apply -f kafka/kowl/kowl.yaml
kubectl apply -f kafka/kowl/kowl_service.yaml

echo "-------------------- Deployment of Cassandra -------------------- "

kubectl create configmap cassandra-script --from-file=cassandra/k8s/script/cassandra_schema.cql
kubectl apply -f cassandra/k8s/volume/cassandra-persistent-volume.yaml
kubectl apply -f cassandra/k8s/volume/cassandra-pvc.yaml
kubectl apply -f cassandra/k8s/deployment/cassandra-load-keyspace-deployment.yaml
kubectl apply -f cassandra/k8s/service/cassandra-service.yaml
kubectl apply -f cassandra/k8s/deployment/cassandra-deployment.yaml

echo "-------------------- Deployment of Producer -------------------- "

kubectl apply -f kafka/producer/k8s/configmaps/producer_configmap.yaml
kubectl apply -f kafka/producer/k8s/deployments/producer_deploy.yaml

echo "-------------------- Deployment of Prometheus -------------------- "
kubectl create configmap prometheus-server-conf --from-file=./prometheus/configs
kubectl apply -R -f prometheus/kube_state_metrics
kubectl apply -R -f prometheus/node_exporter
kubectl apply -R -f prometheus/k8s
kubectl apply -R -f prometheus/alertmanager

echo "-------------------- Deployment of Grafana -------------------- "
kubectl create configmap grafana-dashboards-files --from-file=./grafana/dashboards
kubectl apply -R -f grafana/k8s

echo "-------------------- Deployment of Spark -------------------- "

helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

helm install my-release spark-operator/spark-operator --namespace spark-operator --set sparkJobNamespace=default --set serviceAccounts.spark.name=spark --set enableWebhook=true --create-namespace

kubectl apply -f spark/streaming.yaml