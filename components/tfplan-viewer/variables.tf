variable "env" {}

variable "product" {
  default = "tfplan"
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