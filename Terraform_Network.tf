resource "azurerm_virtual_network" "hub_vnet" {
   name                  = var.hub_vnet_name
   location              = azurerm_resource_group.rg.location
   resource_group_name   = azure_resource_group.rg.name
   address_space         = var.hub_vnet_address_space
}

resource "azurerm_subnet" "azure_bastion_subnet" {
    name                    = "AzureBastionSubnet"
    resource_group_name     = azurerm_resource_group.rg.name
    virtual_network_name    = azurerm_virtual_network.hub_vnet.name
    address_prefixes        = [var.azure_bastion_subnet_cidr]
}

resource "azurerm_suubnet" "shared_services_subnet" {
  name                 = "sharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.shared_services_subnet-cidr]
}
