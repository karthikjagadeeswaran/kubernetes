#!/bin/bash

# Initialize Kubernetes
echo "[TASK 1] Initialize Kubernetes Cluster"
kubeadm init>> /root/kubeinit.log 2>/dev/null

# Copy Kube admin config
echo "[TASK 2] Copy kube admin config to Vagrant user .kube directory"
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

# Deploy flannel network
echo "[TASK 3] Deploy Weave network"
su - vagrant -c "kubectl create -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')""

# Generate Cluster join command
echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh
