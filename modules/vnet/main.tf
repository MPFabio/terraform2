variable "resource_group_name" {}
variable "location" {}
variable "vnet_cidr" {}
variable "subnet_cidr" {}

resource "azurerm_virtual_network" "example" {
  name                = "my-vnet"
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "example" {
  name                 = "my-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.subnet_cidr]
}

output "vnet_id" {
  value = azurerm_virtual_network.example.id
}

output "subnet_id" {
  value = azurerm_subnet.example.id
}
