variable "version_retention_period" {
  type = string
  description = "database version retention time"
}

variable "ddl" {
  type = list(string)
  description = "database schema ddl statements"
}

variable "kms_key_name" {
  type = string
  default = null
  description = "kms key name for database encryption"
}

variable "deletion_protection" {
  type = bool
  description = "database deletion protection"
  default = true
}

variable "drop_protection" {
  type = bool
  description = "database and parent instance deletion protection"
  default = false
}

variable "database_iam"{
  type = list(string)
  description = "list of IAM members & roles for database IAM"
  default = []
}

variable "name" {
  type = string
  description = "database name"
}

variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "instance_name" {
  description = "A unique identifier for the instance, which cannot be changed after the instance is created. The name must be between 6 and 30 characters in length."
  type        = string
}