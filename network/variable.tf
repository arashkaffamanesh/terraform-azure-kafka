variable "vnet" {
  description = "(Required) Vnet information where connect kafka subnet"
  type        = "map"

  default = {
    /* expected keys:
    resource_group -> Resource group name of virtual network where kafka subnet will be created. 
    name           -> Virtual network name where kafka subnet will be created.  
    gateway_addr   -> IP address packets should be forwarded to, usually bastion IP address. */
  }
}

variable "subnet_block_id" {
  description = "(Optional) Subnet id for kafka subnet, if subnet id is 69, and vnet cidr is 10.69.0.0/16, kafka subnet cidr will be 10.69.69.0/24"
  default     = "69"
}

variable "name" {
  description = "(Optionl) General name to be used azure components that will be created, ie: resource group, subnets, route table, etc"
  default     = "kafka"
}
