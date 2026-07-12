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
    acl = optional(list(object({
      access_policy = optional(list(object({
        expiry      = string
        permissions = string
        start       = string
      })))
      id = string
    })))
  }))
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
  # path: acl.id
  #   condition: length(value) >= 1 && length(value) <= 64
  #   message:   must be between 1 and 64 characters
  # path: acl.access_policy.start
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: acl.access_policy.expiry
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: acl.access_policy.permissions
  #   condition: length(value) > 0
  #   message:   must not be empty
}

