variable "name" {
  type    = string
  default = "mgmt"
}

variable "vnet"   {}
variable "subnet" {}

variable "resource_group" {}

data "azurerm_resource_group" "demo" {
  name = var.resource_group

  depends_on = [null_resource.test]
}

data "azurerm_subnet" "demo" {
  name                  = var.subnet
  virtual_network_name  = var.vnet
  resource_group_name   = data.azurerm_resource_group.demo.name
  depends_on = [null_resource.test]
}

