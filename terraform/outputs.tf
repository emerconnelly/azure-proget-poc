output "csi_secret_store_identity" {
  value = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity
  description = "The identity used for the Secret Store CSI driver for Azure Key Vault."

  sensitive = true
}

output "kubeconfig" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  description = "Kubeconfig for AKS cluster"

  sensitive = true
}

output "sql_connection_string" {
  value       = "Server=tcp:${azurerm_mssql_server.this.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.this.name};Persist Security Info=False;User ID=${azurerm_mssql_server.this.administrator_login};Password=${azurerm_mssql_server.this.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  description = "Connection string for the Azure SQL Database created."

  sensitive = true
}
