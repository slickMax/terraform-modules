variable "vpc_id" {
  description = "The specific VPC ID"
}

variable "gateway_name" {
  description = "The specific gateway name"
}

variable "tags" {
  description = "AWS resource taging that can be used for API interaction and billing"
  type        = map(string)
}
