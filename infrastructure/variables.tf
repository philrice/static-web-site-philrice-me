variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-philriceuk-static-web-app-blog"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "West Europe"
}

variable "name" {
  description = "The name of the static web app"
  type        = string
  default     = "philriceuk-static-web-app-blog"
}