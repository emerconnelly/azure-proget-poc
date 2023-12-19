terraform {
  required_version = ">= 1.6.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.84"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"

  features {}
}
