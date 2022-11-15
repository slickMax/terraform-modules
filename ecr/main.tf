resource "aws_ecr_repository" "repo" {
  name = "${var.app_name}"

  tags = merge(var.tags, tomap({"Name" = "${var.app_name}-ecr"}))
}
