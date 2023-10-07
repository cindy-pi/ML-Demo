docker build -t kube-blinkt .
docker tag kube-blinkt localhost:5000/kube-blinkt:latest
docker push localhost:5000/kube-blinkt:latest



