locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "elena.martischuk"
    ExpirationDate = "2026-03-13"
    Environment    = "Learning"
  }
}

# PostgreSQL Flexible Server (Single Server retired 2025-03-28)
resource "azurerm_postgresql_flexible_server" "db" {
  name                          = var.db_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "16"
  sku_name                      = "B_Standard_B1ms"
  storage_mb                    = 32768
  storage_tier                  = "P4"
  administrator_login           = var.db_admin_username
  administrator_password        = var.db_admin_password
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  public_network_access_enabled = true
  lifecycle {
    ignore_changes = [
      zone,
      high_availability.0.standby_availability_zone
    ]
  }

  tags                          = local.tags
}
