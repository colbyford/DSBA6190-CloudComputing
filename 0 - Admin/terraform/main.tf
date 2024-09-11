// Tags
locals {
  tags = {
    class      = var.class
    semester   = var.semester
    instructor = var.instructor
  }
}

// Subscription ID
data "azurerm_subscription" "current" {
  subscription_id = var.subscription_id
}

// Resource Group
data "azurerm_resource_group" "rg" {
  name = "rg-${var.class}-${var.group}-${var.environment}-${var.region}-${var.suffix}"
}

// Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "cr${var.class}${var.environment}${var.region}${var.suffix}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  admin_enabled       = true
  sku                 = "Standard"

  tags = local.tags
}


// Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "kub-${var.class}-${var.group}-${var.environment}-${var.region}-${var.suffix}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "dns-${var.class}-${var.group}-${var.environment}-${var.region}-${var.suffix}"

  default_node_pool {
    name                 = "agentpool"
    node_count           = 1
    vm_size              = "Standard_D2_v2"
    orchestrator_version = "1.29.7"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

  auto_scaler_profile {
    scale_down_utilization_threshold = 0.8
  }

  tags = local.tags
}

// Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = "sto${var.class}${var.group}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  lifecycle {
    prevent_destroy = true
  }

  tags = local.tags
}

# ## Get Agent Pool MI for AKS
# data "azurerm_user_assigned_identity" "aks_ap" {
#   name                = "${azurerm_kubernetes_cluster.aks.name}-agentpool"
#   resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
# }

# ## Credentials for External Container Registry
# resource "azurerm_role_assignment" "cred_aks_to_acr" {
#   scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${azurerm_resource_group.rg.name}/providers/Microsoft.ContainerRegistry/registries/${azurerm_container_registry.acr.name}"
#   role_definition_name = "AcrPull"
#   principal_id         = data.azurerm_user_assigned_identity.aks_ap.principal_id
# }


// Databricks
resource "azurerm_databricks_workspace" "databricks" {
  name                        = "dbx-${var.class}-${var.group}-${var.environment}-${var.region}-${var.suffix}"
  resource_group_name         = data.azurerm_resource_group.rg.name
  location                    = data.azurerm_resource_group.rg.location
  sku                         = "premium"
  managed_resource_group_name = "mrg-${var.class}-${var.group}-${var.environment}-${var.region}-${var.suffix}"

  tags = local.tags
}

# // Azure Machine Learning
# resource "azurerm_machine_learning_workspace" "aml" {
#   name                = "aml-${var.class}-${var.group}-${var.environment}-${var.region}-${var.suffix}"
#   resource_group_name = data.azurerm_resource_group.rg.name
#   location            = data.azurerm_resource_group.rg.location
#   friendly_name       = "Machine Learning Workspace"

#   tags = local.tags
# }


# // Azure Cognitive Services
# resource "azurerm_cognitive_account" "cognitive" {
#   name                = "cog-${var.class}-${var.group}-${var.environment}-${var.region}-${var.suffix}"
#   resource_group_name = data.azurerm_resource_group.rg.name
#   location            = data.azurerm_resource_group.rg.location
#   sku_name            = "S0"
#   kind                = "CognitiveServices"

#   tags = local.tags
# }

# // Azure OpenAI
# resource "azurerm_openai_resource" "openai" {
#   name                = "openai-${var.app_name}-${var.group}-${var.environment}-${var.region}-${var.suffix}"
#   resource_group_name = data.azurerm_resource_group.rg.name
#   location            = data.azurerm_resource_group.rg.location
#   sku_name            = "B0"

#   tags = local.tags
# }