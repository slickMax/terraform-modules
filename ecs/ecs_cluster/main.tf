resource "aws_ecs_cluster" "environment" {
  name = "${var.cluster_name}-ecs-cluster"

  tags = merge(var.tags, tomap({"Name" = "${var.cluster_name}-ecs-cluster"}))
}
