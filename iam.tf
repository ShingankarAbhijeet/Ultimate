resource "google_service_account" "sa" {
  account_id   = "sql-sa"
  display_name = "sql-sa"
}


resource "google_project_iam_member" "role-for-sql-sa" {
  project = var.project
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}
output "servic_account" {
  value = google_service_account.sa.email
}
resource "google_service_account_key" "sql-sa-key" {
  service_account_id = google_service_account.sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
}
output "sa-key" {
  value     = google_service_account_key.sql-sa-key.private_key
  sensitive = true
}
output "key-path" {
  value = "/d/Abhi/Projects/skill-boost-project/Ultimate/"
}