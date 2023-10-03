

cd 02-ScaleUp

kubectl scale deployment nginx-deployment --replicas=8

kubectl wait  --for=condition=available  --timeout=2m deployment.apps/nginx-deployment

sleep 10
cd ..
