resource "azurerm_storage_account" "landingzone_storage" {

  name                = var.storage_account_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  access_tier = "Hot"

  public_network_access_enabled = true

  allow_nested_items_to_be_public = false

  min_tls_version = "TLS1_2"

}

resource "azurerm_storage_container" "logs_container" {

  name                 = "logs"
  storage_account_name = azurerm_storage_account.landingzone_storage.name

  container_access_type = "private"

}