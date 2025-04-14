# ✅ Resource Group (if not already created elsewhere)
resource "azurerm_resource_group" "rg" {
  name     = "IAC"
  location = "westeurope"  # 👈 NEW region
}

# ✅ Public IP for VM
resource "azurerm_public_ip" "test_vm_public_ip" {
  name                = "testVMPublicIP"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# ✅ Network Security Group
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "vmNSG"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Node-Exporter"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9100"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# ✅ Network Interface
resource "azurerm_network_interface" "test_vm_nic" {
  name                = "testVMNIC1"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.aks_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.test_vm_public_ip.id
  }
}

# ✅ Associate NSG to NIC
resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.test_vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

# ✅ Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "test_vm" {
  name                = "testVM"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = "P@ssword1234!"  # Change for production

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

  # Optional: Cloud-init script for Node Exporter
  custom_data = filebase64("${path.module}/scripts/node_exporter_install.sh")
}

# ✅ Outputs
output "test_vm_private_ip" {
  value = azurerm_network_interface.test_vm_nic.private_ip_address
}

output "test_vm_public_ip" {
  value = azurerm_public_ip.test_vm_public_ip.ip_address
}
