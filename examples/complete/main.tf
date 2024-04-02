terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.0.0"
    }
  }
}

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
