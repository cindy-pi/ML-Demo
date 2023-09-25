

cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
    name: blinkt
spec:
    selector:
        matchLabels:
            name: blinkt
    template:
        metadata:
            labels:
                name: blinkt
        spec:
            serviceAccountName: monitor
            tolerations:
                 - key: node-role.kubernetes.io/master
                   effect: NoSchedule
            terminationGracePeriodSeconds: 10
            containers:
                 - name: blinkt
                   image: manager.registry.private/kube-blinkt:latest
                   imagePullPolicy: Always
                   securityContext:
                     privileged: true
                   volumeMounts:
                           - name: sys
                             mountPath: /sys
            volumes:
                 - name: sys
                   hostPath:
                       path: /sys
EOF







