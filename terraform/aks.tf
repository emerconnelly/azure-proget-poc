resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  resource_group_name = "azure-proget-poc"
  location            = resource.azurerm_resource_group.this.location

  # automatic_channel_upgrade           = "patch"
  dns_prefix = "aks-dns"
  # kubernetes_version                  = "1.28.3"
  sku_tier = "Free"
  # support_plan                        = "KubernetesOfficial"
  # azure_policy_enabled                = false
  # http_application_routing_enabled    = true
  # role_based_access_control_enabled   = true
  # run_command_enabled                 = true
  workload_identity_enabled = true
  oidc_issuer_enabled       = true

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  default_node_pool {
    name                = "default"
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
    pod_cidr          = "10.244.0.0/16" # this is Azure's default setting
    service_cidr      = "172.16.0.0/16" # using a different class helps differentiate from pods & nodes
    dns_service_ip    = "172.16.0.10"
  }
}

resource "azurerm_kubernetes_cluster_extension" "flux" {
  name              = "microsoft.flux"
  cluster_id        = resource.azurerm_kubernetes_cluster.aks.id
  extension_type    = "microsoft.flux"
  release_namespace = "flux-system"

  configuration_settings = {
    "image-automation-controller.enabled"              = true,
    "image-reflector-controller.enabled"               = true,
    "notification-controller.enabled"                  = true,
    "helm-controller.detectDrift"                      = true,
    "helm-controller.outOfMemoryWatch.enabled"         = true,
    "helm-controller.outOfMemoryWatch.memoryThreshold" = 70,
    "helm-controller.outOfMemoryWatch.interval"        = "700ms"
  }
}

resource "azurerm_kubernetes_flux_configuration" "proget" {
  name                              = "azure-proget-poc"
  cluster_id                        = resource.azurerm_kubernetes_cluster.aks.id
  namespace                         = "flux-system"
  scope                             = "cluster"
  continuous_reconciliation_enabled = true

  git_repository {
    url                      = "https://github.com/emerconnelly/azure-proget-poc"
    reference_type           = "branch"
    reference_value          = "main"
    sync_interval_in_seconds = 60
  }

  kustomizations {
    name                       = "alpine"
    path                       = "./k8s/alpine"
    garbage_collection_enabled = true
    recreating_enabled         = true
    sync_interval_in_seconds   = 60
  }

  kustomizations {
    name                       = "proget"
    path                       = "./k8s/proget"
    garbage_collection_enabled = true
    recreating_enabled         = true
    sync_interval_in_seconds   = 60
  }

  depends_on = [
    resource.azurerm_kubernetes_cluster_extension.flux,
    resource.azurerm_mssql_server.this,
    ]
}
