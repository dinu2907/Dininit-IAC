resource "azurerm_linux_virtual_machine" "test_vm" {
  name                = "testVM"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = "P@ssword1234!"

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

  custom_data = filebase64("node_exporter_install.sh")
}
