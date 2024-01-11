#!/bin/bash

# Nettoie les ressources Kubernetes
kubectl -n messaging delete $(kubectl get strimzi -o name -n messaging) # Supprime les ressources Strimzi
kubectl delete all --all --namespace=messaging
kubectl delete all --all --namespace=monitoring
kubectl delete all --all --namespace=database
kubectl delete all --all --namespace=web
kubectl delete all --all --namespace=spark-operator
kubectl delete all --all --namespace=airflow
kubectl delete namespace messaging monitoring database web spark-operator airflow
