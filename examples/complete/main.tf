provider "aws" {
  region = "us-east-2"
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "ec2:*",
      "sns:*",
    ]
    resources = ["*"]
  }
}

module "this" {
  source        = "../../"
  git           = var.git
  name          = "terraform-aws-vpn-tunnel"
  lambda_policy = data.aws_iam_policy_document.this.json
}