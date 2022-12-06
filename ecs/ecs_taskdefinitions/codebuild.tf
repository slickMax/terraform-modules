resource "aws_codebuild_project" "this" {
  name          = "${var.name}-${var.service_name}-${var.environment_name}"
  description   = "${var.name}-${var.service_name}-${var.environment_name} codebuild stage"
  service_role  = aws_iam_role.codebuild.arn
  build_timeout = var.build_timeout

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${var.pipeline_s3_bucket}/${var.name}/_cache/archives"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = templatefile("${path.module}/files/buildspec.yml", { docker_image = "${var.image}:${var.image_tag}", deploy_region = var.deploy_region, container_name = var.app_name })
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = var.codebuild_image
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    dynamic "environment_variable" {
      for_each = var.app_environment_var
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.cloudwatch_log_group_name
      stream_name = "/codebuild/${var.name}"
    }
  }

  tags = merge(var.tags, tomap({"Name" = "${var.name}-${var.service_name}-${var.environment_name}-cb"}))
}
