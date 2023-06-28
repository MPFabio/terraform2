variable "resource_group_name" {}
variable "location" {}
variable "vnet_id" {}

resource "azurerm_network_security_group" "example" {
  name                = "my-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-vnet-flows"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.vnet_id
    destination_address_prefix = var.vnet_id
  }

  security_rule {
    name                       = "allow-ssh"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "YOUR_PUBLIC_IP_ADDRESS"
    destination_address_prefix = var.vnet_id
  }
}

output "nsg_id" {
  value = azurerm_network_security_group.example.id
}
