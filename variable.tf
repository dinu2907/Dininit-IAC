variable "APP_ID" {
  description = "Azure client/app ID"
  type        = string
}

variable "CLIENT_SECRET" {
  description = "Azure client secret"
  type        = string
  sensitive   = true
}

variable "SUBSCRIPTION_ID" {
  description = "Azure subscription ID"
  type        = string
}

variable "TENANT_ID" {
  description = "Azure tenant ID"
  type        = string
}
