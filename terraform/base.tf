resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name = "azure-proget-poc"

  location = "centralus"
}

resource "azuread_service_principal" "this" {
  client_id                    = data.azuread_client_config.this.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.this.object_id]
}
