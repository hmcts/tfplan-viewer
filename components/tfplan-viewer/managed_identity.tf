resource "azurerm_user_assigned_identity" "managed_identity" {
  location            = azurerm_resource_group.rg.location
  name                = "${var.component}-cftptl-intsvc-mi"
  resource_group_name = "managed-identities-cftptl-intsvc-rg"
  tags                = module.ctags.common_tags
}