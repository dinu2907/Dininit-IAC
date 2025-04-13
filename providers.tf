terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"  # Choose the older version (e.g., 2.x series)
    }
  }
  required_version = ">= 0.12"
}

provider "azurerm" {
  features = {}

  client_id       = var.APP_ID
  client_secret   = var.CLIENT_SECRET
  subscription_id = var.SUBSCRIPTION_ID
  tenant_id       = var.TENANT_ID
}

