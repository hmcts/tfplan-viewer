module "keyvault" {
  source                      = "git::https://github.com/hmcts/cnp-module-key-vault?ref=master"
  name                        = "${var.component}-${var.env}-kv"
  product                     = var.product
  env                         = var.env
  resource_group_name         = azurerm_resource_group.rg.name
  product_group_name          = "DTS Platform Operations"
  common_tags                 = module.ctags.common_tags
  create_managed_identity     = false
  object_id                   = data.azurerm_client_config.current.object_id
  managed_identity_object_ids = [azurerm_user_assigned_identity.managed_identity.principal_id]

  depends_on = [ azurerm_user_assigned_identity.managed_identity ]
}