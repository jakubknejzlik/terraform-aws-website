# terraform-aws-website

Terraform module for deploying static website using S3, CloudFront and Lambda

# Usage

For using this deployment You need AWS role credentials. And create following file:

```
module "myawesomesite" {
  source = "github.com/novacloudcz/terraform-aws-website"

  subdomain = "www"
  domain = "example.com" # specify your own domain
}
```

Then run:

```
terraform init //required only for first time

terraform apply
```

If everything goes well, S3 bucket is created with following mapping for bucket folders:

```
www -> www.example.com
xxx -> xxx.www.example.com
```

Contents of these folders are distributed using CloudFront via HTTPS. You can integrate Your CI to create folders and upload content to them to distribute content for Your websites in following way (gitflow):

```
develop -> develop folder (-> develop.www.example.com)
master -> www folder (-> www.example.com)
feature/xxx -> feature_xxx folder (-> feature_xxx.www.example.com)
release/xxx -> rc_xxx folder (-> rc_xxx.www.example.com)
```
