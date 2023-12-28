resource "azurerm_role_assignment" "tf_azurerm" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.key_vault_administrator.id
  principal_id       = data.azurerm_client_config.this.object_id
}

# resource "azurerm_user_assigned_identity" "aks_csi_driver_managed_identity" {
#   name                = azurerm_resource_group.this.name
#   resource_group_name = azurerm_resource_group.this.name
#   location            = azurerm_resource_group.this.location
# }

# resource "azurerm_role_assignment" "aks_csi_driver_managed_identity" {
#   scope              = azurerm_key_vault.this.id
#   role_definition_id = data.azurerm_role_definition.key_vault_administrator.id
#   principal_id       = azurerm_user_assigned_identity.aks_csi_driver_managed_identity.principal_id
# }

resource "azurerm_role_assignment" "aks_csi_driver_proget" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.key_vault_administrator.id
  principal_id       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].object_id
}
