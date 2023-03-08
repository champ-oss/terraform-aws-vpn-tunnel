output "lambda_function_arn" {
  description = "function arn"
  value       = module.vpn_tunnel_lambda.arn
}

output "lambda_function_name" {
  description = "function name"
  value       = module.vpn_tunnel_lambda.function_name
}
