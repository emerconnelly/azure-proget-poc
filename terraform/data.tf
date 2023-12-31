data "azurerm_subscription" "this" {}

data "azurerm_client_config" "this" {}

data "azurerm_role_definition" "key_vault_administrator" {
  name  = "Key Vault Administrator"
  scope = azurerm_key_vault.this.id
}

data "azurerm_role_definition" "network_contributor" {
  name  = "Network Contributor"
  scope = azurerm_subnet.app_gateway.id
}

# data "http" "tf_execution_ip" {
#   url = "https://ipv4.icanhazip.com"
# }
