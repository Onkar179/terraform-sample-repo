output "spanner_instance_id" {
  description = "Spanner Instance ID"
  value = (
    !var.create_instance ?
    data.google_spanner_instance.instance[0].id :
    (
      local.enable_instance_nn ?
      google_spanner_instance.instance_num_node[0].id :
      google_spanner_instance.instance_processing_units[0].id
    )
  )
}

output "spanner_instance_iam_details" {
  description = "Spanner Instance IAM details"
  value = google_spanner_instance_iam_member.instance
}