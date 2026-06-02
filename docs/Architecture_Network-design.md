# Azure Secure Landing Zone Architecture

## Network Topology

This project implements a Hub-and-Spoke architecture to centralize shared services, strengthen security boundaries, and isolate workloads across dedicated virtual networks.

### Hub Virtual Network

**Address Space:** `10.0.0.0/16`

**Subnets:**

* AzureBastionSubnet (`10.0.1.0/26`)
* SharedServicesSubnet (`10.0.2.0/24`) *(remove if not present in Terraform)*

**Hub Components:**

* Azure Bastion
* Network Security Groups
* VNet Flow Logs
* Centralized monitoring integration

---

### Production Spoke Virtual Network

**Address Space:** `10.1.0.0/16`

**Subnets:**

* AppSubnet (`10.1.1.0/24`)
* DataSubnet (`10.1.2.0/24`)

**Production Components:**

* Linux Virtual Machine workload
* Network segmentation controls
* VNet Flow Logs
* Monitoring integration

---

### Management Spoke Virtual Network

**Address Space:** `10.2.0.0/16`

**Subnets:**

* AdminSubnet (`10.2.1.0/24`)

**Management Components:**

* Administrative network segmentation
* Monitoring services
* Security controls

---

## Connectivity Model

Virtual network peering enables centralized communication and routing:

* Hub ↔ Production Spoke
* Hub ↔ Management Spoke

Direct spoke-to-spoke communication is intentionally avoided to improve segmentation and reduce attack paths.

---

## Security Controls

Security controls implemented in this landing zone include:

* Azure Bastion for secure administration
* Network Security Groups for segmentation and traffic control
* VNet Flow Logs for network visibility
* Centralized logging through Log Analytics Workspace
* Diagnostic settings configured for monitoring
* Infrastructure deployed using Terraform Infrastructure as Code (IaC)

---

## Monitoring Configuration

Monitoring and observability components include:

* Azure Monitor Diagnostic Settings
* Log Analytics Workspace integration
* VNet Flow Logs with retention policies
* Centralized monitoring architecture
* Network traffic visibility and troubleshooting capabilities

---

## Infrastructure Components

Core Azure resources deployed include:

* Resource Groups
* Hub-Spoke Virtual Networks
* Network Security Groups
* Azure Bastion
* Linux Virtual Machine
* Log Analytics Workspace
* Storage Account
* Recovery Services Vault
* Network Watcher
* VNet Flow Logs
* Virtual Network Peering



## Deployment Approach

Infrastructure deployment and management performed using:

* Terraform Infrastructure as Code
* AzureRM Provider
* AzAPI Provider (for VNet Flow Logs implementation)
* Modular Terraform file structure
* Git version control and GitHub repository management



## Design Objectives

This architecture was designed to provide:

* Centralized security management
* Segmented network architecture
* Improved monitoring visibility
* Secure administrative access
* Infrastructure automation
* Scalability for future workloads
