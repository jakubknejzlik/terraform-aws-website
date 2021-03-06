variable "domain" {
  description = "root domain name"
}

variable "subdomain" {
  default = "www"
}

variable "validation_record_fqdns" {
  type    = "list"
  default = []
}
