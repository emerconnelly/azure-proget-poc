resource "random_integer" "this" {
  min = 100000000000000
  max = 999999999999999
}

resource "azurerm_resource_group" "this" {
  name = "azure-proget-poc"

  location = "centralus"
}

resource "azurerm_storage_account" "this" {
  name = substr("progetpackages${resource.random_integer.this.result}}", 0, 24)

  resource_group_name      = resource.azurerm_resource_group.this.name
  location                 = "centralus"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cool"

  depends_on = [resource.azurerm_resource_group.this]
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

  depends_on = [resource.azurerm_storage_account.this]
}

resource "azurerm_virtual_network" "this" {
  name                = "azure-proget-poc-vnet"
  resource_group_name = resource.azurerm_resource_group.this.name
  location            = "centralus"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks_nodes" {
  name                 = "aks"
  resource_group_name  = resource.azurerm_resource_group.this.name
  virtual_network_name = resource.azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "app_gateway" {
  name                 = "app-gateway"
  resource_group_name  = resource.azurerm_resource_group.this.name
  virtual_network_name = resource.azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  resource_group_name = "azure-proget-poc"
  node_resource_group = "MC_azure-proget-poc_aks_centralus"
  location            = "centralus"

  automatic_channel_upgrade           = "patch"
  azure_policy_enabled                = false
  custom_ca_trust_certificates_base64 = []
  dns_prefix                          = "aks-dns"
  http_application_routing_enabled    = false
  kubernetes_version                  = "1.28.3"
  role_based_access_control_enabled   = true
  run_command_enabled                 = true
  sku_tier                            = "Free"
  support_plan                        = "KubernetesOfficial"
  workload_identity_enabled           = false
  default_node_pool {
    name                = "agentpool"
    vm_size             = "Standard_DS2_v2"
    node_count          = 1
    os_disk_size_gb     = 32
    enable_auto_scaling = false
    vnet_subnet_id      = resource.azurerm_subnet.aks.id
  }
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
    network_policy    = "calico"
    outbound_type     = "loadBalancer"
    pod_cidr          = "10.244.0.0/16"
    service_cidr      = "172.16.0.0/16"
    dns_service_ip    = "172.16.0.10"
  }
}
