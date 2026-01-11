resource "azurerm_storage_table" "storage_tables" {
  for_each = var.storage_tables

  name                 = each.value.name
  storage_account_name = each.value.storage_account_name

  dynamic "acl" {
    for_each = each.value.acl != null ? [each.value.acl] : []
    content {
      dynamic "access_policy" {
        for_each = acl.value.access_policy != null ? [acl.value.access_policy] : []
        content {
          expiry      = access_policy.value.expiry
          permissions = access_policy.value.permissions
          start       = access_policy.value.start
        }
      }
      id = acl.value.id
    }
  }
}

