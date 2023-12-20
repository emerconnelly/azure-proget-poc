output "kubeconfig" {
  value       = resource.azurerm_kubernetes_cluster.aks.kube_config_raw
  description = "Kubeconfig for AKS cluster"
}
