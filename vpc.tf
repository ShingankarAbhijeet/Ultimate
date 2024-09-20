resource "google_compute_network" "my_vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
  project                 = var.project
}

resource "google_compute_subnetwork" "my_subnet" {
  name          = "my-subnet"
  region        = var.region
  network       = google_compute_network.my_vpc.name
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_firewall" "my-fire" {
  name    = "test-firewall"
  network = google_compute_network.my_vpc.name
  allow {
    protocol = "TCP"
    ports    = ["80", "22", "443", "9090", "32386", "8080", "8081", "8443"]
  }
  source_ranges = ["192.168.31.0/24"]
}