output "google_artifact_registry_repository" {
    value = "https://${google_artifact_registry_repository.safle.location}-docker.pkg.dev/${google_artifact_registry_repository.safle.project}/${google_artifact_registry_repository.safle.repository_id}"
}
  
