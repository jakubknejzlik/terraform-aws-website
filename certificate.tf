locals {
  cert_san_names = ["*.${var.subdomain}.${var.domain}"]
}

resource "aws_acm_certificate" "cert" {
  domain_name               = "${var.subdomain}.${var.domain}"
  subject_alternative_names = "${local.cert_san_names}"
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${var.validation_record_fqdns}"]
}
