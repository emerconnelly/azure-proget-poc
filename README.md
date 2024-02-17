# aks-proget-poc

[![Terraform Apply](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/deploy.yml/badge.svg?branch=main)](https://github.com/emerconnelly/aks-proget-poc/actions/workflows/deploy.yml)

Automated deployment of a public ProGet instance on AKS & Azure SQL using GitHub Actions, Terraform Cloud, & Secrets Store CSI Driver.

``` Terraform
terraform {
  required_version = ">= 1.6.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.84"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = false
  use_cli                    = false
}
```


## how to use

- Fork this repository and configure the requirements below.
- This creates two new resource groups in the provided subscription.
  - one for:
    - VNet
    - key vault
    - SQL server & database
    - storage account & containers
    - AKS cluster
  - another for the AKS managed resources
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
