variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  default     = false
}

variable "availability_zone" {
  description = "List of the three AZs we want to use"
  type        = string
}

variable "tags" {
  description = "AWS resource taging that can be used for API interaction and billing"
  type        = map(string)
}

variable "subnet_cidr_block" {
  description = "The specific subnet CIDR block using which subnet created"
}

variable "subnet_name" {
  description = "The specific subnet name"
}

variable "vpc_id" {
  description = "The specific VPC ID"
}
