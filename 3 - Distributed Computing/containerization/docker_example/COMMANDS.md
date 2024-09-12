# Commands for the Docker and Kubernetes lab

## Build Docker Image

```bash
## Build the image using the default Dockerfile and tag it with a name
docker build -t <IMAGE_NAME> .
# docker build -t instructor_sklearn .
```

## Run Docker Container (Locally to test)

```bash
## Run a container with the image you just built
docker run --name <CONTAINER_NAME> <IMAGE_NAME>
# docker run -it --name sklearn_01 -dt instructor_sklearn /bin/bash

## Execute a command in the container (in this case, an interactive shell)
docker exec -it <CONTAINER_NAME> <COMMAND>
# docker exec -it sklearn_01 /bin/bash
```

## Push to Azure Container Registry

```bash
## Log into Azure
az login

## Log into the Azure Container Registry
az acr login --name <REGISTRY_NAME>
# az acr login --name crdsba6190deveastus001

## Tag the image with the container registry information
docker tag <IMAGE_NAME> <REGISTRY_NAME>.azurecr.io/<IMAGE_NAME>:<TAG>
# docker tag instructor_sklearn crdsba6190deveastus001.azurecr.io/instructor_sklearn:latest

## Push the image to the container registry
docker push <REGISTRY_NAME>.azurecr.io/<IMAGE_NAME>:<TAG>
# docker push crdsba6190deveastus001.azurecr.io/instructor_sklearn:latest
```

## Get the Kubernetes Credentials

```bash
## Set the default Azure Subscription
az account set --subscription <SUBSCRIPTION_ID>
# az account set --subscription e9bc187a-e9a1-46be-822e-e955a2563601

## Get the Azure Kubernetes Service credential for kubectl to use
az aks get-credentials --resource-group <RESOURCE_GROUP_NAME> --name <AKS_NAME> --overwrite-existing
# az aks get-credentials --resource-group rg-dsba6190-class-dev-eastus-001 --name kub-dsba6190-class-dev-eastus-001 --overwrite-existing
```

## Apply Kubernetes Pod YAML

```bash
## Apply the pod specification from a YAML file.
kubectl apply -f <POD YAML FILE>
# kubectl apply -f example_pod.yml
```

## Remote into Pod 

```bash
## Execute a command on the pod (in this case, an interactive shell)
kubectl exec -it <pod_name> -- /bin/bash
# kubectl exec -it instructor-test-01 -- /bin/bash
```