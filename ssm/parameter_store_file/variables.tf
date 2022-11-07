variable "parameter_name" {
  description = "Name of the parameter"
}

variable "type" {
  description = "Type of the parameter"
}

variable "value" {
  description = "Value of the parameter"
}

variable "tags" {
  description = "AWS resource taging that can be used for API interaction and billing"
  type        = map(string)
}

variable "description" {
  description = "Description details of the parameter"
}
