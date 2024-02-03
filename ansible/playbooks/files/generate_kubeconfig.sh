export NAMESPACE=default
export CLUSTER_NAME=ml-demo
export SERVICE_ACCT_NAME=monitor
kubectl apply -n $NAMESPACE -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: $SERVICE_ACCT_NAME
secrets:
- name: $SERVICE_ACCT_NAME
EOF

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: $SERVICE_ACCT_NAME
  annotations:
    kubernetes.io/service-account.name: $SERVICE_ACCT_NAME
type: kubernetes.io/service-account-token
EOF

TOKEN=`kubectl create token -n $NAMESPACE $SERVICE_ACCT_NAME --duration=4194967296s`
TOKEN_ENCODED=`echo $TOKEN | base64 -w 0`

kubectl get secret  -n $NAMESPACE $SERVICE_ACCT_NAME -o json | \
  jq 'del(.metadata.annotations."kubectl.kubernetes.io/last-applied-configuration")' | \
  jq 'del(.metadata.annotations."deployment.kubernetes.io/revision")' | \
  jq 'del(.metadata.creationTimestamp)' | \
  jq 'del(.metadata.generation)' | \
  jq 'del(.metadata.resourceVersion)' | \
  jq 'del(.metadata.uid)' | \
  jq --arg TOKEN_ENCODED "$TOKEN_ENCODED" '.data.token |= $TOKEN_ENCODED ' | \
  kubectl apply -f -
kubectl apply -n $NAMESPACE -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  labels:
  name: cluster-reader
  namespace: default
rules:
- apiGroups:
  - ""
  resources: ["*"]
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - extensions
  resources: ["*"]
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - apps
  resources: ["*"]
  verbs:
  - get
  - list
  - watch
EOF

kubectl apply -n $NAMESPACE -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: $SERVICE_ACCT_NAME-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: $SERVICE_ACCT_NAME
  namespace: $NAMESPACE
EOF

kubectl create rolebinding $SERVICE_ACCT_NAME-reader --clusterrole=view --group=system:serviceaccounts --serviceaccount=$NAMESPACE:$SERVICE_ACCT_NAME --namespace=$NAMESPACE
export vSecretName=`kubectl get serviceaccount -n $NAMESPACE ${SERVICE_ACCT_NAME} -o jsonpath='{.secrets[0].name}'`
echo $vSecretName
export vServerAPI=`kubectl cluster-info | head -1 | awk -F ':' '{print $2}' | sed 's/\/\///'`
echo $vServerAPI
ca=$(kubectl get secret -n $NAMESPACE $vSecretName -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret -n $NAMESPACE $vSecretName -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret -n $NAMESPACE $vSecretName -o jsonpath='{.data.namespace}' | base64 --decode)
export external_server=`ifconfig wlan0 | grep 'inet ' | awk '{print $2}'`
export internal_server=`ifconfig eth0  | grep 'inet ' | awk '{print $2}'`

echo "
---
apiVersion: v1
kind: Config
clusters:
  - name: ${CLUSTER_NAME}
    cluster:
      insecure-skip-tls-verify: true
      server: https://${internal_server}:6443
contexts:
  - name: ${SERVICE_ACCT_NAME}@${CLUSTER_NAME}
    context:
      cluster: ${CLUSTER_NAME}
      namespace: ${NAMESPACE}
      user: ${SERVICE_ACCT_NAME}
users:
  - name: ${SERVICE_ACCT_NAME}
    user:
      token: ${token}
current-context: ${SERVICE_ACCT_NAME}@${CLUSTER_NAME}
" > internal.kubeconfig

echo "
---
apiVersion: v1
kind: Config
clusters:
  - name: ${CLUSTER_NAME}
    cluster:
      insecure-skip-tls-verify: true
      server: https://${external_server}:6443
contexts:
  - name: ${SERVICE_ACCT_NAME}@${CLUSTER_NAME}
    context:
      cluster: ${CLUSTER_NAME}
      namespace: ${NAMESPACE}
      user: ${SERVICE_ACCT_NAME}
users:
  - name: ${SERVICE_ACCT_NAME}
    user:
      token: ${token}
current-context: ${SERVICE_ACCT_NAME}@${CLUSTER_NAME}
" > external.kubeconfig

