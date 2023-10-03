#!/bin/bash

cd 00-Init
kubectl apply -f ./00-Init.yaml
sleep 3
kubectl rollout status daemonset/blinkt
cd ..

