output "management_group_id" {
  description = "The ID of the created management group"
  value       = module.management_group.id
}

output "management_group_name" {
  description = "The name of the created management group"
  value       = module.management_group.name
}

output "management_group_display_name" {
  description = "The display name of the created management group"
  value       = module.management_group.display_name
}

output "management_group_resource" {
  description = "The full management group resource object"
  value       = module.management_group.resource
  sensitive   = false
}