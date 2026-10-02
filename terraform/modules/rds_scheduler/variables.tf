variable "lambda_function_name" {
  description = "Name of the RDS scheduler Lambda function."
  type        = string
}

variable "db_instance_identifier" {
  description = "RDS DB instance identifier managed by the scheduler Lambda."
  type        = string
}

variable "lambda_role_name" {
  description = "IAM role name used by the scheduler Lambda."
  type        = string
}

variable "rds_policy_name" {
  description = "Name of the IAM inline policy granting RDS access."
  type        = string
}

variable "lambda_timeout" {
  description = "Lambda execution timeout in seconds."
  type        = number
  default     = 3
}

variable "lambda_memory_size" {
  description = "Lambda memory allocation in MB."
  type        = number
  default     = 128
}

variable "lambda_runtime" {
  description = "Lambda runtime."
  type        = string
  default     = "python3.14"
}

variable "source_file" {
  description = "Path to the Lambda source Python file."
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch Log Group retention period in days."
  type        = number
  default     = 30
}