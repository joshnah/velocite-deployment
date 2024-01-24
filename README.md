# Projet SDTD - k8s
Ce dépôt contient les fichiers nécessaires au déploiment du projet SDTD sur GKE.
Le lien vers le dépôt applicatif: https://gitlab.com/viviane.qian/projet-sdtd

Pour pouvoir communiquer avec le dépôt applicatif, il faut créer un token d'accès et modifier le fichier **secrets.yaml** avec le token.

Pour que Airflow ait accès au dépôt applicatif, il est nécessaire de créer une clé de déploiement et de la placer dans le fichier airflow/values.yaml, sous la valeur airflow-ssh-secret

## Créer le cluster sur GCP

### Sélectionner un projet Google Cloud
Si ce n'est pas déjà fait, il faut sélectionner un projet Google Cloud de votre compte :
```bash
gcloud config set project [PROJECT_ID]
```

### Activer les APIs Google (A faire une seule fois)

```bash
    ./cluster_config/gcp_enable_api.sh
```

### Création du cluster avec création d'un disque de 50go

```bash
    ./cluster_config/gcp_create_cluster.sh
```

### Suppression du cluster

```bash
    ./cluster_config/gcp_delete_cluster.sh
```

## Déployer les ressources (va aussi supprimer les ressources existantes s'il y en a)

- cassandra
- kafka
- kowl
- prometheus (exporters & alert manager)
- grafana
- airflow
- spark

```bash
    ./deploy.sh
```

## Supprimer les ressources

```bash
    ./clear_ressources.sh
```

## Data pipeline
Lors du déploiement des ressources, on va démarrer les tâches Airflow depuis l'UI airflow (Il faut un port-forward sur le pod airflow-webserver pour y accéder). Il est recommandé de démarrer les DAGs dans l'ordre suivant :
- fetch_station: Pour fetch les stations de vélos toutes les 2 minutes
- streaming: Pour lancer le streaming de données
- daily_batch: Pour lancer le batch quotidien
- fetch_weather: Pour fetch les données météo et prédictions de vélos toutes les 12 heures


## Simulation de fautes - Chaos Mesh
Chaos Mesh permet de simuler sur des fautes sur le cluster. Pour l'utiliser, il faut le déployer sur le cluster.
```bash
./chaos_mesh/deploy_chaos_mesh.sh
```

Pour accéder à l'interface web permettant d'injecter des fautes, il faut exposer le service.
```bash
kubectl expose deployment chaos-dashboard --type=LoadBalancer -n chaos-mesh --name=chaos-dashboard-loadbalancer
```

Pour supprimer Chaos Mesh du cluster, il faut exécuter le script suivant :
```bash
./chaos_mesh/clear_chaos_mesh.sh
```
