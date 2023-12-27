resource "azurerm_role_assignment" "key_vault_reader" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.key_vault_reader.id
  principal_id       = data.azurerm_client_config.this.object_id
}
