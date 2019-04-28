terraform {
  required_version = ">= 0.9.8"

  backend "s3" {
    bucket = "your-terraform-bucket"
    key    = "websites/my-website.tfstate"

    region = "eu-central-1"
  }
}
