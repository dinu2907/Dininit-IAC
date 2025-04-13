# ✅ Network Interface for VM
resource "azurerm_network_interface" "test_vm_nic" {
  name                = "testVMNIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.aks_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# ✅ Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "test_vm" {
  name                = "testVM"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = "P@ssword1234!"  # Use a strong, secure password!

  network_interface_ids = [
    azurerm_network_interface.test_vm_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "testOSDisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  disable_password_authentication = false
}

# ✅ Output for testing (optional)
output "test_vm_private_ip" {
  value = azurerm_network_interface.test_vm_nic.private_ip_address
}
