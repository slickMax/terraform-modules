resource "aws_ssm_parameter" "param" {
  name        = var.parameter_name
  description = var.description
  type        = var.type
  value       = var.value

  tags = merge(var.tags, tomap({"Name" = "${var.parameter_name}-ssmparam"}))
}
