resource "azurerm_virtual_network" "example" {
  name                = format("%s-vnet", var.name)
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = format("%s-subnet1", var.name)
    address_prefix = "10.0.1.0/24"
  }

  tags = data.azurerm_resource_group.example.tags
}