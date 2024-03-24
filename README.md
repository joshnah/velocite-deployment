# Project Velocity - ETL pipeline for self-service bike stations.
Fetching data from over 2754 bike stations in France and weather data, this application can display real-time availability, analyze daily statistical analysis, and future availability projections of these stations.

## !! This is a bare clone from https://gitlab.com/phanti/projet-sdtd-k8s
![image](https://github.com/joshnah/velocite-deployment/assets/57731922/098d1ad7-7a73-467c-9cb7-93e14b392015)

# Before starting:
This repository contains the necessary files for deployment on Google Kubernetes Engine (GKE)
Link to application repository: [https://gitlab.com/viviane.qian/projet-sdtd](https://github.com/joshnah/velocite-application)

To communicate with the application repository, we need to create an access token and add this token in **secrets.yaml**
To give access application repository to Airflow, we need to create a deployment key and put it in **airflow/values.yaml** as value of airflow-ssh-secret

## Creating the Cluster on GCP

### Selecting a Google Cloud Project
If not already done, you need to select a Google Cloud project from your account:
```bash
gcloud config set project [PROJECT_ID]
```

### Activating Google APIs (One-time Setup)

```bash
    ./cluster_config/gcp_enable_api.sh
```

### Cluster Creation with a 50GB Disk

```bash
./cluster_config/gcp_create_cluster.sh
```

### Deleting the Cluster

```bash
    ./cluster_config/gcp_delete_cluster.sh
```

## Deploying Resources (will also delete existing resources if any)

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

## Deleting Resources

```bash
    ./clear_ressources.sh
```

## Data pipeline

During resource deployment, we will start Airflow tasks from the Airflow UI (You need to port-forward to the airflow-webserver pod to access it). It is recommended to start the DAGs in the following order:

fetch_station: To fetch bike stations every 2 minutes
streaming: To start data streaming
daily_batch: To run the daily batch
fetch_weather: To fetch weather data and bike predictions every 12 hours

## Fault Injection Simulation - Chaos Mesh

Chaos Mesh allows simulating faults on the cluster. To use it, you need to deploy it on the cluster.

```bash
./chaos_mesh/deploy_chaos_mesh.sh
```

To access the web interface for injecting faults, you need to expose the service.


```bash
kubectl expose deployment chaos-dashboard --type=LoadBalancer -n chaos-mesh --name=chaos-dashboard-loadbalancer
```

To remove Chaos Mesh from the cluster, execute the following script:

```bash
./chaos_mesh/clear_chaos_mesh.sh
```
