# Variable Validation demonstration, Terraform 0.13
# Note - probably not the place to enforce policies, this is just an example.

variable "resource_group_name" {
  type = string
  validation {
    condition     = can(regex("-rg$", var.resource_group_name))
    error_message = "Resource group names must end with -rg."
  }
}

# Create a resource group
resource "azurerm_resource_group" "demo" {
  name     = var.resource_group_name
  location = "Norway East"
}