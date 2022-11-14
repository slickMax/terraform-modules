resource "aws_codepipeline" "this" {
  name = "${var.name}-${var.service_name}-${var.environment_name}"
  role_arn = aws_iam_role.codepipeline.arn 

  artifact_store {
    location = "${var.pipeline_s3_bucket}"
    type = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = var.aws_codestarconnections_arn
        FullRepositoryId = "${var.app["github_org"]}/${var.app["repository_name"]}"
        BranchName       = var.app["branch_name"]
        DetectChanges    = var.app["trigger_pipleine"]
      }
    }
  }

  dynamic "stage" {
    for_each = var.environment_name == "cprod" || var.environment_name == "gprod" || var.environment_name == "ngprod" ? [1] : []
    content {
      name = "Approve"
      action {
        name     = "Production-Approval"
        category = "Approval"
        owner    = "AWS"
        provider = "Manual"
        version  = "1"

        configuration = {
          CustomData      = "Approval needed to perform Production deployment"
        }
      }
    }
  }
  
  stage {
    name = "BuildandPublish"

    action {
      name = "BuildandPublish"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      input_artifacts = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version = "1"

      configuration = {
        ProjectName   = aws_codebuild_project.this.arn
        PrimarySource = "SourceArtifact"
      }

      run_order = 2
    }
  }

  stage {
    name = "Deploy"

    action {
      name = "Deploy"
      category = "Deploy"
      owner = "AWS"
      provider = "ECS"
      input_artifacts = ["BuildArtifact"]
      version = "1"

      configuration = {
        ClusterName = var.ecs_cluster_id
        ServiceName = aws_ecs_service.service.name
      }

      run_order = 3
    }
  }

  tags = merge(var.tags, tomap({"Name" = "${var.name}-${var.service_name}-${var.environment_name}-cp"}))
}

# ToDO
# Setup Trigger the pipline once they become stable
# Fix to use GitHub 2 using CodeStar connection as need org level github access for now using GitHub 1
# Schedule Clean up build artifacts stored in S3