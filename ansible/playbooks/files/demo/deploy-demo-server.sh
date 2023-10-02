cd /home/pi/demo

docker build -t demo-server .

docker stop demo-server
docker rm demo-server
docker run -d --rm --name demo-server -p 5005:5000 -e KUBECONFIG=/etc/kubernetes/kube.config -v /home/pi/internal.kubeconfig:/etc/kubernetes/kube.config demo-server

