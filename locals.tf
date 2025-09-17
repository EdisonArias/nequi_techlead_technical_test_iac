locals {
  capacity      = "nequi"
  functionality = "techlead-technical-test"

  ecs_cluster_name = "${var.name_prefix}-cluster"
  task_family      = "${var.name_prefix}-task"
  service_name     = "${var.name_prefix}-svc"
  alb_name         = "${var.name_prefix}-alb"
  log_group_name   = "/ecs/${var.name_prefix}"

  resource_tags = {
    capacity      = local.capacity
    functionality = local.functionality
    terraform     = "true"
    environment   = "main"
  }
}
