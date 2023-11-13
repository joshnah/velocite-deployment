#!/bin/bash

echo "#################### Deployment of k8s resources #################### "

echo "-------------------- Deleting ressources of namespace -------------------- "

kubectl delete --all --namespace=default pods,services,deployments,configmaps,secrets,ingress

echo "-------------------- Deployment of secret -------------------- "

kubectl apply -f secret.yaml

echo "-------------------- Deployment of Kafka -------------------- "

kubectl apply -f kafka/k8s/services/kafka_service.yaml
kubectl apply -f kafka/k8s/pods/kafka_pod.yaml

echo "-------------------- Deployment of Kowl -------------------- "

kubectl apply -f kafka/k8s/kowl.yaml

echo "-------------------- Deployment of Cassandra -------------------- "

kubectl apply -f cassandra/cassandra-service.yaml
kubectl apply -f cassandra/cassandra-deployment.yaml
kubectl apply -f cassandra/cassandra-load-keyspace-deployment.yaml

echo "-------------------- Deployment of Producer -------------------- "

kubectl apply -f kafka/producer/k8s/configmaps/producer_configmap.yaml
kubectl apply -f kafka/producer/k8s/deployments/producer_deploy.yaml

echo "-------------------- Deployment of Consumer -------------------- "

kubectl apply -f kafka/consumer/k8s/configmaps/consumer_configmap.yaml
kubectl apply -f kafka/consumer/k8s/deployments/consumer_deploy.yaml


