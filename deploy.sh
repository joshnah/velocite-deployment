#!/bin/bash

echo "#################### Deployment of k8s resources #################### "

echo "-------------------- Deleting ressources of namespace -------------------- "

sh clear_ressources.sh

echo "-------------------- Creating ressources of namespaces -------------------- "

kubectl create namespace monitoring
kubectl create namespace messaging
kubectl create namespace database
kubectl create namespace web
kubectl create namespace spark-operator

echo "-------------------- Deployment of secret -------------------- "

kubectl apply -f secret.yaml

echo "-------------------- Deployment of Kafka -------------------- "

kubectl create -f 'https://strimzi.io/install/latest?namespace=messaging' -n messaging 

kubectl apply -f kafka/kafka-persistent.yaml -n messaging

echo "-------------------- Deployment of Kowl -------------------- "

# kubectl apply -R -f kafka/kowl

echo "-------------------- Deployment of Cassandra -------------------- "

kubectl create configmap cassandra-script --from-file=cassandra/k8s/script/cassandra_schema.cql --namespace=database
kubectl apply -R -f cassandra/k8s/

echo "-------------------- Deployment of Producer -------------------- "

# kubectl apply -R -f kafka/producer/k8s
kubectl apply -f kafka/producer/k8s/configmaps/producer_configmap.yaml 


# echo "-------------------- Deployment of Consumer -------------------- "

# kubectl apply -R -f kafka/consumer/k8s

echo "-------------------- Deployment of Prometheus -------------------- "

kubectl create configmap prometheus-server-conf --from-file=./prometheus/configs --namespace=monitoring
kubectl apply -R -f prometheus/kube_state_metrics
kubectl apply -R -f prometheus/node_exporter
kubectl apply -R -f prometheus/kafka_exporter
kubectl apply -R -f prometheus/k8s
kubectl apply -R -f prometheus/alertmanager

echo "-------------------- Deployment of Grafana -------------------- "

kubectl create configmap grafana-dashboards-files --from-file=./grafana/dashboards --namespace=monitoring
kubectl apply -R -f grafana/k8s

echo "-------------------- Deployment of Spark -------------------- "

helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

helm install my-release spark-operator/spark-operator --namespace spark-operator --set sparkJobNamespace=messaging --set serviceAccounts.spark.name=spark --set enableWebhook=true

echo "-------------------- Deployment of Airflow -------------------- "

helm repo add apache-airflow https://airflow.apache.org

helm upgrade --install airflow apache-airflow/airflow --namespace airflow  --values airflow/values.yaml --create-namespace  

kubectl create clusterrolebinding default-admin --clusterrole cluster-admin --serviceaccount=airflow:airflow-worker --namespace messaging