// Outputs

output "AZ_RESOURCE_GROUP" {
  value = data.azurerm_resource_group.rg.name
}

// Storage Account
output "AZ_STORAGE_ACCOUNT_NAME" {
  value = azurerm_storage_account.storage.name
}

output "AZ_STORAGE_ACCOUNT_KEY" {
  value     = azurerm_storage_account.storage.primary_access_key
  sensitive = true
}

// Kubernetes Service
output "AZ_AKS_NAME" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "AZ_KUBE_CONFIG" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

// Container Registry
output "AZ_ACR_USERNAME" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "AZ_ACR_PASSWORD" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}