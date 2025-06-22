<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-avm-template

This deploys the module in its simplest form.

```hcl
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
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5, < 2.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

- <a name="requirement_time"></a> [time](#requirement\_time) (~> 0.9)

## Resources

The following resources are used by this module:

- [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_management_group_display_name"></a> [management\_group\_display\_name](#output\_management\_group\_display\_name)

Description: The display name of the created management group

### <a name="output_management_group_id"></a> [management\_group\_id](#output\_management\_group\_id)

Description: The ID of the created management group

### <a name="output_management_group_name"></a> [management\_group\_name](#output\_management\_group\_name)

Description: The name of the created management group

### <a name="output_management_group_resource"></a> [management\_group\_resource](#output\_management\_group\_resource)

Description: The full management group resource object

## Modules

The following Modules are called:

### <a name="module_management_group"></a> [management\_group](#module\_management\_group)

Source: ../../

Version:

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->