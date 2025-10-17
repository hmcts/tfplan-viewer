resource "azurerm_user_assigned_identity" "managed_identity" {
  location            = azurerm_resource_group.rg.location
  name                = "${var.product}-${var.component}-${var.env}-mi"
  resource_group_name = azurerm_resource_group.rg.name
}