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
  features {}

  # Use environment variables for Service Principal authentication
  client_id       = env("ARM_CLIENT_ID")
  client_secret   = env("ARM_CLIENT_SECRET")
  tenant_id       = env("ARM_TENANT_ID")
  subscription_id = env("ARM_SUBSCRIPTION_ID")
}
