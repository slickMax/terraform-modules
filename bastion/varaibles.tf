variable "ami_filter_name" {
  type        = string
  description = "AWS AMI Name filter value"
  default     = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
}

variable "ami_owners" {
  type        = list(string)
  description = "AMI owners filter"
  default     = ["self", "amazon", "aws-marketplace"]
}

variable "tags" {
  description = "AWS resource taging that can be used for API interaction and billing"
  type        = map(string)
}

variable "environment_name" {
  description = "The name of the environment, for example poc, prod, dev, test"
  type        = string
}

variable "instance_type" {
  description = "The instance type to deploy for mongo"
  default     = "t2.micro"
}

variable "subnet_ids" {
  description = "A list of subnet to spin up bastion instance"
  type        = string
}

variable "ssh_key_name" {
  description = "The name of the ssh key map to EC2 instance"
  type        = string
}

variable "bastion_access_cidr" {
  description = "Bastion access cidr"
  type        = list(any)
  default     = []
}

variable "vpc_id" {
  description = "The specific VPC ID"
}

variable "service_name" {
  description = "Application Prefix"
}
