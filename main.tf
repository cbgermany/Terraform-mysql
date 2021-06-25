# Module Terraform VNET

################################
# Create the initial resource
################################

resource "azurerm_resource_group" "database" {
  name     = var.resource_group
  location = var.location

  tags = merge(
    var.common_tags,
    tomap(
      {"Component" = "Database"}
    )
  )
}

##################################
# Create the mysql server
##################################

resource "azurerm_mysql_server" "database" {
  name                = var.mysql_server_name
  location            = azurerm_resource_group.database.location
  resource_group_name = azurerm_resource_group.database.name

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  create_mode               = var.create_mode

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = var.mysql_version

  auto_grow_enabled                 = true
  backup_retention_days             = var.backup_retention_days
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"

  tags = merge(
    var.common_tags,
    tomap(
      {"Component" = "Database"}
    )
  )
}

##################################
# Create the mysql database
##################################

resource "azurerm_mysql_database" "database" {
  name                = var.database_name
  resource_group_name = azurerm_resource_group.database.name
  server_name         = azurerm_mysql_server.database.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
