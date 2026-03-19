variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-terraform-enterprise"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "northeurope"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "enterprise"
}

variable "vnet_address_space" {
  description = "Address space for virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  description = "Address prefix for subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Admin password for VM"
  type        = string
  default     = "Admin@12345!"
  sensitive   = true
}
