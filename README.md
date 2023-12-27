# azure-proget-poc

## terraform service principal requirements
- terraform cloud environment variables
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`
- Azure RBAC roles
  - scope: subscription
    - Contributor
    - Role Based Access Administrator