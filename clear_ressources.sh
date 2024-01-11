#!/bin/bash

# Nettoie les ressources Kubernetes
kubectl delete all --all --namespace=messaging
kubectl delete all --all --namespace=monitoring
kubectl delete all --all --namespace=database
kubectl delete all --all --namespace=spark-operator
kubectl delete all --all --namespace=airflow
kubectl delete all --all --namespace=loki
kubectl delete namespace messaging monitoring database spark-operator airflow loki
