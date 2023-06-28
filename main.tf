provider "azurerm" {
  features {}
}

variable "location" {
  default = "francecentral"
}

resource "azurerm_resource_group" "example" {
  name     = "terraform-tp"
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  vnet_cidr           = "10.0.0.0/16"
  subnet_cidr         = "10.0.0.0/24"
}

module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  vnet_id             = module.vnet.vnet_id
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  vnet_subnet_id      = module.vnet.subnet_id
  nsg_id              = module.nsg.nsg_id
  vm_count            = 3
  vm_size             = "Standard_D2ds_v4"
  vm_image            = "Canonical:UbuntuServer:22.04-LTS:latest"
}
