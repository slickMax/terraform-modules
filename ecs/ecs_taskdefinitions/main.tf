resource "aws_ecs_task_definition" "task" {
  family                   = var.app_name
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.app["cpu"]
  memory                   = var.app["memory"]
  requires_compatibilities = ["FARGATE"]
  container_definitions    = templatefile("${path.module}/files/taskdefinitions.json",
                            { region       = var.deploy_region, 
                              app_name     = var.app_name,
                              port         = var.app["port"],
                              cpu          = var.app["cpu"],
                              memory       = var.app["memory"],
                              cw_log_group = var.cloudwatch_log_group_name,
                              image        = var.image,
                              image_tag    = var.image_tag,
                              environment_entries = var.app_environment_var,
                              environment_secrets = var.app_secret_var
                            })

  # task_role_arn            = aws_iam_role.ecs_task_execution_role.arn // Enable for Debug

  tags = merge(var.tags, tomap({"Name" = "${var.app_name}-ecs-td"}))
}

resource "aws_ecs_service" "service" {
  name            = var.app_name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.app["task"]
  launch_type     = "FARGATE"

  # enable_execute_command = true // Enable for Debug

  network_configuration {
    security_groups  = concat(var.application_access_sg, [aws_security_group.ecs_tasks.id])
    subnets          = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tasks.arn
    container_name   = var.app_name
    container_port   = var.app["port"]
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [task_definition]
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role]

  tags = merge(var.tags, tomap({"Name" = "${var.app_name}-ecs-service"}))
}
