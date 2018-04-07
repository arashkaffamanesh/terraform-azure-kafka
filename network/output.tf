output "resource_group" {
  description = "Kafka created resource group info"
  depends_on  = ["azurerm_resource_group.kafka"]

  value = {
    name     = "${azurerm_resource_group.kafka.name}"
    location = "${azurerm_resource_group.kafka.location}"
    tags     = "${azurerm_resource_group.kafka.tags}"
  }
}

output "subnet" {
  description = "Kafka created subnet info"
  depends_on  = ["azurerm_subnet.kafka"]

  value = {
    id             = "${azurerm_subnet.kafka.id}"
    address_prefix = "${azurerm_subnet.kafka.address_prefix}"
  }
}
