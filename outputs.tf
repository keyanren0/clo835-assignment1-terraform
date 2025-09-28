output "ec2_public_ip" {
  description = ""
  value       = aws_instance.app_host.public_ip
}

output "webapp_ecr_url" {
  description = ""
  value       = aws_ecr_repository.webapp.repository_url
}

output "mysql_ecr_url" {
  description = ""
  value       = aws_ecr_repository.mysql.repository_url
}

output "ecr_login_command" {
  description = ""
  value       = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${split("/", aws_ecr_repository.webapp.repository_url)[0]}"
}