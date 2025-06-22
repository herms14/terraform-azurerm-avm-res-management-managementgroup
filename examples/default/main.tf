terraform {
  required_version = ">= 1.5, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# This is the module call for the management group
module "management_group" {
  source = "../../"

  display_name = "Default Management Group Example"
  name         = "default-mg-example"

  enable_telemetry = var.enable_telemetry # see variables.tf
}