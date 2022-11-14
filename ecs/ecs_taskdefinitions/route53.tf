# Public
resource "aws_route53_record" "this" {
  zone_id = var.public_domain_id
  name = var.name
  type = "A"

  alias {
    name                   = aws_lb.ecs_tasks.dns_name
    zone_id                = aws_lb.ecs_tasks.zone_id
    evaluate_target_health = false
  }
}
