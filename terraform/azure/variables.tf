variable "name" {
  type    = "string"
  default = "kafka"
}

variable "quorum_count" {
  type    = "string"
  default = "3"
}

variable "subnet_id" {
  type    = "string"
  default = "69"
}

variable "ssh_key" {}
variable "vnet_resource_group_name" {}
variable "vnet_name" {}
