resource "azurerm_availability_set" "zookeeper" {
  location            = "${local.location}"
  name                = "zookeeper"
  resource_group_name = "${local.resource_group_name}"
}

resource "azurerm_network_interface" "zookeeper" {
  count               = "${local.zookeeper_quorum}"
  name                = "${format("zookeeper-%03d-nic", count.index+1)}"
  location            = "${local.location}"
  resource_group_name = "${local.resource_group_name}"

  ip_configuration {
    name                          = "zookeeper-ip-config"
    subnet_id                     = "${data.azurerm_subnet.kafka.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${cidrhost(local.subnet_address_prefix, count.index+11)}"
  }
}

resource "azurerm_virtual_machine" "zookeeper" {
  count                 = "${local.zookeeper_quorum}"
  name                  = "${format("zookeeper-%03d-vm", count.index+1)}"
  location              = "${local.location}"
  resource_group_name   = "${local.resource_group_name}"
  network_interface_ids = ["${element(azurerm_network_interface.zookeeper.*.id, count.index)}"]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = "${local.image_id}"
  }

  storage_os_disk {
    name              = "${format("zookeeper-%03d-osdisk", count.index+1)}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${format("zookeeper-%03d", count.index+1)}"
    admin_username = "franz"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/franz/.ssh/authorized_keys"
      key_data = "${file("${local.ssh_pub_key_file}")}"
    }
  }

  tags {
    class = "zookeeper"
  }
}
