#!/bin/bash

helm_package="vault"
helm_namespace="default"

# Vérifiez si le package est déjà installé dans le namespace spécifié
installed=$(helm list -n $helm_namespace --short | grep "^$helm_package$")

if [ -n "$installed" ]; then
  echo "Le package $helm_package est déjà installé dans le namespace $helm_namespace."
else
  echo "Le package $helm_package n'est pas encore installé dans le namespace $helm_namespace."
  helm repo add hashicorp https://helm.releases.hashicorp.com
  helm install vault hashicorp/vault
fi

echo "Initialisation de vault : création du pod vault-0"

kubectl exec -it vault-0 -- vault operator init

echo "Injection des token d'authentification"

# récupérer dynamiquement les jeton et appeler en boucle la commande autant de fois que le nombre de jeton
kubectl exec -it vault-0 -- vault operator unseal

echo "Authentification"

# récupérer le token d'auth et l'injecter en répnse à la commande
kubectl exec -it vault-0 -- vault login

# spécification du chemin où stocker le secret
kubectl exec -it vault-0 -- vault secrets enable -path=mon-chemin kv

# Ecriture de secrets

kubectl exec -it vault-0 -- vault kv put mon-chemin/mon-secret key1=value1 key2=value2





