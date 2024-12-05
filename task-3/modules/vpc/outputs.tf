output "subnet_ids" {
    value = google_compute_subnetwork.private_subnet1.id
  
}

output "vpc" {
    value = google_compute_network.safle.id
  
}