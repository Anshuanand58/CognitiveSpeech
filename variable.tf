variable "resource_group_name" {
  type = string
  default = ""
}

variable "location" {
  type = string
  default = ""
}

variable "account_name" {
  type = string
  default = ""
}

variable "kind" {
  type = string
  default = ""
}

variable "sku_name" {
  type = string
  default = ""
}


variable "tags" {
 type = map(string) 
}

variable "record_name" {
  type = string
  default = ""
}

variable "account_replication_type" {
  type = string
  default = ""
}

variable "account_tier" {
  type = string
  default = ""
}

variable "subnet_name" {
  type = string
  default = ""
}

variable "vnet_name" {
  type = string
  default = ""
}

variable "enable_private_endpoint" {
  type = bool 
}

variable "public_network_access_enabled" {
  type = bool 
}

variable "private_service_connection_name" {
  type = string
  default = ""
}

variable "pvt_dns_zone_name" {
  type = string
  default = ""
}

variable "sub_resource_name" {
  type = list(string)
  default = [ "account" ]
}