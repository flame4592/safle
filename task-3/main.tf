/*---------------------------------------------google_container_registry--------------------------------*/

module "google_artifact_registry_repository" {
    source = "./modules/conatiner"
    project_name = local.project_name
    location = local.location
  
}

/*---------------------------------------------VPC--------------------------------*/

module "vpc" {
    source = "./modules/vpc"
    project_name = local.project_name
    region = local.location
  
}

/*---------------------------------------------DB--------------------------------*/

module "db" {
    source = "./modules/db"
    private_subnet = module.vpc.vpc
    database_name = local.database_name
  
}