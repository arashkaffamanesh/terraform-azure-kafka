locals {
  subnet_address_prefix = "${data.azurerm_subnet.kafka.address_prefix}"
  location              = "${data.azurerm_resource_group.vnet.location}"
  resource_group_name   = "${data.azurerm_resource_group.kafka.name}"

  zookeeper_quorum = "${var.zookeeper_quorum}"
  ssh_pub_key_file = "${var.ssh_pub_key_file}"

  vnet_resource_group_name = "${var.vnet_resource_group_name}"
  vnet_name                = "${var.vnet_name}"
  image_name               = "${var.image_name}"
  name                     = "${var.name}"
  image_resource_group = "${var.image_resource_group}"

  image_id = "${data.azurerm_image.kafka.id}"
}
