resource "aws_acm_certificate" "ssl_cert" {
  domain_name       = local.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${local.domain_name}",
    "*.api.${local.domain_name}",
    "*.jenkins.${local.domain_name}"
  ]

  tags = merge(
    map(
      "Name", "${local.name_prefix}-cert"
    ),
    local.common_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.ssl_cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.ssl_cert.domain_validation_options.0.resource_record_type
  zone_id = aws_route53_zone.main.id
  records = [aws_acm_certificate.ssl_cert.domain_validation_options.0.resource_record_value]
  ttl     = 60

  allow_overwrite = true
}

resource "aws_route53_record" "cert_validation_alt1" {
  name    = aws_acm_certificate.ssl_cert.domain_validation_options.1.resource_record_name
  type    = aws_acm_certificate.ssl_cert.domain_validation_options.1.resource_record_type
  zone_id = aws_route53_zone.main.id
  records = [aws_acm_certificate.ssl_cert.domain_validation_options.1.resource_record_value]
  ttl     = 60

  allow_overwrite = true
}

resource "aws_route53_record" "cert_validation_alt2" {
  name    = aws_acm_certificate.ssl_cert.domain_validation_options.2.resource_record_name
  type    = aws_acm_certificate.ssl_cert.domain_validation_options.2.resource_record_type
  zone_id = aws_route53_zone.main.id
  records = [aws_acm_certificate.ssl_cert.domain_validation_options.2.resource_record_value]
  ttl     = 60

  allow_overwrite = true
}

resource "aws_route53_record" "cert_validation_alt3" {
  name    = aws_acm_certificate.ssl_cert.domain_validation_options.3.resource_record_name
  type    = aws_acm_certificate.ssl_cert.domain_validation_options.3.resource_record_type
  zone_id = aws_route53_zone.main.id
  records = [aws_acm_certificate.ssl_cert.domain_validation_options.3.resource_record_value]
  ttl     = 60

  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "ssl_cert_validation" {
  certificate_arn = aws_acm_certificate.ssl_cert.arn

  validation_record_fqdns = [
    aws_route53_record.cert_validation.fqdn,
    aws_route53_record.cert_validation_alt1.fqdn,
    aws_route53_record.cert_validation_alt2.fqdn,
    aws_route53_record.cert_validation_alt3.fqdn
  ]
}