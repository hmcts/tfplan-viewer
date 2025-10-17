resource "azurerm_role_assignment" "blob_reader" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.managed_identity.principal_id
}