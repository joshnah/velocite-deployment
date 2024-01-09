#!/bin/bash

./clear_chaos_mesh.sh

echo "-------------------- Deployment of Chaos Mesh -------------------- "

kubectl create namespace chaos-mesh
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm install chaos-mesh chaos-mesh/chaos-mesh -n=chaos-mesh --version 2.6.2