resource "random_integer" "this" {
  min = 100000000000000
  max = 999999999999999
}

resource "azurerm_resource_group" "this" {
  name = "azure-proget-poc"

  location = "centralus"
}
