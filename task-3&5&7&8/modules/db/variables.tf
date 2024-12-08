variable "database_name" {
    type = string

  
}

variable "private_subnet" {
    type = string
  
}

variable "region" {
    type = string
  
}

variable "db_password" {
  description = "MySQL Database Password"
  type        = string
  sensitive   = true
}