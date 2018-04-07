module "network" {
  source = "network"
  vnet   = "${var.vnet}"
}

module "zookeeper" {
  source         = "zookeeper"
  resource_group = "${module.network.resource_group}"
  subnet         = "${module.network.subnet}"
  ssh_public_key = "${var.ssh_public_key}"
  image          = "${var.image}"
}
