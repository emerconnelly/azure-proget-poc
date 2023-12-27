resource "azurerm_role_assignment" "tf_azure_rm" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.key_vault_administrator.id
  principal_id       = data.azurerm_client_config.this.object_id
}

resource "azurerm_role_assignment" "aks_csi_driver_managed_identity" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.key_vault_administrator.id
  principal_id       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity.client_id
}
