resource "azurerm_resource_group" "demo" {
  name     = "count-demo"
  location = "West Europe"
}

resource "azurerm_virtual_network" "demo" {
  name                = "demo-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
}

resource "azurerm_subnet" "demo" {
  name                    = "internal"
  resource_group_name     = azurerm_resource_group.demo.name
  virtual_network_name    = azurerm_virtual_network.demo.name
  address_prefixes        = ["10.0.2.0/24"]
}
