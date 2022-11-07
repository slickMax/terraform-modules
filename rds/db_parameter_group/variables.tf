variable "name" {
  description = "Creates a unique name"
}

variable "identifier" {
  description = "The identifier of the resource"
}

variable "family" {
  description = "The family of the DB parameter group"
}

variable "parameters" {
  description = "A list of DB parameter maps to apply"
  type        = list(map(string))
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}
