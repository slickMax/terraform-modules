resource "aws_security_group" "ecs_tasks" {

  name        = "${var.app_name}-ecs-tasks-sg"
  vpc_id      = var.vpc_id
  description = "allow inbound access from the ALB only"

  ingress {
    protocol = "-1"
    from_port   = 0
    to_port     = 0
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags       = merge(var.tags, tomap({"Name" = "${var.app_name}-ecs-tasks-sg"}))
}

resource "aws_security_group" "lb" {

  name        = "${var.app_name}-lb-sg"
  vpc_id      = var.vpc_id
  description = "Controls access to the Application Load Balancer (ALB)"

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = concat(var.application_access_cidr)
    # cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags       = merge(var.tags, tomap({"Name" = "${var.app_name}-lb-sg"}))
}
