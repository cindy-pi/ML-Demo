
export k3sManager=`ifconfig eth0  | grep 'inet ' | awk '{print $2}'`

cat <<EOF > ./privateManager.yaml
mirrors:
  manager.registry.private:
    endpoint:
      - "http://$k3sManager:5000"
configs:
  "manager.registry.private":
    tls:
      insecure_skip_verify: true
EOF
sudo chmod go-r /etc/rancher/k3s/registries.yaml

sudo systemctl restart k3s
sudo systemctl restart k3s-agent
