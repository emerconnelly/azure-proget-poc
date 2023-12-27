output "csi_secret_store_identity" {
  value       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity
  description = "The identity used for the Secret Store CSI driver for Azure Key Vault."

  sensitive = true
}

output "kubeconfig" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  description = "Kubeconfig for AKS cluster"

  sensitive = true
}

output "sql_connection_string" {
  value       = local.sql_connection_string
  description = "Connection string for the Azure SQL Database created."

  sensitive = true
}
