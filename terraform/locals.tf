locals {
  sql_connection_string = "Server=tcp:${azurerm_mssql_server.this.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.this.name};Persist Security Info=False;User ID=${azurerm_mssql_server.this.administrator_login};Password=${azurerm_mssql_server.this.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}
