# setup high availablity kubernetes with 3 master and 3 worker and 1 haproxy server

### install haproxy on one server

    sudo apt-get install haproxy

### install kubectl on same server

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    sudo apt update

    sudo apt install kubectl -y

### configure haproxy
    
    sudo nano /etc/haproxy/haproxy.cfg

    // copy and paste the below content with change on server ip

    frontend kubernetes
    bind 192.168.56.18:6443 // haproxy server ip
    option tcplog
    mode tcp
    default_backend kubernetes-master-nodes

    backend kubernetes-master-nodes
    mode tcp
    balance roundrobin
    option tcp-check
    server k8s-master-0 192.168.56.12:6443 check fall 3 rise 2 // master-1
    server k8s-master-1 192.168.56.13:6443 check fall 3 rise 2 // master-2
    server k8s-master-2 192.168.56.14:6443 check fall 3 rise 2 // master-3

    sudo systemctl restart haproxy

### setup kubernetes on all master and worker server

    sudo swapoff -a

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    sudo apt update

    sudo apt install docker.io kubelet kubeadm kubectl kubernetes-cni -y

### setup external etcd for kubernetes on all master server

    sudo mkdir /etc/etcd /var/lib/etcd

    wget https://github.com/etcd-io/etcd/releases/download/v3.3.13/etcd-v3.3.13-linux-amd64.tar.gz

    tar xvzf etcd-v3.3.13-linux-amd64.tar.gz

    sudo mv etcd-v3.3.13-linux-amd64/etcd* /usr/local/bin/

    // put the etcd service file on /etc/systemd/system/

    sudo systemctl daemon-reload
    
    sudo systemctl enable etcd
 
    sudo systemctl start etcd

    ETCDCTL_API=3 etcdctl member list // to check etcd members

### initialize cluster on 1st master server

    kubeadm init --config=config.yaml // load config from yaml file

    // copy the certificate to other master server
    scp -r /etc/kubernetes/pki root@192.168.56.13:~
    scp -r /etc/kubernetes/pki root@192.168.56.14:~

    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    nano ~/.bashrc

    export KUBECONFIG=/etc/kubernetes/admin.conf

    source ~/.bashrc

    // copy the join cmd from the result

### setup cluster on other master server

    rm ~/pki/apiserver.*

    mv ~/pki /etc/kubernetes/

    kubeadm init --config=config.yaml // load config from yaml file

    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

### join all workers to the cluster 

    // paste the join command on all workers

    kubeadm join 10.10.40.93:6443 --token [your_token] --discovery-token-ca-cert-hash sha256:[your_token_ca_cert_hash]

### deploy overlay network on any master

    kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

    kubectl get pods -n kube-system

    kubectl get nodes

