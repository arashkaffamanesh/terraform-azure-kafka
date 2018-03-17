output "vnet_id" {
  value = "${data.azurerm_virtual_network.vnet.name}"
}

output "vnet_address_spaces" {
  value = "${data.azurerm_virtual_network.vnet.address_spaces}"
}

output "vnet_dns_servers" {
  value = "${data.azurerm_virtual_network.vnet.dns_servers}"
}

output "vnet_subnets" {
  value = "${data.azurerm_virtual_network.vnet.subnets}"
}

output "vnet_peerings" {
  value = "${data.azurerm_virtual_network.vnet.vnet_peerings}"
}

output "resource_group_location" {
  value = "${data.azurerm_resource_group.vnet.location}"
}

output "resource_group_tags" {
  value = "${data.azurerm_resource_group.vnet.tags}"
}
