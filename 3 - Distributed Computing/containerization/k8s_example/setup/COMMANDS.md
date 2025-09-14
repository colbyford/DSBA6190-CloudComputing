# Kubernetes Setup Commands


## Enable Blob Storage Driver on AKS Cluster

```bash
az aks update --enable-blob-driver --name kub-dsba6190-class-dev-eastus-001 --resource-group rg-dsba6190-class-eastus-001
```


## Create Storage Connection
```bash
## Get AKS Credentials
az aks get-credentials --resource-group rg-dsba6190-class-eastus-001 --name kub-dsba6190-class-dev-eastus-001 --overwrite-existing

## Create a secret for accessing Azure Blob Storage
kubectl apply -f blob_secret.yaml

## Create the Persistent Volume for Azure Blob Storage
kubectl apply -f blob_pv.yaml

## Create the Persistent Volume Claim for Azure Blob Storage
kubectl apply -f blob_pvc.yaml

```

## Create Azure Container Registry Secret

```bash
kubectl create secret docker-registry acr-secret --namespace default --docker-server=crdsba6190deveastus001.azurecr.io --docker-username=crdsba6190deveastus001 --docker-password=<PASSOWORD>
```