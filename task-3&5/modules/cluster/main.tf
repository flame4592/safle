resource "google_container_cluster" "safle" {
  name     = var.project_name
  location = var.region
  deletion_protection = false

  # Remove default node pool
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.vpc_name                     #google_compute_network.main.name
  subnetwork = var.subnetwork_name             #google_compute_subnetwork.kubernetes.name

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "All Networks"
    }
  }
}

# Node Pool for GKE
resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = var.region
  cluster    = google_container_cluster.safle.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 25
    disk_type = "pd-standard"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}