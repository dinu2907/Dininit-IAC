terraform {
  backend "azurerm" {
    resource_group_name   = "IAC"                     # Resource group for storage account
    storage_account_name  = "terraformaccount1234"     # Name of the storage account (globally unique)
    container_name        = "terraform-state"          # Name of the container for the state file
    key                   = "terraform.tfstate"       # Name of the state file
  }
}
