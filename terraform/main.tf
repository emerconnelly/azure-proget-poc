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
  location            = "centralus"

  # automatic_channel_upgrade           = "patch"
  dns_prefix                          = "aks-dns"
  # kubernetes_version                  = "1.28.3"
  sku_tier                            = "Free"
  # support_plan                        = "KubernetesOfficial"
  # azure_policy_enabled                = false
  # http_application_routing_enabled    = true
  # role_based_access_control_enabled   = true
  # run_command_enabled                 = true
  workload_identity_enabled           = true
  oidc_issuer_enabled                 = true
  default_node_pool {
    name                = "agentpool"
    vm_size             = "Standard_B4s_v2" # "Standard_DS2_v2"
    node_count          = 1
    os_disk_size_gb     = 32
    enable_auto_scaling = false
    vnet_subnet_id      = resource.azurerm_subnet.aks_nodes.id
    upgrade_settings {
      max_surge = "10%"
    }
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

# resource "azurerm_kubernetes_cluster_extension" "flux" {
#   name           = "microsoft.flux"
#   cluster_id     = resource.azurerm_kubernetes_cluster.aks.id
#   extension_type = "microsoft.flux"
# }
