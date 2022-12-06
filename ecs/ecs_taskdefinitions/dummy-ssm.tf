resource "aws_ssm_parameter" "this" {
  name  = var.app_name
  type  = "String"
  value = var.app_name

  tags   = merge(var.tags, tomap({"Name" = "${var.app_name}-ssmparam"}))
}
