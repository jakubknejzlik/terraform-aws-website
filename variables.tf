variable "domain" {
  description = "root domain name"
}

variable "subdomain" {
  default = "www"
}

variable "digitalocean_dns" {
  default = false
}
