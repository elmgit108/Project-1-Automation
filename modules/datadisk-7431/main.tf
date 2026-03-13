locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "elena.martischuk"
    ExpirationDate = "2026-03-13"
    Environment    = "Learning"
  }
}

# Managed disks for Linux VMs (for_each using linux_vm_ids map)
resource "azurerm_managed_disk" "linux_disk" {
  for_each             = var.linux_vm_ids
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
  tags                 = local.tags
}

# Attach data disks to Linux VMs
resource "azurerm_virtual_machine_data_disk_attachment" "linux_attach" {
  for_each           = var.linux_vm_ids
  managed_disk_id    = azurerm_managed_disk.linux_disk[each.key].id
  virtual_machine_id = each.value
  lun                = 0
  caching            = "ReadWrite"
}

# Managed disks for Windows VMs (count)
resource "azurerm_managed_disk" "win_disk" {
  count                = length(var.windows_vm_ids)
  name                 = "7431-win-vm-${count.index + 1}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
  tags                 = local.tags
}

# Attach data disks to Windows VMs
resource "azurerm_virtual_machine_data_disk_attachment" "win_attach" {
  count              = length(var.windows_vm_ids)
  managed_disk_id    = azurerm_managed_disk.win_disk[count.index].id
  virtual_machine_id = var.windows_vm_ids[count.index]
  lun                = 0
  caching            = "ReadWrite"
}
