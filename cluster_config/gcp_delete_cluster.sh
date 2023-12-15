#!/bin/bash

gcloud config set compute/zone europe-west6-a
gcloud compute disks delete cassandra-disk --zone=europe-west6-a --quiet
gcloud container clusters delete sdtd-cluster --quiet