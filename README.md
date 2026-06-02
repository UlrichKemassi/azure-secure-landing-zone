# Azure Secure Landing Zone – Terraform Deployment

## Overview

This project demonstrates the deployment of a secure Azure landing zone using Terraform with a focus on networking, security, monitoring, backup, and Infrastructure as Code best practices.

The environment was designed around Azure administration concepts commonly covered in AZ-104 while integrating security-focused architecture and monitoring components.


## Project Objectives

* Build a secure Azure landing zone using Infrastructure as Code
* Implement hub-and-spoke networking architecture
* Apply network segmentation and security controls
* Enable centralized monitoring and diagnostics
* Configure backup and recovery services
* Demonstrate Terraform deployment and lifecycle management


## Architecture

This project uses a Hub-and-Spoke architecture:

Hub VNet:

* Shared services
* Azure Bastion
* Network management components

Management Spoke:

* Administrative workloads
* Monitoring integration

Production Spoke:

* Application subnet
* Data subnet
* Segmented network security controls

Architecture documentation and diagrams are available in:
docs/

## Technologies Used

### Azure Services

* Azure Virtual Network
* Azure Bastion
* Azure Network Watcher
* Azure Monitor
* Log Analytics Workspace
* Recovery Services Vault
* Storage Account
* Linux Virtual Machine
* NSGs
* Virtual Network Peering

### Terraform Providers

* AzureRM Provider
* AzAPI Provider
  

## Security Features

* Hub-and-Spoke network segmentation
* Network Security Groups
* Bastion access model
* Private endpoint network policy configuration
* Centralized monitoring
* Backup strategy for workloads
* Log collection and diagnostics


## Monitoring and Logging

Monitoring components implemented:

* Azure Monitor Diagnostic Settings
* Log Analytics Workspace integration
* Storage diagnostics
* Bastion diagnostics
* Virtual Network Flow Logs

### Monitoring Modernization

Azure deprecated NSG Flow Logs during project development.

To modernize the architecture:

* Deprecated NSG Flow Logs were removed
* Virtual Network Flow Logs were implemented
* Monitoring was migrated using AzAPI resources
* Logging integration was preserved

This migration improved compatibility with newer Azure networking monitoring approaches.


## Project Structure

Terraform_main.tf
Terraform_Network.tf
Terraform_Security.tf
Terraform_VM.tf
Terraform_Monitoring.tf
Terraform_Backup.tf
Terraform_Storage.tf
Terraform_Bastion.tf
Terraform_Logging.tf
Terraform_Variables.tf
Terraform_Peering.tf
docs/


## Deployment Steps

Initialize:
terraform init

Validate:
terraform validate

Review:
terraform plan

Deploy:
terraform apply


## Screenshots

Example screenshots available in:

```text
docs/
```

Recommended screenshots:

* Resource Group deployment
* Network topology
* Terraform deployment
* Virtual Networks
* Monitoring configuration

---

## Skills Demonstrated

* Azure Administration (AZ-104)
* Terraform Infrastructure as Code
* Azure Networking
* Monitoring and Logging
* Cloud Security
* Backup and Recovery
* Troubleshooting and Modernization
* Git and GitHub workflows

---

## Author

Created by Ulrich Kemassi






# azure-secure-landing-zone with Terraform
## Project Description



## Architecture diagram
![Architecture Diagram](docs/Diagram.png)
![Architecture Diagram](docs/RG.png)
![Architecture Diagram](docs/Terraform.png)
![Architecture Diagram](docs/VM.png)
![Architecture Diagram](docs/VN.png)



## Author

Ulrich Kemassi
Cloud & Cybersecurity Enthusiast
