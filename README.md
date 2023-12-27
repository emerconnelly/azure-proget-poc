# azure-proget-poc

## Terraform service principal requirements
- Terraform Cloud environment variables
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`
- Azure RBAC roles
  - scope: subscription
    - Contributor
    - Role Based Access Administrator