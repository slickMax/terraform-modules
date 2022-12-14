resource "aws_subnet" "environment" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags                    = merge(var.tags, tomap({"Name" = "${var.subnet_name}-subnet"}))
}

## Route configuration
resource "aws_route_table" "environment" {
  vpc_id = var.vpc_id
  tags   = merge(var.tags, tomap({"Name" = "${var.subnet_name}-rt"}))
}

## Route Table Association
resource "aws_route_table_association" "environment" {
  subnet_id      = aws_subnet.environment.id
  route_table_id = aws_route_table.environment.id
}
