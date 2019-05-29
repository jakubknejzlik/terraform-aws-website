# AWS Certificate Request DNS 
resource "digitalocean_record" "cert" {
  count  = "${var.digitalocean_dns?length(local.cert_san_names):0}"
  domain = "${var.domain}"
  type   = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index],"resource_record_type")}"
  name   = "${replace(lookup(aws_acm_certificate.cert.domain_validation_options[count.index],"resource_record_name"),".${var.domain}.","")}"
  ttl    = 300
  value  = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index],"resource_record_value")}"
}

# CloudFront DNS  
resource "digitalocean_record" "www" {
  count  = "${var.digitalocean_dns?1:0}"
  domain = "${var.domain}"
  type   = "CNAME"
  name   = "${var.subdomain}"
  ttl    = 300
  value  = "${aws_cloudfront_distribution.s3_distribution.domain_name}."
}

resource "digitalocean_record" "www_wildcard" {
  count  = "${var.digitalocean_dns?1:0}"
  domain = "${var.domain}"
  type   = "CNAME"
  name   = "*.${var.subdomain}"
  ttl    = 300
  value  = "${aws_cloudfront_distribution.s3_distribution.domain_name}."
}

# this is used only for redirecting root domain to www
resource "digitalocean_record" "root_redir" {
  count  = "${var.digitalocean_dns?1:0}"
  domain = "${var.domain}"
  type   = "A"
  name   = "@"
  ttl    = 300
  value  = "174.129.25.170"
}
