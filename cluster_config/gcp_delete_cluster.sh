#!/bin/bash

gcloud config set compute/zone europe-west6-a
gcloud container clusters delete sdtd-cluster --quiet

# Delete all PVCs
gcloud compute disks delete $(gcloud compute disks list --filter="name~'pvc-*'" --format "value(uri())") --quiet
