#!/bin/bash
export KUBECONFIG=kube-config.yml
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=dockerconfig.json \
    --type=kubernetes.io/dockerconfigjson
kubectl create -f morningnews-dep_service.yml
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
kubectl -n default get services -o wide ingress-nginx-controller | awk '{ print$4}' > ingress_svc-IP.txt
echo 'Add the "External-IP" from the ingress_svc-IP.txt file to the Domain you want to link before continuing.'
read -p 'Press Enter when done'
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.crds.yaml
kubectl create namespace cert-manager
helm repo add cert-manager https://charts.jetstack.io
helm repo update
helm install \
my-cert-manager cert-manager/cert-manager \
--namespace cert-manager \
--version v1.8.0
sleep 5s
kubectl create -f acme-issuer-prod.yaml
kubectl create -f morningnews-ingress.yaml --validate=false
kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl -n monitoring create secret generic basic-auth --from-file=lke-monitor/auth
helm install lke-monitor prometheus-community/kube-prometheus-stack -f lke-monitor/values-https-basic-auth.yaml --set grafana.adminPassword=test --namespace monitoring