[![Terraform Apply](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/terraform-apply.yml/badge.svg?branch=main)](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/terraform-apply.yml)

# aks-proget-poc

## Terraform service principal requirements
- Terraform Cloud environment variables
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`
- GitHub environment variables
  - `AZURE_CREDENTIALS`
  - `TF_API_TOKEN`
- Azure RBAC roles for the Terraform executor identity
  - Contributor (scope = subscription)
  - Role Based Access Administrator (scope = subscription)
