terraform {
  backend "azurerm" {
    use_oidc             = true                                   # Can also be set via `ARM_USE_OIDC` environment variable.
    use_azuread_auth     = true                                   # Can also be set via `ARM_USE_AZUREAD` environment variable.
    storage_account_name = "stacctf"                            
    container_name       = "tf-prod"                              
    key                  = "terraform.tfstate"                                     
  }
}