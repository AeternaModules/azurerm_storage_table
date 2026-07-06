output "storage_tables" {
  description = "All storage_table resources"
  value       = azurerm_storage_table.storage_tables
}
output "storage_tables_acl" {
  description = "List of acl values across all storage_tables"
  value       = [for k, v in azurerm_storage_table.storage_tables : v.acl]
}
output "storage_tables_name" {
  description = "List of name values across all storage_tables"
  value       = [for k, v in azurerm_storage_table.storage_tables : v.name]
}
output "storage_tables_resource_manager_id" {
  description = "List of resource_manager_id values across all storage_tables"
  value       = [for k, v in azurerm_storage_table.storage_tables : v.resource_manager_id]
}
output "storage_tables_storage_account_id" {
  description = "List of storage_account_id values across all storage_tables"
  value       = [for k, v in azurerm_storage_table.storage_tables : v.storage_account_id]
}
output "storage_tables_storage_account_name" {
  description = "List of storage_account_name values across all storage_tables"
  value       = [for k, v in azurerm_storage_table.storage_tables : v.storage_account_name]
}

