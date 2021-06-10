#!/bin/bash

echo " * Delete namespace"
kubectl delete namespace k8s-demo-namespace

echo " * Create namespace"
kubectl apply -f ../k8s-files/namespace.yaml

echo " * Create webserver"
kubectl apply -f ../k8s-files/namespace.yaml

echo " * Create ingress"
kubectl apply -f ../k8s-files/ingress.yaml
