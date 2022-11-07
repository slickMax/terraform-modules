resource "aws_db_subnet_group" "this" {
  name        = "${var.name}-${var.identifier}"
  description = "Database subnet group for ${var.identifier}"
  subnet_ids  = var.subnet_ids

  tags = merge(var.tags, tomap({"Name" = "${var.name}-${var.identifier}-db-subnet-group"}))
}
