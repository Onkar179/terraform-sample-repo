variable "instances" {
type = map(object({
  project_id  = string
  instance_display_name = optional(string)
  instance_size = map(string)
  instance_config = string
  instance_labels = optional(map(string))
  instance_iam = optional(list(string))
  create_instance = optional(bool)
}))
}