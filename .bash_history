hostname master
hostnamectl set-hostname master
sudo passwd
hostnamectl set-hostname master
# disable swap
sudo swapoff -a
# Create the .conf file to load the modules at bootup
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
## Install CRIO Runtime
sudo apt-get update -y
sudo apt-get install -y software-properties-common curl apt-transport-https ca-certificates gpg
sudo curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/ /" | sudo tee /etc/apt/sources.list.d/cri-o.list
sudo apt-get update -y
sudo apt-get install -y cri-o
sudo systemctl daemon-reload
sudo systemctl enable crio --now
sudo systemctl start crio.service
echo "CRI runtime installed successfully"
# Add Kubernetes APT repository and install required packages
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubelet="1.29.0-*" kubectl="1.29.0-*" kubeadm="1.29.0-*"
sudo apt-get update -y
sudo apt-get install -y jq
sudo systemctl enable --now kubelet
sudo systemctl start kubelet
sudo kubeadm config images pull
sudo kubeadm init
mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config
# Network Plugin = calico
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml
kubeadm token create --print-join-command
kubectl get nodes
kubectl run hello-world-pod --image=busybox --restart=Never --command -- sh -c "echo 'Hello, World' && sleep 3600"
kubectl get pods
docker login
sudo apt install docker -y
sudo apt install docker.io
docker login
sudo docker login
docker pull nginx
sudo docker pull nginx
nano simple-pod.yaml
kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
kubectl get pods
nano simple-pod.yaml
kubectl get pods
kubectl delete pods -All
kubectl get pods
kubectl delete pods 
kubectl delete pod nginx
kubectl get pods
nano simple-pod.yaml
kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
kubectl apply -f simple-pod.yaml
kubectl get pods
rm simple-pod.yaml 
kubectl get pods
nano simple-pod.yaml 
kubectl apply -f simple-pod.yaml
kubectl get pods
docker pull nginx:latest
sudo docker pull nginx:latest
nano simple-pod.yaml
kubectl get pods
kubectl apply -f simple-pod.yaml
kubectl get pods
kubectl delete pods --all
kubectl get pods
kubectl apply -f simple-pod.yaml
kubectl get pods
kubectl create deploy name=nginx --image=nginx
kubectl create deploy nginx --image=nginx
kubectl get pods
kubectl describe nginx-7854ff8877-q4s8j
kubectl describe nginx
kubectl describe nginx-7854ff8877-q4s8j
kubectl describe nginx
clear
kubectl delete pods -all
kubectl delete pods -a
kubectl delete all --all
docker login
sudo docker login
docker pull nginx
sudo docker pull nginx
kubectl get pods
kubectl    run    my-nginx    --image     nginx
kubectl get pods
kubectl get pods -n kube-system -o wide | grep calico
kubectl delete pod calico-node-dbvnb -n kube-system
kubectl get nodes
kubectl get configmap calico-config -n kube-system -o yaml
kubectl    run    my-nginx    --image     nginx
kubectl get pods
ifconfig
sudo apt install net-tools
ifconfig
sudo ip link delete docker0 type bridge
kubectl get pods
kubectl delete pods -a
kubectl delete pods -all
kubectl delete pods --all
kubectl get pods
kubectl    run    my-nginx    --image=nginx
kubectl get pods
kubectl get events --all-namespaces  --sort-by='.metadata.creationTimestamp'
systemctl restart kubelet.service
sudo systemctl restart kubelet.service
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl reload docker
sudo systemctl restart kubelet
kubectl get pods
kubectl describe pod -n my-nginx
kubectl get pods
docker pull nginx:latest
sudo docker pull nginx:latest
kubectl get pods
ifconfig
sudo 172.17.0.1 link delete docker0 type bridge
sudo ip link delete docker0 type bridge
kubectl get pods
0
k
kubectl create -f simple.yaml
kubectl get pods
kubectl describe pod -n nginx
kubectl describe pod -n my-nginx
kubectl describe pod  my-nginx
curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/calico.yaml -O
kubectl apply -f calico.yaml
kubectl get pods
kubectl get nodes
kubectl get pods
kubectl delete pods --all
kubectl get pods
yum install docker -y
docker version
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
kubectl delete pods -A
kubectl get pods -A
clear
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
sudo setenforce 0
sudo  /etc/selinux/config
sudo  cd /etc/selinux/config
cd /etc/selinux/
ls
cd ..
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

cd ..
sudo -i
kubectl get nodes
sudo -i
kubectl get nodes
kubectl get pods
kubectl    run    my-nginx    --image     nginx
kubectl get pods
kubectl describe pod my-nginx
curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/calico.yaml -O
kubectl apply -f calico.yaml
kubectl get pods
kubectl get nodes
kubectl get pods --all-namespace
kubectl describe pod calico-nodes-2plcp -n <namespace>
kubectl describe pod calico-nodes-2plcp -n default
kubectl describe pod calico-nodes-2plcp -n 
kubectl describe pod calico-nodes-2plcp
kubectl describe pod calico-node-2plcp
kubectl describe pod  calico-node-2plcp -n kube-system
kubectl get nodes
kubectl get pods
kubectl describe pod my-nginx -n default
kubectl get pods -n kube-system -o wide
kubectl delete --all pods
kubectl delete --all deployments
kubectl delete --all svc
kubectl drain centos8-slave --ignore-daemonsets --delete-emptydir-data --force
kubectl version --short
kubectl version 
systemctl stop kubelet
passwd
sudo reboot
systemctl stop kubelet
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install kubeadm kubelet kubectl -y
sudo apt-mark hold kubeadm kubelet kubectl
sudo swapoff -a
sudo kubeadm init
sudo kubeadm init --v=5
sudo kubeadm init --cri-socket unix:///var/run/containerd/containerd.sock
sudo kubeadm init --cri-socket unix:///var/run/crio/crio.sock
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl get nodes
git clone https://github.com/manikcloud/k8s.git
vim kubeadm-config.yaml
kubeadm init --config kubeadm-config.yaml
kubeadm init --config kubeadm-config.yaml --ignore-preflight-error=all
kubeadm init --config kubeadm-config.yaml --v=5
kubeadm init 
kubeadm init --ignore-preflight-errors=all
sudo kubeadm init --ignore-preflight-errors=all
kubectl get nodes
kubectl get pods
kubectl run xyz --image=nginx
kubectl get pods
kubectl describe pod xyz
kubectl get pods -n kube-system
ls /var/lib/calico
sudo mkdir -p /var/lib/calico
curl https://docs.projectcalico.org/manifests/calico.yaml -O
kubectl apply -f calico.yaml
kubectl apply -f calico.yaml --v=5
kubectl get nodes -o wide
kubectl delete pod -n kube-system -l k8s-app=calico-node
kubectl get pods
clear
sudo su
sudo docker –version
sudo docker –-version
sudo su
