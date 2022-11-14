data "aws_caller_identity" "current_account" {}


resource "aws_cloudwatch_dashboard" "cw_dashboard" {
  dashboard_name = var.app_name
  dashboard_body = templatefile("${path.module}/files/cw_dashboard.json", { region = var.deploy_region, service_name = var.app_name, cluster_name = var.ecs_cluster_id })
}
