resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name = "aks-proget-poc"

  location = "eastus"
}
