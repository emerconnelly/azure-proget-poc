[![Terraform Apply](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/terraform-apply.yml/badge.svg?branch=main)](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/terraform-apply.yml)

# aks-proget-poc
Fully automated provisioning of a publicly available ProGet instance on a single-node AKS cluster & Azure SQL database using GitHub Actions, Terraform Cloud, & Secrets Store CSI Driver.

### how to use

#### environment variables

##### Terraform Cloud
- `ARM_CLIENT_ID`
- `ARM_CLIENT_SECRET`
- `ARM_SUBSCRIPTION_ID`
- `ARM_TENANT_ID`

##### GitHub secrets
- `AZURE_CREDENTIALS`
- `TF_API_TOKEN`

#### Azure service principal for Terraform AzureRM
- Azure RBAC roles
  - Contributor (scope = subscription)
  - Role Based Access Administrator (scope = subscription)
