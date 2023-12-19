resource "azurerm_resource_group" "azure_proget_poc" {
  name     = "azure-proget-poc"
  location = "centralus"
}

resource "azurerm_storage_account" "proget_packages" {
  name                = "azureprogetpocpackages"
  location            = "centralus"
  resource_group_name = "azure-proget-poc"

  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cool"
}

resource "azurerm_storage_container" "npm_azure_storage" {
  name                  = "npm-azure-storage"
  storage_account_name  = resource.azurerm_storage_account.proget_poc_packages.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "dotnet_azure_storage" {
  name                  = "dotnet-azure-storage"
  storage_account_name  = resource.azurerm_storage_account.proget_poc_packages.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "chocolatey_azure_storage" {
  name                  = "chocolatey-azure-storage"
  storage_account_name  = resource.azurerm_storage_account.proget_poc_packages.name
  container_access_type = "private"
}
