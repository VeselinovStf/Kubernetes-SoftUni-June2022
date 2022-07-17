#!/bin/bash

echo "** Initial K8s Host Set up"
sudo modprobe br_netfilter

cat << EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat << EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

sudo swapoff -a

sudo sed -i '/swap/ s/^/#/' /etc/fstab

#sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
