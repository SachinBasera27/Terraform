module "resource" {
  source = "./resource"
}

module "networking" {
  source              = "./networking"
  location            = module.resource.location
  resource_group_name = module.resource.name
}

module "storage" {
  source              = "./storage"
  location            = module.resource.location
  resource_group_name = module.resource.name
}

resource "azurerm_windows_virtual_machine" "vm-terraform" {
  name                = "sachin-vm"
  resource_group_name = module.resource.name
  location            = module.resource.location
  size                = "Standard_D4_v5"
  admin_username      = "adminuser"
  admin_password      = "Saz@2701"
  network_interface_ids = [
    module.networking.nic_id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-25h2-pro"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "dda-tf" {
  managed_disk_id    = module.storage.dataDisk
  virtual_machine_id = azurerm_windows_virtual_machine.vm-terraform.id
  lun                = "10"
  caching            = "ReadWrite"
}