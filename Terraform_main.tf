terraform {

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }

  }

}

provider "azurerm" {

  features {}

}

provider "azapi" {}

resource "azurerm_resource_group" "rg" {

  name     = var.resource_group_name
  location = var.location

}