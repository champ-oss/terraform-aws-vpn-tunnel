locals {
  tags = {
    cost    = "shared"
    creator = "terraform"
    git     = var.git
  }
}

data "archive_file" "lambda_zip" {
  type             = "zip"
  output_file_mode = "0666"
  source_file      = "${path.module}/vpn-tunnel-modify.py"
  output_path      = "${path.module}/vpn-tunnel-modify.zip"
}

resource "random_string" "identifier" {
  length  = 5
  special = false
  upper   = false
  lower   = true
  numeric = false
}