#!/bin/bash

# Nettoie les ressources Kubernetes
kubectl delete all --all --namespace=messaging
kubectl delete all --all --namespace=monitoring
kubectl delete all --all --namespace=database
kubectl delete all --all --namespace=web
kubectl delete all --all --namespace=spark-operator
kubectl delete namespace messaging monitoring database web spark-operator
