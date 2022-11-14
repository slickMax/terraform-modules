resource "aws_lb" "ecs_tasks" {
  name               = "${var.app_name}-alb"
  subnets            = var.public_subnet_ids
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]

  tags   = merge(var.tags, tomap({"Name" = "${var.app_name}-alb"}))
}

resource "aws_lb_listener" "ecs_tasks" {
  load_balancer_arn = aws_lb.ecs_tasks.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tasks.arn
  }

  tags   = merge(var.tags, tomap({"Name" = "${var.app_name}-alb-listener"}))
}

resource "aws_lb_target_group" "ecs_tasks" {
  name        = "${var.app_name}-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "20"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags   = merge(var.tags, tomap({"Name" = "${var.app_name}-alb-tg"}))
}
