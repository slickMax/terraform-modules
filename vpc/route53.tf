# Private internal zone for easier lookups
resource "aws_route53_zone" "internal_zone" {
  name = var.domain_private
  vpc {
    vpc_id = aws_vpc.environment.id
  }

  tags  = merge(var.tags, tomap({"Name" = "${var.vpc_name}-domain-internal"}))
}

# Public zone for friendly service access
resource "aws_route53_zone" "public_zone" {
  count = var.enable_public_zone ? 1 : 0

  name = var.domain_public
  tags  = merge(var.tags, tomap({"Name" = "${var.vpc_name}-domain-public"}))
}
