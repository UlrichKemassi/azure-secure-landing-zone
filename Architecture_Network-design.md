# Azure Secure Landing Zone Architecture 
 
## Network Topology 
 
Hub-Spoke architecture is used to isolate workloads and centralize security services. 
 
### Hub VNet 
Address space: 10.0.0.0/16 
 
Subnets: 
- AzureBastionSubnet (10.0.1.0/24) 
- SharedServicesSubnet (10.0.2.0/24) 
 
### Production Spoke VNet 
Address space: 10.1.0.0/16 
 
Subnets: 
- AppSubnet (10.1.1.0/24) 
- DataSubnet (10.1.2.0/24) 
 
### Management Spoke VNet 
Address space: 10.2.0.0/16 
 
Subnets: 
- AdminSubnet (10.2.1.0/24) 
 
## Connectivity 
 
Hub is peered with both spokes. 
 
Hub <-> Production   
Hub <-> Management 
 
Spokes do not peer directly with each other. 
 
## Security Controls 
 
- No public IP addresses 
- Azure Bastion used for secure administration 
- Network Security Groups restrict traffic 
- Private endpoints used for PaaS services 
