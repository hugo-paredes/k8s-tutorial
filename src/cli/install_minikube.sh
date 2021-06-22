!#/bin/bash

echo " * Install `minikube`"
wget -q https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb -O ./minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
minikube version
rm minikube_latest_amd64.deb
