terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.39.1"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_cognitive_account" "cognitive" {
  name                          = var.account_name
  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  kind                          = var.kind
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
#   custom_subdomain_name         = "test.anshurohit5845.tk"
  tags                          = var.tags
}

data "azurerm_subnet" "infra" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
}

resource "azurerm_private_endpoint" "pep1" {
  count               = var.enable_private_endpoint == true ? 1 : 0
  name                = var.private_service_connection_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.infra.id

  private_dns_zone_group {
    name                 = var.pvt_dns_zone_name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.infra.id]
  }

  private_service_connection {
    name                           = var.private_service_connection_name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cognitive_account.cognitive.id
    subresource_names              = var.sub_resource_name
  }
  depends_on = [
    azurerm_cognitive_account.cognitive
  ]
}

data "azurerm_private_endpoint_connection" "private-ip1" {
  count               = var.enable_private_endpoint == true ? 1 : 0
  name                = var.private_service_connection_name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_private_endpoint.pep1]
}


data "azurerm_private_dns_zone" "infra" {
  name                = var.pvt_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_a_record" "arecord1" {
  count               = var.enable_private_endpoint == true ? 1 : 0
  name                = var.record_name
  zone_name           = data.azurerm_private_dns_zone.infra.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.private-ip1.0.private_service_connection.0.private_ip_address]
  depends_on = [
    azurerm_private_endpoint.pep1
  ]
}
