variable "storage_tables" {
  description = <<EOT
Map of storage_tables, attributes below
Required:
    - name
    - storage_account_name
Optional:
    - acl (block):
        - access_policy (optional, block):
            - expiry (required)
            - permissions (required)
            - start (required)
        - id (required)
EOT

  type = map(object({
    name                 = string
    storage_account_name = string
    acl = optional(object({
      access_policy = optional(object({
        expiry      = string
        permissions = string
        start       = string
      }))
      id = string
    }))
  }))
}

