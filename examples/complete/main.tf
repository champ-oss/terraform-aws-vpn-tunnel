provider "aws" {
  region = "us-east-2"
}

locals {
  git = "terraform-aws-vpn-tunnel"
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
  git           = local.git
  name          = "terraform-aws-vpn-tunnel"
  lambda_policy = data.aws_iam_policy_document.this.json
}