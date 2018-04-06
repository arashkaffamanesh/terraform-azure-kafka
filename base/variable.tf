variable "vnet_resource_group_name" {}
variable "vnet_name" {}
variable "subnet_id" {}
variable "name" {}

variable "vnet_gateway" {
  description = "(Required) Contains the IP address packets should be forwarded to, usually Bastion IP address"
}
