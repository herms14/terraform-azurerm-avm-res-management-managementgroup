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

# This is the module call for E2E testing - this example is ignored during tests
module "management_group" {
  source = "../../"

  display_name = "E2E Test Management Group"
  name         = "e2e-test-mg"

  enable_telemetry = var.enable_telemetry # see variables.tf
}