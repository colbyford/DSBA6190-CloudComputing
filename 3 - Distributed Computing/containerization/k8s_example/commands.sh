
#######################################################
## Build Docker Image
docker build -t instructor_sklearn .
## Build Docker Image (on Silcon Macs)
# docker build --platform linux/amd64 -t instructor_sklearn .


## Run Docker Container (Locally to test)
docker run -it --name sklearn_01 -dt instructor_sklearn /bin/bash
## Execute a command in the container (in this case, an interactive shell)
docker exec -it sklearn_01 /bin/bash

#######################################################
### Push to Azure Container Registry
## Log into Azure
az login

## Set the default Azure Subscription (if not prompted)
# az account set --subscription e9bc187a-e9a1-46be-822e-e955a2563601

## Log into the Azure Container Registry
az acr login --name crdsba6190deveastus001

## Tag the image with the container registry information
docker tag instructor_sklearn crdsba6190deveastus001.azurecr.io/instructor_sklearn:latest

## Push the image to the container registry
docker push crdsba6190deveastus001.azurecr.io/instructor_sklearn:latest

#######################################################
### Run in a Kubernetes Cluster Pod
## Get the Azure Kubernetes Service credential for kubectl to use
az aks get-credentials --resource-group rg-dsba6190-class-dev-eastus-001 --name kub-dsba6190-class-dev-eastus-001 --overwrite-existing

## Apply the pod specification from a YAML file.
kubectl apply -f pod.yaml

## Execute a command on the pod (in this case, an interactive shell)
kubectl exec -it instructor-01 -- /bin/bash
