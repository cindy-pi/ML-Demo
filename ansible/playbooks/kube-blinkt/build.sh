
cd /home/pi/kube-blinkt

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


docker build -t kube-blinkt .
docker tag kube-blinkt $k8sManager:5000/kube-blinkt:latest
docker push $k8sManager:5000/kube-blinkt:latest

docker build -t kube-blinkt-clear -f ./Dockerfile.clear .
docker tag kube-blinkt-clear $k8sManager:5000/kube-blinkt:clear
docker push $k8sManager:5000/kube-blinkt:clear
./deploy-kube-blinkt.sh

