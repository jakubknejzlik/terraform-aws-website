output "cert_resource_record_type" {
  value = "${lookup(aws_acm_certificate.cert.domain_validation_options[0],"resource_record_type")}"
}

output "cert_resource_record_name" {
  value = "${lookup(aws_acm_certificate.cert.domain_validation_options[0],"resource_record_name")}"
}

output "cert_resource_record_value" {
  value = "${lookup(aws_acm_certificate.cert.domain_validation_options[0],"resource_record_value")}"
}

output "cloudfront_domain_name" {
  value = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
}
