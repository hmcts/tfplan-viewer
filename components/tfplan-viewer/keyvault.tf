module "keyvault" {
  source                  = "git::https://github.com/hmcts/cnp-module-key-vault?ref=master"
  name                    = "${var.component}-${var.env}-kv"
  product                 = var.product
  env                     = var.env
  resource_group_name     = azurerm_resource_group.rg.name
  product_group_name      = "DTS Platform Operations"
  common_tags             = module.ctags.common_tags
  create_managed_identity = false
  object_id               = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_access_policy" "aks_access_policy" {
  key_vault_id = module.keyvault.key_vault_id

  object_id = data.azurerm_client_config.current.client_id
  tenant_id = data.azurerm_client_config.current.tenant_id

  certificate_permissions = []

  key_permissions = []

  secret_permissions = [
    "Get"
  ]
}