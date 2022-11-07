variable "vpc_name" {
  description = "resource label or name"
  type     = string
}

variable "enable_dns_hostnames" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "vpc_dns_hosts" {
  description = "Name servers to configure"
  type        = string
}

variable "domain_private" {
  description = "Private Domain Name"
  type        = string
}

variable "domain_public" {
  description = "Public Domain Name"
  type        = string
}

variable "cidr_block" {
  description = "The enironment specific VPC CIDR block using which subnet block caluclated automatically"
  type        = string
}

variable "tags" {
  description = "AWS resource taging that can be used for API interaction and billing"
  type        = map(string)
}

variable "enable_public_zone" {
  description = "Disable creation of public zone"
  default     = true
}

variable "public_zone_id" {
  description = "r53 domain id for public zone"
  default     = ""
}
