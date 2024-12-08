resource "google_artifact_registry_repository" "safle" {
  repository_id  = var.project_name
  location = var.location
  format = "DOCKER"
}