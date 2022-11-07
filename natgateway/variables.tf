variable "subnet" {
  description = "The specific Subnet ID"
}

variable "az" {
  description = "The specific Availability zone"
}

variable "tags" {
  description = "AWS resource taging that can be used for API interaction and billing"
  type        = map(string)
}
