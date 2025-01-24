terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.8.0"
    }
  }
}
 
provider "azurerm" {
  # Configuration options
  subscription_id = "cb4add54-6445-4f9b-8c83-5e0f26291f46"
  client_id       = "2e425913-713d-44bb-9d59-cd90084b23f1"
  client_secret   = "b168Q~P1taWGClFxXd564zV~RYtpactbcHizWdvD"
  tenant_id       = "58e4aae1-40e7-4149-a733-a22ddcd8f4f2"
  features {}
}
