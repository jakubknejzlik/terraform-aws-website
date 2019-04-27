resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.subdomain}.${var.domain}"
  acl           = "public-read"
  force_destroy = true

  tags = {
    Name = "${var.subdomain}.${var.domain}"
  }
}

resource "aws_s3_bucket_policy" "open" {
  bucket = "${aws_s3_bucket.bucket.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1530326450671",
    "Statement": [
        {
            "Sid": "Stmt1530326449828",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.subdomain}.${var.domain}/*"
        }
    ]
}
POLICY
}
