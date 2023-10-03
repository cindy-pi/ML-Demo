#!/bin/bash

cd 01-Deployment

kubectl apply -f ./blinkt-monitor-jobs.yaml

kubectl rollout status daemonset.apps/blinkt

kubectl apply -f ./01-ConfigMap.yaml

kubectl apply -f ./10-Deployment.yaml

kubectl wait  --for=condition=available  --timeout=2m deployment.apps/nginx-deployment

sleep 10
cd ..
