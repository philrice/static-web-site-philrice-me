


resource "azurerm_resource_group" "rg-sws" {
  name     = var.resource_group_name
  location = var.location
}

# Create Azure Static Web App using Azure Verfied Module
module "avm-res-web-staticsite" {
  source  = "Azure/avm-res-web-staticsite/azurerm"
  version = "0.4.1"
  location = var.location 
  name = var.name
  resource_group_name = azurerm_resource_group.rg-sws.name
}


resource "azurerm_static_web_app_custom_domain" "sws-domain" {
  static_web_app_id = module.avm-res-web-staticsite.resource_id
  domain_name       = "www.philrice.me"
  validation_type   = "cname-delegation"
}
