locals {
  zone_id = var.vpc_name == "cprod" ? var.public_zone_id : join("", aws_route53_zone.public_zone[*].zone_id)
}

# Creates an SSL certificate
resource "aws_acm_certificate" "this" {
  domain_name       = "*.${var.domain_public}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }

  tags  = merge(var.tags, tomap({"Name" = "${var.domain_public}-acm-cert"}))
}

# Validation record for the strategic ssl cert
resource "aws_route53_record" "this" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.this.domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.this.domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.this.domain_validation_options)[0].resource_record_type
  zone_id         = local.zone_id
  ttl             = 60
}

# This resource allows terraform to wait till the certificate has been validated using the above r53 record
resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [ aws_route53_record.this.fqdn ]
}
