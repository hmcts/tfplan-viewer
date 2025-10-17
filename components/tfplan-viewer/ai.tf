module "ai" {
  source                       = "git::https://github.com/hmcts/terraform-module-ai-services?ref=optional-resources"
  env                          = var.env
  project                      = "${var.component}-${var.env}-project"
  existing_resource_group_name = azurerm_resource_group.rg.name
  common_tags                  = module.ctags.common_tags
  product                      = var.component
  component                    = var.component
  key_vault_id                 = module.keyvault.key_vault_id
}