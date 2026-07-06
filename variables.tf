variable "storage_tables" {
  description = <<EOT
Map of storage_tables, attributes below
Required:
    - name
Optional:
    - storage_account_id
    - storage_account_name
    - acl (block):
        - access_policy (optional, block):
            - expiry (required)
            - permissions (required)
            - start (required)
        - id (required)
EOT

  type = map(object({
    name                 = string
    storage_account_id   = optional(string)
    storage_account_name = optional(string)
    acl = optional(object({
      access_policy = optional(object({
        expiry      = string
        permissions = string
        start       = string
      }))
      id = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.storage_tables : (
        v.acl == null || (length(v.acl.id) >= 1 && length(v.acl.id) <= 64)
      )
    ])
    error_message = "must be between 1 and 64 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_tables : (
        v.acl == null || (v.acl.access_policy == null || (length(v.acl.access_policy.start) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_tables : (
        v.acl == null || (v.acl.access_policy == null || (length(v.acl.access_policy.expiry) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_tables : (
        v.acl == null || (v.acl.access_policy == null || (length(v.acl.access_policy.permissions) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_storage_table's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   source:    [from validate.StorageTableName] value == "table"
  # path: name
  #   source:    [from validate.StorageTableName] !regexp.MustCompile(`^[A-Za-z][A-Za-z0-9]{2,62}$`).MatchString(value)
  # path: storage_account_id
  #   source:    [from commonids.ValidateStorageAccountID] !ok
  # path: storage_account_id
  #   source:    [from commonids.ValidateStorageAccountID] err != nil
}

