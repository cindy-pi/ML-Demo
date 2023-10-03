

cd 04-ScaleDown

kubectl scale deployment nginx-deployment --replicas=3

kubectl wait  --for=condition=available  --timeout=2m deployment.apps/nginx-deployment

sleep 10
cd ..
