# Projet SDTD - k8s


## Créer le cluster sur GCP

### Activer les APIs Google (A faire une seule fois)

```bash
    ./cluster_config/gcp_enable_api.sh
```
### Création d'un disque de 20Gb (A faire une seule fois)
```bash
    gcloud compute disks create cassandra-disk --size=20GB --type=pd-ssd
```
### Création du cluster avec création d'un disque de 20go

```bash
    ./cluster_config/gcp_create_cluster.sh
```

### Suppression du cluster

```bash
    ./cluster_config/gcp_delete_cluster.sh
```

## Déployer les ressources

- cassandra
- kafka
- producer
- consumer
- kowl
- prometheus
- grafana

```bash
    ./deploy.sh
```

## Supprimer les ressources

```bash
    ./clear_ressources.sh
```