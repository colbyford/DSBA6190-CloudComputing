# Commands for Docker and Kubernetes

## Build Docker Image

```bash
docker build -t <IMAGE_NAME> .
# docker build -t instructor_sklearn .
## for ARM-based laptops
# docker build -t instructor_sklearn --platform linux/amd64 .
```

## Run Docker Container (Locally to test)

```bash
docker run -it --name <CONTAINER_NAME> -dt <IMAGE_NAME> <COMMAND> 
# docker run -it --name sklearn_01 -dt instructor_sklearn /bin/bash

## Execute a command in the container (in this case, an interactive shell)
docker exec -it sklearn_01 /bin/bash
```

## Push to Azure Container Registry

```bash
## Log into Azure
az login

## Set the default Azure Subscription (if not prompted)
# az account set --subscription e9bc187a-e9a1-46be-822e-e955a2563601

## Log into the Azure Container Registry
az acr login --name <REGISTRY_NAME>
# az acr login --name crdsba6190deveastus001

## Tag the image with the container registry information
docker tag <IMAGE_NAME> <REGISTRY_NAME>.azurecr.io/<IMAGE_NAME>
# docker tag instructor_sklearn crdsba6190deveastus001.azurecr.io/instructor_sklearn:latest

## Push the image to the container registry
docker push <REGISTRY_NAME>.azurecr.io/<IMAGE_NAME>
# docker push crdsba6190deveastus001.azurecr.io/instructor_sklearn:latest
```

## Get the Azure Kubernetes Service credential for kubectl to use
```bash
az aks get-credentials --resource-group rg-dsba6190-class-dev-eastus-001 --name kub-dsba6190-class-dev-eastus-001 --overwrite-existing
```

## Apply Kubernetes Pod

```bash
kubectl apply -f <POD YAML FILE>
# kubectl apply -f example_pod.yml
```

## Remote into Pod 

```bash
kubectl exec -it <pod_name> -- /bin/bash
# kubectl exec -it instructor-test-01 -- /bin/bash
```