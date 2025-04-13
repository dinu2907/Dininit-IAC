terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"  # Adjust this version as needed
    }
  }

  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}

  client_id       = var.APP_ID
  client_secret   = var.CLIENT_SECRET
  subscription_id = var.SUBSCRIPTION_ID
  tenant_id       = var.TENANT_ID
}
