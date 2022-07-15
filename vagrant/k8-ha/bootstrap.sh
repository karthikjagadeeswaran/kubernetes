#!/bin/bash

echo "[TASK 1] Enable ssh password authentication"
{
  sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
  sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
  systemctl reload sshd
} >/dev/null 2>&1

echo "[TASK 2] Set root password"
echo -e "admin\nadmin" | passwd root >/dev/null 2>&1

echo "[TASK 3] Update /etc/hosts file"
cat <<EOF >>/etc/hosts
192.168.56.7    k8-haproxy.com      k8-haproxy
192.168.56.11   kube-master-1.com   kube-master-1
192.168.56.12   kube-master-2.com   kube-master-2
192.168.56.13   kube-master-3.com   kube-master-3
192.168.56.21   kube-node-1.com     kube-node-1
192.168.56.22   kube-node-2.com     kube-node-2
192.168.56.23   kube-node-3.com     kube-node-3
EOF

echo "[TASK 4] Update Apt cache"
apt update >/dev/null 2>&1
