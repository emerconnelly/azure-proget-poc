resource "azurerm_storage_account" "this" {
  name = substr("progetpackages${resource.random_integer.this.result}}", 0, 24)

  resource_group_name      = resource.azurerm_resource_group.this.name
  location                 = resource.azurerm_resource_group.this.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cool"
}

resource "azurerm_storage_container" "this" {
  for_each = toset([
    "npm-azure-storage",
    "dotnet-azure-storage",
    "chocolatey-azure-storage",
  ])
  name = each.key

  storage_account_name  = resource.azurerm_storage_account.this.name
  container_access_type = "private"
}
