# =====================================
# NETWORK WATCHER
# =====================================

resource "azurerm_network_watcher" "nw" {

  name = "network-watcher"

  location = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

}

#######
# HUB VNET FLOW LOGS
#######

resource "azapi_resource" "hub_vnet_flow_logs" {

  type      = "Microsoft.Network/networkWatchers/flowLogs@2025-05-01"
  name      = "hub-vnet-flowlogs"
  parent_id = azurerm_network_watcher.nw.id

  location = azurerm_resource_group.rg.location

  schema_validation_enabled = false

  body = {

    properties = {

      enabled = true

      targetResourceId = azurerm_virtual_network.hub_vnet.id

      storageId = azurerm_storage_account.landingzone_storage.id

      format = {
        type    = "JSON"
        version = 2
      }

      retentionPolicy = {
        enabled = true
        days    = 30
      }

      flowAnalyticsConfiguration = {

        networkWatcherFlowAnalyticsConfiguration = {

          enabled = true

          workspaceId = azurerm_log_analytics_workspace.law.workspace_id

          workspaceRegion = azurerm_log_analytics_workspace.law.location

          workspaceResourceId = azurerm_log_analytics_workspace.law.id

          trafficAnalyticsInterval = 10

        }
      }
    }

  }

}

#######
# Management VNET FLOW LOGS
#######

resource "azapi_resource" "management_vnet_flow_logs" {

  type      = "Microsoft.Network/networkWatchers/flowLogs@2025-05-01"
  name      = "management-vnet-flowlogs"
  parent_id = azurerm_network_watcher.nw.id

  location = azurerm_resource_group.rg.location

  schema_validation_enabled = false

  body = {

    properties = {

      enabled = true

      targetResourceId = azurerm_virtual_network.management_spoke_vnet.id

      storageId = azurerm_storage_account.landingzone_storage.id

      format = {
        type    = "JSON"
        version = 2
      }

      retentionPolicy = {
        enabled = true
        days    = 30
      }

      flowAnalyticsConfiguration = {

        networkWatcherFlowAnalyticsConfiguration = {

          enabled = true

          workspaceId = azurerm_log_analytics_workspace.law.workspace_id

          workspaceRegion = azurerm_log_analytics_workspace.law.location

          workspaceResourceId = azurerm_log_analytics_workspace.law.id

          trafficAnalyticsInterval = 10

        }
      }
    }

  }

}

#######
# PRODUCTION VNET FLOW LOGS
#######


resource "azapi_resource" "production_vnet_flow_logs" {

  type      = "Microsoft.Network/networkWatchers/flowLogs@2025-05-01"
  name      = "production-vnet-flowlogs"
  parent_id = azurerm_network_watcher.nw.id

  location = azurerm_resource_group.rg.location

  schema_validation_enabled = false

  body = {

    properties = {

      enabled = true

      targetResourceId = azurerm_virtual_network.production_spoke_vnet.id

      storageId = azurerm_storage_account.landingzone_storage.id

      format = {
        type    = "JSON"
        version = 2
      }

      retentionPolicy = {
        enabled = true
        days    = 30
      }
    }

  }

}



/*

After running terraform apply I noticed that Azure deprecated NSG flow logs so 
I had to comment out all nsg flow logs and replace them with vnet flow logs
*/

# HUB NSG FLOW LOGS
# =====================================

/*
resource "azurerm_network_watcher_flow_log" "hub_nsg_flow_logs" {

  name = "hub-nsg-flow-logs"

  network_watcher_name = azurerm_network_watcher.nw.name

  resource_group_name = azurerm_resource_group.rg.name

  network_security_group_id = azurerm_network_security_group.hub_nsg.id

  storage_account_id = azurerm_storage_account.landingzone_storage.id

  enabled = true

  retention_policy {

    enabled = true
    days    = 30

  }

  traffic_analytics {

    enabled = true

    workspace_id = azurerm_log_analytics_workspace.law.workspace_id

    workspace_region = azurerm_log_analytics_workspace.law.location

    workspace_resource_id = azurerm_log_analytics_workspace.law.id

    interval_in_minutes = 10

  }
}
*/

# =====================================
# PRODUCTION APP NSG FLOW LOGS
# =====================================

