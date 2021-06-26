# INTRODUCTION

This is a Terraform module to create an Azure MySql server and database.  The module will create new a resource_group for the server and database.

The following options are enforced by this module and not configurable.

- The database will not be publicly assessible
- Connections to the database will only be allowed using TLS 1.2

## Objectives

The module will create the initial resource group and networking for the following:

* Database resource group
* Create MySQL server for the database
* Create the MySql database
* Create Firewall policy

## Usage

```hcl
module "mysql" {
    source   = "../modules/Terraform-mysql"

    mysql_server_name = "database_server"
    location          = "UK south"
    resource_group    = "database_rsg"

    database_name     = 'database_name"

    administrator_login          = "useradmin"
    administrator_login_password = "password"

    sku_name      = "GP_Gen5_2"
    storage_mb    = 5120
    mysql_version = "5.7"

    auto_grow_enabled                 = true
    backup_retention_days             = 7
    geo_redundant_backup_enabled      = false
    infrastructure_encryption_enabled = true

}
```
In the example above the subnets will be called Sysman, FrontEnd and BackEnd, the GatewaySubnet will be used for the VPN gateway. 

## Parameters

* **mysql_server_name**: The name of the MySql server

* **location**: The Region/Location where the VNET will be created

* **resource_group**: The name of the VNET resource group

* **create_mode**: The mode to create the server, default will create a database

* **creation_source_server_id**: The Azure Resource ID for a source database if creating a replica

* **administrator_login**: The admin username for the database server

* **administrator_login_password**: The admin password for the Server

* **sku_name**: The size of the VM used for the database the default B_Gen5_2

* **storage_gb**: The initial size of the database specified in MB, the default is 5GB.

* **mysql_version**: The version of the MySql database, defaults to 5.7.  Set to either 5.7 or 8.0

* **auto_grow_enabled**: Defaults to false, set to tru if you want the database to grow automatically

* **backup_retention_days**: Defaults to 7, can be between 7 and 35

* **geo_redundant_backup_enabled**: Default to false, set to true for offsite backups.

* **database_name**: The name of the MySql database

* **common_tags**: The common tags applied to resources

## Outputs

The following outputs are generated when terraform is run.

* **mysql_server**: A Map of the MySql server 

* **mysql_database**: A Map of the MySql database 

## Author

Chris Germany
