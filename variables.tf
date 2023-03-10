variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "git" {
  description = "Name of the Git repo"
  type        = string
}

variable "name" {
  description = "Unique identifier for naming resources"
  type        = string
}

variable "vpn_connection_id" {
  description = "vpn_connection_id"
  type        = string
  default     = "abc123"
}

variable "lambda_policy" {
  type        = any
  description = "point to data.aws_iam_policy_document.custom.json"
  default     = null
}

variable "enabled_restart" {
  description = "enabled restart to modify tunnel restart"
  type        = string
  default     = "false"
}
