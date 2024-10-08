resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.instance.name

}

# See versions at https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version
resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  region           = "us-central1"
  database_version = "POSTGRES_15"
  project          = var.project
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = "false"
}

resource "google_sql_user" "sql-user" {
  name     = "postgres-admin"
  instance = google_sql_database_instance.instance.name
  password = "Changeme@postgres"
}