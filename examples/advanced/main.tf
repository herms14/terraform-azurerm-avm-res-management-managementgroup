provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

module "management_group" {
  source = "../../"

  display_name               = "Production Management Group"
  name                       = "prod-mg"
  parent_management_group_id = null # Will be created under tenant root

  role_assignments = {
    reader = {
      role_definition_id_or_name = "Reader"
      principal_id               = data.azurerm_client_config.current.object_id
      description                = "Reader access for current user"
      principal_type             = "User"
    }
    contributor = {
      role_definition_id_or_name = "Contributor"
      principal_id               = data.azurerm_client_config.current.object_id
      description                = "Contributor access for management"
      principal_type             = "User"
    }
  }

  time_sleep_duration = "45s"
  enable_telemetry    = true
}