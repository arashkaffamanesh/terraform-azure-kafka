data "azurerm_resource_group" "vnet" {
  name = "${local.vnet_resource_group_name}"
}

data "azurerm_image" "kafka" {
  name_regex          = "${local.image_name}"
  resource_group_name = "${local.name}"
  sort_descending     = "1"
}

data "azurerm_subnet" "kafka" {
  name                 = "${local.name}"
  virtual_network_name = "${local.vnet_name}"
  resource_group_name  = "${local.vnet_resource_group_name}"
}

data "azurerm_resource_group" "kafka" {
  name = "${local.name}"
}