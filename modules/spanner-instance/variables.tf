variable "project_id" {
  description = "The project ID to deploy to"
  type        = string
}

variable "instance_name" {
  description = "A unique identifier for the instance, which cannot be changed after the instance is created. The name must be between 6 and 30 characters in length."
  type        = string
  default     = "regional-europe-west1"
}

variable "instance_display_name" {
  description = "The descriptive name for this instance as it appears in UIs."
  type        = string
  default     = "regional-europe-west1"
}

variable "region" {
  description = "The name of the instance's configuration (similar but not quite the same as a region) which defines the geographic placement and replication of your databases in this instance."
  type        = string
}

variable "instance_size" {
  description = "The sizing configuration of Spanner Instance based on num of nodes OR instance processing units."
  type = object({
    num_nodes        = optional(number)
    processing_units = optional(number)
  })
  validation {
    condition = !(
      try(var.instance_size.num_nodes, null) == null
      &&
      try(var.instance_size.processing_units, null) == null
    )
    error_message = "Either num_nodes OR processing_units information is supported."
  }
}

variable "create_instance" {
  description = "Switch to use create OR use existing Spanner Instance "
  type        = bool
  default     = true
}

variable "instance_iam" {
  description = "The list of permissions on spanner instance"
  type        = list(string)
  default     = []
}

variable "instance_labels" {
  type        = map(string)
  description = "A set of key/value label pairs to assign to the spanner instance"
  default     = {}
}