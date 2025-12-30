output "web_sg_id" {
  description = "Security Group ID for WEB tier"
  value       = aws_security_group.WEB_SG.id
}

output "app_sg_id" {
  description = "Security Group ID for APP tier"
  value       = aws_security_group.APP_SG.id
}

output "db_sg_id" {
  description = "Security Group ID for DB tier"
  value       = aws_security_group.DB_SG.id
}
