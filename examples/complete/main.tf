provider "aws" {
  region = "us-east-2"
}

module "this" {
  source = "../../"
  git    = var.git
  name   = "terraform-aws-vpn-tunnel"
}