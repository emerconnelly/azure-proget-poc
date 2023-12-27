data "azurerm_subscription" "this" {}

data "azurerm_client_config" "this" {}

data "azurerm_role_definition" "key_vault_administrator" {
  name  = "Key Vault Secrets Officer"
  scope = azurerm_key_vault.this.id
}
