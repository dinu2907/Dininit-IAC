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

    # Use the Service Principal for authentication
  client_id       = "04a73b31-9ae2-45ed-ad40-2fc91b5145f4"
  client_secret   = "J4O8Q~mKTp4XlKJVzDI51gGgkprm4K.ZFI_1WalT"
  tenant_id       = "e76f4fb2-c488-42f7-a7b4-18d2fa2ea405"
  subscription_id = "3502cdf1-2daf-4167-a8dc-5e4a39bbe518"
}
