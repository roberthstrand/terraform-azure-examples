# foreach using child modules, Terraform 0.13.
# Create resource groups based on three environments - Test, Dev and Prod.

variable "project_name" {
  type    = string
  default = "terraform013"
}

variable "environments" {
  type    = set(string)
  default = ["test","dev","prod"]
}

module resource_group {
  source    = "./modules/resource_group"
  for_each  = var.environments

  name      = format("%s-%s-rg", var.project_name, each.key)
  location  = "norwayeast"

  tags = {
    environment = each.key
    deployment  = "terraform"
    type        = "demo"
  }
}