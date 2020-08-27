# Variable Validation

Custom variable validation was introduced as a production-ready feature from Terraform 0.13. With variable validation, you can predefine rules for what a input variable should allow and what kind of error it should report. By using variable validation, you can make sure that the input variable is correct at an earlier stage.

## Storage account limitations

Storage accounts naming can be a tricky thing. Not only do the name have to be a certain length, but you can only use numbers and lower case characters. By using variable validation, you can make sure that the input is correct without trying to create the resource.

_For easier readability, I have split the three conditions to their own line but this will generate and error. Every condition needs to be on one line. If unsure, take a look at the [actual code here](main.tf)._

```hcl
variable "storage_account_name" {
  type = string
  validation {
    condition     = length(var.storage_account_name) > 2 && 
                    length(var.storage_account_name) < 25 && 
                    can(regex("[a-z.*]|[0-9]", var.storage_account_name))
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
```