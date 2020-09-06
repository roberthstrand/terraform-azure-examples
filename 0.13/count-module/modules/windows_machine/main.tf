resource "random_string" "random" {
  length      = 3
  special     = false
  upper       = false
  min_numeric = 1
  min_lower   = 2
}

resource "azurerm_network_interface" "demo" {
  name                = format("nic-%s-%s", var.name, random_string.random.result)
  location            = data.azurerm_resource_group.demo.location
  resource_group_name = data.azurerm_resource_group.demo.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.demo.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "demo" {
  name                = format("vm-%s-%s", var.name, random_string.random.result)
  resource_group_name = data.azurerm_resource_group.demo.name
  location            = data.azurerm_resource_group.demo.location
  size                = "Standard_B1ms"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.demo.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
