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

```bash
    ./deploy.sh
```

## Supprimer les ressources

```bash
    ./clear_ressources.sh
```

## Kafka
- Déploiement de la stack Kafka :
```
kubectl apply -R -f kafka
```


## Prometheus
- Config du serveur Prometheus :
```
kubectl create configmap prometheus-server-conf --from-file=./prometheus/configs
```

- Déploiement des exporters et de Prometheus:
```
kubectl apply -R -f prometheus/kube_state_metrics
kubectl apply -R -f prometheus/node_exporter
kubectl apply -R -f prometheus/k8s
```


## Grafana
- Dashboards :
Versionnés sous /grafana/dashboards.

Il faut générer une ConfigMap pour les dashboards :
```
kubectl create configmap grafana-dashboards-files --from-file=./grafana/dashboards
```

Si elle existe déjà, il faut la supprimer puis la recréer :
```
kubectl delete configmap grafana-dashboards-files
```

- Déploiement de Grafana :
Ensuite appliquer les fichiers Kubernetes :
```
kubectl apply -R -f grafana/k8s
```