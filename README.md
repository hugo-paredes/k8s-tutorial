# My Kubernetes Tutorial

This is a simple tutorial about Kubernetes.

## To run this tutorial

* Any modern operating system will do. I've used [Ubuntu 21.04](https://discourse.ubuntu.com/t/hirsute-hippo-release-notes/19221).
* [minikube](https://minikube.sigs.k8s.io/docs/start/)
* kubectl
* [Docker](https://www.docker.com/products/docker-desktop)
* [dotnet core 5.0](https://dotnet.microsoft.com/download/dotnet/5.0)

### Let's start

After all installed, we need to start the Kubernetes cluster.

```bash
> minikube start
😄  minikube v1.20.0 on Ubuntu 21.04 (vbox/amd64)
✨  Using the docker driver based on existing profile
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
🔄  Restarting existing docker container for "minikube" ...

🐳  Preparing Kubernetes v1.20.2 on Docker 20.10.6 ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
    ▪ Using image k8s.gcr.io/ingress-nginx/controller:v0.44.0
    ▪ Using image docker.io/jettech/kube-webhook-certgen:v1.5.1
    ▪ Using image kubernetesui/dashboard:v2.1.0
    ▪ Using image docker.io/jettech/kube-webhook-certgen:v1.5.1
    ▪ Using image kubernetesui/metrics-scraper:v1.0.4
🔎  Verifying ingress addon...
🌟  Enabled addons: storage-provisioner, default-storageclass, dashboard, ingress
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

And that's it. The cluster is now running and we can interact with it running `kubectl` commands.

```bash
> kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   6d23h
```

## Kubernetes

### Namespaces

[Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) are a way to organize clusters into virtual sub-clusters — they can be helpful when different teams or projects share a Kubernetes cluster. Any number of namespaces are supported within a cluster, each logically separated from others but with the ability to communicate with each other.

In other words, it helps keepings things tidy.

#### Create a namespace

1. Create a new YAML file named `namespace.yaml` with the following content:

```yaml
kind: Namespace
apiVersion: v1
metadata:
  name: k8s-tutorial
  labels:
    name: k8s-tutorial
```

2. Run the `kubectl` `apply` command that creates objects:

```bash
> kubectl apply -f namespace.yaml
namespace/k8s-tutorial created
```

#### Delete a namespace

**Warning:** Be aware that deleting a namespace deletes everything under the namespace.

```bash
kubectl delete namespaces k8s-tutorial
```

### Deployment

A Kubernetes Deployment is used to tell Kubernetes how to create or modify instances of the pods that hold a containerized application. Deployments can scale the number of replica pods, enable rollout of updated code in a controlled manner, or roll back to an earlier deployment version if necessary.

1. Create a new YAML file named `deployment.yaml` with the following content:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: restapi-deployment      # Name of the deployment
  namespace: k8s-tutorial       # In which namespace it will be created
  labels:
    app: restapi-pod
spec:
  replicas: 3                   # How many pods will be created
  strategy: 
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
  selector:
    matchLabels:
      app: restapi-pod          # Which Pods to manage
  template:
    metadata:
      labels:
        app: restapi-pod
    spec:
      containers:
      - name: restapi-container # Name of the container
        image: nginx:1.14.2

        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
          limits:
            cpu: 200m
            memory: 200Mi
```

2. Run the `kubectl` `apply` command that creates objects:

```bash
> kubectl apply -f deployment.yaml
deployment.apps/restapi-deployment created
```

### Service

A Kubernetes **service** is a logical abstraction for a deployed group of pods in a cluster (which all perform the same function). Since pods are ephemeral, a **service** enables a group of pods, which provide specific functions (web services, image processing, etc.) to be assigned a name and unique IP address.

1. Create a new YAML file named `service.yaml` with the following content:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: restapi-service     # Name of the service
  namespace: k8s-tutorial   # In which namespace it will be created
spec:
  selector:
    app: restapi-pod        # Which Pods will be targeted
  type: LoadBalancer        # Exposes the Service externally
  ports:
  - protocol: TCP
    port: 18080           # Port used by the service
    targetPort: 80        # Target port in the Pod
```

2. Run the `kubectl` `apply` command that creates objects:

```bash
> kubectl apply -f service.yaml
service/restapi-service created
```

## References

* https://kubernetes.io/
* https://www.vmware.com/

