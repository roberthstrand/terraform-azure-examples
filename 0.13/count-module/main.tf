# Example, using the count meta-argument on a child module.

module "virtual_machine" {
  source = "./modules/windows_machine"

  name            = "dc"
  vnet            = azurerm_virtual_network.demo.name
  subnet          = azurerm_subnet.demo.name
  resource_group  = azurerm_resource_group.demo.name

  count = 2
}