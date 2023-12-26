output "csi_secret_store_secret_identity" {
  value = resource.azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity
  description = "The identity used for the Secret Store CSI driver for Azure Key Vault."

  # sensitive = true
}

output "kubeconfig" {
  value       = resource.azurerm_kubernetes_cluster.aks.kube_config_raw
  description = "Kubeconfig for AKS cluster"

  sensitive = true
}

output "sql_connection_string" {
  value       = "Server=tcp:${resource.azurerm_mssql_server.this.fully_qualified_domain_name},1433;Initial Catalog=${resource.azurerm_mssql_database.this.name};Persist Security Info=False;User ID=${resource.azurerm_mssql_server.this.administrator_login};Password=${resource.azurerm_mssql_server.this.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  description = "Connection string for the Azure SQL Database created."

  sensitive = true
}
