# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
    features{}  
}

resource "azurerm_resource_group" "tf_rg" {
  name     = "tfmainrg"
  location = "westeurope"
}

resource "azurerm_container_group" "tf_cg" {
    name                        = "weatherapi"
    location                    = azurerm_resource_group.tf_rg.location
    resource_group_name         = azurerm_resource_group.tf_rg.name  

    ip_address_type             = "Public"
    dns_name_label              = "mgokwe"
    os_type                     = "Linux"

    container {
      name                      = "weatherapi"
      image                     = "mgok5/weatherapi"
      cpu                       = "1"
      memory                    = "1"

      ports {
        port                    = 80
        protocol                = "TCP"
      }
    }
}