resource "google_storage_bucket" "backend-bucket" {
  name                     = "mygcsbackendbucket"
  location                 = var.region
  public_access_prevention = "enforced"
}
