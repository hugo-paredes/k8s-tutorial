#!/bin/bash

echo " * Delete namespace"
kubectl delete namespace k8s-demo-namespace

echo " * Create namespace"
kubectl apply -f ./src/k8s-files/namespace.yaml

echo " * Create deployment"
kubectl apply -f ./src/k8s-files/deployment.yaml

echo " * Create service"
kubectl apply -f ./src/k8s-files/service.yaml

echo " * Create ingress"
kubectl apply -f ./src/k8s-files/ingress.yaml
