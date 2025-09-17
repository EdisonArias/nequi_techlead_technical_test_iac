
locals {
  atlas_region_map = {
    "us-east-1" = "US_EAST_1"
  }
  atlas_uri = "mongodb+srv://${var.db_user}:${var.db_password}@${data.mongodbatlas_cluster.conn.connection_strings[0].standard_srv}/${var.db_name}?retryWrites=true&w=majority&appName=${var.atlas_cluster_name}"
}

