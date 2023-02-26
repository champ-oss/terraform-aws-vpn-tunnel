provider "aws" {
  region = "us-east-2"
}

data "aws_vpcs" "this" {
  tags = {
    purpose = "vega"
  }
}

data "aws_subnets" "private" {
  tags = {
    purpose = "vega"
    Type    = "Private"
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.this.ids[0]]
  }
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
  source = "../../"
  git    = var.git
  name   = "terraform-aws-vpn-tunnel"
  vpc_id = data.aws_vpcs.this.ids[0]
}