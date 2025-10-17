resource "azurerm_resource_group" "rg" {
  name     = "${var.component}-${var.env}-rg"
  location = var.location

  tags = module.ctags.common_tags
}