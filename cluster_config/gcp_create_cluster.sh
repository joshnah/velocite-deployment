#!/bin/bash

gcloud config set compute/zone europe-west6-a

gcloud container clusters create sdtd-cluster --num-nodes=4 --disk-size=50GB --quiet

gcloud compute disks create cassandra-disk --size=20GB --type=pd-ssd --quiet
