output "subnet_ids" {
    value = google_compute_subnetwork.private_subnet1.id
  
}

output "vpc" {
    value = google_compute_network.safle.id
  
}

output "vpc_name" {
    value = google_compute_network.safle.name
  
}

output "subnetwork_name_kubernetes" {
    value = google_compute_subnetwork.kubernetes.name
  
}