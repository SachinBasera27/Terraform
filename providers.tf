terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.80.0"
    }
  }
}

provider "azurerm" {
  features {
    virtual_machine {
      detach_implicit_data_disk_on_deletion = false
      delete_os_disk_on_deletion            = true
      skip_shutdown_and_force_delete        = false
    }

  }
  use_oidc = true
}