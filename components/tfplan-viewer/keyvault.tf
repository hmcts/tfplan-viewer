module "keyvault" {
  source                  = "git::https://github.com/hmcts/cnp-module-key-vault?ref=master"
  name                    = "${var.component}-${var.env}-kv"
  product                 = var.component
  env                     = var.env
  resource_group_name     = azurerm_resource_group.rg.name
  product_group_name      = "DTS Platform Operations"
  developers_group        = "DTS Platform Operations"
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

resource "azurerm_key_vault_secret" "storage_account_primary_key" {
  name         = "storage-account-primary-key"
  value        = module.storage.storageaccount_primary_access_key
  key_vault_id = module.keyvault.key_vault_id
}

resource "azurerm_key_vault_secret" "cognitive_account_primary_access_key" {
  name         = "cognitive-account-primary-access-key"
  value        = module.ai.cognitive_account_primary_access_key
  key_vault_id = module.keyvault.key_vault_id
}

resource "azurerm_key_vault_secret" "cognitive_account_endpoint" {
  name         = "storage-account-primary-key"
  value        = module.ai.cognitive_account_endpoint
  key_vault_id = module.keyvault.key_vault_id
}

resource "azurerm_key_vault_secret" "openai_deployment" {
  name         = "openai-deployment"
  value        = "${var.component}-${var.env}-deployment"
  key_vault_id = module.keyvault.key_vault_id
}
