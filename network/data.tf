data "azurerm_resource_group" "vnet" {
  name = "${lookup(var.vnet, "resource_group")}"
}

data "azurerm_virtual_network" "vnet" {
  name                = "${lookup(var.vnet, "name")}"
  resource_group_name = "${lookup(var.vnet, "resource_group")}"
}
