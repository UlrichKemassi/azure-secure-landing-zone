# =====================================
# RECOVERY SERVICES VAULT
# =====================================

resource "azurerm_recovery_services_vault" "backup_vault" {

  name = "rsv-secure-landing-zone"

  location = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

  sku = "Standard"

  storage_mode_type = "LocallyRedundant"

}

# =====================================
# BACKUP POLICY
# =====================================

resource "azurerm_backup_policy_vm" "daily_backup" {

  name = "daily-backup-policy"

  resource_group_name = azurerm_resource_group.rg.name

  recovery_vault_name = azurerm_recovery_services_vault.backup_vault.name

  timezone = "Eastern Standard Time"

  backup {

    frequency = "Daily"

    time = "23:00"

  }

  retention_daily {

    count = 30

  }

}

resource "azurerm_backup_protected_vm" "app_vm_backup" {

  resource_group_name = azurerm_resource_group.rg.name

  recovery_vault_name = azurerm_recovery_services_vault.backup_vault.name

  source_vm_id = azurerm_linux_virtual_machine.app_vm.id

  backup_policy_id = azurerm_backup_policy_vm.daily_backup.id

}