resource "azurerm_virtual_network" "hub_vnet" {
   name                  = var.hub_vnet_name
   location              = azurerm_resource_group.rg.location
   resource_group_name   = azurerm_resource_group.rg.name
   address_space         = var.hub_vnet_address_space
}

resource "azurerm_subnet" "azure_bastion_subnet" {
    name                    = "AzureBastionSubnet"
    resource_group_name     = azurerm_resource_group.rg.name
    virtual_network_name    = azurerm_virtual_network.hub_vnet.name
    address_prefixes        = [var.azure_bastion_subnet_cidr]
}

resource "azurerm_subnet" "shared_services_subnet" {
  name                 = "sharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.shared_services_subnet_cidr]
}

resource "azurerm_virtual_network" "production_spoke_vnet" {
   name                  = var.production_spoke_vnet_name
   location              = azurerm_resource_group.rg.location
   resource_group_name   = azurerm_resource_group.rg.name
   address_space         = var.production_spoke_vnet_address_space
}

resource "azurerm_subnet" "app_subnet" {
    name                    = "AppsSubnet"
    resource_group_name     = azurerm_resource_group.rg.name
    virtual_network_name    = azurerm_virtual_network.production_spoke_vnet.name
    address_prefixes        = [var.app_subnet_cidr]
}

resource "azurerm_subnet" "data_subnet" {
  name                 = "DataSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.production_spoke_vnet.name
  address_prefixes     = [var.data_subnet_cidr]
}

resource "azurerm_virtual_network" "management_spoke_vnet" {
   name                  = var.management_spoke_vnet_name
   location              = azurerm_resource_group.rg.location
   resource_group_name   = azurerm_resource_group.rg.name
   address_space         = var.management_spoke_vnet_address_space
}

resource "azurerm_subnet" "admin_subnet" {
    name                    = "AdminSubnet"
    resource_group_name     = azurerm_resource_group.rg.name
    virtual_network_name    = azurerm_virtual_network.management_spoke_vnet.name
    address_prefixes        = [var.admin_subnet_cidr]
}
