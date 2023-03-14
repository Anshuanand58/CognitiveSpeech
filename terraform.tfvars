resource_group_name             = "demorg"
location                        = "Central india"
account_name                    = "exampleaccount"
kind                            = "SpeechServices"
sku_name                        = "S0"
record_name                     = "record"
account_tier                    = "Standard"
account_replication_type        = "LRS"
subnet_name                     = "default"
vnet_name                       = "demovnet"
enable_private_endpoint         = true
public_network_access_enabled   = true
private_service_connection_name = "example-connection"
pvt_dns_zone_name               = "testdns.com"
sub_resource_name               = [ "account" ]
tags = {
  Terraform = "1"
}
