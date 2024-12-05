resource "google_sql_database_instance" "safle" {
  name             = var.database_name
  database_version = "MYSQL_8_0"
  region           = "us-east1"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_subnet
    }
  }

  deletion_protection = false
}