module "myawesomesite" {
  source = "github.com/novacloudcz/terraform-aws-website"

  subdomain = "www"
  domain    = "example.com"
}
