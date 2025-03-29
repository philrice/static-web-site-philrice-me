terraform {
  required_version = ">= 1.7.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.17.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-lab-tfstate"
    storage_account_name = "labtfstate28798"
    container_name       = "labtfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_cli         = true
  subscription_id = "294d08d4-5eff-4a0b-83fd-c8d11ca62d39"
}

