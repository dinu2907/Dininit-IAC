# 🔹 Use Existing Resource Group "IAC"
resource "azurerm_resource_group" "rg" {
  name     = "IAC"  # Use the existing Resource Group
  location = "East US"  # You can keep this as "East US" or change as per your need
}
