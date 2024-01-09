# Projet SDTD - k8s


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

### Création du cluster avec création d'un disque de 20go

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
Lors du déploiement des ressources, on va démarrer les tâches Airflow depuis l'UI airflow (Il faut un port-forward sur le pod airflow-webserver pour y accéder).


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

## A FAIRE
- Remote log GCP pour airflow
- schedule dag automatiquement lors du déploiement
- Clean up sparkOperatorPods (Ils sont pas nettoyés après la fin de l'exécution)
