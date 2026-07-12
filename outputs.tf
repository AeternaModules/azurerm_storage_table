output "storage_tables_id" {
  description = "Map of id values across all storage_tables, keyed the same as var.storage_tables"
  value       = { for k, v in azurerm_storage_table.storage_tables : k => v.id }
}
output "storage_tables_acl" {
  description = "Map of acl values across all storage_tables, keyed the same as var.storage_tables"
  value       = { for k, v in azurerm_storage_table.storage_tables : k => v.acl }
}
output "storage_tables_name" {
  description = "Map of name values across all storage_tables, keyed the same as var.storage_tables"
  value       = { for k, v in azurerm_storage_table.storage_tables : k => v.name }
}
output "storage_tables_resource_manager_id" {
  description = "Map of resource_manager_id values across all storage_tables, keyed the same as var.storage_tables"
  value       = { for k, v in azurerm_storage_table.storage_tables : k => v.resource_manager_id }
}
output "storage_tables_storage_account_id" {
  description = "Map of storage_account_id values across all storage_tables, keyed the same as var.storage_tables"
  value       = { for k, v in azurerm_storage_table.storage_tables : k => v.storage_account_id }
}
output "storage_tables_storage_account_name" {
  description = "Map of storage_account_name values across all storage_tables, keyed the same as var.storage_tables"
  value       = { for k, v in azurerm_storage_table.storage_tables : k => v.storage_account_name }
}

