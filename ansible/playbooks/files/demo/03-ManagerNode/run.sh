

cd 03-ManagerNode


kubectl patch deployment nginx-deployment -p '{
  "spec": {
    "template": {
      "spec": {
        "affinity": {
          "nodeAffinity": {
            "requiredDuringSchedulingIgnoredDuringExecution": {
              "nodeSelectorTerms": [
                {
                  "matchExpressions": [
                    {
                      "key": "kubernetes.io/hostname",
                      "operator": "NotIn",
                      "values": ["pi11"]
                    }
                  ]
                }
              ]
            }
          }
        }
      }
    }
  }
}'


kubectl wait  --for=condition=available  --timeout=2m deployment.apps/nginx-deployment

sleep 10
cd ..
