

kubectl get nodes

case $NODE_NAME in
    pi11)
        python3 setLights.py 1 .5 0 255 0
        echo "pi11"
        ;;
    pi12)
        python3 setLights.py 1 .5 255 0 0
        echo "pi12"
        ;;
    pi13)
        python3 setLights.py 2 .5 255 0 0
        echo "pi13"
        ;;
    pi14)
        python3 setLights.py 3 .5 255 0 0
        echo "pi14"
        ;;
    *)
        echo "NODE_NAME is neither pi11 nor pi12"
        ;;
esac


