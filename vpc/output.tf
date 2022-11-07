output "vpc_id" {
  value = aws_vpc.environment.id
}

output "vpc_cidr" {
  value = aws_vpc.environment.cidr_block
}

output "private_zone_id" {
  value = aws_route53_zone.internal_zone.zone_id
}

output "public_zone_id" {
  value = join("", aws_route53_zone.public_zone[*].zone_id)
}

output "public_ssl_arn" {
  value = aws_acm_certificate.this.arn
}

output "public_cf_ssl_arn" {
  value = aws_acm_certificate.cf_this.arn
}
