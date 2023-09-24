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
  sudo rm -rf /etc/docker/daemon.json
  sudo sh -c 'echo { \"insecure-registries\":[\"'$k8sManager':5000\"] } > /etc/docker/daemon.json'
  sudo systemctl stop docker.socket
  sudo systemctl stop docker.service
  sleep 10
  sudo systemctl start docker.socket
  sudo systemctl start docker.service
  sudo systemctl is-enabled docker
  sudo  systemctl enable --now docker
  sleep 10
  docker run -d -p 5000:5000 --restart=always --name registry registry
else
  echo Registry is already running
fi


