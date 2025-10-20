variable "env" {}

variable "product" {
  default = "cft-platform"
}

variable "component" {
  default = "tfplan-viewer"
}

variable "location" {
  default = "uksouth"
}

variable "builtFrom" {}

variable "account_kind" {
  default = "StorageV2"
}

variable "account_replication_type" {
  default = "ZRS"
}

variable "cognitive_deployment" {
  type = object({
    name          = optional(string)
    model_name    = optional(string)
    model_version = optional(string)
    model_format  = optional(string)
    sku_name      = optional(string)
    sku_capacity  = optional(number)
  })
  default = {}
}