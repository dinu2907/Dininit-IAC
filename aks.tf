# 🔹 AKS Cluster with Cost Optimization & Fix Service CIDR Overlap
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "Dinenit-AKS"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "myakspractice"

  default_node_pool {
    name       = "agentpool"
    node_count = 1
    vm_size    = "Standard_B2s"  # Updated VM size to meet AKS requirements
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  network_profile {
    network_plugin    = "azure"
    service_cidr      = "10.1.0.0/16"  # Separate non-overlapping CIDR for services
    dns_service_ip    = "10.1.0.10"   # Set a DNS service IP within the service CIDR
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
  }
}

# 🔹 Outputs for AKS
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
