resource "azurerm_storage_account" "terraform" {
  name                     = "terraformaccount1234"  # Must be globally unique
  resource_group_name      = "IAC"                   # The resource group where the storage account will reside
  location                 = "EastUS"                # The location (region) for the storage account
  account_tier              = "Standard"              # Tier for the storage account (Standard or Premium)
  account_replication_type = "LRS"                   # Replication type (Locally Redundant Storage - LRS)

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = "terraform-state"       # Name of the container where state will be stored
  storage_account_name  = azurerm_storage_account.terraform.name
  container_access_type = "private"               # Private container (default)
}
