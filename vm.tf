# 🔹 SSH Key (replace with your actual public key)
variable "admin_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
}

# 🔹 Network Interface for VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "testVMNIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.aks_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# 🔹 Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "test_vm" {
  name                = "testVM"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.admin_ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "testOSDisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts"
    version   = "latest"
  }

  disable_password_authentication = true
}

# Optional output
output "test_vm_private_ip" {
  value = azurerm_network_interface.vm_nic.private_ip_address
}
