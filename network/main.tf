locals {
  vnet_resource_group = "${lookup(var.vnet, "resource_group")}"
  vnet_name           = "${lookup(var.vnet, "name")}"
  vnet_gateway        = "${lookup(var.vnet, "gateway_addr")}"
  vnet_address_space  = "${element(data.azurerm_virtual_network.vnet.address_spaces, 0)}"

  location = "${data.azurerm_resource_group.vnet.location}"
  name     = "${var.name}"

  subnet = "${cidrsubnet(local.vnet_address_space, 8, var.subnet_block_id)}"
}

resource "azurerm_resource_group" "kafka" {
  name     = "${local.name}"
  location = "${local.location}"
}

resource "azurerm_route_table" "kafka" {
  name                = "${local.name}-rt"
  location            = "${local.location}"
  resource_group_name = "${azurerm_resource_group.kafka.name}"

  route {
    name                   = "${local.name}-route"
    address_prefix         = "${local.subnet}"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${local.vnet_gateway}"
  }
}

resource "azurerm_network_security_group" "kafka" {
  name                = "${local.name}-nsg"
  location            = "${local.location}"
  resource_group_name = "${azurerm_resource_group.kafka.name}"
}

resource "azurerm_subnet" "kafka" {
  name                      = "${local.name}"
  resource_group_name       = "${local.vnet_resource_group}"
  virtual_network_name      = "${local.vnet_name}"
  address_prefix            = "${local.subnet}"
  route_table_id            = "${azurerm_route_table.kafka.id}"
  network_security_group_id = "${azurerm_network_security_group.kafka.id}"
}
