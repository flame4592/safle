provider "google" {
    project = local.project_id
    credentials = "${file("D:/git/safle/credentials.json")}"
    region = "us-east1"
    zone = "us-east1-b"

  
}