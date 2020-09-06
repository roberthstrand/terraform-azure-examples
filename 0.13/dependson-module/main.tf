resource "azurerm_resource_group" "example" {
  name      = "demo-rg"
  location  = "westeurope"
}

module "network" {
  source    = "./modules/network"
  name  = var.name

  resource_group = azurerm_resource_group.example.name

  depends_on = [azurerm_resource_group.example]
}