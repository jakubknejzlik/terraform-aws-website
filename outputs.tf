output "domain_validation_options" {
  value = "${aws_acm_certificate.cert.domain_validation_options}"
}

output "cloudfront_domain_name" {
  value = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
}
