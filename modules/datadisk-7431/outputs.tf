output "linux_disk_names" {
  value = [for d in azurerm_managed_disk.linux_disk : d.name]
}

output "windows_disk_names" {
  value = azurerm_managed_disk.win_disk[*].name
}
