#!/bin/bash

echo "Create the configuration folder if does not exist"
mkdir -p /etc/docker

echo "Then create the configuration file with the following content"
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

echo "Reload and restart the service"
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
