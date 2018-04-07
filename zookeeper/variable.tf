variable "resource_group" {
  description = "(Required) Kafka resource group info"
  type        = "map"

  default = {
    /* expected keys:
    name     -> kafka resource group name
    location -> kafka resource group location */
  }
}

variable "subnet" {
  description = "(Required) Kafka subnet info"
  type        = "map"

  default = {
    /* expected keys:
    id             -> kafka subnet id
    address_prefix -> kafka subnet address prefix */
  }
}

variable "image" {
  description = "(Required)"
  type        = "map"

  default = {
    /*
    name           -> kafka image name
    resource_group -> kafka resource group name */
  }
}

variable "ssh_public_key" {
  description = "(Required) Path to ssh public key to be used as authorized key on vm"
}

variable "name" {
  description = "(Optional)"
  default     = "kafka"
}

variable "quorum" {
  description = "(Optional)"
  default     = "3"
}

variable "vm_size" {
  description = "(Optional) https://docs.microsoft.com/pt-br/azure/virtual-machines/linux/sizes"
  default     = "Standard_DS1_v2"
}

variable "username" {
  description = "(Optional) Linux user to be created on vm"
  default     = "franz"
}
