variable "name" {
  description = "App name"
}

variable "app_name" {}

variable "tags" {
  description = "AWS resource taging that can be used for API interaction and billing"
  type        = map(string)
}

variable "deploy_region" {
  description = "The region for which this stack will be deployed"
  type        = string
  default     = "eu-west-2"
}

variable "application_access_sg" {
  description = "Application access sg"
  default     = ""
}

variable "private_subnet_ids" {
  description = "A list of subnet to spin up ecs tasks"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "A list of subnet to spin up ALB"
  type        = list(string)
}

variable "ecs_cluster_id" {
  description = "ECS Cluster ID"
}

variable "vpc_id" {
  description = "The specific VPC ID"
}

variable "public_domain_id" {
  description = "r53 domain id for public zone"
  default     = ""
}

variable "certificate_arn" {
  description = "Application service viewer certificate"
}

variable "application_access_cidr" {
  description = "Bastion access cidr"
  type        = list(any)
  default     = []
}

variable "app" {
  description = "Details for the application"
  type        = map(string)
}

variable "app_environment_var" {
  description = "Application Environment variable for the application"
  type        = map(string)
}

variable "app_secret_var" {
  description = "Application Environment variable secrest from SSM for the application"
  type        = map(string)
}

variable "cloudwatch_log_group_name" {
  description = "The Central AWS CloudWatch LogGroup"
}

variable "image" {
  description = "Application service docekr image uri"
}

variable "image_tag" {
  description = "Application service docker image tag"
  default = "latest"
}

variable "environment_name" {
  description = "The name of the environment, for example poc, prod, dev, test"
  type        = string
}

variable "service_name" {
  description = "Application Prefix"
}

variable "codebuild_image" {
  description = "CodeBuild Container base image"
  default = "aws/codebuild/standard:4.0"
  type = string
}

variable "pipeline_s3_bucket" {
  description = "Name of S3 bucket used for pipleine artifacts"
  type = string
}

variable build_timeout {
  type        = string
  default     = "20"
  description = "Build time out duration"
}

variable "aws_codestarconnections_arn" {
  description = "AWS code star connection arn"
}
