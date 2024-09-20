resource "google_container_cluster" "my-gke" {
  name                     = "my-gke-cluster"
  location                 = "us-central1"
  deletion_protection      = false
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.my_vpc.name
  subnetwork               = google_compute_subnetwork.my_subnet.name
  node_config {
    disk_size_gb = 15
  }

}
resource "google_container_node_pool" "external_node_pool" {
  name     = "my-node-pool"
  location = "us-central1"
  cluster  = google_container_cluster.my-gke.name
  network_config {

  }
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 15
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_compute_disk" "persistent_disk" {
  name = "disk-for-k8s-volume"
  size = 10
  zone = "us-central1-a"
  labels = {
    app = "tomcat"
  }
}