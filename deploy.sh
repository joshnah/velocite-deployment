echo "#################### Deployment of k8s resources #################### "

echo "-------------------- Deleting ressources of namespace -------------------- "

kubectl delete --all --namespace=default pods,services,deployments,configmaps,secrets,ingress

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

echo "-------------------- Deployment of Consumer -------------------- "

kubectl apply -f kafka/consumer/k8s/configmaps/consumer_configmap.yaml
kubectl apply -f kafka/consumer/k8s/deployments/consumer_deploy.yaml