data "aws_secretsmanager_secret" "mongo_uri" {
  name = "nequi-techlead-mongo-uri" 
}

data "mongodbatlas_cluster" "conn" {
  project_id = mongodbatlas_project.this.id
  name       = mongodbatlas_cluster.this.name
}