/*
resource "azurerm_network_watcher_flow_log" "prod_nsg_flow_logs" {

  name = "prod_nsg_flow_logs"

  network_watcher_name = azurerm_network_watcher.nw.name

  resource_group_name = azurerm_resource_group.rg.name

  network_security_group_id = azurerm_network_security_group.production_nsg.id

  storage_account_id = azurerm_storage_account.landingzone_storage.id

  enabled = true

  retention_policy {

    enabled = true
    days    = 30

  }

  traffic_analytics {

    enabled = true

    workspace_id = azurerm_log_analytics_workspace.law.workspace_id

    workspace_region = azurerm_log_analytics_workspace.law.location

    workspace_resource_id = azurerm_log_analytics_workspace.law.id

    interval_in_minutes = 10

  }

}
*/

# =====================================
# PRODUCTION DATA NSG FLOW LOGS
# =====================================

/*
resource "azurerm_network_watcher_flow_log" "prod_data_flow_logs" {

  name = "prod_data_flow_logs"

  network_watcher_name = azurerm_network_watcher.nw.name

  resource_group_name = azurerm_resource_group.rg.name

  network_security_group_id = azurerm_network_security_group.production_data_nsg.id

  storage_account_id = azurerm_storage_account.landingzone_storage.id

  enabled = true

  retention_policy {

    enabled = true
    days    = 30

  }

  traffic_analytics {

    enabled = true

    workspace_id = azurerm_log_analytics_workspace.law.workspace_id

    workspace_region = azurerm_log_analytics_workspace.law.location

    workspace_resource_id = azurerm_log_analytics_workspace.law.id

    interval_in_minutes = 10

  }

}
*/

# =====================================
# MANAGEMENT NSG FLOW LOGS
# =====================================

/*
resource "azurerm_network_watcher_flow_log" "management_flow_logs" {

  name = "management_flow_logs"

  network_watcher_name = azurerm_network_watcher.nw.name

  resource_group_name = azurerm_resource_group.rg.name

  network_security_group_id = azurerm_network_security_group.management_nsg.id

  storage_account_id = azurerm_storage_account.landingzone_storage.id

  enabled = true

  retention_policy {

    enabled = true
    days    = 30

  }

  traffic_analytics {

    enabled = true

    workspace_id = azurerm_log_analytics_workspace.law.workspace_id

    workspace_region = azurerm_log_analytics_workspace.law.location

    workspace_resource_id = azurerm_log_analytics_workspace.law.id

    interval_in_minutes = 10

  }

}
*/

# Azure Bastion Diagnostics

resource "azurerm_monitor_diagnostic_setting" "bastion_diagnostics" {

  name = "bastion-diagnostics"

  target_resource_id = azurerm_bastion_host.bastion.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log {

    category = "BastionAuditLogs"

  }

  metric {

    category = "AllMetrics"
    enabled  = true

  }

}

# Storage Account Diagnostics

resource "azurerm_monitor_diagnostic_setting" "storage_diagnostics" {

  name = "storage-diagnostics"

  target_resource_id = "${azurerm_storage_account.landingzone_storage.id}/blobServices/default"

  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  metric {

    category = "Transaction"

  }

  metric {

    category = "Capacity"

  }

  enabled_log {

    category = "StorageRead"

  }

  enabled_log {

    category = "StorageWrite"

  }

  enabled_log {

    category = "StorageDelete"
  }

}

# NSG Diagnostics

resource "azurerm_monitor_diagnostic_setting" "management_nsg_diagnostics" {

  name = "management-nsg-diagnostics"

  target_resource_id = azurerm_network_security_group.management_nsg.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log {

    category = "NetworkSecurityGroupEvent"

  }

  enabled_log {

    category = "NetworkSecurityGroupRuleCounter"

  }

}

# Hub NSG Diagnostics

resource "azurerm_monitor_diagnostic_setting" "hub_nsg_diagnostics" {

  name = "hub-nsg-diagnostics"

  target_resource_id = azurerm_network_security_group.hub_nsg.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log {

    category = "NetworkSecurityGroupEvent"

  }

  enabled_log {

    category = "NetworkSecurityGroupRuleCounter"

  }

}

# Production App NSG Diagnostics

resource "azurerm_monitor_diagnostic_setting" "prod_nsg_diagnostics" {

  name = "production-nsg-diagnostics"

  target_resource_id = azurerm_network_security_group.production_nsg.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log {

    category = "NetworkSecurityGroupEvent"

  }

  enabled_log {

    category = "NetworkSecurityGroupRuleCounter"

  }

}

# Production Data NSG Diagnostics

resource "azurerm_monitor_diagnostic_setting" "prod_data_nsg_diagnostics" {

  name = "production-data-nsg-diagnostics"

  target_resource_id = azurerm_network_security_group.production_data_nsg.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log {

    category = "NetworkSecurityGroupEvent"

  }

  enabled_log {

    category = "NetworkSecurityGroupRuleCounter"

  }

}