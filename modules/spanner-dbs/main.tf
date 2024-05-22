locals {
  # enable_instance_nn = (
  #   try(var.instance_size.num_nodes, 0) != null ?
  #   true : false
  # )

  # database_creation_list = {
  #   for k, v in var.database_config :
  #   k => v if(try(v.create_db, null) == null ? false : v.create_db)
  # }

  # database_iam = flatten([
  #   for k, v in var.database_config :
  #   [
  #     for x in v.database_iam :
  #     "${k}|${element(split("=>", x), 0)}|${element(split("=>", x), 1)}"
  #   ]
  # ])

#   backup_args = [
#     for k, v in var.database_config :
#     {
#       "backupId" : k,
#       "database" : "projects/${var.project_id}/instances/${var.instance_name}/databases/${k}",
#       "expireTime" : v.backup_retention,
#       "parent" : "projects/${var.project_id}/instances/${var.instance_name}"
#     } if try(v.enable_backup, false)
#   ]
}

data "google_spanner_instance" "instance" {
  # count   = !var.create_instance ? 1 : 0
  name    = var.instance_name
  project = var.project_id
}

resource "google_spanner_database" "database" {
  # for_each = local.database_creation_list
  instance = var.instance_name
  project                  = var.project_id
  name                     = var.name
  version_retention_period = var.version_retention_period
  ddl                      = var.ddl
  deletion_protection      = var.deletion_protection
  enable_drop_protection   = var.drop_protection
  database_dialect        = "POSTGRESQL"
  dynamic "encryption_config" {
    for_each = (
      try(var.kms_key_name, null) != null ?
      tolist([var.kms_key_name]) :
      []
    )
    content {
      kms_key_name = encryption_config.value
    }
  }

  lifecycle {
    ignore_changes = [
      ddl # added ignore as changes to ddl forces database replacement
    ]
  }
}

resource "google_spanner_database_iam_member" "database" {
  for_each = toset(var.database_iam)
  instance = var.instance_name
  project  = var.project_id
  database = element(split("=>", each.key), 0)
  role     = element(split("=>", each.key), 2)
  member   = element(split("=>", each.key), 1)
  depends_on = [
    google_spanner_database.database
  ]
}

# module "schedule_spanner_backup" {
#   count                  = length(local.backup_args) > 0 ? 1 : 0
#   source                 = "./modules/schedule_spanner_backup"
#   project_id             = var.project_id
#   backup_schedule        = var.backup_schedule
#   workflow_argument      = jsonencode(local.backup_args)
#   backup_schedule_region = var.backup_schedule_region
# }