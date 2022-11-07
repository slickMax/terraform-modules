resource "aws_security_group" "rds_sg" {
  vpc_id      = var.vpc_id
  name        = "${var.service_name}-${var.environment_name}-rds-sg"
  description = "security group that allows rds access"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    self            = true
    cidr_blocks     = concat(var.rds_access_cidr)
  }

  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = [aws_security_group.rds_access_sg.id]
  }

  tags       = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-sg"}))
}

resource "aws_security_group" "rds_access_sg" {
  vpc_id      = var.vpc_id
  name        = "${var.service_name}-${var.environment_name}-rds-access-sg"
  description = "Application Security group that allows rds access"

  tags       = merge(var.tags, tomap({"Name" = "${var.service_name}-${var.environment_name}-rds-access-sg"}))
}
