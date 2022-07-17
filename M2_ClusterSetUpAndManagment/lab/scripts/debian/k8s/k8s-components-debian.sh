#!/bin/bash

echo "Install any packages that may be missing"
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl

echo "Download and install the key"
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "Add the repository"
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "Update repositories information"
sudo apt-get update -y

echo "Check available versions of the packages"
sudo apt-cache madison kubelet

echo "Should we want to install the latest version, we may use (skip it for now)"
#sudo apt-get install -y kubelet kubeadm kubectl

echo "For a particular version we should use (execute this one)"
sudo apt-get install -y kubelet=1.23.3-00 kubeadm=1.23.3-00 kubectl=1.23.3-00

echo "Then exclude the packages from being updated"
sudo apt-mark hold kubelet kubeadm kubectl
