module "rgroup" {
  source = "./modules/rgroup-7431"

  rg_name  = "7431RG"
  location = "Canada Central"
}

module "network" {
  source = "./modules/network-7431"

  resource_group_name = module.rgroup.rg_name
  location            = module.rgroup.rg_location

  depends_on = [module.rgroup]
}

module "common" {
  source = "./modules/common-7431"

  resource_group_name = module.rgroup.rg_name
  location            = module.rgroup.rg_location

  depends_on = [module.rgroup]
}

module "vmlinux" {
  source = "./modules/vmlinux-7431"

  resource_group_name = module.rgroup.rg_name
  location            = module.rgroup.rg_location
  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_primary_blob_endpoint

  depends_on = [module.rgroup, module.network, module.common]
}

module "vmwindows" {
  source = "./modules/vmwindows-7431"

  resource_group_name = module.rgroup.rg_name
  location            = module.rgroup.rg_location
  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_primary_blob_endpoint

  depends_on = [module.rgroup, module.network, module.common]
}

module "datadisk" {
  source = "./modules/datadisk-7431"

  resource_group_name = module.rgroup.rg_name
  location            = module.rgroup.rg_location
  linux_vm_ids        = module.vmlinux.linux_vm_ids
  windows_vm_ids      = module.vmwindows.windows_vm_ids

  depends_on = [module.vmlinux, module.vmwindows]
}

module "loadbalancer" {
  source = "./modules/loadbalancer-7431"

  resource_group_name = module.rgroup.rg_name
  location            = module.rgroup.rg_location
  linux_nic_ids       = module.vmlinux.linux_nic_ids

  depends_on = [module.vmlinux]
}

module "database" {
  source = "./modules/database-7431"

  resource_group_name = module.rgroup.rg_name
  location            = module.rgroup.rg_location

  depends_on = [module.rgroup]
}
