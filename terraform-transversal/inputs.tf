variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources."
  default     = "us-east-1"
}

variable "name_prefix" {
  type        = string
  description = "Prefix to name AWS resources (cluster, service, ALB, etc)."
  default     = "nequi-techlead"
}

variable "ecr_repo_name" {
  type        = string
  description = "ECR repository name for the application image."
  default     = "nequi-techlead-app"
}

variable "container_port" {
  type        = number
  description = "Container port exposed by the Spring Boot app."
  default     = 8080
}

variable "desired_count" {
  type        = number
  description = "Number of ECS tasks to run (Fargate service desired count)."
  default     = 1
}

variable "health_check_path" {
  type        = string
  description = "HTTP path for ALB target group health checks."
  default     = "/actuator/health"
}

variable "mongodb_uri" {
  type        = string
  description = "MongoDB Atlas connection string (e.g., mongodb+srv://...). Stored in Secrets Manager."
  sensitive   = true
}
