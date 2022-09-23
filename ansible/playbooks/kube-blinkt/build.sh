
docker login
docker build -t blinkt .
docker tag blinkt cindyspirion/blinkt:test$1
docker push cindyspirion/blinkt:test$1
docker push tag blinkt pi05.local:5000/blinkt:test$1
docker push pi05.local:5000/blinkt:test$1

