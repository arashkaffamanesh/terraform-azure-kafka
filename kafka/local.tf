locals {
  subnet_address_prefix = "${data.azurerm_subnet.kafka.address_prefix}"
  location              = "${data.azurerm_resource_group.vnet.location}"
  resource_group        = "${data.azurerm_resource_group.kafka.name}"

  zookeeper_quorum = "${var.zookeeper_quorum}"
  ssh_pub_key_file = "${var.ssh_pub_key_file}"

  vnet_resource_group  = "${var.vnet_resource_group}"
  vnet_name            = "${var.vnet_name}"
  image_name           = "${var.image_name}"
  image_resource_group = "${var.image_resource_group}"
  name                 = "${var.name}"

  image_id = "${data.azurerm_image.kafka.id}"
}
