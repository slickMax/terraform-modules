provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

# Creates an SSL certificate
resource "aws_acm_certificate" "cf_this" {
  domain_name       = "*.${var.domain_public}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }

  tags  = merge(var.tags, tomap({"Name" = "${var.domain_public}-acmcf-cert"}))

  provider = aws.us-east-1
}

# Validation record for the strategic ssl cert
resource "aws_route53_record" "cf_this" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cf_this.domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.cf_this.domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.cf_this.domain_validation_options)[0].resource_record_type
  zone_id         = local.zone_id
  ttl             = 60

  provider = aws.us-east-1
}

# This resource allows terraform to wait till the certificate has been validated using the above r53 record
resource "aws_acm_certificate_validation" "cf_this" {
  certificate_arn         = aws_acm_certificate.cf_this.arn
  validation_record_fqdns = [ aws_route53_record.cf_this.fqdn ]

  provider = aws.us-east-1
}
