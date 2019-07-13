output "certificate_dns" {
  value = {
    resource_record_type  = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index],"resource_record_type")}"
    resource_record_name  = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index],"resource_record_name")}"
    resource_record_value = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index],"resource_record_value")}"
  }
}

output "cloudfront_domain_name" {
  value = "${aws_cloudfront_distribution.s3_distribution.domain_name}."
}
