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
  validation {
    condition = alltrue([
      for k, v in var.storage_tables : (
        v.acl == null || alltrue([for item in v.acl : (length(item.id) >= 1 && length(item.id) <= 64)])
      )
    ])
    error_message = "must be between 1 and 64 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_tables : (
        v.acl == null || alltrue([for item in v.acl : (item.access_policy == null || alltrue([for item in item.access_policy : (length(item.start) > 0)]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_tables : (
        v.acl == null || alltrue([for item in v.acl : (item.access_policy == null || alltrue([for item in item.access_policy : (length(item.expiry) > 0)]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.storage_tables : (
        v.acl == null || alltrue([for item in v.acl : (item.access_policy == null || alltrue([for item in item.access_policy : (length(item.permissions) > 0)]))])
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

