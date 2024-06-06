variable "enable_soar" {
  type        = bool
  default = true
  description = "description"
}

provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

module "cloud_spanner" {
  source = "../modules/spanner-instance"
  for_each = var.enable_soar ? var.instances : {}
  project_id  = each.value.project_id
  create_instance = each.value.create_instance
  instance_name = each.key
  instance_display_name = each.value.instance_display_name
  instance_iam = each.value.instance_iam
  instance_size = each.value.instance_size
  region = each.value.instance_config
  instance_labels = each.value.instance_labels
}
