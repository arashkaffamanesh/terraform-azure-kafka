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

resource "azurerm_availability_set" "zookeeper" {
  location            = "${local.location}"
  name                = "zookeeper"
  resource_group_name = "${azurerm_resource_group.kafka.name}"
}

resource "azurerm_network_interface" "zookeeper" {
  count               = "${var.quorum_count}"
  name                = "${format("zookeeper-%03d-nic", count.index+1)}"
  location            = "${local.location}"
  resource_group_name = "${azurerm_resource_group.kafka.name}"

  ip_configuration {
    name                          = "zookeeper-ip-config"
    subnet_id                     = "${azurerm_subnet.kafka.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${cidrhost(local.subnet_address_prefix, count.index+11)}"
  }
}

resource "azurerm_virtual_machine" "zookeeper" {
  count                 = "${var.quorum_count}"
  name                  = "${format("zookeeper-%03d-vm", count.index+1)}"
  location              = "${local.location}"
  resource_group_name   = "${azurerm_resource_group.kafka.name}"
  network_interface_ids = ["${element(azurerm_network_interface.zookeeper.*.id, count.index)}"]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
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
      key_data = "${file("${var.ssh_key}")}"
    }
  }

  tags {
    class = "zookeeper"
  }
}
