#!/bin/bash
echo "Running Docker Check"
. ~/.profile
export PATH=/usr/sbin/:$PATH
export dockerUp=`sudo systemctl status docker | grep "active (running)" | wc -l`

if [ "$dockerUp" != "1" ] ; then
  echo "Running Docker Reset" 
  sudo rm -rf /etc/docker/daemon.json
  sudo systemctl stop docker.socket
  sudo systemctl stop docker.service
  sudo service docker stop
  sudo service docker start
fi

echo "Running Registry Check"
export k8sManager=`ifconfig eth0  | grep 'inet ' | awk '{print $2}'`
export registryStatus=`docker ps | grep registry | wc -l`

if [ "$registryStatus" != "1" ] ; then
  echo "Running Registry Install"
  export k8sManager=`ifconfig eth0  | grep 'inet ' | awk '{print $2}'`
  ifconfig eth0  | grep 'inet ' | awk '{print $2}'
  ifconfig eth0
  echo "Running Registry k8sManager :: $k8sManager"
  sudo sh -c 'echo { \"insecure-registries\":[\"'$k8sManager':5000\"] } > /etc/docker/daemon.json'
  cat /etc/docker/daemon.json
  sudo systemctl stop docker.socket
  sudo systemctl stop docker.service
  sudo service docker stop
  sudo service docker start
  sleep 10
  docker run -d -p 5000:5000 --restart=always --name registry registry
else
  echo Registry is already running
fi

echo "Building kube monitor"
docker build -t kube-blinkt .
docker tag kube-blinkt $k8sManager:5000/kube-blinkt:latest
docker push $k8sManager:5000/kube-blinkt:latest

echo "Deploying kube monitor"
./deploy-kube-blinkt.sh

