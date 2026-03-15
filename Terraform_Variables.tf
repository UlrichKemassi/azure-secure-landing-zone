variable "resource_group_name" {
   description = "Name of the resource group"
   type        = string
   default     = "rg-secure-landing-zone"
}

variable "location" {
  description  = "Azure region"
  type         = string
  default      = "Canada Central"
}

variable "hub_vnet_name"  {
  description  = "Name of the hub virtual network"
  type         = string
  default      = "hub-vnet"
}

variable "hub_vnet_address_space" {
  description   = "Address space for the hub vnet"
  type          = list(string)
  default       = ["10.0.0.0/16"]
}

variable "azure_bastion_subnet_cidr"  {
   description = "CIDR for Azure Bastion subnet"
   type        = string
  default      = "10.0.1.0/24"
}

variable "shared_services_subnet_cidr"  {
  description = "CIDR for shared services subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "production_spoke_vnet_name"  {
  description  = "Name of the production spoke virtual network"
  type         = string
  default      = "production-spoke-vnet"
}

variable "production_spoke_vnet_address_space" {
  description   = "Address space for the production spoke vnet"
  type          = list(string)
  default       = ["10.1.0.0/16"]
}

variable "app_subnet_cidr"  {
   description = "CIDR for app subnet"
   type        = string
  default      = "10.1.1.0/24"
}

variable "data_subnet_cidr"  {
  description = "CIDR for data subnet"
  type        = string
  default     = "10.1.2.0/24"
}

variable "management_spoke_vnet_name"  {
  description  = "Name of the management spoke virtual network"
  type         = string
  default      = "management-spoke-vnet"
}

variable "management_spoke_vnet_address_space" {
  description   = "Address space for the management spoke vnet"
  type          = list(string)
  default       = ["10.2.0.0/16"]
}

variable "admin_subnet_cidr" {
   description = "CIDR for Admin subnet"
   type        = string
  default      = "10.2.1.0/24"
}
