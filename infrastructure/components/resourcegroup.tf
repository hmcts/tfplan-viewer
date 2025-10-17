resource "azurerm_resource_group" "rg" {
  name     = "${var.product}-${var.component}-rg"
  location = var.location

  tags = module.ctags.common_tags
}