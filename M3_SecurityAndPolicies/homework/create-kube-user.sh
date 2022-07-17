#!/bin/bash

# Args:
# 1- user name
# 2- group name
# 3- cluster name

echo "Add user"
useradd -m -s /bin/bash $1

echo "Create group"
sudo groupadd $2

echo "Add user to group"
usermod -a -G $2 $1

echo "Create a folder for the certificate related files"
mkdir /home/$1/.certs

echo "Create a private key"
openssl genrsa -out /home/$1/.certs/$1.key 2048

echo "Create a certificate signing request"
openssl req -new -key /home/$1/.certs/$1.key -out /home/$1/.certs/$1.csr -subj "/CN=${1}"

echo "Sign the CSR with the Kubernetes CA certificate"
openssl x509 -req -in /home/$1/.certs/$1.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out /home/$1/.certs/$1.crt -days 365

echo "Create the user in Kubernetes"
kubectl config set-credentials $1 --client-certificate=/home/$1/.certs/$1.crt --client-key=/home/$1/.certs/$1.key

echo "Create context for the user as well"
kubectl config set-context $1-context --cluster=$3 --user=$1

echo "Create a folder to store the user configuration"
mkdir /home/$1/.kube

echo "Create a copy of config"
cp /etc/kubernetes/admin.conf /home/$1/.kube/config

echo "Change ownership"
chown -R $1: /home/$1/
