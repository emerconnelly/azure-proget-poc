[![Terraform Apply](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/terraform-apply.yml/badge.svg?branch=main)](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/terraform-apply.yml)

# aks-proget-poc

## Terraform service principal requirements
- Terraform Cloud environment variables
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`
- Azure RBAC roles (scope: subscription)
  - Contributor
  - Role Based Access Administrator