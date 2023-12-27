data "azurerm_subscription" "this" {}

data "azurerm_client_config" "this" {}

data "azurerm_role_definition" "key_vault_reader" {
  name = "Key Vault Reader"
}
