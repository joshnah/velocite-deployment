#!/bin/bash

# Clean Up Chaos Experiments
for i in $(kubectl api-resources | grep chaos-mesh | awk '{print $1}'); do kubectl get $i -A; done

# Uninstall Chaos Mesh
helm uninstall chaos-mesh -n chaos-mesh
kubectl delete crd $(kubectl get crd | grep 'chaos-mesh.org' | awk '{print $1}')

kubectl delete namespace chaos-mesh