data "azurerm_resource_group" "vnet" {
  name = "${var.vnet_resource_group_name}"
}

data "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_name}"
  resource_group_name = "${var.vnet_resource_group_name}"
}
