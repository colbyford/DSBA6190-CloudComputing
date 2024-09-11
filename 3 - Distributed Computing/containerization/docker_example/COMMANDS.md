# Commands for Docker and Kubernetes

## Build Docker Image

```bash
docker build -t <IMAGE_NAME> .
# docker build -t instructor_sklearn .
```

## Run Docker Image (Locally to test)

```bash
docker run --name <CONTAINER_NAME> <IMAGE_NAME>
# docker run -it --name sklearn_01 -dt instructor_sklearn /bin/bash
# docker run -it instructor_sklearn /bin/bash

docker exec -it <CONTAINER_NAME> <COMMAND>
# docker exec -it sklearn_01 /bin/bash
```

## Push to Azure Container Registry

```bash
az acr login --name <REGISTRY_NAME>
# az acr login --name crdsba6190deveastus001
docker tag <IMAGE_NAME> <REGISTRY_NAME>.azurecr.io/<IMAGE_NAME>
# docker tag instructor_sklearn crdsba6190deveastus001.azurecr.io/instructor_sklearn
docker push <REGISTRY_NAME>.azurecr.io/<IMAGE_NAME>
# docker push crdsba6190deveastus001.azurecr.io/instructor_sklearn
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