variable "rsa_bits" {
  description = "size of the generated RSA key in bit"
}

variable "keyname" {
  description = "key name"
}

variable "tags" {
  description = "AWS resource taging that can be used for API interaction and billing"
  type        = map(string)
}
