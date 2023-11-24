#!/bin/bash

# Nettoie les ressources Kubernetes

# Supprime tous les pods dans l'espace de noms spécifié
kubectl delete pods --all -n default

# Supprime tous les services dans l'espace de noms spécifié
kubectl delete services --all -n default

# Supprime tous les déploiements dans l'espace de noms spécifié
kubectl delete deployments --all -n default

# Supprime tous les secrets dans l'espace de noms spécifié
kubectl delete secrets --all -n default

# Supprime tous les services de type LoadBalancer dans l'espace de noms spécifié
kubectl delete svc --all -n default

# Supprime tous les services de type NodePort dans l'espace de noms spécifié
kubectl delete svc --all -n default

# Supprime tous les services de type ClusterIP dans l'espace de noms spécifié
kubectl delete svc --all -n default

# Supprime tous les PVC (PersistentVolumeClaim) dans l'espace de noms spécifié
kubectl delete pvc --all -n default

# Supprime tous les PV (PersistentVolume) dans l'espace de noms spécifié
kubectl delete pv --all -n default

# Supprime tous les configmaps dans l'espace de noms spécifié
kubectl delete configmaps --all -n default

# Supprime tous les services account dans l'espace de noms spécifié
kubectl delete serviceaccount --all -n default

# Supprime tous les ingresses dans l'espace de noms spécifié
kubectl delete ingress --all -n default

# Supprime tous les services network policy dans l'espace de noms spécifié
kubectl delete networkpolicy --all -n default

# Supprime tous les rôles dans l'espace de noms spécifié
kubectl delete roles --all -n default

# Supprime tous les rôles liés aux groupes dans l'espace de noms spécifié
kubectl delete rolebinding --all -n default

# Supprime tous les daemonsets dans l'espace de noms spécifié
kubectl delete daemonset --all -n default