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
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = var.ssl_enforcement_enabled ? "TLS1_2" : null

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

##################################
# Create the mysql virtual network rull for the frontend subnet
##################################

resource "azurerm_mysql_virtual_network_rule" "database" {
  name                = "frontend-mysql-vnet-rule"
  resource_group_name = azurerm_resource_group.database.name
  server_name         = azurerm_mysql_server.database.name
  subnet_id           = var.subnet_id
}

