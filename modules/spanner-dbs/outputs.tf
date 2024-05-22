output "spanner_db_details" {
  description = "Spanner Databases information map"
  value = google_spanner_database.database
}

output "spanner_db_iam_details" {
  description = "Spanner Databases IAM information map"
  value = google_spanner_database_iam_member.database
}