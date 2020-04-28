#!/bin/sh
curl -Lo azk8spull https://github.com/xuxinkun/littleTools/releases/download/v1.0.0/azk8spull && chmod +x ./azk8spull

# azk8spull k8s.gcr.io/kube-proxy:v1.15.5
# azk8spull k8s.gcr.io/kube-controller-manager:v1.15.5
# azk8spull k8s.gcr.io/kube-scheduler:v1.15.5
# azk8spull k8s.gcr.io/kube-apiserver:v1.15.5
# azk8spull k8s.gcr.io/coredns:1.3.1
# azk8spull k8s.gcr.io/pause:3.1
# azk8spull k8s.gcr.io/etcd:3.3.10

sudo mv azk8spull /usr/local/bin
azk8spull k8s.gcr.io/kube-proxy:v1.18.0
azk8spull k8s.gcr.io/kube-controller-manager:v1.18.0
azk8spull k8s.gcr.io/kube-scheduler:v1.18.0
azk8spull k8s.gcr.io/kube-apiserver:v1.18.0
azk8spull k8s.gcr.io/coredns:1.6.7
azk8spull k8s.gcr.io/pause:3.2
azk8spull k8s.gcr.io/etcd:3.4.3-0
azk8spull quay.azk8s.cn/coreos/flannel:v0.11.0

sudo minikube start --registry-mirror=https://registry.docker-cn.com --vm-driver=none --cache-images

env PATH=/var/lib/minikube/binaries/v1.18.0:$PATH kubeadm init --config /var/tmp/minikube/kubeadm.yaml  --ignore-preflight-errors=DirAvailable--etc-kubernetes-manifests,DirAvailable--var-lib-minikube,DirAvailable--var-lib-minikube-etcd,FileAvailable--etc-kubernetes-manifests-kube-scheduler.yaml,FileAvailable--etc-kubernetes-manifests-kube-apiserver.yaml,FileAvailable--etc-kubernetes-manifests-kube-controller-manager.yaml,FileAvailable--etc-kubernetes-manifests-etcd.yaml,Port-10250,Swap,SystemVerification -v=9

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.5.2 sh -
cd istio-1.5.2
sudo cp bin/istioctl /usr/local/bin
istioctl manifest apply --set profile=demo
kubectl label namespace default istio-injection=enabled
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
