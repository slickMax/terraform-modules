# IAM role and policy for CodePipeline
data "aws_iam_policy_document" "codepipeline" {
   statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  } 
}

resource "aws_iam_role" "codepipeline" {
  name                 = "${var.name}-codepipeline-${var.environment_name}"
  assume_role_policy   = data.aws_iam_policy_document.codepipeline.json

  tags = merge(var.tags, tomap({"Name" = "${var.name}-codepipeline-${var.environment_name}-iam-role"}))
}

resource "aws_iam_policy" "codepipeline" {
  name        = "${var.name}-codepipeline-${var.environment_name}"
  description = "Allow Codepipeline deployments"
  policy      = data.aws_iam_policy_document.codepipeline_policy.json

  tags = merge(var.tags, tomap({"Name" = "${var.name}-codepipeline-${var.environment_name}-iam-policy"}))
}

resource "aws_iam_role_policy_attachment" "codepipeline" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = aws_iam_policy.codepipeline.arn
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${var.pipeline_s3_bucket}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "codestar-connections:UseConnection"
    ]

    resources = [
      "${var.aws_codestarconnections_arn}"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:StartBuild",
      "codebuild:StopBuild",
      "codebuild:BatchGetBuilds"
    ]

    resources = ["arn:aws:codebuild:${var.deploy_region}:*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ecr:DescribeImages"
    ]
    
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTasks",
      "ecs:ListTasks",
      "ecs:RegisterTaskDefinition",
      "ecs:UpdateService"
    ]
    
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]
    
    resources = ["*"]
  }

}


# IAM role and policy for CodeBuild
data "aws_iam_policy_document" "codebuild" {
   statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  } 
}

resource "aws_iam_role" "codebuild" {
  name                 = "${var.name}-codebuild-${var.environment_name}"
  assume_role_policy   = data.aws_iam_policy_document.codebuild.json

  tags = merge(var.tags, tomap({"Name" = "${var.name}-codebuild-${var.environment_name}-iam-role"}))
}

data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
      "ec2:CreateNetworkInterfacePermission"
    ]

    resources = ["arn:aws:logs:${var.deploy_region}:*","arn:aws:ec2:${var.deploy_region}:*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${var.pipeline_s3_bucket}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:UpdateReportGroup",
      "codebuild:ListReportsForReportGroup",
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:ListReports",
      "codebuild:DeleteReport",
      "codebuild:ListReportGroups",
      "codebuild:BatchPutTestCases"
    ]

    resources = [
      "arn:aws:codebuild:${var.deploy_region}:*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "codebuild" {
  name        = "${var.name}-codebuild-${var.environment_name}"
  description = "Allow codebuild deployments"
  policy      = data.aws_iam_policy_document.codebuild_policy.json

  tags = merge(var.tags, tomap({"Name" = "${var.name}-codebuild-${var.environment_name}-iam-policy"}))
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild.arn
}
