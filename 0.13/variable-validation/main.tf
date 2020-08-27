# Variable Validation demonstration, Terraform 0.13
# Note - Some of these might be a better fit for Azure Policy as this
# is probably not the place to enforce policies. These are just examples.


resource "azurerm_resource_group" "demo" {
  name     = "storage-account-rg"
  location = "Norway East"
}

# Create a storage account, making sure the name sticks to naming limitations.
variable "storage_account_name" {
  type = string
  validation {
    condition     = (
                    length(var.storage_account_name) > 2 && 
                    length(var.storage_account_name) < 25 && 
                    can(regex("[a-z.*]|[0-9]", var.storage_account_name))
                    )
    error_message = "Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only."
  }
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}