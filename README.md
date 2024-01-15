[![Terraform Apply](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/terraform-apply.yml/badge.svg?branch=main)](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/terraform-apply.yml)

# aks-proget-poc
Automated deployment of a public ProGet instance on AKS & Azure SQL using GitHub Actions, Terraform Cloud, & Secrets Store CSI Driver.

## how to use

### environment variables

- GitHub secrets
  - `AZURE_CREDENTIALS` ([see here](https://github.com/marketplace/actions/azure-login#login-with-a-service-principal-secret))
  - `TF_API_TOKEN`
- Terraform Cloud
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`

### Azure Service Principal  for Terraform AzureRM
- Contributor (scope subscription)
- Role Based Access Administrator (scope subscription)
