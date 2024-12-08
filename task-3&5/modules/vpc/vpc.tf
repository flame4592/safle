
resource "google_compute_network" "safle" {
  name                    = var.project_name
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "private_subnet1" {
  name          = "private-subnet-1"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.region
  network       = google_compute_network.safle.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "kubernetes" {
  name          = "kubernetes-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.safle.id
}

resource "google_compute_global_address" "private_ip_block" {
  name          = "private-ip-block"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  ip_version    = "IPV4"
  prefix_length = 16
  network       = google_compute_network.safle.id
}

resource "google_compute_router" "router" {
  name    = "gke-router"
  region  = var.region
  network = google_compute_network.safle.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "gke-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_firewall" "allow_outbound" {
  name    = "allow-outbound"
  network = google_compute_network.safle.id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
}


resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.safle.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]
}