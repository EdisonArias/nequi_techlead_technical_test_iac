resource "mongodbatlas_project" "this" {
  name   = var.atlas_project_name
  org_id = var.atlas_org_id
}

resource "mongodbatlas_cluster" "this" {
  project_id   = mongodbatlas_project.this.id
  name         = var.atlas_cluster_name
  cluster_type = "REPLICASET"

  provider_name               = "TENANT"      
  backing_provider_name       = "AWS"
  provider_region_name        = local.atlas_region_map[var.aws_region]
  provider_instance_size_name = "M0"
}

resource "mongodbatlas_database_user" "app" {
  project_id         = mongodbatlas_project.this.id
  username           = var.db_user
  password           = var.db_password
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = var.db_name
  }
}

resource "mongodbatlas_project_ip_access_list" "open" {
  project_id = mongodbatlas_project.this.id
  cidr_block = "0.0.0.0/0"
}