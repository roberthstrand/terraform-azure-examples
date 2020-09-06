data "azurerm_resource_group" "example" {
  name = var.resource_group

  #depends_on = [null_resource.test]
}