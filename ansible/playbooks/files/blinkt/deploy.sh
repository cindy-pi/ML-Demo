

docker build -t kube-blinkt .
docker tag kube-blinkt localhost:5000/kube-blinkt:latest
##docker run -it --rm --name cindy --privileged  kube-blinkt sh
docker push localhost:5000/kube-blinkt:latest

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
                   command:
                   - /bin/sh
                   - -c
                   - './monitor.sh; sleep 6000 '
                   env:
                   - name: NODE_NAME
                     valueFrom:
                       fieldRef:
                         apiVersion: v1
                         fieldPath: spec.nodeName
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


