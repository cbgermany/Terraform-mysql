output "mysql_server" {
  description = "A Map of the mysql server resource"
  value       = azurerm_mysql_server.database
}

output "mysql_database" {
  description = "A Map of the mysql database resource"
  value       = azurerm_mysql_database.database
}

