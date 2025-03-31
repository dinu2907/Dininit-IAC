# 🔹 Create Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "dinenitacrdev"   # Must be globally unique
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"             # Choose Basic SKU for free-tier ACR
  admin_enabled       = false               # Disable admin credentials for security
}

# 🔹 Grant AKS Permission to Pull from ACR
resource "azurerm_role_assignment" "aks_acr" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope               = azurerm_container_registry.acr.id
}

# 🔹 Outputs for ACR
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}
