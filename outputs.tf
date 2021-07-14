output "mysql_server" {
  description = "A Map of the mysql server resource"
  value       = azurerm_mysql_server.database
}

output "mysql_database" {
  description = "A Map of the mysql database resource"
  value       = azurerm_mysql_database.database
}

output "mysql_server_name" {
  description = "The name of the mysql server"
  value       = azurerm_mysql_server.database.name
}

output "mysql_database_name" {
  description = "A name of the mysql database"
  value       = azurerm_mysql_database.database.name
}


