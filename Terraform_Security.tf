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

resource "azurerm_network_security_group" "production_data_nsg" {
  name                = "production-data-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Hub NSG rule
resource "azurerm_network_security_rule" "allow_spokes_to_shared_services" {
  name                   = "AllowHttpsFromSpokesToSharedServices"
  priority               = 100
  direction              = "Inbound"
  access                 = "Allow"
  protocol               = "Tcp"
  source_port_range      = "*"
  destination_port_range = "443" # Https

  source_address_prefixes = [
    "10.1.0.0/16", # Production Spoke Vnet
    "10.2.0.0/16"  # Management Spoke Vnet
  ]

  destination_address_prefix = "10.0.2.0/24"

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.hub_nsg.name
}

# Management NSG rule
resource "azurerm_network_security_rule" "allow_management_traffic" {
  name              = "AllowTcpPortsFromSharedServicesSubnetToManagement"
  priority          = 100
  direction         = "Inbound"
  access            = "Allow"
  protocol          = "Tcp"
  source_port_range = "*"

  destination_port_ranges = [
    "3389", # RDP
    "22",   # SSH
    "443",  # HTTPS
    "5986"  # WinRM HTTPS
  ]

  source_address_prefix = "10.0.2.0/24" # shared_services_subnet

  destination_address_prefix  = "10.2.1.0/24"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.management_nsg.name
}

# AppSubnet Production NSG Rules
resource "azurerm_network_security_rule" "allow_vnet_inbound_production" {
  name                   = "AllowHttpsFromHubVnetToAppSubnet"
  priority               = 100
  direction              = "Inbound"
  access                 = "Allow"
  protocol               = "Tcp"
  source_port_range      = "*"
  destination_port_range = "443" # HTTPS

  source_address_prefix = "10.0.2.0/24" # shared_services_subnet

  destination_address_prefix  = "10.1.1.0/24" # app_subnet
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.production_nsg.name
}

# Data Subnet Production
resource "azurerm_network_security_rule" "allow_app_to_data_sql" {

  name      = "AllowSqlFromAppSubnet"
  priority  = 100
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "3306" # MySQL

  source_address_prefix      = "10.1.1.0/24" # AppSubnet
  destination_address_prefix = "10.1.2.0/24" # DataSubnet

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.production_data_nsg.name
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
  network_security_group_id = azurerm_network_security_group.production_data_nsg.id
}


# Associate Management NSG with Admin Subnet

resource "azurerm_subnet_network_security_group_association" "admin_subnet_nsg" {
  subnet_id                 = azurerm_subnet.admin_subnet.id
  network_security_group_id = azurerm_network_security_group.management_nsg.id
}




