module "storage" {
  source                   = "git::https://github.com/hmcts/cnp-module-storage-account?ref=4.x"
  env                      = var.env
  storage_account_name     = "${replace(var.component, "-", "")}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_kind             = var.account_kind
  account_replication_type = var.account_replication_type
  default_action           = "Allow"

  managed_identity_object_id = data.azurerm_client_config.current.object_id
  role_assignments = [
    "Storage Blob Data Contributor"
  ]

  containers = [{
    name        = "plan-html"
    access_type = "private"
    },
    {
      name        = "plan-json"
      access_type = "private"
    }
  ]

  common_tags = module.ctags.common_tags
}