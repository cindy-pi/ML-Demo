

kubectl get nodes
export HOSTNAME=$NODE_NAME

while true; do
  export HOST_POD=`kubectl get pods -l app=nginx -o wide --no-headers | awk '{print $7}' | sort | uniq -c | awk '{print $2" "$1}' | grep $HOSTNAME || echo $HOSTNAME 0`
  echo $HOST_POD | awk '{print $2'} |  xargs -I % python3 setLights.py % .5 0 0 255
  ping -c 1 pi11
  sleep 10
done

