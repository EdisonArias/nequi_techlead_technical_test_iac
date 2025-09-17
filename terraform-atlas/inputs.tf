variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources."
  default     = "us-east-1"
}

variable "atlas_org_id" {
  type        = string
  description = "MongoDB Atlas Organization ID."
}

variable "atlas_public_key" {
  type        = string
  description = "MongoDB Atlas API Public Key."
}

variable "atlas_private_key" {
  type        = string
  description = "MongoDB Atlas API Private Key."
  sensitive   = true
}

variable "atlas_project_name" {
  type        = string
  description = "Atlas Project name."
  default     = "nequi-techlead"
}

variable "atlas_cluster_name" {
  type        = string
  description = "Atlas Cluster name."
  default     = "Cluster0"
}

variable "db_user" {
  type        = string
  description = "MongoDB application user."
  default     = "nequi_app"
}

variable "db_password" {
  type        = string
  description = "MongoDB application user password."
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "Application database name to include in the URI."
  default     = "nequiTechnicalTest"
}

variable "allowlist_cidrs" {
  type        = list(string)
  description = "CIDR list allowed to access Atlas (dev-only default)."
  default     = ["0.0.0.0/0"]
}