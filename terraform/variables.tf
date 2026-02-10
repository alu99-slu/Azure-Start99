variable "rg_name" {
  type        = string
  default     = "azure-start-rg"
  description = "Resource group name"
}

variable "location" {
  type    = string
  default = "eastus"
}