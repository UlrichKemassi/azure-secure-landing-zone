# Create NSG and associate them with the subnet
# NSG containers
resource "azurerm_network_security_group" "hub_nsg" {
  name                = "hub-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "production_nsg" {
  name                = "production-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "management_nsg" {
  name                = "management-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Hub NSG rule
resource "azurerm_network_security_rule" "allow_spokes_to_shared_services" {
  name                        = "AllowSpokes"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"

  source_address_prefixes     = [
    "10.1.0.0/16",
    "10.2.0.0/16"
  ]

  destination_address_prefix  = "*"

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.hub_nsg.name
}

# Management NSG rule
resource "azurerm_network_security_rule" "allow_admin_access" {
  name                       = "AllowAdminAccess"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "*"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "*"
  resource_group_name        = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.management_nsg.name
}

# Complete Terraform code for subnet-NSG associations

# Associate Hub NSG with Shared Services Subnet

resource "azurerm_subnet_network_security_group_association" "shared_services_subnet_nsg" {
  subnet_id                 = azurerm_subnet.shared_services_subnet.id
  network_security_group_id = azurerm_network_security_group.hub_nsg.id
}


# Associate Production NSG with App Subnet

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.production_nsg.id
}


# Associate Production NSG with Data Subnet

resource "azurerm_subnet_network_security_group_association" "data_subnet_nsg" {
  subnet_id                 = azurerm_subnet.data_subnet.id
  network_security_group_id = azurerm_network_security_group.production_nsg.id
}


# Associate Management NSG with Admin Subnet

resource "azurerm_subnet_network_security_group_association" "admin_subnet_nsg" {
  subnet_id                 = azurerm_subnet.admin_subnet.id
  network_security_group_id = azurerm_network_security_group.management_nsg.id
}

# Complete Terraform code for Production NSG rules

# Allow internal Vnet traffic
resource "azurerm_network_security_rule" "allow_vnet_inbound_production" {
  name                        = "AllowVNetInbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.production_nsg.name
}

# Deny Internal inbound traffic
resource "azurerm_network_security_rule" "deny_internet_inbound_production" {
  name                        = "DenyInternetInbound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.production_nsg.name
}


