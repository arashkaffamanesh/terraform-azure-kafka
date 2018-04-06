locals {
  vnet_address_space    = "${data.azurerm_virtual_network.vnet.address_spaces[0]}"
  subnet_address_prefix = "${cidrsubnet(local.vnet_address_space, 8, var.subnet_id)}"
  location              = "${data.azurerm_resource_group.vnet.location}"
}

resource "azurerm_resource_group" "kafka" {
  name     = "${var.name}"
  location = "${local.location}"
}

resource "azurerm_subnet" "kafka" {
  name                 = "${var.name}"
  resource_group_name  = "${var.vnet_resource_group_name}"
  virtual_network_name = "${var.vnet_name}"
  address_prefix       = "${local.subnet_address_prefix}"
}
