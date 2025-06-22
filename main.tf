resource "azurerm_management_group" "this" {
  display_name               = var.display_name
  name                       = var.name
  parent_management_group_id = var.parent_management_group_id
  subscription_ids           = var.subscription_ids
}

resource "azurerm_role_assignment" "this" {
  for_each = var.role_assignments

  principal_id                           = each.value.principal_id
  scope                                  = azurerm_management_group.this.id
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  principal_type                         = each.value.principal_type
  role_definition_id                     = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? each.value.role_definition_id_or_name : null
  role_definition_name                   = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? null : each.value.role_definition_id_or_name
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}

resource "time_sleep" "this" {
  count = length(var.role_assignments) > 0 ? 1 : 0

  create_duration = var.time_sleep_duration

  depends_on = [azurerm_role_assignment.this]
}