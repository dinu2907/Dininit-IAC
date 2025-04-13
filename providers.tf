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
}
