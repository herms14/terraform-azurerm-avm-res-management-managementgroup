variable "display_name" {
  type        = string
  description = "The display name for the management group."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the management group. This name is unique within the tenant."
  nullable    = false

  validation {
    condition     = can(regex("^[a-zA-Z0-9_\\-\\.\\(\\)]{1,90}$", var.name))
    error_message = "The name must be between 1 and 90 characters and can contain letters, numbers, underscores, hyphens, periods, and parentheses."
  }
}

variable "parent_management_group_id" {
  type        = string
  default     = null
  description = "The ID of the parent management group. If not specified, the management group will be created under the tenant root group."
}

variable "subscription_ids" {
  type        = set(string)
  default     = []
  description = "A set of subscription IDs to associate with the management group."
  nullable    = false
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of role assignments to create on the management group. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.
- `delegated_managed_identity_resource_id` - The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created.
- `principal_type` - The type of the principal_id. Possible values are `User`, `Group` and `ServicePrincipal`. Changing this forces a new resource to be created.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
DESCRIPTION
  nullable    = false
}

variable "time_sleep_duration" {
  type        = string
  default     = "30s"
  description = "The duration to wait after creating role assignments to ensure RBAC propagation. This helps with eventual consistency issues."
  nullable    = false

  validation {
    condition     = can(regex("^[0-9]+[smh]$", var.time_sleep_duration))
    error_message = "The time_sleep_duration must be a valid duration string (e.g., '30s', '5m', '1h')."
  }
}