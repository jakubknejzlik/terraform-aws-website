data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda.js"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "reportingdovrecka-sk-edge-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com","edgelambda.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda" {
  filename         = "${path.module}/lambda.zip"
  function_name    = "${replace(var.subdomain,".","-")}-${replace(var.domain,".","-")}-edge"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "lambda.handler"
  source_code_hash = "${data.archive_file.lambda.output_base64sha256}"
  runtime          = "nodejs8.10"
  publish          = true
}
