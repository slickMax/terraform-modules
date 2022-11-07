variable "route_table_id" {
  type = list
  description = "The specific list of route table ID"
}

variable "gateway_id" {
  description = "The specific Gateway ID"
}

variable "destination_cidr_block" {
  type = list
  description = "The specific destination CIDR block"
}
