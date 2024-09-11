## Logic for post-deployment setup of AKS
import subprocess, json, yaml, uuid, base64

## Grab Terraform outputs
tf_outputs = json.loads(subprocess.check_output(['terraform', 'output', '-json']))

## Configure AKS Storage Settings
from azure.cli.core import get_default_cli

az_cli = get_default_cli()

k8s_storage_setting_command = f"""
aks update --resource-group {tf_outputs['AZ_RESOURCE_GROUP']['value']} \
              --name {tf_outputs['AZ_AKS_NAME']['value']} \
              --enable-disk-driver \
              --enable-file-driver \
              --enable-blob-driver \
              --enable-snapshot-controller \
              --yes
"""

az_cli.invoke(k8s_storage_setting_command.split())

## Make Storage Secrets
from kubernetes import client, config, utils
kubeconfig = yaml.safe_load(tf_outputs['AZ_KUBE_CONFIG']['value'])
k8s_api_client = config.new_client_from_config_dict(kubeconfig)
k8s_client = client.CoreV1Api(k8s_api_client)

## Azure Storage Secret
azure_storage_secret = client.V1Secret(
    api_version="v1",
    kind="Secret",
    metadata=client.V1ObjectMeta(name="datalake-class-secret"),
    data = {
        "azurestorageaccountname": base64.b64encode(bytes(tf_outputs['AZ_STORAGE_ACCOUNT_NAME']['value'], 'utf-8')).decode('ascii'),
        "azurestorageaccountkey": base64.b64encode(bytes(tf_outputs['AZ_STORAGE_ACCOUNT_KEY']['value'], 'utf-8')).decode('ascii'),
    } 
)
k8s_client.create_namespaced_secret(namespace="default", body=azure_storage_secret)
utils.create_from_yaml(k8s_api_client, "./pv-blobfuse-datalake.yaml")
utils.create_from_yaml(k8s_api_client, "./pvc-blobfuse-datalake.yaml")

## Azure Container Registry Secret
azure_container_registry_secret = client.V1Secret(
    api_version="v1",
    kind="Secret",
    metadata=client.V1ObjectMeta(name="acr-secret"),
    data = {
        "username": base64.b64encode(bytes(tf_outputs['AZ_ACR_USERNAME']['value'], 'utf-8')).decode('ascii'),
        "password": base64.b64encode(bytes(tf_outputs['AZ_ACR_PASSWORD']['value'], 'utf-8')).decode('ascii'),
    } 
)
k8s_client.create_namespaced_secret(namespace="default", body=azure_container_registry_secret)

