resource "azurerm_resource_group" "azure_proget_poc" {
  name = "azure-proget-poc"

  location = "centralus"
}

resource "azurerm_storage_account" "proget_packages" {
  name = "azureprogetpocpackages"

  resource_group_name      = "azure-proget-poc"
  location                 = "centralus"
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cool"

  depends_on = [azurerm_resource_group.azure_proget_poc]
}

resource "azurerm_storage_container" "proget_packages" {
  for_each = toset([
    "npm-azure-storage",
    "dotnet-azure-storage",
    "chocolatey-azure-storage",
  ])
  name = each.key

  storage_account_name  = resource.azurerm_storage_account.proget_packages.name
  container_access_type = "private"

  depends_on = [azurerm_storage_account.proget_packages]
}
