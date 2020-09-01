variable "name" {}
variable "location" {}
variable "tags" {
  type = map(string)
}

resource "azurerm_resource_group" "demo" {
  name     = var.name
  location = var.location

  tags = var.tags
}