# allow the Terraform execution identity to create secrets in the key vault
resource "azurerm_role_assignment" "tf_azurerm" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.key_vault_administrator.id
  principal_id       = data.azurerm_client_config.this.object_id
}

# allow the AKS secret store csi driver identity to use the key vault
resource "azurerm_role_assignment" "aks_secrets_store_csi_driver_identity" {
  scope              = azurerm_key_vault.this.id
  role_definition_id = data.azurerm_role_definition.key_vault_administrator.id
  principal_id       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].object_id
}

# allow the AGIC identity to use the "app-gateway" subnet since it's in a different resource group than the managed AKS resources
resource "azurerm_role_assignment" "aks_application_gateway_ingress_controller_identity" {
  scope              = azurerm_subnet.app_gateway.id
  role_definition_id = data.azurerm_role_definition.network_contributor.id
  principal_id       = azurerm_kubernetes_cluster.this.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

# if not using the auto-created aks csi driver identity, create one and assign
# resource "azurerm_user_assigned_identity" "aks_secrets_store_csi_driver_identity" {
#   name                = azurerm_resource_group.this.name
#   resource_group_name = azurerm_resource_group.this.name
#   location            = azurerm_resource_group.this.location
# }
# resource "azurerm_role_assignment" "aks_secrets_store_csi_driver_identity" {
#   scope              = azurerm_key_vault.this.id
#   role_definition_id = data.azurerm_role_definition.key_vault_administrator.id
#   principal_id       = azurerm_user_assigned_identity.aks_secrets_store_driver_identity.principal_id
# }

# federate credentials are only required for workload identity, not managed identity
# resource "azurerm_federated_identity_credential" "aks_secrets_store_driver_proget" {
#   name                = azurerm_resource_group.this.name
#   resource_group_name = azurerm_resource_group.this.name
#   parent_id = azurerm_user_assigned_identity.aks_secrets_store_driver_identity.id # replace(azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].user_assigned_identity_id, "resourcegroups", "resourceGroups")
#   issuer    = azurerm_kubernetes_cluster.this.oidc_issuer_url
#   subject   = "system:serviceaccount:proget:workload-identity-sa"
#   audience  = ["api://AzureADTokenExchange"]
# }
