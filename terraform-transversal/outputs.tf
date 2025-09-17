output "alb_dns_name" {
  value       = aws_lb.app.dns_name
  description = "ALB public DNS"
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.app.repository_url
  description = "ECR repo URL"
}
