resource "google_sql_database_instance" "safle" {
  name             = var.database_name
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_subnet
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.safle.name
}

resource "google_sql_user" "users" {
  name     = var.database_name
  instance = google_sql_database_instance.safle.name
  host     = "%"
  password = var.db_password
}