module "vpn_tunnel_lambda" {
  source                         = "github.com/champ-oss/terraform-aws-lambda.git?ref=v1.0.111-919a6e1"
  git                            = var.git
  name                           = "${var.name}-${random_string.identifier.result}"
  tags                           = merge(local.tags, var.tags)
  runtime                        = "python3.9"
  handler                        = "vpn_tunnel_modify.lambda_handler"
  sync_image                     = false
  enable_vpc                     = true
  private_subnet_ids             = var.private_subnet_ids
  filename                       = data.archive_file.lambda_zip.output_path
  source_code_hash               = data.archive_file.lambda_zip.output_base64sha256
  reserved_concurrent_executions = 1
  vpc_id                         = var.vpc_id
  environment = {
    VPN_CONNECTION_ID = var.vpn_connection_id
  }
}