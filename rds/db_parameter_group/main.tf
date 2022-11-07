resource "aws_db_parameter_group" "this" {

  name        = "${var.name}-${var.identifier}"
  description = "Database parameter group for ${var.identifier}"
  family      = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  tags = merge(var.tags, tomap({"Name" = "${var.name}-${var.identifier}-db-parameter-group"}))

  lifecycle {
    create_before_destroy = true
  }
}
