
i
docker login
docker build -f Dockerfile.reset -t blinkt-reset .
docker tag blinkt-reset cindyspirion/blinkt:clear
docker push cindyspirion/blinkt:clear

