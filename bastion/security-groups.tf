resource "aws_security_group" "bastion_ssh" {
  vpc_id      = var.vpc_id
  name        = "${var.environment_name}-bastion-sg"
  description = "security group that allows ssh and all egress traffic for bastion box"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = concat(var.bastion_access_cidr)
  }

  tags       = merge(var.tags, tomap({"Name" = "${var.environment_name}-bastion-sg"}))
}
