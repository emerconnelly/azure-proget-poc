resource "azurerm_resource_group" "azure_proget_poc" {
  name = "azure-proget-poc"

  location = "centralus"
}

resource "azurerm_storage_account" "proget_packages" {
  name = "azureprogetpocpackages"

  resource_group_name      = resource.azurerm_resource_group.azure_proget_poc.name
  location                 = "centralus"
  account_kind             = "StorageV2"
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

resource "azurerm_virtual_network" "this" {
  name                = "azure-proget-poc-vnet"
  resource_group_name = resource.azurerm_resource_group.azure_proget_poc.name
  location            = "centralus"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks" {
  name                 = "aks"
  resource_group_name  = resource.azurerm_resource_group.azure_proget_poc.name
  virtual_network_name = resource.azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0./24"]
}

resource "azurerm_subnet" "app_gateway" {
  name                 = "app-gateway"
  resource_group_name  = resource.azurerm_resource_group.azure_proget_poc.name
  virtual_network_name = resource.azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0./24"]
}

# resource "azurerm_kubernetes_cluster" "azure_proget_poc" {
#   name                = "azure-proget-poc"
#   resource_group_name = resource.azurerm_resource_group.azure_proget_poc.name
#   location            = "centralus"

#   dns_prefix                = "azure-proget-poc-dns"
#   sku_tier                  = "Free"
#   automatic_channel_upgrade = "patch"

#   default_node_pool {
#     name       = "agentpool"
#     vm_size    = "Standard_DS2_v2"
#     node_count = 1
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   network_profile {
#     network_plugin    = "kubenet"
#     load_balancer_sku = "standard"
#     network_policy    = "calico"
#   }

#   depends_on = [azurerm_resource_group.azure_proget_poc]
# }
