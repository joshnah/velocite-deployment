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
- producer
- consumer
- kowl
- prometheus (exporters & alert manager)
- grafana

```bash
    ./deploy.sh
```

## Supprimer les ressources

```bash
    ./clear_ressources.sh
```
