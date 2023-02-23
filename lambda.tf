module "vpn_tunnel_lambda" {
  source           = "github.com/champ-oss/terraform-aws-lambda.git?ref=v1.0.111-919a6e1"
  git              = var.git
  name             = "${var.name}-${random_string.identifier.result}"
  tags             = merge(local.tags, var.tags)
  runtime          = "python3.10"
  handler          = "vpn_tunnel_modify.lambda_handler"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  environment = {
    VPN_CONNECTION_ID = var.vpn_connection_id
  }
}