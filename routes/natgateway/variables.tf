variable "route_table_id" {
  type = list
  description = "The specific list of Route Table ID"
}

variable "nat_gateway_id" {
  type = list
  description = "The specific list of NAT Gateway ID"
}

variable "destination_cidr_block" {
  type = list
  description = "The specific destination CIDR block"
}
