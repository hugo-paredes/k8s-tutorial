#!/bin/bash

echo " * Start minikube"
minikube start

echo " * Start minikube dashboard"
minikue dashboard

echo " * Enable ingress addon"
minikube addons enable ingress
