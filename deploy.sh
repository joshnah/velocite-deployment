#!/bin/bash

echo "#################### Deployment of k8s resources #################### "

echo "-------------------- Deleting ressources of namespace -------------------- "

sh clear_ressources.sh

echo "-------------------- Creating ressources of namespaces -------------------- "

kubectl create namespace monitoring
kubectl create namespace messaging
kubectl create namespace database
kubectl create namespace spark-operator
kubectl create namespace loki

echo "-------------------- Deployment of secret -------------------- "

kubectl apply -f secret.yaml

echo "-------------------- Deployment of Kafka -------------------- "

kubectl apply -f kafka/kafka.yaml
kubectl apply -f kafka/producer_configmap.yaml

# echo "-------------------- Deployment of Kowl -------------------- "

# kubectl apply -R -f kafka/kowl

echo "-------------------- Deployment of Cassandra -------------------- "

kubectl create configmap cassandra-script --from-file=cassandra/k8s/script/cassandra_schema.cql --namespace=database
kubectl apply -R -f cassandra/k8s/


echo "-------------------- Deployment of Prometheus -------------------- "

kubectl create configmap prometheus-server-conf --from-file=./prometheus/configs --namespace=monitoring
kubectl apply -R -f prometheus/kube_state_metrics
kubectl apply -R -f prometheus/node_exporter
kubectl apply -R -f prometheus/kafka_exporter
kubectl apply -R -f prometheus/k8s
kubectl apply -R -f prometheus/alertmanager

echo "-------------------- Deployment of Grafana -------------------- "

kubectl create configmap grafana-dashboards-files --from-file=./_grafana/dashboards --namespace=monitoring
kubectl apply -R -f _grafana/k8s

echo "-------------------- Deployment of Spark -------------------- "

helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

helm install my-release spark-operator/spark-operator --namespace spark-operator --set sparkJobNamespace=messaging --set serviceAccounts.spark.name=spark --set enableWebhook=true

echo "-------------------- Deployment of Airflow -------------------- "

helm repo add apache-airflow https://airflow.apache.org

helm upgrade --install airflow apache-airflow/airflow --namespace airflow --values airflow/values.yaml --create-namespace

kubectl create clusterrolebinding default-admin --clusterrole cluster-admin --serviceaccount=airflow:airflow-worker --namespace messaging

echo "-------------------- Deployment of Loki -------------------- "

helm repo add grafana https://grafana.github.io/helm-charts

helm upgrade --install loki loki/loki-stack --namespace loki --values _grafana/loki/values.yml
