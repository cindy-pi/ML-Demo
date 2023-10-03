#!/bin/bash

cd 99-Reset
kubectl apply -f ./blinkt-reset.yaml
sleep 3
kubectl rollout status daemonset/blinkt

kubectl get deployments -o custom-columns=NAME:.metadata.name --no-headers | xargs kubectl delete deployment
kubectl get daemonset -o custom-columns=NAME:.metadata.name --no-headers | xargs kubectl delete daemonset 

while true; do
    POD_COUNT=$(kubectl get pods --no-headers 2>/dev/null | wc -l)
    if [ "$POD_COUNT" -eq 0 ]; then
        break
    fi
done

cd ..

