output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.inst.*.arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.inst.address
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.inst.*.id
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.inst.*.name
}

output "application_rds_access_sg" {
  description = "Application Security group that allows rds access"
  value       = aws_security_group.rds_access_sg.id
}

output "db_admin_user_password_ssm_name" {
  description = "The SSM parameter store name contains DB password"
  value       = aws_ssm_parameter.admin_password.name
}