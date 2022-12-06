resource "random_password" "admin_password" {
  length  = 16
  special = false
}

resource "aws_ssm_parameter" "admin_password" {
  name        = "/${var.service_name}/${var.environment_name}/rds/admin/password"
  description = "IAI MongoDB Admin Password"
  type        = "SecureString"
  value       = random_password.admin_password.result

  tags       = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-admin-password"}))

  lifecycle {
    ignore_changes = [value]
  }
}

data "aws_ssm_parameter" "admin_password" {
  depends_on = [aws_ssm_parameter.admin_password]
  name = "/${var.service_name}/${var.environment_name}/rds/admin/password"
}
