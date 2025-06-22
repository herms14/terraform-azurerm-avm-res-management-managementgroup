provider "azurerm" {
  features {}
}

module "management_group" {
  source = "../../"

  display_name = "Example Management Group"
  name         = "example-mg"
}