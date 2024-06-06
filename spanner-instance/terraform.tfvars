instances = {
test-instance = {
  project_id  = "onkar-17-cloud"
  instance_display_name = "Spanner demo"
  create_instance = true
  instance_size = {
    processing_units = 100
  }
  instance_config = "regional-us-central1"
  instance_labels = {
    "env" = "demo"
  }
  instance_iam = [
    "user:onkar.naik@forescout.com=>roles/spanner.databaseAdmin"
  ]
}
test-instance-2 = {
  project_id  = "onkar-17-cloud"
  instance_display_name = "Spanner Prod"
  create_instance = true
  instance_size = {
    processing_units = 200
  }
  instance_config = "regional-us-east4"
  instance_labels = {
    "env" = "prod"
  }
  instance_iam = [
    "user:onkar.naik@forescout.com=>roles/spanner.databaseAdmin"
  ]
}
}