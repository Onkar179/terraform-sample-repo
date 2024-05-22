locals {
  enable_instance_nn = (
    try(var.instance_size.num_nodes, 0) != null ?
    true : false
  )
}

resource "google_spanner_instance" "instance_num_node" {
  count        = local.enable_instance_nn && var.create_instance ? 1 : 0
  project      = var.project_id
  config       = var.region
  display_name = var.instance_display_name
  name         = var.instance_name
  num_nodes    = var.instance_size.num_nodes
  labels       = var.instance_labels
}

resource "google_spanner_instance" "instance_processing_units" {
  count            = !local.enable_instance_nn && var.create_instance ? 1 : 0
  project          = var.project_id
  config           = var.region
  display_name     = var.instance_display_name
  name             = var.instance_name
  processing_units = var.instance_size.processing_units
  labels           = var.instance_labels
}

data "google_spanner_instance" "instance" {
  count   = !var.create_instance ? 1 : 0
  name    = var.instance_name
  project = var.project_id
}

resource "google_spanner_instance_iam_member" "instance" {
  for_each = toset(var.instance_iam)
  instance = (
    !var.create_instance ?
    data.google_spanner_instance.instance[0].name :
    (
      local.enable_instance_nn ?
      google_spanner_instance.instance_num_node[0].name :
      google_spanner_instance.instance_processing_units[0].name
    )
  )
  project = var.project_id
  role    = element(split("=>", each.key), 1)
  member  = element(split("=>", each.key), 0)
}