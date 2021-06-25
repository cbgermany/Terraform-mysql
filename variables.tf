# This defines the list of variables used by this module

variable "resource_group" {
  description = "The resource group associated with the database"
  default     = "mysqlRG"
}

variable "location" {
  description = "The Region/Location where the Database should be created"
  default     = "UK South"
}

variable "mysql_server_name" {
  description = "The name of the MySql server that will be running the databases"
  type        = string
}

variable "create_mode" {
  description = "Specify whether this database is being created or used for a replica database"
  type        = string
  default     = "Create"
}

variable "creation_source_server_id" {
  description = "When setting up a MySql replica or restoring from a backup specify the source id"
  type        = string
  default     = ""
}

variable "administrator_login" {
  description = "The name of the admin user to access the MySql server"
  type        = string
  default     = "unixadmin"
}

variable "administrator_login_password" {
  description = "The password for the MySql admin user"
  type        = string
}

variable "sku_name" {
  description = <<DESCRIPTION
    Defins the pricing tier and size of the VM provisioned for the MySql database.
    For more details see https://docs.microsoft.com/en-us/azure/mysql/concepts-pricing-tiers
    The default selected will be Basic Gen5 with 2 Virtual cores.  Note for Geo Redundancy options
    a General Purpose sku will be required such as G_Gen5_2.
DESCRIPTION
  type        = string
  default     = "B_Gen5_2"
}

variable "storage_mb" {
  description = "The initial size of the database in MB, the defailt will be 5GB"
  type        = number
  default     = 5102
}

variable "mysql_version" {
  description = "The version of the MySQL database i.e. 5.7 or 8.0"
  type       = string
  default    = "5.7"
}

variable "auto_grow_enabled" {
  description = "Flag to state whether the database should be allowed to autoextend, default is true"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "The number of days to retain the backup between 7 and 35 days"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = <<DESCRIPTION
  Turn Geo-redundant server backups on/off. 
  This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and 
  Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within 
  the region in which your server is hosted, but are also replicated to a paired data center. This provides better 
  protection and ability to restore your server in a different region in the event of a disaster. 
  This is not supported for the Basic tier.  Default to false
DESCRIPTION
  type        = bool
  default     = false
}

variable "database_name" {
  description = "The name of the database for the MySql database"
  type        = string
}

variable "common_tags" {
  description = "A Map of common tags to assign to the network security group"
  type        = map(string)
}


