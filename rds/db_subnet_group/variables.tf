variable "name" {
  description = "Creates a unique name"
}

variable "identifier" {
  description = "The identifier of the resource"
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
}

variable "tags" {
  description = "AWS resource taging that can be used for API interaction and billing"
  type        = map(string)
}
