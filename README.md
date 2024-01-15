[![Terraform Apply](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/deploy.yml/badge.svg?branch=main)](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/deploy.yml)

# aks-proget-poc
Automated deployment of a public ProGet instance on AKS & Azure SQL using GitHub Actions, Terraform Cloud, & Secrets Store CSI Driver.

## how to use

- Fork this repository and configure the requirements below.
- This creates two new resource groups in the provided subscription, containing all the resources.
  - one for the
    - VNet
    - key vault
    - SQL server & database
    - storage account & containers
    - AKS cluster
  - one for the AKS managed resources
- Once deployed, access ProGet by locating the ingress public IP in the new resource group.

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
